--[[
des_bar_win_end
des_bar_win_start
des_bar_window
des_bee_shack
des_bee_shack_collapse
des_brt3_door
des_crn1_barn
des_crn1_barn_01
des_dis_alchemist
des_dis_alchemist_house
des_em5_roof
des_fus1_boilerhouse
des_gang_amb_wag_bomb
des_gang_wag_bomb_back
des_gang_wag_bomb_front
des_gang_wag_bomb_side
des_gang_wag_rho_ne
des_gang_wagon_back
des_gang_wagon_front
des_gang_wagon_rhodes_ne
des_gang_wagon_side
des_grh_outhouse
des_gry1_still
des_gua1_ship_lurches
des_gua3_cannon
des_gua3_cannon_exp
des_gua3_cannon_exp_ig
des_gua3_cannon_exp_var1
des_gua3_window_jump
des_guarma3_tower_exp
des_guarma3_wall_exp
des_mg_poker_table
des_mob1_fence
des_mob3_trolley
des_nbd1_bankwall
des_nbd1_bankwall_int
des_nts1_boat_chain
des_nts1_chain_exp
des_ntv3_fort
des_ntv3_rail_break
des_ntvs2_treefall
des_ntvs2_treefall_top
des_re_wagon_crash_front
des_rho_bankwall
des_rho_sheriff
des_rho_sheriff_start
des_safe_lrg_l_fail
des_safe_lrg_l_succeed
des_safe_lrg_r_fail
des_safe_lrg_r_succeed
des_safe_med_l_fail
des_safe_med_l_succeed
des_safe_med_r_fail
des_safe_med_r_succeed
des_safe_sml_l_fail
des_safe_sml_l_succeed
des_safe_sml_r_fail
des_safe_sml_r_succeed
des_smg2_fortwall
des_str_jail
des_str_jail_exp
des_trap_gua01x
des_trap_roa02x
des_trap_roa0a01x
des_trap_roa0b01x
des_tree_fall_neutral
des_treefall_accident
des_treefall_down15
des_treefall_flat
des_treefall_up15
des_trn3_bridge
des_trn4_train_crash
des_trn4_train_derail
des_utp2_rvrbed
des_utp2_treefall
des_val_sheriff
des_wagon_bomb_start
des_wnt1_cabin_collapse
--]]
--[[
RegisterCommand("paalle", function(source, args, rawCommand)
	print("DeactivateInteriorEntitySet")
	--RequestImap(1017355491) --SD Bank Wand
	ActivateInteriorEntitySet(29186, "str_jail_unbrokenwall")
	--DeactivateInteriorEntitySet(29186, "str_jail_unbrokenwall", true)
end)

RegisterCommand("pois", function(source, args, rawCommand)
	print("DeactivateInteriorEntitySet")
	--RequestImap(1017355491) --SD Bank Wand
	--ActivateInteriorEntitySet(29186, "str_jail_unbrokenwall")
	DeactivateInteriorEntitySet(29186, "str_jail_unbrokenwall", true)
end)]]


RegisterNetEvent("Oku_Animaatiot:Animate")
AddEventHandler("Oku_Animaatiot:Animate",function()
	--[[
	local object = GetRayfireMapObject(GetEntityCoords(PlayerPedId()), 150.0, 'des_fus1_boilerhouse') -- where the first parameter is the coords used for the search, the second parameter is the radius, and the third is the RayFire map object string.
	local exist = DoesRayfireMapObjectExist(object)
	SetStateOfRayfireMapObject(object, 4) -- where the second parameter is an integer state, typically 4 resets the state and 6 will then start the RayFire sequence. 
	Citizen.Wait(5000)
	SetStateOfRayfireMapObject(object, 6)
	--]]
	--Puiden katto ei oo testattu
	--[[
	local object = GetRayfireMapObject(GetEntityCoords(PlayerPedId()), 150.0, 'des_treefall_down15') -- where the first parameter is the coords used for the search, the second parameter is the radius, and the third is the RayFire map object string.
	local exist = DoesRayfireMapObjectExist(object)
	SetStateOfRayfireMapObject(object, 4) -- where the second parameter is an integer state, typically 4 resets the state and 6 will then start the RayFire sequence. 
	Citizen.Wait(5000)
	SetStateOfRayfireMapObject(object, 6)
	--]]
	------RHODES PANKKI SEINÄ RJÄYTYS
	--[[
	DeactivateInteriorEntitySet(29442, "rhobank_int_walla", true) -- rhobank_int_walla -- rhobank_int_wallb
	local object = GetRayfireMapObject(GetEntityCoords(PlayerPedId()), 150.0, 'des_rho_bankwall') -- where the first parameter is the coords used for the search, the second parameter is the radius, and the third is the RayFire map object string.
	local exist = DoesRayfireMapObjectExist(object)
	SetStateOfRayfireMapObject(object, 4) -- where the second parameter is an integer state, typically 4 resets the state and 6 will then start the RayFire sequence. 
	Citizen.Wait(5000)
	SetStateOfRayfireMapObject(object, 6)
	--]]
	---Rhodes sheriffin toimiston sellin räjäytys
	--[[
	local object = GetRayfireMapObject(GetEntityCoords(PlayerPedId()), 150.0, 'des_rho_sheriff') -- where the first parameter is the coords used for the search, the second parameter is the radius, and the third is the RayFire map object string.
	local exist = DoesRayfireMapObjectExist(object)
	SetStateOfRayfireMapObject(object, 4) -- where the second parameter is an integer state, typically 4 resets the state and 6 will then start the RayFire sequence. 
	Citizen.Wait(5000)
	SetStateOfRayfireMapObject(object, 6)
	--]]
	---SAINT DENIS Pankin seinän räjäytys <-- Pankkiryöstö scriptiin
	--[[
	local object = GetRayfireMapObject(GetEntityCoords(PlayerPedId()), 150.0, 'des_nbd1_bankwall') -- where the first parameter is the coords used for the search, the second parameter is the radius, and the third is the RayFire map object string.
	local exist = DoesRayfireMapObjectExist(object)
	SetStateOfRayfireMapObject(object, 4) -- where the second parameter is an integer state, typically 4 resets the state and 6 will then start the RayFire sequence. 
	Citizen.Wait(5000)
	SetStateOfRayfireMapObject(object, 6)
	--]]
	---Mansikka sheriffin seinän räjäytys <-- Seinä ei räjähdä (ymap ongelma ?)
	--iplremove 1934919499
	--[[
	local object = GetRayfireMapObject(GetEntityCoords(PlayerPedId()), 150.0, 'des_str_jail') -- where the first parameter is the coords used for the search, the second parameter is the radius, and the third is the RayFire map object string.
	local exist = DoesRayfireMapObjectExist(object)
	SetStateOfRayfireMapObject(object, 4) -- where the second parameter is an integer state, typically 4 resets the state and 6 will then start the RayFire sequence. 
	Citizen.Wait(5000)
	SetStateOfRayfireMapObject(object, 6)
	--]]
	---BACCHUS BRIDGE SILLAN RÄJÄHDYS
	--[[
	local object = GetRayfireMapObject(GetEntityCoords(PlayerPedId()), 150.0, 'des_trn3_bridge') -- where the first parameter is the coords used for the search, the second parameter is the radius, and the third is the RayFire map object string.
	local exist = DoesRayfireMapObjectExist(object)
	SetStateOfRayfireMapObject(object, 4) -- where the second parameter is an integer state, typically 4 resets the state and 6 will then start the RayFire sequence. 
	Citizen.Wait(5000)
	SetStateOfRayfireMapObject(object, 6)
	--]]
	local object = GetRayfireMapObject(GetEntityCoords(PlayerPedId()), 150.0, 'des_trap_roa0b01x') -- where the first parameter is the coords used for the search, the second parameter is the radius, and the third is the RayFire map object string.
	local exist = DoesRayfireMapObjectExist(object)
	SetStateOfRayfireMapObject(object, 4) -- where the second parameter is an integer state, typically 4 resets the state and 6 will then start the RayFire sequence. 
	Citizen.Wait(1000)
	SetStateOfRayfireMapObject(object, 6)
end)
