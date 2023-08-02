local poisoned = false
local myrkky = 0
local tapahtunut = false
local tapahtunut2 = false
local tapahtunut3 = false
local tapahtunut4 = false
local antidote = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local size = GetNumberOfEvents(0)
        if size > 0 then
            for i = 0, size - 1 do

                local eventAtIndex = GetEventAtIndex(0, i)

                if eventAtIndex == GetHashKey("EVENT_ENTITY_DAMAGED") then

                    local eventDataSize = 9 

                    local eventDataStruct = DataView.ArrayBuffer(128)
                    eventDataStruct:SetInt32(8 ,0)

                    local is_data_exists = Citizen.InvokeNative(0x57EC5FA4D4D6AFCA,0,i,eventDataStruct:Buffer(),eventDataSize)

                    if is_data_exists then
                        local snake = eventDataStruct:GetInt32(8)
                        local model = GetEntityModel(snake)
                        local snakecoords = GetEntityCoords(snake)
                        for i,v in pairs(Config.Snakes) do
                            if model == GetHashKey(v.model) then
                                if GetDistanceBetweenCoords(snakecoords.x, snakecoords.y, snakecoords.z, GetEntityCoords(PlayerPedId()), false) < 1.5 then
									local randomi = math.random(1,101)
									if randomi <= 50 then
                                   		Poison()
									end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-----------

--[[

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local size = GetNumberOfEvents(0)
        if size > 0 then
            for i = 0, size - 1 do

                local eventAtIndex = GetEventAtIndex(0, i)

                if eventAtIndex == GetHashKey("EVENT_ENTITY_DAMAGED") then

                    local eventDataSize = 9 

                    local eventDataStruct = DataView.ArrayBuffer(128)
					eventDataStruct:SetInt32(0 ,0)		 	-- 8*0 offset for 0 element of eventData
					eventDataStruct:SetInt32(16 ,0)			-- 8*2 offset for 2 element of eventData
					eventDataStruct:SetInt32(24 ,0)			-- 8*3 offset for 3 element of eventData

                    local is_data_exists = Citizen.InvokeNative(0x57EC5FA4D4D6AFCA,0,i,eventDataStruct:Buffer(),eventDataSize)

                    if is_data_exists then
						local idee = eventDataStruct:GetInt32(0)
                        local weaponhash = eventDataStruct:GetInt32(16)
						local ammohash = eventDataStruct:GetInt32(24)
						if ammohash == GetHashKey("AMMO_22_TRANQUILIZER") then
							print("JATKA TÄSTÄ")
							--if HasEntityBeenDamagedByAnyPed(PlayerPedId()) then
								--TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_DRUNK_PASSED_OUT_FLOOR'), -1, true, true, false, false)
							--end
						end
                    end
                end
            end
        end
    end
end)

--]]

RegisterNetEvent('Perry_Poison:Effektit')
AddEventHandler('Perry_Poison:Effektit', function()
	local playerPed = PlayerPedId()
	AnimpostfxPlay('PlayerRPGCoreDeadEye')
	Citizen.Wait(5000)
	AnimpostfxStop('PlayerRPGCoreDeadEye')
end)

Citizen.CreateThread(function()
	AnimpostfxStop("ODR3_Injured01Loop")
end)

RegisterNetEvent('Perry_Poison:UseAntidote')
AddEventHandler('Perry_Poison:UseAntidote', function()
	antidote = true
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if poisoned then
			if IsPedRunning(PlayerPedId()) then
				Citizen.Wait(5000)
				myrkky = myrkky + 5
			end
		end
	end
end)

function Poison()
	poisoned = true
	AnimpostfxPlay("ODR3_Injured01Loop")
	while poisoned do
		Citizen.Wait(10000)
		if IsPedDeadOrDying(PlayerPedId()) then
			AnimpostfxStop("ODR3_Injured01Loop")
			myrkky = 0
			tapahtunut = false
			tapahtunut2 = false
			tapahtunut3 = false
			tapahtunut4 = false
			antidote = false
			poisoned = false
			break
		else
			if not antidote then
				myrkky = myrkky + 1
				if myrkky >= 20 and not tapahtunut then
					Citizen.Wait(500)
					tapahtunut = true
					TriggerEvent("vorp:TipBottom", "Hengityksesi ei kulje kunnolla!", 5000)
					RequestAnimDict("amb_misc@world_human_coughing@male_c@wip_base")
					while not HasAnimDictLoaded("amb_misc@world_human_coughing@male_c@wip_base") do
						Citizen.Wait(100)
					end
					TaskPlayAnim(PlayerPedId(), "amb_misc@world_human_coughing@male_c@wip_base", "wip_base", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
					Citizen.Wait(10000)
					TaskPlayAnim(PlayerPedId(), "amb_misc@world_human_coughing@male_c@wip_base", "wip_base", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
					Citizen.Wait(10000)
					TaskPlayAnim(PlayerPedId(), "amb_misc@world_human_coughing@male_c@wip_base", "wip_base", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
					Citizen.Wait(5000)
					SetPedToRagdoll(PlayerPedId(), 10000, 10000, 0, 0, 0, 0)
				elseif myrkky >= 40 and not tapahtunut2 then
					tapahtunut2 = true
					TriggerEvent("vorp:TipBottom", "Tunnet että raajasi ei enää toimi kunnolla!", 5000)
					AnimpostfxStop("ODR3_Injured01Loop")
					AnimpostfxPlay("PoisonDartPassOut")
					Citizen.Wait(7000)
					DoScreenFadeOut(2000) 
					Citizen.Wait(3000)
					AnimpostfxStop("PoisonDartPassOut")  
					Wait(5000)
					AnimpostfxPlay("ODR3_Injured01Loop")
					TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_SLEEP_GROUND_ARM'), -1, false, "test", 0, false)
					DoScreenFadeIn(5000)
					Wait(5000)
				elseif myrkky >= 60 and not tapahtunut3 then
					tapahtunut3 = true
					SetPedToRagdoll(PlayerPedId(), 10000, 10000, 0, 0, 0, 0)
				elseif myrkky >= 80 and not tapahtunut4 then
					tapahtunut4 = true
					local pl = Citizen.InvokeNative(0x217E9DC48139933D)
					local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
					Citizen.InvokeNative(0x697157CED63F18D4, ped, 500000, false, true, true)
					AnimpostfxStop("ODR3_Injured01Loop")
					myrkky = 0
					tapahtunut = false
					tapahtunut2 = false
					tapahtunut3 = false
					tapahtunut4 = false
					antidote = false
					poisoned = false
					break
				end
			else
				AnimpostfxStop("ODR3_Injured01Loop")
				myrkky = 0
				tapahtunut = false
				tapahtunut2 = false
				tapahtunut3 = false
				tapahtunut4 = false
				antidote = false
				poisoned = false
				break
			end
		end
	end
end