--------------------------------------------------------------------------------------
------------------------------- VORP TELEGRAM ----------------------------------------
--EDIT BY OUTSIDER


Config = {}

----------------------------------- PROPMT ------------------------------------------
Config.keys = {
    G = 0x760A9C6F, -- CHANGE ONLY HASH
} 
Config.Press = "PAINA"
Config.Post = "POLIISIPÄÄLLIKKÖ"

Config.Press2 = "PAINA"
Config.Post2 = "KAAPPI"

-------------------------------- BLIPS ----------------------------------------------

Config.PoliceLocations = {
    { x = 2503.92, y = -1308.91, z = 49.15 }
}

Config.Stations = {
	["SaintDenis"] = {
        blipcoords = vector3(2501.77, -1309.1, 48.85),
		kauppa = vector3(2494.46, -1304.25, 48.85), 
        paallikko = vector3(2503.2, -1301.88, 39.78), 
        kaappi = vector3(2509.48, -1304.75, 48.85), 
        vankkurit = vector3(2476.66, -1312.9, 48.77), 
        vankkuricoords = vector3(2487.21, -1310.64, 48.77), 
        vankkuriheading = 178.37,

        --Tekstit 
		name = "saintdenis",
		blipname = "Virkavalta",
		society = "society_sheriff",
		job = "sheriff"
	},
	["Valentine"] = {
        blipcoords = vector3(-276.54, 806.69, 119.28),
		kauppa = vector3(-278.38, 805.34, 119.28), 
        paallikko = vector3(-277.09, 804.09, 119.28), 
        kaappi = vector3(-277.06, 811.13, 119.29), 
        vankkurit = vector3(-274.99, 813.02, 119.27), 
        vankkuricoords = vector3(-280.51, 829.06, 119.37), 
        vankkuriheading = 280.49,

        --Tekstit 
		name = "valentine",
		blipname = "Sheriff",
		society = "society_sheriff",
		job = "sheriff"
	},
	["Rhodes"] = {
        blipcoords = vector3(1360.13, -1301.58, 77.67),
		kauppa = vector3(1361.28, -1306.11, 77.66), 
        paallikko = vector3(1361.61, -1303.38, 77.67), 
        kaappi = vector3(1362.16, -1301.86, 77.66), 
        vankkurit = vector3(1359.22, -1299.62, 77.66), 
        vankkuricoords = vector3(1361.25, -1293.6, 76.59), 
        vankkuriheading = 245.43,

        --Tekstit 
		name = "valentine",
		blipname = "Sheriff",
		society = "society_sheriff",
		job = "sheriff"
	},
}