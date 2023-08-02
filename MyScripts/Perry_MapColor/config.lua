Config = {}

--[[
COLORS:
BLIP_STYLE_ADVERSARY =  CYAN
BLIP_STYLE_AREA_BOUNDS_OVERLAY = black with shadow
IP_STYLE_AMBIENT_CANO =  white
BLIP_STYLE_AREA = yellow 
BLIP_STYLE_AREA_BOUNDS = black
BLIP_STYLE_COMPANION = gray
BLIP_STYLE_COP_PERSISTENT = red with shadow ?
BLIP_STYLE_DEBUG_BLUE = blue
BLIP_STYLE_DEBUG_GREEN = green
BLIP_STYLE_DEBUG_PINK = pink
BLIP_STYLE_DEBUG_RED = red
BLIP_STYLE_DEBUG_YELLOW = yellow 
BLIP_STYLE_FM_EVENT = purple

--]]

Config.Map = {
    BAYOU_NWA = { -- Saint denis outer bounds
		hash = 0x2843E325,
		color = "BLIP_STYLE_AREA_BOUNDS", -- This makes shadow on the map, you can disable it
    },
    BIG_VALLEY = { -- Strawberry area
		hash = 0x8DCC574F,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    BLUEGILL_MARSH = { -- prison inside area
		hash = 0x024C01CA,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    CHOLLA_SPRINGS = { -- armadillo area
		hash = 0x99B6A1E6,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    CUMBERLAND_FOREST = { -- cumberland forest area
		hash = 0x717F4A96,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    DIEZ_CORONAS = { -- idk maybe mexico ?
		hash = 0x8966022D,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    GAPTOOTH_RIDGE = { -- GAPTOOTH_RIDGE
		hash = 0x3AC128F9,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    GREAT_PLAINS = { -- GREAT_PLAINS
		hash = 0x0E95FF51,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },

--[[
    DISTRICT_GRIZZLIES = { -- upperleft corner going out of bounds lol
		hash = 0x9125D14C,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
--]]
	
    DISTRICT_GRIZZLIES_EAST = { -- DISTRICT_GRIZZLIES_EAST
		hash = 0x943198D3,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    DISTRICT_GRIZZLIES_WEST = { -- DISTRICT_GRIZZLIES_WEST -- this one working the DISTRICT_GRIZZLIES can be undefined
		hash = 0xD41D039A,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    DISTRICT_HEARTLAND = { -- DISTRICT_HEARTLAND heartland oilfields and valentine
		hash = 0x724E7654,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    DISTRICT_HENNIGANS_STEAD = { -- mcflarens ranch and thieves landing 
		hash = 0x33D88587,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    DISTRICT_PERDIDO = { -- idk no idea
		hash = 0x27253ED3,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    DISTRICT_PUNTA_ORGULL = { -- idk no idea
		hash = 0x5046DD11,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    DISTRICT_RIO_BRAVO = { -- rio bravo
		hash = 0xD428627B,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    DISTRICT_ROANOKE_RIDGE = { -- annesburg and so on
		hash = 0x30FAE29B,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    DISTRICT_SCARLETT_MEADOWS = { -- rhodes and so on
		hash = 0x0BB92EEF,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    DISTRICT_TALL_TREES = { -- TALL_TREES
		hash = 0x763A8A87,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
	
	
	
	
    LBS_AMBARINO_BOUNTY = { -- water lines at valentine 
		hash = 0x3BBA228A,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    LBS_GUARMA_BOUNTY = { -- guarma waterlines ? 
		hash = 0x6009F334,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    LBS_LEMOYNE_BOUNTY = { -- lemoyne waterlines 
		hash = 0x0F32B44D,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    LBS_NEW_AUSTIN_BOUNTY = { -- newaustin waterlines 
		hash = 0xD339F6AB,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    LBS_NEW_HANOVER_BOUNTY = { -- new hanover waterlines 
		hash = 0x5CD2A36F,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    LBS_W_ELIZABETH_BOUNTY = { -- strawberry waterlines 
		hash = 0xF030C0B2,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
	
--[[
    LOCKOUT_EASTSIDE = { -- idk
		hash = 0xFAF570C5,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_BAY_LAGRAS = { -- lagras small area
		hash = 0x9652B96E,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_BAY_SAINT_DENIS = { -- saint denis city area
		hash = 0x2A6CBBA2,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_BGV_STRAWBERRY = { -- STRAWBERRY city area
		hash = 0x4663EEB9,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_BLU_SISIKA = { -- prison city area
		hash = 0x2D1A7AF2,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_CML_OLDFORTWALLACE = { -- fort wallace at valentine
		hash = 0x1BDD5A12,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_GRT_BLACKWATER = { -- blackwater city area
		hash = 0x5647E155,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_GRZ_WAPITI = { -- WAPITI city area
		hash = 0xBB785C8A,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_GUA_MANICATO = { -- idk maybe guarma
		hash = 0x6E10D212,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_HRT_CORNWALLKEROSENE = { -- heartland oilfields area
		hash = 0x7B23B4C7,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_HRT_EMERALDRANCH = { -- emeraldranch area
		hash = 0x6E7BDAC4,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_HRT_VALENTINE = { -- VALENTINE area
		hash = 0x0079B7EE,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_ROA_ANNESBURG = { -- ANNESBURG area
		hash = 0x0A8B2CBE,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_ROA_BUTCHERCREEK = { -- BUTCHERCREEK area
		hash = 0xA053D058,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_ROA_VANHORNPOST = { -- VANHORNPOST area
		hash = 0x507B5360,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_SCM_BRAITHWAITEMANOR = { -- BRAITHWAITEMANOR area
		hash = 0xFC531E7A,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_SCM_CALIGAHALL = { -- CALIGAHALL area
		hash = 0xD218D90D,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_SCM_RHODES = { -- RHODES area
		hash = 0xD3F2B8A7,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    REGION_TAL_MANZANITAPOST = { -- idk
		hash = 0xDC87C0C8,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    STATE_AMBARINO = { -- whole ambarino state area
		hash = 0x3B8DD21A,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    STATE_DEFAULT = { -- just a blip in the valentine, maybe color fucking up
		hash = 0xAF5E7C06,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    STATE_GUARMA = { -- guarma state
		hash = 0x9307FD41,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    STATE_LEMOYNE = { -- whole leymoyne state area 
		hash = 0x945395DF,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    STATE_NEW_AUSTIN = { -- whole new austin state area 
		hash = 0x41759831,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    STATE_NEW_HANOVER = { -- whole new hanover area 
		hash = 0x41332496,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
    STATE_WEST_ELIZABETH = { -- whole west elisa area 
		hash = 0xD69B5B49,
		color = "BLIP_STYLE_AREA_BOUNDS",
    },
--]]
}
