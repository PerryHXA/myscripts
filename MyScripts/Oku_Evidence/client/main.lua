local shots = {}
local blood = {}

local update = true
local last = 0
local time = 0
local open = false
local analyzing = false
local analyzingDone = false
local ignore = false

local evidence = {}

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)

            local playerid = PlayerId()

            if not IsPlayerFreeAiming(playerid) then
                update = true
                Citizen.Wait(500)
            else
                local playerPed = PlayerPedId()

                if IsPlayerFreeAiming(playerid) then
					local retval --[[ boolean ]], weaponHash = GetCurrentPedWeapon(PlayerPedId(), false, weaponHash , false)
					if weaponHash == 1247405313 or weaponHash == -164645981 then
						if update then
							ESX.TriggerServerCallback(
								"Perry_Evidence:getData",
								function(ans)
									shots = ans.shots
									blood = ans.blood
									time = ans.time
								end
							)
							update = false
						end

						for t, s in pairs(blood) do
							if GetDistanceBetweenCoords(s.coords, GetEntityCoords(playerPed)) < 5 then
								DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.4, Config.Text["blood_hologram"])

								local passed = time - t

								if passed > 300 and passed < 600 then
									DrawText3D(
										s.coords[1],
										s.coords[2],
										s.coords[3] - 0.5,
										Config.Text["blood_after_5_minutes"]
									)
								elseif passed > 600 then
									DrawText3D(
										s.coords[1],
										s.coords[2],
										s.coords[3] - 0.5,
										Config.Text["blood_after_10_minutes"]
									)
								else
									DrawText3D(
										s.coords[1],
										s.coords[2],
										s.coords[3] - 0.5,
										Config.Text["blood_after_0_minutes"]
									)
								end
							end
							if GetDistanceBetweenCoords(s.coords, GetEntityCoords(playerPed)) < 1 then
								DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.65, Config.Text["remove_evidence"])
								if IsControlJustReleased(0, 0x8AAA0AD4) then
									if (time - t) > Config.TimeBeforeCrimsCanDestory then
										TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), -1, true, false, false, false)
										Citizen.Wait(1000)
										local randomizer =  math.random(1000,1500)
										local testplayer = exports["syn_minigame"]:taskBar(randomizer,7)
										if testplayer == 100 then 
											blood[t] = nil
											TriggerServerEvent("Perry_Evidence:removeBlood", t)
											exports['mythic_notify']:DoHudText('Error', Config.Text["evidence_removed"])
										end
										ClearPedTasks(PlayerPedId())
										ClearPedSecondaryTask(PlayerPedId())
									else
										exports['mythic_notify']:DoHudText('Error', Config.Text["cooldown_before_pickup"])
									end
								end
							end
						end

						for t, s in pairs(shots) do
							if GetDistanceBetweenCoords(s.coords, GetEntityCoords(playerPed)) < 5 then
								DrawText3D(
									s.coords[1],
									s.coords[2],
									s.coords[3] - 0.5,
									string.gsub(Config.Text["shell_hologram"], "{guncategory}", s.bullet)
								)

								local passed = time - t

								if passed > 300 and passed < 600 then
									DrawText3D(
										s.coords[1],
										s.coords[2],
										s.coords[3] - 0.6,
										Config.Text["shell_after_5_minutes"]
									)
								elseif passed > 600 then
									DrawText3D(
										s.coords[1],
										s.coords[2],
										s.coords[3] - 0.6,
										Config.Text["shell_after_10_minutes"]
									)
								else
									DrawText3D(
										s.coords[1],
										s.coords[2],
										s.coords[3] - 0.6,
										Config.Text["shell_after_0_minutes"]
									)
								end
							end

							if GetDistanceBetweenCoords(s.coords, GetEntityCoords(playerPed)) < 1 then
								DrawText3D(
									s.coords[1],
									s.coords[2],
									s.coords[3] - 0.7,
									Config.Text["pick_up_evidence_text"]
								)
								if IsControlJustReleased(0, 0x8AAA0AD4) then
									ESX.TriggerServerCallback('Perry_Evidence:getJobPlayer', function(jobs)
										if jobs.job == Config.JobRequired then
											if #evidence < 3 then
												TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), -1, true, false, false, false)
												Citizen.Wait(1000)
												local randomizer =  math.random(1000,1500)
												local testplayer = exports["syn_minigame"]:taskBar(randomizer,7)
												if testplayer == 100 then 
													shots[t] = nil
													evidence[#evidence + 1] = {type = "bullet", evidence = s.reportInfo}
													TriggerServerEvent("Perry_Evidence:removeShot", t)
													exports['mythic_notify']:DoHudText('Error', Config.Text["evidence_colleted"]..#evidence)
												else
													TriggerServerEvent("Perry_Evidence:removeShot", t)
													exports['mythic_notify']:DoHudText('Error', "Todisteen ottaminen meni pieleen")
												end
												ClearPedTasks(PlayerPedId())
												ClearPedSecondaryTask(PlayerPedId())
											else
												exports['mythic_notify']:DoHudText('Error', Config.Text["no_more_space"])
											end
										else
											if (time - t) > Config.TimeBeforeCrimsCanDestory then
												TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), -1, true, false, false, false)
												Citizen.Wait(1000)
												local randomizer =  math.random(1000,1500)
												local testplayer = exports["syn_minigame"]:taskBar(randomizer,7)
												if testplayer == 100 then 
													shots[t] = nil

													TriggerServerEvent("Perry_Evidence:removeShot", t)
													TriggerServerEvent("Perry_Evidence:GiveShot")
													exports['mythic_notify']:DoHudText('Error', Config.Text["evidence_removed"])
												end
												ClearPedTasks(PlayerPedId())
												ClearPedSecondaryTask(PlayerPedId())
											else
												exports['mythic_notify']:DoHudText('Error', Config.Text["cooldown_before_pickup"])
											end
										end
									end)
								end
							end
						end
					end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)

            if GetDistanceBetweenCoords(coords, Config.EvidenceStorageLocation) < 1.5 then
                DrawText3D(
                    Config.EvidenceStorageLocation[1],
                    Config.EvidenceStorageLocation[2],
                    Config.EvidenceStorageLocation[3],
                    Config.Text["open_evidence_archive"]
                )

                if IsControlJustReleased(0, 0x8AAA0AD4) then
					Citizen.Wait(500)
					ESX.TriggerServerCallback('Perry_Evidence:getJobPlayer', function(jobs)
						if jobs.job == Config.JobRequired and tonumber(jobs.grade) >= Config.JobGradeRequired then
							ESX.TriggerServerCallback(
								"Perry_Evidence:getStorageData",
								function(data)
									ESX.UI.Menu.CloseAll()

									local elements = {}

									for _, v in ipairs(data) do
										table.insert(
											elements,
											{label = Config.Text["report_list"] .. v.id, value = v.data, id = v.id}
										)
									end

									MenuData.Open(
										"default",
										GetCurrentResourceName(),
										"evidence_storage",
										{
											title = Config.Text["evidence_archive"],
											align = "bottom-right",
											elements = elements
										},
										function(data, menu)
											MenuData.Open(
												"default",
												GetCurrentResourceName(),
												"evidence_options",
												{
													title = data.current.label,
													align = "bottom-right",
													elements = {
														{label = Config.Text["view"], value = "view"},
														{label = Config.Text["delete"], value = "delete"}
													}
												},
												function(data2, menu2)
													if data2.current.value == "view" then
														SendNUIMessage(
															{
																type = "showReport",
																evidence = data.current.value
															}
														)
														open = true
													elseif data2.current.value == "delete" then
														TriggerServerEvent(
															"Perry_Evidence:deleteEvidenceFromStorage",
															data.current.id
														)
														exports['mythic_notify']:DoHudText('Error', Config.Text["evidence_deleted_from_archive"])
													end
													menu2.close()
												end,
												function(data2, menu2)
													menu2.close()
												end
											)
											menu.close()
										end,
										function(data, menu)
											menu.close()
										end
									)
								end
							)
						end
					end)
                end
            elseif GetDistanceBetweenCoords(coords, Config.EvidenceAlanysisLocation) < 1.5 then
                if not analyzing and not analyzingDone then
                    DrawText3D(
                        Config.EvidenceAlanysisLocation[1],
                        Config.EvidenceAlanysisLocation[2],
                        Config.EvidenceAlanysisLocation[3],
                        Config.Text["analyze_evidence"]
                    )
                elseif analyzingDone then
                    DrawText3D(
                        Config.EvidenceAlanysisLocation[1],
                        Config.EvidenceAlanysisLocation[2],
                        Config.EvidenceAlanysisLocation[3],
                        Config.Text["read_evidence_report"]
                    )
                else
                    DrawText3D(
                        Config.EvidenceAlanysisLocation[1],
                        Config.EvidenceAlanysisLocation[2],
                        Config.EvidenceAlanysisLocation[3],
                        Config.Text["evidence_being_analyzed_hologram"]
                    )
                end
                if IsControlJustReleased(0, 0x8AAA0AD4) and not analyzing and not analyzingDone then
					Citizen.Wait(500)
					ESX.TriggerServerCallback('Perry_Evidence:getJobPlayer', function(jobs)
						if jobs.job == Config.JobRequired and tonumber(jobs.grade) >= Config.JobGradeRequired then
							if #evidence > 0 then
								Citizen.CreateThread(
									function()
										exports['mythic_notify']:DoHudText('Error', Config.Text["evidence_being_analyzed"])

										analyzing = true
										Citizen.Wait(Config.TimeToAnalyze)

										analyzingDone = true
										analyzing = false
									end
								)
							else
								exports['mythic_notify']:DoHudText('Error', Config.Text["no_evidence_to_analyze"])
							end
						else
							exports['mythic_notify']:DoHudText('Error', "Sinulla ei ole osaamista tähän")
							Citizen.Wait(4000)
						end
					end)
                elseif IsControlJustReleased(0, 0x8AAA0AD4) and not analyzing and analyzingDone then
					Citizen.Wait(500)
					ESX.TriggerServerCallback('Perry_Evidence:getJobPlayer', function(jobs)
						if jobs.job == Config.JobRequired and tonumber(jobs.grade) >= Config.JobGradeRequired then
							SendNUIMessage(
								{
									type = "showReport",
									evidence = json.encode(evidence)
								}
							)
							TriggerServerEvent("Perry_Evidence:addEvidenceToStorage", json.encode(evidence))
							if Config.PlayClipboardAnimation then
								TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("world_human_write_notebook"), -1, true, false, false, false)
							end
							open = true
							analyzingDone = false
							evidence = {}
						end
					end)
                end
            end

            if IsControlJustReleased(0, 0x156F7119) and open then
                SendNUIMessage(
                    {
                        type = "close"
                    }
                )
                ClearPedTasks(ped)
                open = false
            end        
        end
    end
)

RegisterNetEvent("Perry_Evidence:unmarkedBullets")
AddEventHandler(
    "Perry_Evidence:unmarkedBullets",
    function(value)
        ignore = value
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(5000)
            if Config.RainRemovesEvidence then
                if GetRainLevel() > 0.3 then
                    TriggerServerEvent("Perry_Evidence:removeEverything")
                    Citizen.Wait(10000)
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(10)

            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
			--[[
            if HasEntityBeenDamagedByAnyPed(ped) then
				ClearEntityLastDamageEntity(ped)
				TriggerServerEvent("Perry_Evidence:saveBlood", coords, GetInteriorFromEntity(ped))
            end          
			--]]
            if IsPedShooting(ped) and not ignore then
				_, wepHash = GetCurrentPedWeapon(ped, true, 0, true)
                TriggerServerEvent("Perry_Evidence:saveShot", coords, getWeaponName(wepHash), GetInteriorFromEntity(ped))
				Citizen.Wait(5000)
            end
        end
    end
)

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
                    eventDataStruct:SetInt32(16 ,0)

                    local is_data_exists = Citizen.InvokeNative(0x57EC5FA4D4D6AFCA,0,i,eventDataStruct:Buffer(),eventDataSize)

                    if is_data_exists then
                        local weapon = eventDataStruct:GetInt32(16)
						if weapon == -1569615261 then
						
						else
							local ped = PlayerPedId()
							local coords = GetEntityCoords(ped)
							if HasEntityBeenDamagedByAnyPed(ped) then
								ClearEntityLastDamageEntity(ped)
								TriggerServerEvent("Perry_Evidence:saveBlood", coords, GetInteriorFromEntity(ped))
							end        
						end
                    end
                end
            end
        end
    end
end)

function getWeaponName(hash)
    local ped = GetPlayerPed(-1)
    if GetWeapontypeGroup(hash) == 860033945 then
        return Config.Text["group_shotgun"]
    end
    if GetWeapontypeGroup(hash) == 416676503 then
        return Config.Text["pistol_category"]
    end
    if GetWeapontypeGroup(hash) == -594562071 then
        return Config.Text["repeater_category"]
    end
    if GetWeapontypeGroup(hash) == 1159398588 then
        return Config.Text["lightmachine_category"]
    end
    if GetWeapontypeGroup(hash) == -1212426201 then
        return Config.Text["sniper_category"]
    end
    if GetWeapontypeGroup(hash) == -1569042529 then
        return Config.Text["heavy_category"]
    end

    return GetWeapontypeGroup(hash)
end

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
	end
end


