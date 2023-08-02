Config = {}

Config.SaluunaLocations = {
    { x = 2633.44, y = -1230.50, z = 59.78 }
}

Config.keys = {
    G = 0x8AAA0AD4, -- CHANGE ONLY HASH
} 

Config.Press = "PAINA"
Config.Post = "JOHTAJA"

Config.Press2 = "PAINA"
Config.Post2 = "KAAPPI"

Config.Press3 = "PAINA"
Config.Post3 = "TARJOILU"

Config.Saluunat = {
	["SaintDenis"] = {
		name = "saintdenis",
		blipname = "Saluuna",
		position = vector3(2639.85, -1227.58, 53.28), 
		kaappi = vector3(2636.92, -1225.0, 59.5),
		paallikko = vector3(2639.81, -1224.78, 59.49),
		society = "society_saluuna",
		job = "saintdenis"
	},
	["Teatteri"] = {
		name = "teatteri",
		blipname = "Teatterin Saluuna",
		position = vector3(2550.59, -1284.39, 49.12), 
		kaappi = vector3(2542.19, -1282.6, 49.12),
		paallikko = vector3(2544.25, -1282.96, 49.12),
		society = "society_teatteri",
		job = "cinema"
	},
	["Blackwater"] = {
		name = "bwsaluuna",
		blipname = "Blackwater Saluuna",
		position = vector3(-817.59, -1318.88, 43.58), 
		kaappi = vector3(-821.78, -1323.29, 47.79),
		paallikko = vector3(-825.7, -1323.64, 47.78),
		society = "society_bwsaluuna",
		job = "bwsaluuna"
	},
}