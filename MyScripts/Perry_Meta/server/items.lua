local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("broccoli", function(data)
		local _source = data.source
		local hunger = 15
		local thirst = 25
		local objekti = "p_bocceballgreen01x"
		local health = 20
		local stamina = 40
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"broccoli", 1)
	end)
	VorpInv.RegisterUsableItem("kalakeitto", function(data) 
		local _source = data.source
		TriggerClientEvent('Perry_Saluuna:soppa', _source,2232, "p_fishstew01x", 40, 70, 100, 100)
		VorpInv.subItem(_source,"kalakeitto", 1)
	end)
	VorpInv.RegisterUsableItem("kanavanukas", function(data) 
		local _source = data.source
		TriggerClientEvent('Perry_Saluuna:soppa', _source,2232, "p_bacon_cabbage01x", 50, 50, 50, 20)
		VorpInv.subItem(_source,"kanavanukas", 1)
	end)
	VorpInv.RegisterUsableItem("kesakeitto", function(data) 
		local _source = data.source
		TriggerClientEvent('Perry_Saluuna:soppa', _source,2232, "p_lobster_bisque01x", 30, 50, 50,20)
		VorpInv.subItem(_source,"kesakeitto", 1)
	end)
	VorpInv.RegisterUsableItem("porkkanavanukas", function(data) 
		local _source = data.source
		TriggerClientEvent('Perry_Saluuna:soppa', _source,2232, "p_wheat_milk01x", 70, 30, 20, 50)
		VorpInv.subItem(_source,"porkkanavanukas", 1)
	end)
	VorpInv.RegisterUsableItem("porkstew", function(data) 
		local _source = data.source
		TriggerClientEvent('Perry_Saluuna:soppa', _source,2232, "p_bowl04x_stew", 40, 30, 20, 50)
		VorpInv.subItem(_source,"porkstew", 1)
	end)
	VorpInv.RegisterUsableItem("stew", function(data) 
		local _source = data.source
		TriggerClientEvent('Perry_Saluuna:soppa', _source,"useless", "p_bowl04x_stew", 40, 30, 40, 100)
		VorpInv.subItem(_source,"stew", 1)
	end)
	VorpInv.RegisterUsableItem("apple", function(data)
		local _source = data.source
		local hunger = 4
		local thirst = 8
		local objekti = "p_apple01x"
		local health = 3
		local stamina = 3
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"apple", 1)
	end)
	VorpInv.RegisterUsableItem("banana", function(data)
		local _source = data.source
		local hunger = 7
		local thirst = 7
		local objekti = "p_banana_day_01x"
		local health = 5
		local stamina = 5
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"banana", 1)
	end)
	VorpInv.RegisterUsableItem("bread", function(data)
		local _source = data.source
		local hunger = 10
		local thirst = 0
		local objekti = "p_bread01x"
		local health = 5
		local stamina = 5
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"bread", 1)
	end)
	VorpInv.RegisterUsableItem("carrot", function(data)
		local _source = data.source
		local hunger = 8
		local thirst = 5
		local objekti = "p_carrot01x"
		local health = 4
		local stamina = 4
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"carrot", 1)
	end)
	VorpInv.RegisterUsableItem("cbeef", function(data) -- Paistettu
		local _source = data.source
		local hunger = 70
		local thirst = 7
		local objekti = "p_main_roastbeef01x"
		local health = 20
		local stamina = 40
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"cbeef", 1)
	end)
	VorpInv.RegisterUsableItem("caligatormeat", function(data) -- Paistettu
		local _source = data.source
		local hunger = 85
		local thirst = 7
		local objekti = "p_main_roastbeef01x"
		local health = 40
		local stamina = 100
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"caligatormeat", 1)
	end)
	VorpInv.RegisterUsableItem("cbird", function(data) -- Paistettu
		local _source = data.source
		local hunger = 30
		local thirst = 5
		local objekti = "p_main_roastbeef01x"
		local health = 20
		local stamina = 10
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"cbird", 1)
	end)
	VorpInv.RegisterUsableItem("cbiggame", function(data) -- Paistettu
		local _source = data.source
		local hunger = 65
		local thirst = 9
		local objekti = "p_main_roastbeef01x"
		local health = 80
		local stamina = 80
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"cbiggame", 1)
	end)
	VorpInv.RegisterUsableItem("ccrab_c", function(data) -- Paistettu
		local _source = data.source
		local hunger = 52
		local thirst = 5
		local objekti = "p_bluecrab01x"
		local health = 5
		local stamina = 40
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"ccrab_c", 1)
	end)
	VorpInv.RegisterUsableItem("cgame", function(data) -- Paistettu
		local _source = data.source
		local hunger = 53
		local thirst = 6
		local objekti = "p_main_roastbeef01x"
		local health = 20
		local stamina = 5
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"cgame", 1)
	end)
	VorpInv.RegisterUsableItem("cherptile", function(data) -- Paistettu
		local _source = data.source
		local hunger = 47
		local thirst = 2
		local objekti = "s_saltedbeef01x"
		local health = 22
		local stamina = 1
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"cherptile", 1)
	end)
	VorpInv.RegisterUsableItem("cpork", function(data) -- Paistettu
		local _source = data.source
		local hunger = 47
		local thirst = 7
		local objekti = "p_main_roastbeef01x"
		local health = 35
		local stamina = 20
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"cpork", 1)
	end)
	VorpInv.RegisterUsableItem("cmutton", function(data) -- Paistettu
		local _source = data.source
		local hunger = 45
		local thirst = -5 
		local objekti = "s_saltedbeef01x"
		local health = 80
		local stamina = 10
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"cmutton", 1)
	end)
	VorpInv.RegisterUsableItem("cstringy", function(data) -- Paistettu
		local _source = data.source
		local hunger = 37
		local thirst = 2
		local objekti = "s_saltedbeef01x"
		local health = 5
		local stamina = 2
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"cstringy", 1)
	end)
	VorpInv.RegisterUsableItem("cvenison", function(data) -- Paistettu
		local _source = data.source
		local hunger = 32
		local thirst = 3
		local objekti = "p_main_roastbeef01x"
		local health = 60
		local stamina = 10
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"cvenison", 1)
	end)
	VorpInv.RegisterUsableItem("cfish", function(data) -- Paistettu
		local _source = data.source
		local hunger = 60
		local thirst = 33
		local objekti = "p_main_friedcatfish02x"
		local health = 20
		local stamina = 40
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"cfish", 1)
	end)
	VorpInv.RegisterUsableItem("eggs", function(data) -- Paistettu
		local _source = data.source
		local hunger = 3
		local thirst = 8
		local objekti = "s_gatoregg01x"
		local health = 20
		local stamina = 40
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"eggs", 1)
	end)
	VorpInv.RegisterUsableItem("consumable_chocolate", function(data) 
		local _source = data.source
		local hunger = 14
		local thirst = -10
		local objekti = "s_chocolatebar01x"
		local health = 5
		local stamina = 40
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"consumable_chocolate", 1)
	end)
	VorpInv.RegisterUsableItem("kalanmaksaoljy", function(data) 
		local _source = data.source
		local hunger = 0
		local thirst = 3
		local objekti = "s_inv_potenthreviver01x"
		local health = 4
		local stamina = 40
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"kalanmaksaoljy", 1)
	end)
	VorpInv.RegisterUsableItem("lettuce", function(data) 
		local _source = data.source
		local hunger = 8
		local thirst = 10
		local objekti = "s_lettuce01x"
		local health = 4
		local stamina = 4
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"lettuce", 1)
	end)
	VorpInv.RegisterUsableItem("lpihvit", function(data) 
		local _source = data.source
		local hunger = 17
		local thirst = 10
		local objekti = "p_main_roastbeef01x"
		local health = 80
		local stamina = 22
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"lpihvit", 1)
	end)
	VorpInv.RegisterUsableItem("milk", function(data) 
		local _source = data.source
		local hunger = 0
		local thirst = 14
		local objekti = "p_bottlemedicine01x"
		local health = 1
		local stamina = 40
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"milk", 1)
	end)
	VorpInv.RegisterUsableItem("mpiiras", function(data) 
		local _source = data.source
		local hunger = 24
		local thirst = 0
		local objekti = "p_pie01x_slice"
		local health = 20
		local stamina = 40
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"mpiiras", 1)
	end)
	VorpInv.RegisterUsableItem("etaiwasta", function(data) 
		local _source = data.source
		local hunger = 5
		local thirst = 5
		local objekti = "s_ginsengelixir01x"
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst)
		VorpInv.subItem(_source,"etaiwasta", 1)
	end)
	VorpInv.RegisterUsableItem("omenapiiras", function(data) 
		local _source = data.source
		local hunger = 24
		local thirst = 0
		local objekti = "p_pie01x_slice"
		local health = 2
		local stamina = 2
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"omenapiiras", 1)
	end)
	VorpInv.RegisterUsableItem("onion", function(data) 
		local _source = data.source
		local hunger = 2
		local thirst = 0
		local objekti = "p_onionwhite_01x"
		local health = 2
		local stamina = 2
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"onion", 1)
	end)
	VorpInv.RegisterUsableItem("paprika", function(data) 
		local _source = data.source
		local hunger = 4
		local thirst = 3
		local objekti = "p_onionred02x"
		local health = 2
		local stamina = 2
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"paprika", 1)
	end)
	VorpInv.RegisterUsableItem("piirakkapohja", function(data) 
		local _source = data.source
		local hunger = 10
		local thirst = 0
		local objekti = "p_pie01x_slice"
		local health = 2
		local stamina = 2
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"piirakkapohja", 1)
	end)
	VorpInv.RegisterUsableItem("possupiiras", function(data) 
		local _source = data.source
		local hunger = 32
		local thirst = 5
		local objekti = "p_pie01x_slice"
		local health = 40
		local stamina = 40
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"possupiiras", 1)
	end)
	VorpInv.RegisterUsableItem("potato", function(data) 
		local _source = data.source
		local hunger = 8
		local thirst = 4
		local objekti = "p_potato01x"
		local health = 2
		local stamina = 2
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"potato", 1)
	end)
	VorpInv.RegisterUsableItem("pumpkin", function(data) 
		local _source = data.source
		local hunger = 13
		local thirst = 6
		local objekti = "p_pumpkin_01x"
		local health = 4
		local stamina = 2
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"pumpkin", 1)
	end)
	VorpInv.RegisterUsableItem("sitruuna", function(data) 
		local _source = data.source
		local hunger = 0
		local thirst = 7
		local objekti = "p_lemon01x"
		local health = 5
		local stamina = 5
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"sitruuna", 1)
	end)
	VorpInv.RegisterUsableItem("corn", function(data) 
		local _source = data.source
		local hunger = 7
		local thirst = 7
		local objekti = "p_corn01x"
		local health = 4
		local stamina = 2
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"corn", 1)
	end)
	VorpInv.RegisterUsableItem("consumable_salmon_can", function(data) 
		local _source = data.source
		local hunger = 15
		local thirst = 10
		local objekti = "s_canbeansused01x"
		local health = 20
		local stamina = 40
		TriggerClientEvent('Perry_Needs:UseItem', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"consumable_salmon_can", 1)
	end)
	
	---------JUOMAT----------	
	
	VorpInv.RegisterUsableItem("water", function(data) 
		local _source = data.source
		local hunger = 0
		local thirst = 60
		local objekti = "p_water01x"
		local health = 1
		local stamina = 10
		TriggerClientEvent('Perry_Needs:drink', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"water", 1)
	end)
	
	VorpInv.RegisterUsableItem("aloevesi", function(data) 
		local _source = data.source
		local hunger = 0
		local thirst = 40
		local objekti = "p_water01x"
		local health = 1
		local stamina = 20
		TriggerClientEvent('Perry_Needs:drink', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"aloevesi", 1)
	end)
	
	VorpInv.RegisterUsableItem("consumable_raspberrywater", function(data) 
		local _source = data.source
		local hunger = 0
		local thirst = 60
		local objekti = "p_water01x"
		local health = 1
		local stamina = 10
		TriggerClientEvent('Perry_Needs:drink', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"consumable_raspberrywater", 1)
	end)

	VorpInv.RegisterUsableItem("p_icecream01", function(data) 
		local _source = data.source
		local hunger = 20
		local thirst = 40
		local objekti = "p_icecream01"
		local health = 21
		local stamina = 50
		TriggerClientEvent('Perry_Needs:drink', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(_source,"p_icecream01", 1)
	end)
	
	----ginsengtea
	
	
	---------ALKOHOLI----------

	VorpInv.RegisterUsableItem("beer", function(data) 
		local _source = data.source
		local thirst = 30
		local objekti = "p_bottlebeer01a"
		local hand = "p_bottleBeer01x_PH_R_HAND"
		local sekunda = "DRINK_BOTTLE@Bottle_Cylinder_D1-55_H18_Neck_A8_B1-8_TABLE_HOLD"
		local stamina = 5
		local health = 5
		local alcohol = 10
		TriggerClientEvent('Perry_Meta:Alkoholi', _source, objekti, hand, sekunda, health, stamina, thirst, alcohol)
		VorpInv.subItem(_source,"beer", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)
	
	VorpInv.RegisterUsableItem("viski", function(data) 
		local _source = data.source
		local thirst = 5
		local objekti = "p_bottlejd01x"
		local hand = "p_bottleJD01x_PH_R_HAND"
		local sekunda = "DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_HOLD"
		local stamina = 10
		local health = 5
		local alcohol = 40
		TriggerClientEvent('Perry_Meta:Alkoholi', _source, objekti, hand, sekunda, health, stamina, thirst, alcohol)
		VorpInv.subItem(_source,"viski", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)
	
	VorpInv.RegisterUsableItem("shampanja", function(data) 
		local _source = data.source
		local thirst = 5
		local objekti = "p_glass001x"
		local hand = "p_glass001x_PH_R_HAND"
		local sekunda = "DRINK_CHAMPAGNE_HOLD"
		local stamina = 20
		local health = 10
		local alcohol = 20
		TriggerClientEvent('Perry_Meta:Alkoholi', _source, objekti, hand, sekunda, health, stamina, thirst, alcohol)
		VorpInv.subItem(_source,"shampanja", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)
	
	VorpInv.RegisterUsableItem("konjakki", function(data) 
		local _source = data.source
		local thirst = 5
		local objekti = "p_glassbrandy01x"
		local hand = "p_glassbrandy01x_PH_R_HAND"
		local sekunda = "DRINK_COFFEE_HOLD"
		local stamina = 5
		local health = 5
		local alcohol = 30
		TriggerClientEvent('Perry_Meta:Alkoholi', _source, objekti, hand, sekunda, health, stamina, thirst, alcohol)
		VorpInv.subItem(_source,"konjakki", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)

	VorpInv.RegisterUsableItem("taskumatti", function(data) 
		local _source = data.source
		local thirst = 5
		local objekti = "p_flask02x"
		local hand = "p_flask02x_PH_R_HAND"
		local sekunda = "USE_LARGE_BOTTLE_COMBAT_Bottle_Oval_L5-5W9-5H10_Neck_A6_B2-5_RIGHT_HAND"
		local stamina = 10
		local health = 5
		local alcohol = 60
		TriggerClientEvent('Perry_Meta:Alkoholi', _source, objekti, hand, sekunda, health, stamina, thirst, alcohol)
		VorpInv.subItem(_source,"taskumatti", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)
	
	VorpInv.RegisterUsableItem("rommi", function(data) 
		local _source = data.source
		local thirst = 5
		local objekti = "s_inv_rum01x"
		local hand = "s_inv_rum01x_PH_R_HAND"
		local sekunda = "DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_TABLE_HOLD"
		local stamina = 5
		local health = 5
		local alcohol = 30
		TriggerClientEvent('Perry_Meta:Alkoholi', _source, objekti, hand, sekunda, health, stamina, thirst, alcohol)
		VorpInv.subItem(_source,"rommi", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)
	
	VorpInv.RegisterUsableItem("gin", function(data) 
		local _source = data.source
		local thirst = 5
		local objekti = "s_inv_gin01x"
		local hand = "s_inv_gin01x_PH_R_HAND"
		local sekunda = "DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_TABLE_HOLD"
		local stamina = 10
		local health = 5
		local alcohol = 30
		TriggerClientEvent('Perry_Meta:Alkoholi', _source, objekti, hand, sekunda, health, stamina, thirst, alcohol)
		VorpInv.subItem(_source,"gin", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)

	VorpInv.RegisterUsableItem("gin", function(data) 
		local _source = data.source
		local thirst = 5
		local objekti = "s_inv_gin01x"
		local hand = "s_inv_gin01x_PH_R_HAND"
		local sekunda = "DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_TABLE_HOLD"
		local stamina = 10
		local health = 5
		local alcohol = 30
		TriggerClientEvent('Perry_Meta:Alkoholi', _source, objekti, hand, sekunda, health, stamina, thirst, alcohol)
		VorpInv.subItem(_source,"gin", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)
	
	VorpInv.RegisterUsableItem("pontikka", function(data) 
		local _source = data.source
		local thirst = 5
		local objekti = "p_flask02x"
		local hand = "p_flask02x_PH_R_HAND"
		local sekunda = "USE_LARGE_BOTTLE_COMBAT_Bottle_Oval_L5-5W9-5H10_Neck_A6_B2-5_RIGHT_HAND"
		local stamina = 10
		local health = 5
		local alcohol = 80
		TriggerClientEvent('Perry_Meta:Alkoholi', _source, objekti, hand, sekunda, health, stamina, thirst, alcohol)
		VorpInv.subItem(_source,"pontikka", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)	
	VorpInv.RegisterUsableItem("canteen_100", function(data)
		local _source = data.source
		local hunger = 0
		local thirst = 60
		local objekti = "p_canteen01x"
		local health = 1
		local stamina = 10
		TriggerClientEvent('Perry_Needs:drink', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(data.source, "canteen_100", 1)
		VorpInv.addItem(data.source, "canteen_75", 1)
	end)
	
	VorpInv.RegisterUsableItem("canteen_75", function(data)
		local _source = data.source
		local hunger = 0
		local thirst = 60
		local objekti = "p_canteen01x"
		local health = 1
		local stamina = 10
		TriggerClientEvent('Perry_Needs:drink', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(data.source, "canteen_75", 1)
		VorpInv.addItem(data.source, "canteen_50", 1)
	end)
	
	VorpInv.RegisterUsableItem("canteen_50", function(data)
		local _source = data.source
		local hunger = 0
		local thirst = 60
		local objekti = "p_canteen01x"
		local health = 1
		local stamina = 10
		TriggerClientEvent('Perry_Needs:drink', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(data.source, "canteen_50", 1)
		VorpInv.addItem(data.source, "canteen_25", 1)
	end)
	
	VorpInv.RegisterUsableItem("canteen_25", function(data)
		local _source = data.source
		local hunger = 0
		local thirst = 60
		local objekti = "p_canteen01x"
		local health = 1
		local stamina = 10
		TriggerClientEvent('Perry_Needs:drink', _source, objekti, hunger, thirst, health, stamina)
		VorpInv.subItem(data.source, "canteen_25", 1)
		VorpInv.addItem(data.source, "empty_canteen", 1)
	end)

	VorpInv.RegisterUsableItem("canteen_empty", function(data)
		local _source = data.source
		TriggerClientEvent('checkcanteenS', _source)
	end)
	
end)

RegisterServerEvent('fillcanteenS', function()
	local src = source
	VorpInv.subItem(src, "empty_canteen", 1)
	VorpInv.addItem(src, "canteen_100", 1)
end)