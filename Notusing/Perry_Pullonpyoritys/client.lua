RegisterCommand("pullo", function(source, args, rawCommand)
	Rotate()
end)

function Rotate()
	local model = "p_bottle003x"
	local prop = CreateObjectNoOffset(model, 2687.6, -1126.75, 50.7, false, false, false)
    SetEntityRotation(prop, 90.0, 0.0, 0.0, 1, true)
    Citizen.CreateThread(function()
        local speedIntCnt = 1
        local rollspeed = 1.0
        -- local _priceIndex = math.random(1, 20)
        local _rollAngle = 360 * 8
        local _midLength = (_rollAngle / 2)
        local intCnt = 0
        while speedIntCnt > 0 do
            local retval = GetEntityRotation(prop, 1)
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
            local _z = retval.z - rollspeed
            _rollAngle = _rollAngle - rollspeed
            SetEntityRotation(prop, 90.0, 0.0, _z, 1, true)
            Citizen.Wait(0)
        end
    end)
end