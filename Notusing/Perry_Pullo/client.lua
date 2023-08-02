local _pullo = nil
local model = "p_group_gamble_bottlewine01x"

local prompts = GetRandomIntInRange(0, 0xffffff)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = "Paina"
	Pyorittaa = PromptRegisterBegin()
	PromptSetControlAction(Pyorittaa,  0x760A9C6F) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(Pyorittaa, str)
	PromptSetEnabled(Pyorittaa, 1)
	PromptSetVisible(Pyorittaa, 1)
	PromptSetStandardMode(Pyorittaa,1)
    PromptSetHoldMode(Pyorittaa, 1)
	PromptSetGroup(Pyorittaa, prompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,Pyorittaa,true)
	PromptRegisterEnd(Pyorittaa)
end)

Citizen.CreateThread(function()
    -- Wheel
    RequestModel(model)

    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end

    _pullo = CreateObject(model, 2635.87, -1222.36, 53.23, true, false, true) 
    SetModelAsNoLongerNeeded(model)
	SetEntityRotation(_pullo, 90.0, 0.0, 0.0, 2, true)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(9)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 2635.87, -1222.36, 53.37, true)


        if dist < 1.8 then
			local label  = CreateVarString(10, 'LITERAL_STRING', "Pyörittääksesi pulloa")
			PromptSetActiveGroupThisFrame(prompts, label)

			if Citizen.InvokeNative(0xC92AC953F0A982AE,Pyorittaa) then
				Citizen.Wait(1000)
				pyorita()
			end
		end
	end
end)


function pyorita()
	local paska = math.random(1,360)
    _isRolling = true
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
		local pulloli = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, GetHashKey(model), false, false, false)
        local speedIntCnt = 1
        local rollspeed = 1.0
        local _rollAngle = 360 * 8
        local _midLength = (_rollAngle / 2)
        local intCnt = 0
        while speedIntCnt > 0 do
            local retval = GetEntityRotation(pulloli, 1)
            if _rollAngle > _midLength then
                speedIntCnt = speedIntCnt + 1
            else
                speedIntCnt = speedIntCnt - 1
                if speedIntCnt < 0 then
                    speedIntCnt = 0

                end
            end
            intCnt = intCnt + 1
            rollspeed = speedIntCnt / 10
            _rollAngle = _rollAngle - rollspeed
            SetEntityRotation(pulloli, 90.0, 0.0, _rollAngle, 2, true)
            Citizen.Wait(0)
        end
		local numero = math.random(1,1080)
		SetEntityRotation(pulloli, 90.0, numero+.0, 0.0, 2, true)
    end)
end
