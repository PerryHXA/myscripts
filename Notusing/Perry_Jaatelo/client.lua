local count = 0

local buttons_prompt1 = GetRandomIntInRange(0, 0xffffff)

function Button_Prompt1()
	Citizen.CreateThread(function()
        local str = "Syö"
        EatCream = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(EatCream, 0x27D1C284)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(EatCream, str)
        PromptSetEnabled(EatCream, true)
        PromptSetVisible(EatCream, true)
        PromptSetHoldMode(EatCream, true)
        PromptSetGroup(EatCream, buttons_prompt1)
        PromptRegisterEnd(EatCream)
	end)
	Citizen.CreateThread(function()
		local str = "Heitä helvettiin"
		ThrowAway = Citizen.InvokeNative(0x04F97DE45A519419)
		PromptSetControlAction(ThrowAway, 0xA1ABB953)
		str = CreateVarString(10, 'LITERAL_STRING', str)
		PromptSetText(ThrowAway, str)
		PromptSetEnabled(ThrowAway, true)
		PromptSetVisible(ThrowAway, true)
		PromptSetHoldMode(ThrowAway, true)
		PromptSetGroup(ThrowAway, buttons_prompt1)
		PromptRegisterEnd(ThrowAway)
	end)
end

RegisterNetEvent("icecream:eaticecream") 
AddEventHandler("icecream:eaticecream", function(object, counting)	
	Button_Prompt1()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1)
			count = counting 
            local text = CreateVarString(10, 'LITERAL_STRING', "Jäätelö")
            PromptSetActiveGroupThisFrame(buttons_prompt1, text)
            if not check then
                if PromptHasHoldModeCompleted(EatCream) then
                    check = true
					if count == 1 then
						count = count - 1
						Haukku(objekti)
						Citizen.Wait(2000)
						ClearPedTasks(PlayerPedId())
						DeleteEntity(object)
					else
						Haukku(objekti)
						count = count - 1
						Citizen.Wait(2000)
						ClearPedTasks(PlayerPedId())
						--HOLD ANIMAATIO
					end
                    Wait(5000)
                    check = false
                end
                if PromptHasHoldModeCompleted(ThrowAway) then
                    check = true
                    Wait(5000)
                    check = false
                end
            end
		end
	end)
end)

function Haukku(objekti)
	local ped = PlayerPedId()
	local ped_coords = GetEntityCoords(ped)
	local x,y,z =  table.unpack(ped_coords)
	local object = CreateObject(GetHashKey(objekti), x, y, z + 0.2, true, true, true)
	local righthand = GetEntityBoneIndexByName(ped, "SKEL_L_Finger13")
	AttachEntityToEntity(object, ped, righthand, 0.017, -0.01, -0.01, 0.0, 120.0, 10.0, true, true, false, true, 1, true)
	TaskItemInteraction(PlayerPedId(), nil, GetHashKey("EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_LEFT_HAND"), true, 0, 0)
end