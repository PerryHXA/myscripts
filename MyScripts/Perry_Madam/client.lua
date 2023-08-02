local prop

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

local prompts = GetRandomIntInRange(0, 0xffffff)

--PROPMT
Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = "Paina"
	avaaSalaisuus = PromptRegisterBegin()
	PromptSetControlAction(avaaSalaisuus,  0x760A9C6F) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(avaaSalaisuus, str)
	PromptSetEnabled(avaaSalaisuus, 1)
	PromptSetVisible(avaaSalaisuus, 1)
	PromptSetStandardMode(avaaSalaisuus,1)
    PromptSetHoldMode(avaaSalaisuus, 1)
	PromptSetGroup(avaaSalaisuus, prompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,avaaSalaisuus,true)
	PromptRegisterEnd(avaaSalaisuus)
end)

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	SpawnNpcs()
end)


local modeli = "cs_mp_travellingsaleswoman"
local karry = "mp005_p_collectorwagon01"

local paikat = { 
	--[1] = {x = 2689.02, y = 260.71, z = 62.45, h = 146.27, xx = 2689.84, yy = 261.6, zz = 62.46, hh = 52.86},  
	--[2] = {x = 1950.36, y = 486.79, z = 130.38, h = 330.04, xx = 1949.63, yy = 485.97, zz = 130.26, hh = 242.38},  
   -- [3] = {x = 1284.77, y = 279.46, z = 87.39, h = 60.9, xx = 1285.77, yy = 278.5, zz = 87.58, hh = 325.84},  
   -- [4] = {x = -2269.08, y = -612.58, z = 163.41, h = 112.89, xx = -2267.83, yy = -612.36, zz = 163.47, hh = 15.07},  -- UUS INTIAANIKYLÄ
   -- [5] = {x = -1192.22, y = -350.14, z = 98.28, h = 342.5, xx = -1192.96, yy = -351.19, zz = 98.45, hh = 248.1}, 
    [1] = {x = 597.09, y = -534.55, z = 75.88, h = 328.33, xx = 596.21, yy = -535.55, zz = 76.06, hh = 242.8}, --Valentinen ja rhodes välillä, lähemmäs valentinee
}

function SpawnNpcs()
	local paikka = math.random(1,6)
    LoadModel(modeli)
    NpcPed = CreatePed(modeli, paikat[1].x, paikat[1].y, paikat[1].z, paikat[1].h, false, true, true, true)
	prop = CreateObject(GetHashKey(karry), paikat[1].xx, paikat[1].yy, paikat[1].zz,  false,  true, true)
	SetEntityHeading(prop, paikat[1].hh)
	PlaceObjectOnGroundProperly(prop)
	Citizen.InvokeNative(0x283978A15512B2FE, NpcPed, true)
	FreezeEntityPosition(NpcPed, true)
	FreezeEntityPosition(prop, true)
	SetEntityInvincible(NpcPed, true)
	SetEntityInvincible(prop, true)
	SetBlockingOfNonTemporaryEvents(NpcPed, true)
	while true do
		Citizen.Wait(1)

		if IsPlayerNearCoords(paikat[1].x, paikat[1].y, paikat[1].z) then
			if not menu and not missionInProgress then
			   
				local label  = CreateVarString(10, 'LITERAL_STRING', "Madam Nazar") -- TRANSLATE HERE
				PromptSetActiveGroupThisFrame(prompts, label)

				if Citizen.InvokeNative(0xC92AC953F0A982AE,avaaSalaisuus) then
					Citizen.Wait(1000)
					AvaaSalaisuusMenu()
				end
			end
		end
	end
end

function AvaaSalaisuusMenu()
	SetNuiFocus(false)
    local bossMenu = {
        {
            header = "Madam Nazar",
            isMenuHeader = true,
        },
        {
            header = "Käsiraudat 15$",
            params = {
				isServer = true,
                event = "Perry_Madam:OstaTuote",
                args = {
                    itemi = "kasirauta", -- value we want to pass
                    label = "Käsiraudat",
					hinta = 15
                }
            }
        },
        {
            header = "A632F2 1500$",
            params = {
				isServer = true,
                event = "Perry_Madam:OstaTuote",
                args = {
                    itemi = "a632f2", -- value we want to pass
                    label = "A632F2",
					hinta = 1500
                }
            }
        },
        {
            header = "Vastamyrkky 3$",
            params = {
				isServer = true,
                event = "Perry_Madam:OstaTuote",
                args = {
                    itemi = "antipoison", -- value we want to pass
                    label = "Vastamyrkky",
					hinta = 3
                }
            }
        },
        {
            header = "Savupommi 25$",
            params = {
				isServer = true,
                event = "Perry_Madam:OstaTuote",
                args = {
                    itemi = "big_firecracker", -- value we want to pass
                    label = "Savupommi",
					hinta = 25
                }
            }
        },
        {
            header = "Iso Ilotulite 40$",
            params = {
				isServer = true,
                event = "Perry_Madam:OstaTuote",
                args = {
                    itemi = "big_fireworks", -- value we want to pass
                    label = "Iso Ilotulite",
					hinta = 40
                }
            }
        },
        {
            header = "Lipuke (Guarma) 10$",
            params = {
				isServer = true,
                event = "Perry_Madam:OstaTuote",
                args = {
                    itemi = "lipuke", -- value we want to pass
                    label = "Lipuke (Guarma)",
					hinta = 10
                }
            }
        },
        {
            header = "Tislaamo 80$",
            params = {
				isServer = true,
                event = "Perry_Madam:OstaTuote",
                args = {
                    itemi = "brewingstation1", -- value we want to pass
                    label = "Tislaamo",
					hinta = 80
                }
            }
        },
        {
            header = "Tynnyri (Ikäännyttämis) 20$",
            params = {
				isServer = true,
                event = "Perry_Madam:OstaTuote",
                args = {
                    itemi = "agingbarrel", -- value we want to pass
                    label = "Tynnyri (Ikäännyttämis)",
					hinta = 20
                }
            }
        },
        {
            header = "Tynnyri (Fermentointi) 20$",
            params = {
				isServer = true,
                event = "Perry_Madam:OstaTuote",
                args = {
                    itemi = "fermentbarrel", -- value we want to pass
                    label = "Tynnyri (Fermentointi)",
					hinta = 20
                }
            }
        },
        {
            header = "Korttipakka (Tarot) 5$",
            params = {
				isServer = true,
                event = "Perry_Madam:OstaTuote",
                args = {
                    itemi = "tarotpakka", -- value we want to pass
                    label = "Korttipakka (Tarot)",
					hinta = 5
                }
            }
        },
        {
            header = "Käsirautojen avain 10$",
            params = {
				isServer = true,
                event = "Perry_Madam:OstaTuote",
                args = {
                    itemi = "kasiavain", -- value we want to pass
                    label = "Käsirautojen avain",
					hinta = 10
                }
            }
        },
        {
            header = "Poistu",
            params = {
                event = "qbr-menu:closeMenu",
            }
        },
    }
    exports['qbr-menu']:openMenu(bossMenu)
end

function IsPlayerNearCoords(x, y, z)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(PlayerPedId(), 0))
    local distance = Vdist2(playerx, playery, playerz, x, y, z, true) -- USE VDIST

    if distance < 2 then
        return true
    end
end

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	DeleteObject(prop)
	DeleteEntity(NpcPed)
	SetEntityAsNoLongerNeeded(NpcPed)	
end)


function LoadModel(model)
    local model = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
    end
end


