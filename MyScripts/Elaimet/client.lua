local IsAnimal = false
local IsAttacking = false

function SetControlContext(pad, context)
	Citizen.InvokeNative(0x2804658EB7D8A50B, pad, context)
end

-- Change control context to OnMount when an animal ped to fix controls
CreateThread(function()
	local lastPed = 0

	while true do
		local ped = PlayerPedId()

		if ped ~= lastPed then
			if IsPedHuman(ped) then
				SetControlContext(2, 0)
				IsAnimal = false
			else
				-- Prevent animal peds from climbing on ladders, as this crashes the game
				SetPedConfigFlag(ped, 43, true)
				IsAnimal = true
			end

			lastPed = ped
		end

		Wait(1000)
	end
end)


RegisterNetEvent('Perry_Pedit:VaihdaPedi')
AddEventHandler('Perry_Pedit:VaihdaPedi', function(model)
    local model = model
    local hashModel = GetHashKey(model)
	if not IsModelValid(hashModel) then return end
	RequestModel(hashModel, 0)
	while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, hashModel) do
        Citizen.InvokeNative(0xFA28FE3A6246FC30, hashModel, 0)
        Citizen.Wait(0)
	end
	
	if HasModelLoaded(hashModel) then
		Citizen.InvokeNative(0xED40380076A31506, PlayerId(), hashModel, false)
		Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
		SetModelAsNoLongerNeeded(hashModel)
	end
end)

function PerformRequest(hash)
    RequestModel(hash, 0) -- RequestModel
    local times = 1
    while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, hash) do -- HasModelLoaded
        Citizen.InvokeNative(0xFA28FE3A6246FC30, hash, 0) -- RequestModel
        times = times + 1
        Citizen.Wait(0)
        if times >= 100 then break end
    end
end

function PerformRequest(hash)
    RequestModel(hash, 0)
    local bacon = 1
    while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, hash) do
        Citizen.InvokeNative(0xFA28FE3A6246FC30, hash, 0)
        bacon = bacon + 1
        Citizen.Wait(0)
        if bacon >= 100 then break end
    end
end

RegisterNetEvent("fixanimals:attack")

function SetControlContext(pad, context)
	Citizen.InvokeNative(0x2804658EB7D8A50B, pad, context)
end

function GetPedCrouchMovement(ped)
	return Citizen.InvokeNative(0xD5FE956C70FF370B, ped)
end

function SetPedCrouchMovement(ped, state, immediately)
	Citizen.InvokeNative(0x7DE9692C6F64CFE8, ped, state, immediately)
end

function PlayAnimation(anim)
	if not DoesAnimDictExist(anim.dict) then
		print("Invalid animation dictionary: " .. anim.dict)
		return
	end

	RequestAnimDict(anim.dict)

	while not HasAnimDictLoaded(anim.dict) do
		Citizen.Wait(0)
	end

	TaskPlayAnim(PlayerPedId(), anim.dict, anim.name, 4.0, 4.0, -1, 0, 0.0, false, false, false, "", false)

	RemoveAnimDict(anim.dict)
end

function IsPvpEnabled()
	return GetRelationshipBetweenGroups(`PLAYER`, `PLAYER`) == 5
end

function IsValidTarget(ped)
	return not IsPedDeadOrDying(ped) and not (IsPedAPlayer(ped) and not IsPvpEnabled())
end

function GetClosestPed(playerPed, radius)
	local playerCoords = GetEntityCoords(playerPed)

	local itemset = CreateItemset(true)
	local size = Citizen.InvokeNative(0x59B57C4B06531E1E, playerCoords, radius, itemset, 1, Citizen.ResultAsInteger())

	local closestPed
	local minDist = radius

	if size > 0 then
		for i = 0, size - 1 do
			local ped = GetIndexedItemInItemset(i, itemset)

			if playerPed ~= ped and IsValidTarget(ped) then
				local pedCoords = GetEntityCoords(ped)
				local distance = #(playerCoords - pedCoords)

				if distance < minDist then
					closestPed = ped
					minDist = distance
				end
			end
		end
	end

	if IsItemsetValid(itemset) then
		DestroyItemset(itemset)
	end
	print(closestPed)
	return closestPed
end

function MakeEntityFaceEntity(entity1, entity2)
	local p1 = GetEntityCoords(entity1)
	local p2 = GetEntityCoords(entity2)

	local dx = p2.x - p1.x
	local dy = p2.y - p1.y

	local heading = GetHeadingFromVector_2d(dx, dy)

	SetEntityHeading(entity1, heading)
end

function GetAttackType(playerPed)
	local playerModel = GetEntityModel(playerPed)

	for _, attackType in ipairs(Config.AttackTypes) do
		for _, model in ipairs(attackType.models) do
			if playerModel == model then
				return attackType
			end
		end
	end
end

function ApplyAttackToTarget(attacker, target, attackType)
	if attackType.force > 0 then
		SetPedToRagdoll(target, 1000, 1000, 0, 0, 0, 0)
		SetEntityVelocity(target, GetEntityForwardVector(attacker) * attackType.force)
	end

	if attackType.damage > 0 then
		ApplyDamageToPed(target, attackType.damage, 1, -1, 0)
	end
end

function GetPlayerServerIdFromPed(ped)
	for _, player in ipairs(GetActivePlayers()) do
		if GetPlayerPed(player) == ped then
			return GetPlayerServerId(player)
		end
	end
end

function Attack()
	local playerPed = PlayerPedId()

	if IsPedDeadOrDying(playerPed) or IsPedRagdoll(playerPed) then
		return
	end

	local attackType = GetAttackType(playerPed)

	if attackType then
		print("attaxck")
		local target = GetClosestPed(playerPed, attackType.radius)
		print(target)
		print(attackType.radius)

		if target then
			IsAttacking = true
			print("yay")

			MakeEntityFaceEntity(playerPed, target)

			PlayAnimation(attackType.animation)

			if IsPedAPlayer(target) then
				TriggerServerEvent("fixanimals:attack", GetPlayerServerIdFromPed(target), -1)
			elseif NetworkGetEntityIsNetworked(target) and not NetworkHasControlOfEntity(target) then
				TriggerServerEvent("fixanimals:attack", -1, PedToNet(target))
			else
				ApplyAttackToTarget(playerPed, target, attackType)
			end

			SetTimeout(Config.AttackCooldown, function()
				IsAttacking = false
			end)
		end
	end
end

function ToggleCrouch()
	local playerPed = PlayerPedId()

	SetPedCrouchMovement(playerPed, not GetPedCrouchMovement(playerPed), true)
end

AddEventHandler("fixanimals:attack", function(attacker, entity)
	local attackerPed = GetPlayerPed(GetPlayerFromServerId(attacker))
	local attackType = GetAttackType(attackerPed)

	if entity == -1 then
		if IsPvpEnabled() then
			ApplyAttackToTarget(attackerPed, PlayerPedId(), attackType)
		end
	else
		ApplyAttackToTarget(attackerPed, NetToPed(entity), attackType)
	end
end)

CreateThread(function()
	while true do
		if IsAnimal then
			-- Change control context
			SetControlContext(2, `OnMount`)

			-- Disable first person mode as an animal since the camera is glitchy and may cause crashes
			DisableFirstPersonCamThisFrame()

			-- Allow animals that can't normally attack to attack
			if not IsAttacking and IsControlJustPressed(0, `INPUT_ATTACK`) then
				print("Attack")
				Attack()
			end

			-- Toggle crouched movement
			if IsControlJustPressed(0, `INPUT_HORSE_MELEE`) then
				ToggleCrouch()
			end
		end

		Wait(0)
	end
end)
