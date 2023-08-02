Citizen.CreateThread(function()
    while true do
        local isTargetting, targetEntity = GetPlayerTargetEntity(PlayerId())

        if isTargetting and GetEntityModel(targetEntity) == `A_C_Cow` then
		
			local cow = GetEntityCoords(targetEntity)
			local pos = GetEntityCoords(PlayerPedId())
			if (Vdist(pos.x, pos.y, pos.z, cow.x, cow.y, cow.z) < 2.0) then
				DrawText3D(cow.x, cow.y, cow.z, "~q~Paina [~o~G~q~] lypsääksesi maitoa")
				if IsControlJustPressed(0, 0x760A9C6F) then
					FreezeEntityPosition(targetEntity, true)
					FreezeEntityPosition(PlayerPedId(), true)
					if IsPedMale(PlayerPedId()) then
						TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_FARMER_WEEDING`, 10000, true, false, false, false)
					else
						RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
						while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
								Citizen.Wait( 100 )
						end
						TaskPlayAnim(PlayerPedId(), "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_a", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
					end
					exports['progressBars']:startUI(20000, 'Lypsätään maitoa...')
					Wait(20000)
					FreezeEntityPosition(targetEntity, false)
					FreezeEntityPosition(PlayerPedId(), false)
					local item = "milk"
					local count = 1
					TriggerServerEvent("Wiplerilypsa:Palkinto", item , count)
				end
			end
        end

        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        local isTargetting, targetEntity = GetPlayerTargetEntity(PlayerId())

        if isTargetting and GetEntityModel(targetEntity) == `a_c_sheep_01` then
		
			local cow = GetEntityCoords(targetEntity)
			local pos = GetEntityCoords(PlayerPedId())
			if (Vdist(pos.x, pos.y, pos.z, cow.x, cow.y, cow.z) < 2.0) then
				DrawText3D(cow.x, cow.y, cow.z, "~q~Paina [~o~ALT~q~] kerätäksesi villaa")
				if IsControlJustPressed(0, 0x8AAA0AD4) then
					TriggerServerEvent("Perry_Keritsimet:Keritsimet", targetEntity)
				end
			end
        end

        Citizen.Wait(0)
    end
end)

RegisterNetEvent('Perry_Keritsimet:Keraa')
AddEventHandler('Perry_Keritsimet:Keraa', function(targetEntity)
	FreezeEntityPosition(targetEntity, true)
	FreezeEntityPosition(PlayerPedId(), true)
	if IsPedMale(PlayerPedId()) then
		TaskStartScenarioInPlace(PlayerPedId(), `WORLD_HUMAN_FARMER_WEEDING`, 10000, true, false, false, false)
	else
		RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
		while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
				Citizen.Wait( 100 )
		end
		TaskPlayAnim(PlayerPedId(), "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_a", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
	end
	exports['progressBars']:startUI(20000, 'Kerätään villaa...')
	Wait(20000)
	FreezeEntityPosition(targetEntity, false)
	FreezeEntityPosition(PlayerPedId(), false)
	local item = "villa"
	local count = 1
	TriggerServerEvent("Wiplerilypsa:Palkinto", item , count)
end)

UipromptManager:startEventThread()

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
	local px,py,pz=table.unpack(GetGameplayCamCoord())  
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
	if onScreen then
	  SetTextScale(0.30, 0.30)
	  SetTextFontForCurrentCommand(1)
	  SetTextColor(255, 255, 255, 215)
	  SetTextCentre(1)
	  DisplayText(str,_x,_y)
	  local factor = (string.len(text)) / 225
	  DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
	end
end