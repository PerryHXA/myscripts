local prop 

local emote = `KIT_EMOTE_TWIRL_GUN`
RegisterCommand("spin", function(source, args)
    local emote_variation = tonumber( args[1] )
    if ( emote_variation ) then
        local ped = PlayerPedId()

        Citizen.InvokeNative(0xCBCFFF805F1B4596, ped, emote)
        Citizen.InvokeNative(0xB31A277C1AC7B7FF, ped, 4, 1, Citizen.InvokeNative(0x2C4FEC3D0EFA9FC0, ped), true, false, false, false, false)
        Citizen.InvokeNative(0x01F661BB9C71B465, ped, 4, N_0xf4601c1203b1a78d(emote, emote_variation))
        Citizen.InvokeNative(0x408CF580C5E96D49, ped, 4)

    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		SetEntityMaxHealth(PlayerId(), 150)
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
	end
end)

-----------------------------------------------------------------------------------------------------------------------
local InvokeNative = Citizen.InvokeNative


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if (IsControlJustPressed(0,0x26E9DC00))  then -- Press X
            if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
                RequestAnimDict( "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs" )
                while ( not HasAnimDictLoaded( "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs" ) ) do
                    Citizen.Wait( 100 )
                end
                if IsEntityPlayingAnim(ped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 3) then
                    ClearPedSecondaryTask(ped)
                    ClearPedTasks(ped)
                else
                    ClearPedTasks(ped)
                    ClearPedSecondaryTask(ped)
                    TaskPlayAnim(ped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 2.0, -1.0, -1, 31, 0, true, 0, false, 0, false)
                end
            end
        end
       if IsEntityPlayingAnim(ped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 3) then
            HidePedWeaponForScriptedCutscene(ped,true)
        end
    end
end)


local toggledoff = false
--0x4CC5F2FC1332577F
--0x8BC7C1F929D07BF3
--[[
RegisterCommand('hidehud', function()
    if not toggleoff then
        toggleoff = true
        Citizen.InvokeNative(0x4CC5F2FC1332577F, 474191950)
    else
        Citizen.InvokeNative(0x8BC7C1F929D07BF3, 474191950)
        toggleoff = false
    end
end)]]
--[[
RegisterCommand('testaa', function(source, args, rawCommand)
    Citizen.InvokeNative(0xA762C9D6CF165E0D, PlayerPedId(), "BodyPartChained", "Legs", 5000)
end)]]

local cinematic = false
RegisterCommand('cinematic', function()
	if not cinematic then
        cinematic = true
		Citizen.InvokeNative(0x69D65E89FFD72313, true,true)
	else
        cinematic = false
		Citizen.InvokeNative(0x69D65E89FFD72313, false,false)
	end
end)

RegisterNetEvent('perry_teleport:nakymaton')
AddEventHandler('perry_teleport:nakymaton', function()	
	if visible then 
		SetEntityVisible(PlayerPedId(), false)
		TriggerServerEvent("Log", GetPlayerName(player), "Misc", "Visibility off.") -- Log example
		visible = false
	else 
		SetEntityVisible(PlayerPedId(), true)
		TriggerServerEvent("Log", GetPlayerName(player), "Misc", "Visibility on.") -- Log example
		visible = true
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local x,y,z =  table.unpack(GetEntityCoords(PlayerPedId()))
		local ZoneTypeId = 1
		local current_district = Citizen.InvokeNative(0x43AD8FC02B429D33 ,x,y,z,ZoneTypeId)
		if current_district then
			Citizen.InvokeNative(0xC1E8A365BF3B29F2,PlayerPedId(),25,true)   -- estää npc hyökkäämästä
		end
	end
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    Citizen.InvokeNative(0xC1E8A365BF3B29F2,PlayerPedId(),364,true)   -- SetPedResetFlag, flag 2 is preventing ped to jump
	Citizen.InvokeNative(0xB8DE69D9473B7593,PlayerPedId(),6) -- Choke estäminen
	Citizen.InvokeNative(0xB8DE69D9473B7593,PlayerPedId(),15) -- Ei voi takedown
	Citizen.InvokeNative(0xB8DE69D9473B7593,PlayerPedId(),33) -- Taklauksen estäminen
	Citizen.InvokeNative(0xC1E8A365BF3B29F2,PlayerPedId(),204,true)   --  ---- Poistaa kaatumisen jyrkässä mäessä
  end
end)

-- The distance to check in front of the player for a vehicle   
local distanceToCheck = 5.0

-- The number of times to retry deleting a vehicle if it fails the first time 
local numRetries = 5

RegisterCommand("delveh", function(source, args, rawCommand)
	PoistaAjoneuvo()
end)

--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60*60000) -- example 22 minutos /22 minutes 
		TriggerServerEvent("redm:paycheck")
	end
end)]]

function PoistaAjoneuvo()
    local ped = PlayerPedId()

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
                print( "You must be in the driver's seat!" )
            end 
		
		elseif IsPedOnMount(ped) then
			local mount = GetMount(ped)
			NetworkRequestControlOfEntity(mount)
            while not NetworkHasControlOfEntity(mount) do Citizen.Wait(0);    end
            SetEntityAsMissionEntity(mount, true, true)
            while not IsEntityAMissionEntity(mount) do Citizen.Wait(0);    end
            DeletePed(mount)
        else
            local vehicle = GetVehicleInDirection()

            if ( DoesEntityExist( vehicle ) ) then 
                DeleteGivenVehicle( vehicle, numRetries )
            else 
                print( "You must be in or near a vehicle to delete it." )
            end 
        end 
    end 
end

function DeleteGivenVehicle( veh, timeoutMax )
    local timeout = 0 

    SetEntityAsMissionEntity( veh, true, true )
    DeleteVehicle( veh )

    if ( DoesEntityExist( veh ) ) then
        print( "Failed to delete vehicle, trying again..." )

        -- Fallback if the vehicle doesn't get deleted
        while ( DoesEntityExist( veh ) and timeout < timeoutMax ) do 
            DeleteVehicle( veh )

            -- The vehicle has been banished from the face of the Earth!
            if ( not DoesEntityExist( veh ) ) then 
                print( "Vehicle deleted." )
            end 

            -- Increase the timeout counter and make the system wait
            timeout = timeout + 1 
            Citizen.Wait( 500 )

            -- We've timed out and the vehicle still hasn't been deleted. 
            if ( DoesEntityExist( veh ) and ( timeout == timeoutMax - 1 ) ) then
                print( "Failed to delete vehicle after " .. timeoutMax .. " retries." )
            end 
        end 
    else 
        print( "Vehicle deleted." )
    end 
end


function GetVehicleInDirection()
    local Cam = GetGameplayCamCoord()
    local handle = Citizen.InvokeNative(0x377906D8A31E5586, Cam, GetCoordsFromCam(10.0, Cam), -1, PlayerPedId(), 4)
    local _, Hit, Coords, _, Entity = GetShapeTestResult(handle)
    return Entity
end

GetCoordsFromCam = function(distance, coords)
    local rotation = GetGameplayCamRot()
    local adjustedRotation = vector3((math.pi / 180) * rotation.x, (math.pi / 180) * rotation.y, (math.pi / 180) * rotation.z)
    local direction = vector3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.sin(adjustedRotation[1]))
    return vector3(coords[1] + direction[1] * distance, coords[2] + direction[2] * distance, coords[3] + direction[3] * distance)
end


----Noclip ---- 

RegisterNetEvent('Perry_Noclip:noclip')--------------------------näytä hash
AddEventHandler('Perry_Noclip:noclip', function()
	admin_no_clip()
end)

local noclip = false
local noclip_speed = 1.0

function admin_no_clip()
noclip = not noclip
  local playerPed = PlayerPedId()
  if noclip then -- active
    SetEntityVisible(playerPed, false, false)
	
  else -- desactive
    SetEntityVisible(playerPed, true, false)
	
  end
end

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if noclip then
      local playerPed = PlayerPedId()
      local x,y,z = getPosition()
      local dx,dy,dz = getCamDirection()
      local speed = noclip_speed
	  
      -- reset du velocity
      SetEntityVelocity(playerPed, 0.0001, 0.0001, 0.0001)

      -- aller vers le haut
      if IsControlPressed(0, 0x8FD015D8) then -- MOVE UP
        x = x+speed*dx
        y = y+speed*dy
        z = z+speed*dz
      end

      -- aller vers le bas
      if IsControlPressed(0, 0xD27782E3) then -- MOVE DOWN
        x = x-speed*dx
        y = y-speed*dy
        z = z-speed*dz
      end
      SetEntityCoordsNoOffset(playerPed,x,y,z,true,true,true)
    end
  end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        SetPlayerTargetingMode(3) -- or Citizen Native : Citizen.InvokeNative(0xD66A941F401E7302, 3)
    end
end)

function getPosition()
  local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
  return x,y,z
end

function getCamDirection()
  local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
  local pitch = GetGameplayCamRelativePitch()

  local x = -math.sin(heading*math.pi/180.0)
  local y = math.cos(heading*math.pi/180.0)
  local z = math.sin(pitch*math.pi/180.0)

  local len = math.sqrt(x*x+y*y+z*z)
  if len ~= 0 then
    x = x/len
    y = y/len
    z = z/len
  end

  return x,y,z
end

--------------------------------------------------------------------------------------------------------------------------

-----------------------------Laita eläimiä/ped kärryihin
-----------------------------Place Animals /peds in cart nearby
local prompt = false



local buttons_prompt1 = GetRandomIntInRange(0, 0xffffff)

function Button_Prompt1()
	Citizen.CreateThread(function()
        local str = "Laita"
        Omyt1 = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(Omyt1, 0x27D1C284)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Omyt1, str)
        PromptSetEnabled(Omyt1, true)
        PromptSetVisible(Omyt1, true)
        PromptSetHoldMode(Omyt1, true)
        PromptSetGroup(Omyt1, buttons_prompt1)
        PromptRegisterEnd(Omyt1)
	end)
end

local cartCheckDistance = 0.5
local tarpCheckDistance = 1.0
local carcassCheckDistance = 5.0
local volumeArea = Citizen.InvokeNative(0xB3FB80A32BAE3065, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, tarpCheckDistance, tarpCheckDistance, tarpCheckDistance)
local itemSet = CreateItemset(1)


local cartYOffset = {
    [GetHashKey('CART03')] = -1.8,
    [GetHashKey('CART06')] = -2.2,
}
local cartDistance = {
    [GetHashKey('CART03')] = 0.5,
    [GetHashKey('CART06')] = 0.5,
}

local tarpEntity = false
local itemsInCart = 0
Citizen.CreateThread(function()
	Button_Prompt1()
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local carriedEntity = Citizen.InvokeNative(0xD806CD2A4F2C2996, player)

        if carriedEntity then
            if not IsPedHuman(carriedEntity) then
                local coordsf = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.0, 0.0)
                Citizen.InvokeNative(0xA46E98BDC407E23D, volumeArea, cartCheckDistance, cartCheckDistance, cartCheckDistance * 2.0) -- SET_VOLUME_SIZE
                Citizen.InvokeNative(0x541B8576615C33DE, volumeArea, coordsf.x, coordsf.y, coordsf.z) -- SET_VOLUME_COORDS

                local itemsFound = Citizen.InvokeNative(0x886171A12F400B89, volumeArea, itemSet, 2) -- Get volume items into itemset

                local hitEntity = false
                local hitModel = false
                if itemsFound then
                    n = 0
                    while n < itemsFound do
                        local itemId = GetIndexedItemInItemset(n, itemSet)
                        local itemModel = GetEntityModel(itemId)
                        if SupportedWagon(itemModel) then
                            hitEntity = itemId
                            hitModel = itemModel
                        end
                        n = n + 1
                    end
                end

                Citizen.InvokeNative(0x20A4BF0E09BEE146, itemSet) -- Empty Item Set

                if hitEntity then
                    local hitCoords = GetEntityCoords(hitEntity)
                    Citizen.InvokeNative(0xA46E98BDC407E23D, volumeArea, tarpCheckDistance, tarpCheckDistance, tarpCheckDistance) -- SET_VOLUME_SIZE
                    Citizen.InvokeNative(0x541B8576615C33DE, volumeArea, hitCoords.x, hitCoords.y, hitCoords.z) -- SET_VOLUME_COORDS
                    local itemsFound = Citizen.InvokeNative(0x886171A12F400B89, volumeArea, itemSet, 3) -- Get volume items into itemset
                    if itemsFound then
                        n = 0
                        while n < itemsFound do
                            local itemId = GetIndexedItemInItemset(n, itemSet)
                            local itemModel = GetEntityModel(itemId)
                            if itemModel == `MP005_P_HUNTINGWAGONTARP01` then
                                tarpEntity = itemId
                            end
                        n = n + 1
                        end
                    end
                    local entityCoords = GetOffsetFromEntityInWorldCoords(hitEntity, 0.0, cartYOffset[hitModel], 0.0)

                    local distance = #(coords - entityCoords)

                    Citizen.InvokeNative(0x20A4BF0E09BEE146, itemSet) -- Empty Item Set

                    Citizen.InvokeNative(0xA46E98BDC407E23D, volumeArea, carcassCheckDistance, carcassCheckDistance, carcassCheckDistance) -- SET_VOLUME_SIZE
                    Citizen.InvokeNative(0x541B8576615C33DE, volumeArea, GetEntityCoords(hitEntity)) -- SET_VOLUME_COORDS
                    local itemsFound = Citizen.InvokeNative(0x886171A12F400B89, volumeArea, itemSet, 1) -- Get volume items into itemset
                    itemsInCart = 0
                    if itemsFound then
                        n = 0
                        while n < itemsFound do
                            local itemId = GetIndexedItemInItemset(n, itemSet)
                            local attachedTo = GetEntityAttachedTo(itemId)
                            if attachedTo == tarpEntity then
                                itemsInCart = itemsInCart + 1
                            end
                            n = n + 1
                        end
                    end
                    Citizen.InvokeNative(0x20A4BF0E09BEE146, itemSet) -- Empty Item Set

                    if distance < cartDistance[hitModel] and itemsInCart < 6 then
						local item_name2 = CreateVarString(10, 'LITERAL_STRING', "Kärry")
						PromptSetActiveGroupThisFrame(buttons_prompt1, item_name2)
						if PromptHasHoldModeCompleted(Omyt1) then
							LaitaPerkele()
						end
                    end
                end
            end
        else
            --tarpEntity = false
        end
    end
end)

function SupportedWagon(model)
    return model == `CART06` or model == `CART03`
end

function randomZeroRange(range)
    return math.random() * range - (range / 2)
end

function LaitaPerkele()
    local player = PlayerPedId()
    local carriedEntity = Citizen.InvokeNative(0xD806CD2A4F2C2996, player)
    TaskPlaceCarriedEntityAtCoord(player, carriedEntity, GetEntityCoords(player), GetEntityHeading(player), 4)
    Citizen.CreateThread(function()
        Wait(1500)
        local attachCoords = {
            math.random() * 0.3 - 0.15,
            math.random() * 1.6 - 1.0
        }
        local zRot = math.random() * 360.0
        print(itemsInCart, json.encode(attachCoords), zRot)
--AttachEntityToEntity(entity1, entity2, boneIndex, xPos, yPos, zPos, xRot, yRot, zRot, p9, useSoftPinning, collision, isPed, vertexIndex, fixedRot, p15, p16);
        AttachEntityToEntity(carriedEntity, tarpEntity, 0, attachCoords[1], attachCoords[2], 0.75, 0.0, 0.0, zRot, true, false, false, true, 0, true, false, false)
        Wait(1000)
        AttachEntityToEntity(carriedEntity, tarpEntity, 0, attachCoords[1], attachCoords[2], 0.75, 0.0, 0.0, zRot, true, false, false, true, 0, true, false, false)
        --SetEntityCollision(carriedEntity, true, false)
        --SetEntityCompletelyDisableCollision(carriedEntity, true, false)
    end)
end

function LoadModel(model)
    local attempts = 0
    while attempts < 100 and not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
        attempts = attempts + 1
    end
    return IsModelValid(model)
end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		Citizen.InvokeNative(0xAF341032E97FB061, PlayerPedId(), 0)
	end
end)


Citizen.CreateThread(function()
    while true do
        Wait(30000)
	local todd = GetPlayerIndex()
	local joe = PlayerPedId()
       -- SetPlayerWeaponDamageModifier(GetPlayerIndex(),Config.WeaponDmg)
        --SetPlayerMeleeWeaponDamageModifier(GetPlayerIndex(),Config.MeleeDmg)
	--SetPlayerWeaponTypeDamageModifier(GetPlayerIndex(), 0xACE4A4A3, 5.0)
	--Citizen.InvokeNative(0xD04AD186CE8BB129, todd, 0xACE4A4A3, 5.0)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_MELEE_HAMMER'), 2.4)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_REVOLVER_CATTLEMAN'), 2.9)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_REVOLVER_CATTLEMAN_MEXICAN'), 2.9)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_REVOLVER_NAVY_CROSSOVER'), 1.2)																		--------------revolvers
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_REVOLVER_DOUBLEACTION'), 2.05)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_REVOLVER_DOUBLEACTION_GAMBLER'), 2.05)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_REVOLVER_SCHOFIELD'), 2.0)
		Wait(20)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_REVOLVER_NAVY'), 1.2)
		Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_REVOLVER_LEMAT'), 1.85)
		Wait(20)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('	WEAPON_PISTOL_VOLCANIC'), 5.0) -- pistol
		Wait(20)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_REPEATER_WINCHESTER'), 1.5) -- repeaters
		Wait(20)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_REPEATER_HENRY'), 1.45)
		Wait(20)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_REPEATER_EVANS'), 1.75)
		Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_REPEATER_CARBINE'), 2.2)
		Wait(20)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_RIFLE_VARMINT'), 0.5) ---- rifles
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_RIFLE_SPRINGFIELD'), 1.96)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_RIFLE_BOLTACTION'), 2.66)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('	WEAPON_SNIPERRIFLE_ROLLINGBLOCK'), 1.95)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('	WEAPON_SNIPERRIFLE_CARCANO'), 0.25)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('	WEAPON_RIFLE_ELEPHANT'), 15.95)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_BOW'), 1.15) -- others
		Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_BOW_IMPROVED'), 2.95) -- others
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('	WEAPON_MELEE_KNIFE'), 1.85)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_MELEE_KNIFE_JAWBONE'), 1.85)
		Wait(20)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_MELEE_MACHETE'), 3.85)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_MELEE_MACHETE_COLLECTOR'), 7.85)
		Wait(20)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_THROWN_MOLOTOV'), 2.85)
		Wait(20)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_SHOTGUN_DOUBLEBARREL'), 1.25)
Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_SHOTGUN_SAWEDOFF'), 3.2)	-- shotguns
		Wait(20)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_SHOTGUN_REPEATING'), 1.25)
		Wait(20)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_SHOTGUN_PUMP'), 1.15)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('	WEAPON_SHOTGUN_SEMIAUTO'), 1.05)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_THROWN_TOMAHAWK'), 3.85)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('	WEAPON_THROWN_THROWING_KNIVES'), 15.85)
	Citizen.InvokeNative(0xD04AD186CE8BB129, todd, GetHashKey('WEAPON_MELEE_HATCHET'), 3.85)
    end
end)



RegisterNetEvent('EveryoneTeleportEntity')
AddEventHandler('EveryoneTeleportEntity', function(netid,x,y,z)
	ent = NetworkGetEntityFromNetworkId(netid)
	Wait(150)
	SetEntityCoords(ent,x,y,z)
end)

--[[function deleteVehicle(entity)
    if entity and IsEntityAVehicle(entity) then
        print('Deleting Stuck Vehicle: ' .. entity)
        SetEntityAsMissionEntity(entity, true, true)
        DeletePed(entity)
        DeleteEntity(entity)
    end
end

local movingVehicles = {}

Citizen.CreateThread(function()
    while true do
        local vehicles = GetGamePool('CVehicle')

        for _,vehicle in pairs(vehicles) do
            if NetworkHasControlOfEntity(vehicle) then
                local driver = Citizen.InvokeNative(0x2963B5C1637E8A27, 2794498) -- GET_DRIVER_OF_VEHICLE
                if not driver or not IsPedAPlayer(driver) then
                    local isStuck = IsVehicleStuckTimerUp(vehicle, 3, 1000)
                    if isStuck then
                        local horse = Citizen.InvokeNative(0xA8BA0BAE0173457B, vehicle, 0) -- _GET_PED_IN_DRAFT_HARNESS
                        local horseSpeed = GetPedDesiredMoveBlendRatio(horse)
                        if horseSpeed > 0.5 or horseSpeed < -0.5 then
                            deleteVehicle(vehicle)
                        end
                    else
                        -- Since isStuck is unreliable we will also check position of vehicles with horses trying to move
                        local velocity = #GetEntityVelocity(vehicle)
                        if velocity == 0 then
                            local horse = Citizen.InvokeNative(0xA8BA0BAE0173457B, vehicle, 0) -- _GET_PED_IN_DRAFT_HARNESS
                            local horseSpeed = GetPedDesiredMoveBlendRatio(horse)
                            if horseSpeed ~= 0 then
                                if movingVehicles[vehicle] then
                                    local oldCoords = movingVehicles[vehicle]
                                    local coords = GetEntityCoords(vehicle)
                                    if
                                    math.floor(coords.x) == math.floor(oldCoords.x) and
                                            math.floor(coords.y) == math.floor(oldCoords.y) and
                                            math.floor(coords.z) == math.floor(oldCoords.z)
                                    then
                                        deleteVehicle(vehicle)
                                    end
                                    movingVehicles[vehicle] = nil
                                else
                                    movingVehicles[vehicle] = GetEntityCoords(vehicle)
                                end
                            end
                        end
                    end
                end
            end
        end
        Wait(10000)
    end
end)]]--
--------------------------------------------------------------------------------end of hash function

-- Minimap // Piilottaa KAIKEN
--0x4CC5F2FC1332577F
--0x8BC7C1F929D07BF3

--[[
Citizen.CreateThread(function()
	Citizen.InvokeNative(0x8BC7C1F929D07BF3, 474191950)
end)]]

-- Forcehonor
Citizen.CreateThread(function()
	Citizen.InvokeNative(0x8BC7C1F929D07BF3, 121713391)
end)

-- skillcards
Citizen.CreateThread(function()
		Citizen.InvokeNative(0x4CC5F2FC1332577F, 1058184710)
end)

-- onlymoney // Piilottaa KAIKEN
--[[
Citizen.CreateThread(function()
		Citizen.InvokeNative(0x8BC7C1F929D07BF3, 1920936087)
end)]]

-- onlyFishingBait  // Piilottaa KAIKEN
--[[
Citizen.CreateThread(function()
		Citizen.InvokeNative(0x8BC7C1F929D07BF3, -859384195)
end)]]


-- unkSpMoney  
Citizen.CreateThread(function()
		Citizen.InvokeNative(0x4CC5F2FC1332577F, -950624750)
end)

-- unkSpMoneyReplace  
Citizen.CreateThread(function()
		Citizen.InvokeNative(0x4CC5F2FC1332577F, 1670279562)
end)

-- mpMoney  
Citizen.CreateThread(function()
		Citizen.InvokeNative(0x4CC5F2FC1332577F, -66088566)
end)

local minimap_object_rotation = 0
Citizen.CreateThread(function()
    Citizen.InvokeNative(0x1392105DA88BBFFB,GetHashKey("EXTERIOR_GRANDKORRIGANBOATDOCKED"), 2870.0, -1399.0, minimap_object_rotation, 0)
end)

-- honorMoneyCards   
Citizen.CreateThread(function()
		Citizen.InvokeNative(0x4CC5F2FC1332577F, -2124237476)
end)

-- forceSkillCards   
Citizen.CreateThread(function()
		Citizen.InvokeNative(0x4CC5F2FC1332577F, 1533515944)
end)

-- actionWheelItems    
Citizen.CreateThread(function()
		Citizen.InvokeNative(0x4CC5F2FC1332577F, -2106452847)
end)

Citizen.CreateThread(function()

    while true do
        local isTargetting, targetEntity = GetPlayerTargetEntity(PlayerId())
        if isTargetting and IsPedAPlayer(targetEntity) then
            if lastCow ~= targetEntity then

                local promptGroup = PromptGetGroupIdForTargetEntity(targetEntity)
				local horse = targetEntity -- GetMount(PlayerPedId())
				local group = Citizen.InvokeNative(0xB796970BD125FCE8, horse, Citizen.ResultAsLong()) -- PromptGetGroupIdForTargetEntity
				PromptSetGroup(prompt, group, 0)
				SetPedPromptName(horse, "Tuntematon")

            end
        end

        Citizen.Wait(0)
    end
end)

local pointing = false 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlJustPressed(0, 0x4CC0E2FE) then
            if pointing then 
                pointing = false 
                ClearPedSecondaryTask(PlayerPedId())
            elseif not pointing then 
                pointing = true 
                RequestAnimDict('script_common@other@unapproved')
                while not HasAnimDictLoaded('script_common@other@unapproved') do
                    Citizen.Wait(100)
                end
                TaskPlayAnim(PlayerPedId(), 'script_common@other@unapproved', 'loop_0', 1.0, -1.0, 9999999999, 30, 0, true, 0, false, 0, false)
            end
            Wait(500)
        end

    end

end)