local PromptPlacerGroup = GetRandomIntInRange(0, 0xffffff)

function Set()
    Citizen.CreateThread(function()
        local str = 'Aseta'
        SetPrompt = PromptRegisterBegin()
        PromptSetControlAction(SetPrompt, 0x8AAA0AD4)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(SetPrompt, str)
        PromptSetEnabled(SetPrompt, true)
        PromptSetVisible(SetPrompt, true)
        PromptSetHoldMode(SetPrompt, true)
        PromptSetGroup(SetPrompt, PromptPlacerGroup)
        PromptRegisterEnd(SetPrompt)

    end)
end

function Del()
    Citizen.CreateThread(function()
        local str = 'Peruuta'
        CancelPrompt = PromptRegisterBegin()
        PromptSetControlAction(CancelPrompt, 0xF84FA74F)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(CancelPrompt, str)
        PromptSetEnabled(CancelPrompt, true)
        PromptSetVisible(CancelPrompt, true)
        PromptSetHoldMode(CancelPrompt, true)
        PromptSetGroup(CancelPrompt, PromptPlacerGroup)
        PromptRegisterEnd(CancelPrompt)

    end)
end

RegisterCommand("poppoo", function(source, args, rawCommand)
	PropPlacer("p_cs_note01x")
end)

SceneTarget = function()
    local Cam = GetGameplayCamCoord()
    local handle = Citizen.InvokeNative(0x377906D8A31E5586, Cam, GetCoordsFromCam(10.0, Cam), -1, PlayerPedId(), 4)
    local _, Hit, Coords, _, Entity = GetShapeTestResult(handle)
    return Coords
end

GetCoordsFromCam = function(distance, coords)
    local rotation = GetGameplayCamRot()
    local adjustedRotation = vector3((math.pi / 180) * rotation.x, (math.pi / 180) * rotation.y, (math.pi / 180) * rotation.z)
    local direction = vector3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.sin(adjustedRotation[1]))
    return vector3(coords[1] + direction[1] * distance, coords[2] + direction[2] * distance, coords[3] + direction[3] * distance)
end

local addMode = false

local laittaa = false

function PropPlacer(ObjectModel)	
	Set()
	Del()
	laittaa = true
	local x, y, z
	local PropHash = GetHashKey(ObjectModel)
	local tempObj = CreateObject(PropHash, x, y, z, false, true, false, false, true)
	SetEntityAlpha(tempObj, 60)
	SetEntityCompletelyDisableCollision(tempObj, true, true)
	SetEntityCollision(tempObj, false, false)
	while laittaa do
		Citizen.Wait(0)
		x, y, z = table.unpack(SceneTarget())
		SetEntityCoords(tempObj, x, y, z, true, true, true, false)
		local pPos = GetEntityCoords(tempObj)
		local PropPlacerGroupName  = CreateVarString(10, 'LITERAL_STRING', "PropPlacer")
		PromptSetActiveGroupThisFrame(PromptPlacerGroup, PropPlacerGroupName)
		if PromptHasHoldModeCompleted(SetPrompt) then
			--DeleteEntity(tempObj)
			--FreezeEntityPosition(PlayerPedId() , false)
			--TriggerServerEvent("Perry_Saluuna:Serverilletuotteet",  PropHash, pPos.x , pPos.y , pPos.z)
			--break
		end

		if PromptHasHoldModeCompleted(CancelPrompt) then
			DeleteEntity(tempObj)
			SetModelAsNoLongerNeeded(PropHash)
			break
		end
	end
end