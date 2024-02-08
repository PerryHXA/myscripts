local VORPcore = {} -- core object

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

local CAC = 'CUR_ALC_CNT'
local TAC = 'TAR_ALC_CNT'
local USE_TIME = 'SLN_USE_TIME'
local SLN_RAGDOLL = 'SLN_DRUNK_RAGDOLL'
DecorRegister(CAC, 1)
DecorRegister(TAC, 1)
DecorRegister(USE_TIME, 3)
DecorRegister(SLN_RAGDOLL, 3)

DecorSetFloat(player, TAC, 0.0)
DecorSetFloat(player, CAC, 0.0)

local lastInteraction = false
local pedIsDoing = false
local startedDrinkingAt = false
local startedEatingAt = false
local isDrinking = false
local isEating = false
local endDrinking = false
local endEating = false
local player = PlayerPedId()
local buttons_prompt1 = GetRandomIntInRange(0, 0xffffff)
local buttons_prompt2 = GetRandomIntInRange(0, 0xffffff)
local prompts = GetRandomIntInRange(0, 0xffffff)
local prompts2 = GetRandomIntInRange(0, 0xffffff)
local prompts3 = GetRandomIntInRange(0, 0xffffff)
local PromptPlacerGroup = GetRandomIntInRange(0, 0xffffff)
local PromptPlacerGroup2 = GetRandomIntInRange(0, 0xffffff)
local PromptPlacerGroup3 = GetRandomIntInRange(0, 0xffffff)
local pi, sin, cos, abs, rad, mathRandom, mathMin, floor = math.pi, math.sin, math.cos, math.abs, math.rad, math.random, math.min, math.floor
saluunaObj = {}
PlateObj = {}
MainObj = {}
SideObj = {}
SideObj2 = {}

local menu = false

Citizen.CreateThread(function()
    Set()
    Del()
    RotateLeft()
    RotateRight()
end)

function Button_Prompt1()
	Citizen.CreateThread(function()
        local str = "Ota"
        Omyt1 = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(Omyt1, 0x8AAA0AD4)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Omyt1, str)
        PromptSetEnabled(Omyt1, true)
        PromptSetVisible(Omyt1, true)
        PromptSetHoldMode(Omyt1, true)
        PromptSetGroup(Omyt1, buttons_prompt1)
        PromptRegisterEnd(Omyt1)
	end)
	Citizen.CreateThread(function()
		local str = "Poista"
		Cutora1 = Citizen.InvokeNative(0x04F97DE45A519419)
		PromptSetControlAction(Cutora1, 0x27D1C284)
		str = CreateVarString(10, 'LITERAL_STRING', str)
		PromptSetText(Cutora1, str)
		PromptSetEnabled(Cutora1, true)
		PromptSetVisible(Cutora1, true)
		PromptSetHoldMode(Cutora1, true)
		PromptSetGroup(Cutora1, buttons_prompt1)
		PromptRegisterEnd(Cutora1)
	end)
end

function Button_Prompt2()
	Citizen.CreateThread(function()
        local str = "Syö"
        SyoCustom = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(SyoCustom, 0x8AAA0AD4)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(SyoCustom, str)
        PromptSetEnabled(SyoCustom, true)
        PromptSetVisible(SyoCustom, true)
        PromptSetHoldMode(SyoCustom, true)
        PromptSetGroup(SyoCustom, buttons_prompt2)
        PromptRegisterEnd(SyoCustom)
	end)
	Citizen.CreateThread(function()
		local str = "Poista"
		PoistaCustom = Citizen.InvokeNative(0x04F97DE45A519419)
		PromptSetControlAction(PoistaCustom, 0x27D1C284)
		str = CreateVarString(10, 'LITERAL_STRING', str)
		PromptSetText(PoistaCustom, str)
		PromptSetEnabled(PoistaCustom, true)
		PromptSetVisible(PoistaCustom, true)
		PromptSetHoldMode(PoistaCustom, true)
		PromptSetGroup(PoistaCustom, buttons_prompt2)
		PromptRegisterEnd(PoistaCustom)
	end)
end

function Del()
    Citizen.CreateThread(function()
        local str = 'Peruuta'
        CancelPrompt = PromptRegisterBegin()
        PromptSetControlAction(CancelPrompt, 0xF84FA74F)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(CancelPrompt, str)
        PromptSetEnabled(CancelPrompt, true)
        PromptSetVisible(CancelPrompt, true)
        PromptSetHoldMode(CancelPrompt, true)
        PromptSetGroup(CancelPrompt, PromptPlacerGroup)
        PromptRegisterEnd(CancelPrompt)

    end)
end

function Set()
    Citizen.CreateThread(function()
        local str = 'Aseta'
        SetPrompt = PromptRegisterBegin()
        PromptSetControlAction(SetPrompt, 0x8AAA0AD4)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(SetPrompt, str)
        PromptSetEnabled(SetPrompt, true)
        PromptSetVisible(SetPrompt, true)
        PromptSetHoldMode(SetPrompt, true)
        PromptSetGroup(SetPrompt, PromptPlacerGroup)
        PromptRegisterEnd(SetPrompt)

    end)
end


function RotateLeft()
    Citizen.CreateThread(function()
        local str = 'Käännä vasemmalle'
        RotateLeftPrompt = PromptRegisterBegin()
        PromptSetControlAction(RotateLeftPrompt, 0xA65EBAB4)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(RotateLeftPrompt, str)
        PromptSetEnabled(RotateLeftPrompt, true)
        PromptSetVisible(RotateLeftPrompt, true)
        PromptSetStandardMode(RotateLeftPrompt, true)
        PromptSetGroup(RotateLeftPrompt, PromptPlacerGroup)
        PromptRegisterEnd(RotateLeftPrompt)

    end)
end

function RotateRight()
    Citizen.CreateThread(function()
        local str = 'Käännä oikealle'
        RotateRightPrompt = PromptRegisterBegin()
        PromptSetControlAction(RotateRightPrompt, 0xDEB34313)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(RotateRightPrompt, str)
        PromptSetEnabled(RotateRightPrompt, true)
        PromptSetVisible(RotateRightPrompt, true)
        PromptSetStandardMode(RotateRightPrompt, true)
        PromptSetGroup(RotateRightPrompt, PromptPlacerGroup)
        PromptRegisterEnd(RotateRightPrompt)

    end)
end

--PROPMT
Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = Config.Press
	avaaPaallikkos = PromptRegisterBegin()
	PromptSetControlAction(avaaPaallikkos,  Config.keys.G) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(avaaPaallikkos, str)
	PromptSetEnabled(avaaPaallikkos, 1)
	PromptSetVisible(avaaPaallikkos, 1)
	PromptSetStandardMode(avaaPaallikkos,1)
    PromptSetHoldMode(avaaPaallikkos, 1)
	PromptSetGroup(avaaPaallikkos, prompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,avaaPaallikkos,true)
	PromptRegisterEnd(avaaPaallikkos)
end)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = Config.Press2
	avaaKaappi = PromptRegisterBegin()
	PromptSetControlAction(avaaKaappi,  Config.keys.G) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(avaaKaappi, str)
	PromptSetEnabled(avaaKaappi, 1)
	PromptSetVisible(avaaKaappi, 1)
	PromptSetStandardMode(avaaKaappi,1)
    PromptSetHoldMode(avaaKaappi, 1)
	PromptSetGroup(avaaKaappi, prompts2)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,avaaKaappi,true)
	PromptRegisterEnd(avaaKaappi)
end)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = "Paina"
	avaaTarjoilu = PromptRegisterBegin()
	PromptSetControlAction(avaaTarjoilu,  Config.keys.G) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(avaaTarjoilu, str)
	PromptSetEnabled(avaaTarjoilu, 1)
	PromptSetVisible(avaaTarjoilu, 1)
	PromptSetStandardMode(avaaTarjoilu,1)
    PromptSetHoldMode(avaaTarjoilu, 1)
	PromptSetGroup(avaaTarjoilu, prompts3)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,avaaTarjoilu,true)
	PromptRegisterEnd(avaaTarjoilu)
end)


---Paallikko
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		for i,v in pairs(Config.Saluunat) do
			if IsPlayerNearCoords(v.paallikko) then
				if not menu then
				   
					local label  = CreateVarString(10, 'LITERAL_STRING', Config.Post) -- TRANSLATE HERE
					PromptSetActiveGroupThisFrame(prompts, label)

					if Citizen.InvokeNative(0xC92AC953F0A982AE,avaaPaallikkos) then
						Citizen.Wait(1000)
						VORPcore.RpcCall('Perry_Saluuna:HaeTiedotJob',function(tiedot) -- asynchronous 
							if tiedot.grade == 10 and tiedot.job == v.job then
								menu = true
								avaaPaallikkosedic(v.society, v.job)
							end
						end) 
					end
				end
			end
		end
    end
end)

---MENU
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		for i,v in pairs(Config.Saluunat) do
			if IsPlayerNearCoords(v.position) then
				if not menu then
					local label  = CreateVarString(10, 'LITERAL_STRING', "Menu") -- TRANSLATE HERE
					PromptSetActiveGroupThisFrame(prompts3, label)

					if Citizen.InvokeNative(0xC92AC953F0A982AE,avaaTarjoilu) then
						Citizen.Wait(1000)
						VORPcore.RpcCall('Perry_Saluuna:HaeTiedotJob',function(tiedot) -- asynchronous 
							if tiedot.grade >= 2 and tiedot.job == v.job then
								AvaaTarjoilu(v.society)
							end
						end) 
					end
				end
			end
		end
    end
end)

--KAAPPI
Citizen.CreateThread(function()
	Button_Prompt1()
	Button_Prompt2()
    while true do
        Citizen.Wait(1)
		for i,v in pairs(Config.Saluunat) do
			if IsPlayerNearCoords(v.kaappi) then
				if not menu then
				   
					local label  = CreateVarString(10, 'LITERAL_STRING', Config.Post2) -- TRANSLATE HERE
					PromptSetActiveGroupThisFrame(prompts2, label)

					if Citizen.InvokeNative(0xC92AC953F0A982AE,avaaKaappi) then
						Citizen.Wait(1000)
						VORPcore.RpcCall('Perry_Saluuna:HaeTiedotJob',function(tiedot) -- asynchronous 
							if tiedot.grade >= 2 and tiedot.job == v.job then
								local job = v.job
								TriggerEvent("Perry_Kaapit:AvaaKaappi", job)
							end
						end) 
					end
				end
			end
		end
    end
end)


function AvaaTarjoilu(society)
	SetNuiFocus(false)
	menu = false
	local elements = {
		{label = 'Tarjoile Alkoholijuomia',    value = 'alkoholit'},
		{label = 'Tarjoile ruokia',    value = 'ruokia'},
		{label = 'Tarjoile juomia',    value = 'juomia'},
		{label = 'Lautasruoat',    value = 'lautasruoat'},
		{label = 'Anna lasku',    value = 'lasku'},
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'tarjoilu_menu',

		{

			title    = 'SALUUNA',

			subtext    = 'SALUUNA VALIKKO',

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		
		if data.current.value == 'ruokia' then
			menu.close()
			local elements = {
				{label = 'Pekonisalaatti',    value = 'pekonisalad'},
				{label = 'Lihasoppa',    value = 'lihasoppa'},
				{label = 'Lihakeitto',    value = 'lihakeitto'},
				{label = 'Chili con carne',    value = 'chilikurrru'},
				{label = 'Kalakeitto',    value = 'kalakeitto'},
				{label = 'Rapukeitto',    value = 'rapukeitto'},
				{label = 'Kaurapuuro',    value = 'kaurapuuro'},
				{label = 'Vehnämuroja',    value = 'vehnismurot'},
				{label = 'Osteri sitrunaan kanssa',    value = 'oyster'},
				{label = 'Koiranruoka',    value = 'koira'}, 
				{label = 'Lihamuhennos',    value = 'lihamuhennos'},
				{label = 'Rapulautanen',    value = 'rapu'},


			}
			MenuData.Open(

				'default', GetCurrentResourceName(), 'tarjoilu_menu',

				{

					title    = 'SALUUNA',

					subtext    = 'SALUUNA VALIKKO',

					align    = 'top-left',

					elements = elements,

				},

				function(data, menu2)
				
				if data.current.value == 'pekonisalad' then
					menu2.close()
					local model = "p_bacon_cabbage01x"
					PropPlacer(model, "soppa")
				elseif data.current.value == 'lihasoppa' then
					menu2.close()
					local model = "p_beefstew01x"
					PropPlacer(model, "soppa")
				elseif data.current.value == 'lihakeitto' then
					menu2.close()
					local model = "p_bowl04x_stew"
					PropPlacer(model, "soppa")
				elseif data.current.value == 'chilikurrru' then
					menu2.close()
					local model = "p_chillicurry01x"
					PropPlacer(model, "soppa")
				elseif data.current.value == 'kalakeitto' then
					menu2.close()
					local model = "p_fishstew01x"
					PropPlacer(model, "soppa")
				elseif data.current.value == 'rapukeitto' then
					menu2.close()
					local model = "p_lobster_bisque01x"
					PropPlacer(model, "soppa")
				elseif data.current.value == 'kaurapuuro' then
					menu2.close()
					local model = "p_oatmeal01x"
					PropPlacer(model, "soppa")
				elseif data.current.value == 'vehnismurot' then
					menu2.close()
					local model = "p_wheat_milk01x"
					PropPlacer(model, "soppa")
				elseif data.current.value == 'oyster' then
					menu2.close()
					local model = "p_oyster_plate"
					PropPlacer(model, "lautanen")
				elseif data.current.value == 'koira' then
					menu2.close()
					local model = "p_platedog01x"
					PropPlacer(model, "lautanen")
				elseif data.current.value == 'lihamuhennos' then
					menu2.close()
					local model = "p_stewplate01x"
					PropPlacer(model, "lautanen")
				elseif data.current.value == 'rapu' then
					menu2.close()
					local model = "p_crab_plate_02"
					PropPlacer(model, "lautanen")
				end
			end, function(data, menu2)
				menu2.close()
			end) 
			
		elseif data.current.value == 'juomia' then	
			menu.close()
			local elements = {
				{label = 'Tarjoile kahvia',    value = 'kahvi'},
				{label = 'Tarjoile maitoa',    value = 'maito'},

			}
			MenuData.Open(

				'default', GetCurrentResourceName(), 'tarjoilu_menu',

				{

					title    = 'SALUUNA',

					subtext    = 'SALUUNA VALIKKO',

					align    = 'top-left',

					elements = elements,

				},

				function(data, menu3)
				
				if data.current.value == 'kahvi' then	
					menu3.close()
					local model = "p_mugCoffee01x"
					PropPlacer(model)
				elseif data.current.value == 'maito' then	
					menu3.close()
					local model = "p_bottle01x"
					PropPlacer(model)
				end
			end, function(data, menu3)
				menu3.close()
			end) 
		elseif data.current.value == 'lautasruoat' then	
			menu.close()
			AvaaCustom()
		elseif data.current.value == 'alkoholit' then	
			menu.close()
			AvaaAlkoholit()
		elseif data.current.value == 'lasku' then	
			menu.close()
			local closestPlayer, closestDistance = GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
				billingmenu(player, society)
			end
		end
	end, function(data, menu)
		menu.close()
	end) 
end

function billingmenu(player, society)
	MenuData.Open(
		'dialog', GetCurrentResourceName(), 'saluunamenu_menu',
		{
			title = "Syötä laskun nimi"
		},
	function(data, menu)
		local name = tostring(data.value)
		menu.close()
		Citizen.Wait(200)
		maxLength = 5
		AddTextEntry('FMMC_MPM_NA', "Syötä laskun hinta")
		DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", maxLength)
		while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
			Citizen.Wait( 0 )
		end
	
		local palkkio = GetOnscreenKeyboardResult()
		UnblockMenuInput()
		if string.len(palkkio) >= 1 and string.len(palkkio) <= 15 and palkkio ~= nil then
			TriggerServerEvent('Oku_Laskutus:sendBill', GetPlayerServerId(player), society, name, palkkio)
		else
			exports['mythic_notify']:DoLongHudText('Error', 'Palkkio on virheellinen!')
		end
	end, function(data, menu)
	end)
end

AvaaAlkoholit = function()
	SetNuiFocus(false)
    local bossMenu = {
        {
            header = "Mitäs tänään tarjoillaan?",
            isMenuHeader = true,
        },
        {
            header = "Prairie Moon Gin 5%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottle006x" -- value we want to pass
                }
            }
        },
        {
            header = "Lager Olut 2%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottle008x" -- value we want to pass
                }
            }
        },
        {
            header = "Jätti Lager Olut 3%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottle008x_big" -- value we want to pass
                }
            }
        },
        {
            header = "Täysruis Viski 4%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottle009x" -- value we want to pass
                }
            }
        },
        {
            header = "Absinttia 10%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottle010x" -- value we want to pass
                }
            }
        },
        {
            header = "Talon erikoinen 5%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottle011x" -- value we want to pass
                }
            }
        },
        {
            header = "Limping Williams Viski 6%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottle02x" -- value we want to pass
                }
            }
        },
        {
            header = "Vanhan tilan absinttia 15%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottleabsinthe01x" -- value we want to pass
                }
            }
        },
	    {
            header = "Sehiffer Olut 1%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottlebeer01a" -- value we want to pass
                }
            }
        },
	    {
            header = "McCarth Olut 1%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottlebeer01a_1" -- value we want to pass
                }
            }
        },
	    {
            header = "BlackBurnAle Olut 1%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottlebeer01a_2" -- value we want to pass
                }
            }
        },
	    {
            header = "Baltz Brewer Olut 1%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottlebeer01a_3" -- value we want to pass
                }
            }
        },
	    {
            header = "Pioneer Olut 1%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottlebeer01x" -- value we want to pass
                }
            }
        },
	    {
            header = "DraftHorse erikois-olut 2%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottlebeer02x" -- value we want to pass
                }
            }
        },
	    {
            header = "New Hanover Olut 2%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottlebeer03x" -- value we want to pass
                }
            }
        },
	    {
            header = "Antonette Brandy 5%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottlebrandy01x" -- value we want to pass
                }
            }
        },
	    {
            header = "RobesPierre Shampanja 2%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottlechampagne01x" -- value we want to pass
                }
            }
        },
	    {
            header = "Richesse Konjakki 2%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottlecognac01x" -- value we want to pass
                }
            }
        },
	    {
            header = "Lahjapullo Red mist 4%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottleredmist01x" -- value we want to pass
                }
            }
        },
	    {
            header = "Antoinette Sherryä 0.3%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottlesherry01x" -- value we want to pass
                }
            }
        },
	    {
            header = "Tuntematon Tequila 6%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottletequila02x" -- value we want to pass
                }
            }
        },
	    {
            header = "Reichards Hammasvoima 8%",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottletoothpwdr01x" -- value we want to pass
                }
            }
        },
	    {
            header = "Chateau Gourmandise Punaviini 3% (1887)",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottlewine01x" -- value we want to pass
                }
            }
        },
	    {
            header = "Chateau Gourmandise Punaviini 3% (1895)",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottlewine02x" -- value we want to pass
                }
            }
        },
	    {
            header = "Saint-Dymphna Valkoviini 2% MERIOT (1894)",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottlewine03x" -- value we want to pass
                }
            }
        },
	    {
            header = "Saint-Dymphna Valkoviini 2% CABERNET (1894)",
            params = {
				isServer = false,
                event = "Perry_Saluuna:Juomaa",
                args = {
                    juoma = "p_bottlewine04x" -- value we want to pass
                }
            }
        },
    }
    exports['qbr-menu']:openMenu(bossMenu)
					
end

AvaaCustom = function()
	SetNuiFocus(false)
    local bossMenu = {
        {
            header = "Mitä päätäytteeksi?",
            isMenuHeader = true,
        },
        {
            header = "Lampaan rintaa",
            params = {
				isServer = false,
                event = "Perry_Saluuna:LautasRuoka",
                args = {
                    main = "p_main_breastmutton01x" -- value we want to pass
                }
            }
        },
        {
            header = "Suolalihaa",
            params = {
				isServer = false,
                event = "Perry_Saluuna:LautasRuoka",
                args = {
                    main = "p_main_cornedbeef01x" -- value we want to pass
                }
            }
        },
        {
            header = "Paistettu monni",
            params = {
				isServer = false,
                event = "Perry_Saluuna:LautasRuoka",
                args = {
                    main = "p_main_friedcatfish02x" -- value we want to pass
                }
            }
        },
        {
            header = "Lampaan sydän",
            params = {
				isServer = false,
                event = "Perry_Saluuna:LautasRuoka",
                args = {
                    main = "p_main_lamb_heart01x" -- value we want to pass
                }
            }
        },
        {
            header = "Lammas paahtoleipä",
            params = {
				isServer = false,
                event = "Perry_Saluuna:LautasRuoka",
                args = {
                    main = "p_main_lambfrytoast01x" -- value we want to pass
                }
            }
        },
        {
            header = "Hummerin häntä",
            params = {
				isServer = false,
                event = "Perry_Saluuna:LautasRuoka",
                args = {
                    main = "p_main_lobstertail01x" -- value we want to pass
                }
            }
        },
        {
            header = "Preeria kanaa",
            params = {
				isServer = false,
                event = "Perry_Saluuna:LautasRuoka",
                args = {
                    main = "p_main_prairiechicken01x" -- value we want to pass
                }
            }
        },
        {
            header = "Härän kyljys",
            params = {
				isServer = false,
                event = "Perry_Saluuna:LautasRuoka",
                args = {
                    main = "p_main_primerib01x" -- value we want to pass
                }
            }
        },
	        {
            header = "Paahtopaisti",
            params = {
				isServer = false,
                event = "Perry_Saluuna:LautasRuoka",
                args = {
                    main = "p_main_roastbeef01x" -- value we want to pass
                }
            }
        },
    }
    exports['qbr-menu']:openMenu(bossMenu)
					
end

RegisterNetEvent('Perry_Saluuna:LautasRuoka') 
AddEventHandler('Perry_Saluuna:LautasRuoka', function(argut)	
	local maini = argut.main
	SetNuiFocus(false)
    local bossMenu = {
        {
            header = "Mitä laitetaan kylkeen?",
            isMenuHeader = true,
        },
        {
            header = "Perunaa ja herneitä",
            params = {
				isServer = false,
                event = "Perry_Saluuna:LautasRuokaa",
                args = {
					maini = maini,
                    main = "P_SIDE_GREENPEASPOTATO01X" -- value we want to pass
                }
            }
        },
    }
    exports['qbr-menu']:openMenu(bossMenu)
end)

RegisterNetEvent('Perry_Saluuna:LautasRuokaa') 
AddEventHandler('Perry_Saluuna:LautasRuokaa', function(argut)	
	local sideruoka = argut.main
	local mainruoka = argut.maini
	SetNuiFocus(false)
    local bossMenu = {
        {
            header = "Minkälainen lautanen?",
            isMenuHeader = true,
        },
        {
            header = "Ruma lautanen",
            params = {
				isServer = false,
                event = "Perry_Saluuna:LautasRuokaValmis",
                args = {
					mainruoka = mainruoka,
					sideruoka = sideruoka,
                    lautaunen = "p_plate17x" -- value we want to pass
                }
            }
        },
        {
            header = "Valkoinen lautanen",
            params = {
				isServer = false,
                event = "Perry_Saluuna:LautasRuokaValmis",
                args = {
					mainruoka = mainruoka,
					sideruoka = sideruoka,
                    lautaunen = "p_plate01x" -- value we want to pass
                }
            }
        },
        {
            header = "Valkoinen lautanen (Koristeltu)",
            params = {
				isServer = false,
                event = "Perry_Saluuna:LautasRuokaValmis",
                args = {
					mainruoka = mainruoka,
					sideruoka = sideruoka,
                    lautaunen = "p_plate02x" -- value we want to pass
                }
            }
        },
        {
            header = "Sinertävä lautanen (Koristeltu)",
            params = {
				isServer = false,
                event = "Perry_Saluuna:LautasRuokaValmis",
                args = {
					mainruoka = mainruoka,
					sideruoka = sideruoka,
                    lautaunen = "p_plate14x" -- value we want to pass
                }
            }
        },
    }
    exports['qbr-menu']:openMenu(bossMenu)
end)

RegisterNetEvent('Perry_Saluuna:LautasRuokaValmis') 
AddEventHandler('Perry_Saluuna:LautasRuokaValmis', function(argut)
	local plate = argut.lautaunen
	local main = argut.mainruoka
	local side = argut.sideruoka
	local side2 = argut.sideruoka
	PropPlacer2(plate, main, side, side2)
end)

RegisterNetEvent('Perry_Saluuna:Juomaa') 
AddEventHandler('Perry_Saluuna:Juomaa', function(argut)	
	local juoma = argut.juoma
	PropPlacer(juoma)
end)

SceneTarget = function()
    local Cam = GetGameplayCamCoord()
    local handle = Citizen.InvokeNative(0x377906D8A31E5586, Cam, GetCoordsFromCam(10.0, Cam), -1, PlayerPedId(), 4)
    local _, Hit, Coords, _, Entity = GetShapeTestResult(handle)
    return Coords
end

GetCoordsFromCam = function(distance, coords)
    local rotation = GetGameplayCamRot()
    local adjustedRotation = vector3((math.pi / 180) * rotation.x, (math.pi / 180) * rotation.y, (math.pi / 180) * rotation.z)
    local direction = vector3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.sin(adjustedRotation[1]))
    return vector3(coords[1] + direction[1] * distance, coords[2] + direction[2] * distance, coords[3] + direction[3] * distance)
end

local addMode = false

local laittaa = false

function PropPlacer(ObjectModel, soppa)	
	laittaa = true
	local x, y, z
	local PropHash = GetHashKey(ObjectModel)
	local tempObj = CreateObject(PropHash, x, y, z, false, true, false, false, true)
	SetEntityAlpha(tempObj, 60)
	SetEntityCompletelyDisableCollision(tempObj, true, true)
	SetEntityCollision(tempObj, false, false)
	while laittaa do
		Citizen.Wait(0)
		x, y, z = table.unpack(SceneTarget())
		SetEntityCoords(tempObj, x, y, z, true, true, true, false)
		local pPos = GetEntityCoords(tempObj)
		local PropPlacerGroupName  = CreateVarString(10, 'LITERAL_STRING', "PropPlacer")
		PromptSetActiveGroupThisFrame(PromptPlacerGroup, PropPlacerGroupName)
		if PromptHasHoldModeCompleted(SetPrompt) then
			DeleteEntity(tempObj)
			FreezeEntityPosition(PlayerPedId() , false)
			TriggerServerEvent("Perry_Saluuna:Serverilletuotteet",  PropHash, pPos.x , pPos.y , pPos.z)
			break
		end

		if PromptHasHoldModeCompleted(CancelPrompt) then
			DeleteEntity(tempObj)
			SetModelAsNoLongerNeeded(PropHash)
			break
		end
	end
end

function PropPlacer2(plate, main, side, side2)	
	laittaa = true
	local x, y, z
	local PropHash = GetHashKey(plate)
	local tempObj = CreateObject(PropHash, x, y, z, false, true, false, false, true)
	SetEntityAlpha(tempObj, 60)
	SetEntityCompletelyDisableCollision(tempObj, true, true)
	SetEntityCollision(tempObj, false, false)
	while laittaa do
		Citizen.Wait(0)
		x, y, z = table.unpack(SceneTarget())
		SetEntityCoords(tempObj, x, y, z, true, true, true, false)
		local pPos = GetEntityCoords(tempObj)
		local PropPlacerGroupName  = CreateVarString(10, 'LITERAL_STRING', "PropPlacer")
		PromptSetActiveGroupThisFrame(PromptPlacerGroup, PropPlacerGroupName)
		if PromptHasHoldModeCompleted(SetPrompt) then
			DeleteEntity(tempObj)
			FreezeEntityPosition(PlayerPedId() , false)
			TriggerServerEvent("Perry_Saluuna:Serverilletuotteet2", PropHash, plate, main, side, side2, pPos.x , pPos.y , pPos.z)
			break
		end

		if PromptHasHoldModeCompleted(CancelPrompt) then
			DeleteEntity(tempObj)
			SetModelAsNoLongerNeeded(PropHash)
			break
		end
	end
end

RegisterNetEvent('Perry_Saluuna:ClientTuotteet') 
AddEventHandler('Perry_Saluuna:ClientTuotteet', function(PropHash, x, y, z)	
	local tempObj3 = CreateObject(PropHash, x, y, z , false, true, false)
	Citizen.InvokeNative(0x669655FFB29EF1A9, tempObj3, 0, "Stew_Fill", 1.0)
	Citizen.InvokeNative(0xCAAF2BCCFEF37F77, tempObj3, 20)
	SetEntityCompletelyDisableCollision(tempObj3, true, true)
	SetEntityCollision(tempObj3, false, false)
	table.insert(saluunaObj, tempObj3)
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local koordit2 = GetEntityCoords(ped)
		local koordit = GetEntityCoords(tempObj3)
		local distance = GetDistanceBetweenCoords(koordit2, koordit.x, koordit.y, koordit.z, true)
		if distance <= 0.6 then
			local item_name2 = CreateVarString(10, 'LITERAL_STRING', "Tuote")
			PromptSetActiveGroupThisFrame(buttons_prompt1, item_name2)
			if not check then
				if PromptHasHoldModeCompleted(Omyt1) then
					check = true
					local pulloli = GetClosestObjectOfType(koordit.x, koordit.y, koordit.z, 1.5, PropHash, false, false, false)
					TriggerServerEvent("Perry_Saluuna:PoistaTuote", pulloli)
					Animaatiot(PropHash)
					Wait(5000)
					check = false
				end
				if PromptHasHoldModeCompleted(Cutora1) then
					check = true
					local pulloli = GetClosestObjectOfType(koordit.x, koordit.y, koordit.z, 1.5, PropHash, false, false, false)
					TriggerServerEvent("Perry_Saluuna:PoistaTuote", pulloli)
					Wait(5000)
					check = false
				end
			end
		end
	end
end)

RegisterNetEvent('Perry_Saluuna:ClientTuotteet2') 
AddEventHandler('Perry_Saluuna:ClientTuotteet2', function(PropHash,platee, mainn, sidee, sidee2, x, y, z)	
    local plate = CreateObject(GetHashKey(platee), x, y, z, true, false, false, true, true)
    local main = CreateObject(GetHashKey(mainn), x, y, z, true, false, false, true, true)
    local side = CreateObject(GetHashKey(sidee), x, y, z, true, false, false, true, true)
    AttachEntityToEntity(main, plate, 0, 0.0, -0.03, 0.00, 0.0, 0.0, 0.0, true, false, false, false, 0, true, false, false)
    AttachEntityToEntity(side, plate, 0, -0.04, 0.04, 0.00, 0.0, 0.0, 180.0, true, false, false, false, 0, true, false, false)
    AttachEntityToEntity(side2, plate, 0, 0.04, 0.04, 0.00, 0.0, 0.0, 0.0, true, false, false, false, 0, true, false, false)
	table.insert(PlateObj, plate)
	table.insert(MainObj, main)
	table.insert(SideObj, side)
	Citizen.Wait(1000)
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local koordit2 = GetEntityCoords(ped)
		local koordit = GetEntityCoords(plate)
		local distance = GetDistanceBetweenCoords(koordit2, koordit.x, koordit.y, koordit.z, true)
		if distance <= 0.6 then
			local item_name2 = CreateVarString(10, 'LITERAL_STRING', "Tuote")
			PromptSetActiveGroupThisFrame(buttons_prompt2, item_name2)
			if not check then
				if PromptHasHoldModeCompleted(SyoCustom) then
					check = true
					local lautanen = GetClosestObjectOfType(koordit.x, koordit.y, koordit.z, 1.5, GetHashKey(platee), false, false, false)
					local paaruoka = GetClosestObjectOfType(koordit.x, koordit.y, koordit.z, 1.5, GetHashKey(mainn), false, false, false)
					local sivuruoka = GetClosestObjectOfType(koordit.x, koordit.y, koordit.z, 1.5, GetHashKey(sidee), false, false, false)
					TriggerServerEvent("Perry_Saluuna:PoistaTuote2", lautanen, paaruoka, sivuruoka)
					CustomAnimaatiot(platee, mainn, sidee, sidee2)
					Wait(5000)
					check = false
				end
				if PromptHasHoldModeCompleted(PoistaCustom) then
					check = true
					local lautanen = GetClosestObjectOfType(koordit.x, koordit.y, koordit.z, 1.5, GetHashKey(platee), false, false, false)
					local paaruoka = GetClosestObjectOfType(koordit.x, koordit.y, koordit.z, 1.5, GetHashKey(mainn), false, false, false)
					local sivuruoka = GetClosestObjectOfType(koordit.x, koordit.y, koordit.z, 1.5, GetHashKey(sidee), false, false, false)
					TriggerServerEvent("Perry_Saluuna:PoistaTuote2", lautanen, paaruoka, sivuruoka)
					Wait(5000)
					check = false
				end
			end
		end
	end
	--]]
end)

function CustomAnimaatiot(platee, mainn, sidee)
	local playerPed = PlayerPedId()
    local plate = CreateObject(GetHashKey(platee), x, y, z, true, true, false, false, true)
	local fork = CreateObject("p_fork01x", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
    local main = CreateObject(GetHashKey(mainn), x, y, z, true, true, false, false, true)
    local side = CreateObject(GetHashKey(sidee), x, y, z, true, true, false, false, true)
    --local side2 = CreateObject(GetHashKey("s_bit_peach01x"), x, y, z, true, true, false, false, true)
    AttachEntityToEntity(main, plate, 0, 0.0, -0.03, 0.00, 0.0, 0.0, 0.0, true, false, false, false, 0, true, false, false)
    AttachEntityToEntity(side, plate, 0, -0.04, 0.04, 0.00, 0.0, 0.0, 180.0, true, false, false, false, 0, true, false, false)
    --AttachEntityToEntity(side2, plate, 0, 0.04, 0.04, 0.00, 0.0, 0.0, 0.0, true, false, false, false, 0, true, false, false)
	Citizen.InvokeNative(0xCAAF2BCCFEF37F77, plate, 20)
	Citizen.InvokeNative(0xCAAF2BCCFEF37F77, fork, 82)
	TaskItemInteraction_2(PlayerPedId(), 599184882, plate, GetHashKey("p_bowl04x_stew_ph_l_hand"), -583731576, 1, 0, -1.0)
	TaskItemInteraction_2(PlayerPedId(), 599184882, fork, GetHashKey("p_spoon01x_ph_r_hand"), -583731576, 1, 0, -1.0)
	Citizen.InvokeNative(0xB35370D5353995CB, PlayerPedId(), -583731576, 1.0)
	while true do 
		Citizen.Wait(1000)
		local interaction = Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, playerPed) -- _GET_ITEM_INTERACTION_FROM_PED
		if interaction == -1318807663 then
			DeleteEntity(plate)
			DeleteEntity(fork)
			DeleteEntity(main)
			DeleteEntity(side)
			--DeleteEntity(side2)
			TriggerEvent("Perry_Needs:UseItemOuter", 85, 30)
			break
		end
		if interaction == false then
			DeleteEntity(plate)
			DeleteEntity(fork)
			DeleteEntity(main)
			DeleteEntity(side)
			--DeleteEntity(side2)
			TriggerEvent("Perry_Needs:UseItemOuter", 85, 30)
			break
		end
	end
end

function Lautanen(hash)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local plate = CreateObject(hash, GetEntityCoords(PlayerPedId()), true, true, false, false, true)
	local fork = CreateObject("p_fork01x", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
	Citizen.InvokeNative(0xCAAF2BCCFEF37F77, plate, 20)
	Citizen.InvokeNative(0xCAAF2BCCFEF37F77, fork, 82)
	TaskItemInteraction_2(PlayerPedId(), 599184882, plate, GetHashKey("p_bowl04x_stew_ph_l_hand"), -583731576, 1, 0, -1.0)
	TaskItemInteraction_2(PlayerPedId(), 599184882, fork, GetHashKey("p_spoon01x_ph_r_hand"), -583731576, 1, 0, -1.0)
	Citizen.InvokeNative(0xB35370D5353995CB, PlayerPedId(), -583731576, 1.0)
	while true do 
		Citizen.Wait(1000)
		local interaction = Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, playerPed) -- _GET_ITEM_INTERACTION_FROM_PED
		if interaction == -1318807663 then
			DeleteEntity(plate)
			DeleteEntity(fork)
			TriggerEvent("Perry_Needs:UseItemOuter", 85, 30)
			break
		end
		if interaction == false then
			DeleteEntity(plate)
			DeleteEntity(fork)
			TriggerEvent("Perry_Needs:UseItemOuter", 85, 30)
			break
		end
	end
end

function Animaatiot(hash)
	if hash == 587066646 then
		TriggerEvent("Perry_Saluuna:soppa", "p_bowl04x_stew")
	elseif hash == 1110150222 then
		TriggerEvent("Perry_Saluuna:soppa", "p_bacon_cabbage01x")
	elseif hash == -1915884981 then
		TriggerEvent("Perry_Saluuna:soppa", "p_chillicurry01x")
	elseif hash == 559479694 then
		TriggerEvent("Perry_Saluuna:soppa", "p_fishstew01x")
	elseif hash == -1763136482 then
		TriggerEvent("Perry_Saluuna:soppa", "p_lobster_bisque01x")
	elseif hash == -1621868985 then
		TriggerEvent("Perry_Saluuna:soppa", "p_beefstew01x")
	elseif hash == -1776489172 then
		TriggerEvent("Perry_Saluuna:soppa", "p_oatmeal01x")
	elseif hash == 1098641034 then
		TriggerEvent("Perry_Saluuna:soppa", "p_wheat_milk01x")
	elseif hash == GetHashKey("p_bottle01x") then
		Juoma("p_bottle01x")
	elseif hash == GetHashKey("p_mugCoffee01x") then
		Juoma("p_mugCoffee01x")
	elseif hash == GetHashKey("p_bottlechampagne01x") then --- RobesPierre Shampanja
		local alcoholia = 0.2
		Alkoholi("p_bottlechampagne01x", "other", alcoholia)				   --- TOIMI
	elseif hash == GetHashKey("p_bottlecognac01x") then --- Richesse Konjakki
		local alcoholia = 0.2
		Alkoholi("p_bottlecognac01x", "other", alcoholia)					--- TOIMI	
	elseif hash == GetHashKey("p_bottleredmist01x") then --- Lahjapullo Red mist
		local alcoholia = 0.4
		Alkoholi("p_bottleredmist01x", "other", alcoholia)			 --- TOIMII
	elseif hash == GetHashKey("p_bottlesherry01x") then --- Antoinette Sherryä
		local alcoholia = 0.3
		Alkoholi("p_bottlesherry01x", "other", alcoholia)			--- TOIMII
	elseif hash == GetHashKey("p_bottletequila02x") then --- Tuntematon Tequila
		local alcoholia = 0.6
		Alkoholi("p_bottletequila02x", "other", alcoholia)			 --- TOIMII
	elseif hash == GetHashKey("p_bottletoothpwdr01x") then --- Reichards Hammasvoima
		local alcoholia = 0.8
		Alkoholi("p_bottletoothpwdr01x", "other", alcoholia)		   --- TOIMI
	elseif hash == GetHashKey("p_bottlewine04x") then --- Saint-Dymphna Valkoviini CABERNET (1894)
		local alcoholia = 0.2
		Alkoholi("p_bottlewine04x", "other", alcoholia)		  --- TOIMII
	elseif hash == GetHashKey("p_bottlebrandy01x") then --- Antonette Brandy
		local alcoholia = 0.5
		Alkoholi("p_bottlebrandy01x", "other", alcoholia)			--- TOIMII
	elseif hash == GetHashKey("p_bottlewine03x") then --- Saint-Dymphna Valkoviini MERIOT (1894)
		local alcoholia = 0.2
		Alkoholi("p_bottlewine03x", "other", alcoholia)		  --- TOIMII
	elseif hash == GetHashKey("p_bottlewine02x") then --- Chateau Gourmandise Punaviini (1895)
		local alcoholia = 0.3
		Alkoholi("p_bottlewine02x", "other", alcoholia)		  --- TOIMII
	elseif hash == GetHashKey("p_bottlewine01x") then --- Chateau Gourmandise Punaviini (1887)
		local alcoholia = 0.3
		Alkoholi("p_bottlewine01x", "other", alcoholia)		  --- TOIMII
	elseif hash == GetHashKey("p_bottleabsinthe01x") then --- Vanhan tilan absinttia
		local alcoholia = 1.5
		Alkoholi("p_bottleabsinthe01x", "other", alcoholia) 		  --- TOMII
	elseif hash == GetHashKey("p_bottle02x") then --- Limping Williams Viski
		local alcoholia = 0.6
		Alkoholi("p_bottle02x", "other", alcoholia)		  --- TOIMI
	elseif hash == GetHashKey("p_bottlebeer03x") then --- New Hanover Olut
		local alcoholia = 0.2
		Alkoholi("p_bottlebeer03x", "small", alcoholia)		  --- TOIMII
	elseif hash == GetHashKey("p_bottlebeer02x") then --- DraftHorse erikois-olut
		local alcoholia = 0.2
		Alkoholi("p_bottlebeer02x", "small", alcoholia)		  ---TOIMI
	elseif hash == GetHashKey("p_bottlebeer01x") then ---Pioneer Olut
		local alcoholia = 0.1
		Alkoholi("p_bottlebeer01x", "small", alcoholia)		  ---Toimii
	elseif hash == GetHashKey("p_bottlebeer01a_3") then --- Baltz Brewer Olut
		local alcoholia = 0.1
		Alkoholi("p_bottlebeer01a_3", "small", alcoholia)			--- Toimii
	elseif hash == GetHashKey("p_bottlebeer01a_2") then --- BlackBurnAle Olut
		local alcoholia = 0.1
		Alkoholi("p_bottlebeer01a_2", "small", alcoholia)			--- Toimii
	elseif hash == GetHashKey("p_bottlebeer01a_1") then ---McCarth Olut
		local alcoholia = 0.1
		Alkoholi("p_bottlebeer01a_1", "small", alcoholia)			--- TOIMII
	elseif hash == GetHashKey("p_bottlebeer01a") then --- Sehiffer Olut
		local alcoholia = 0.1
		Alkoholi("p_bottlebeer01a", "small", alcoholia) 		  --- TOIMII
	elseif hash == GetHashKey("p_bottle008x_big") then	--- Jätti Lager Olut
		local alcoholia = 0.3
		Alkoholi("p_bottle008x_big", "large", alcoholia)			--- TOIMI
	elseif hash == GetHashKey("p_bottle008x") then	--- Lager Olut
		local alcoholia = 0.2
		Alkoholi("p_bottle008x", "other", alcoholia)			--- TOIMII
	elseif hash == GetHashKey("p_bottle009x") then	--- Täysruis Viski
		local alcoholia = 0.4
		Alkoholi("p_bottle009x", "other", alcoholia)			--- TOIMII
	elseif hash == GetHashKey("p_bottle006x") then --- Prairie Moon Gin
		local alcoholia = 0.5
		Alkoholi("p_bottle006x", "other", alcoholia) 		   --- TOIMII
	elseif hash == GetHashKey("p_bottle011x") then  --- Talon erikoinen
		local alcoholia = 0.5
		Alkoholi("p_bottle011x", "other", alcoholia)			--- TOIMII
	elseif hash == GetHashKey("p_bottle010x") then --Absinttia
		local alcoholia = 1.0
		Alkoholi("p_bottle010x", "other", alcoholia) --TOIMII
	else
		Lautanen(hash)
	end
end

RegisterNetEvent('Perry_Saluuna:PoistaTuoteClient') 
AddEventHandler('Perry_Saluuna:PoistaTuoteClient', function(pullo)	
	for k,v in pairs(saluunaObj) do
		DeleteObject(pullo)
	end
end)

RegisterNetEvent('Perry_Saluuna:PoistaTuoteClient2') 
AddEventHandler('Perry_Saluuna:PoistaTuoteClient2', function(lautanen, paaruoka, sivuruoka, sivuruoka2)	
	for k,v in pairs(PlateObj) do
		DeleteObject(lautanen)
	end
	for k,v in pairs(MainObj) do
		DeleteObject(paaruoka)
	end
	for k,v in pairs(SideObj) do
		DeleteObject(sivuruoka)
	end
	for k,v in pairs(SideObj2) do
		DeleteObject(sivuruoka2)
	end
end)
	
RegisterNetEvent('Perry_Saluuna:DeleteEntity') 
AddEventHandler('Perry_Saluuna:DeleteEntity', function(entity)	
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	closestEntity   = entity
	DeleteEntity(closestEntity)
end)


function Alkoholi(hash, bottle, alcoholia)
	local playerPed = PlayerPedId()
	if bottle == "small" then
		local propEntity = CreateObject(hash, GetEntityCoords(PlayerPedId()), true, true, false, false, true)
		TaskItemInteraction_2(PlayerPedId(), GetHashKey('CONSUMABLE_SALOON_BEER'), propEntity, GetHashKey('P_BOTTLEBEER01X_PH_R_HAND'), -1493684811, 1, 0, -1.0)
		while true do 
			Citizen.Wait(1000)
			local interaction = Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, playerPed) -- _GET_ITEM_INTERACTION_FROM_PED
			if interaction == -1318807663 then
				print("interaction")
				local targetAlcoholContent = DecorGetFloat(player, TAC)
				targetAlcoholContent = targetAlcoholContent + alcoholia
                DecorSetFloat(player, TAC, targetAlcoholContent)
				DeleteEntity(propEntity)
				TriggerEvent("Perry_Needs:UseItemOuter", 0, 5)
				break
			end
			if interaction == false then
				local targetAlcoholContent = DecorGetFloat(player, TAC)
				targetAlcoholContent = targetAlcoholContent + alcoholia
                DecorSetFloat(player, TAC, targetAlcoholContent)
				DeleteEntity(propEntity)
				TriggerEvent("Perry_Needs:UseItemOuter", 0, 5)
				break
			end
		end
	elseif bottle == "other" then
		local propEntity = CreateObject(hash, GetEntityCoords(PlayerPedId()), true, true, false, false, true)
		TaskItemInteraction_2(PlayerPedId(), -1679900928, propEntity, GetHashKey('P_BOTTLEJD01X_PH_R_HAND'), -68870885, 1, 0, -1.0)
		while true do 
			Citizen.Wait(1000)
			local interaction = Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, playerPed) -- _GET_ITEM_INTERACTION_FROM_PED
			if interaction == -1318807663 then
				local targetAlcoholContent = DecorGetFloat(player, TAC)
				targetAlcoholContent = targetAlcoholContent + alcoholia
                DecorSetFloat(player, TAC, targetAlcoholContent)
				DeleteEntity(propEntity)
				TriggerEvent("Perry_Needs:UseItemOuter", 0, 5)
				break
			end
			if interaction == false then
				local targetAlcoholContent = DecorGetFloat(player, TAC)
				targetAlcoholContent = targetAlcoholContent + alcoholia
                DecorSetFloat(player, TAC, targetAlcoholContent)
				DeleteEntity(propEntity)
				TriggerEvent("Perry_Needs:UseItemOuter", 0, 5)
				break
			end
		end
	elseif bottle == "large" then
		local propEntity = CreateObject(hash, GetEntityCoords(PlayerPedId()), true, true, false, false, true)
		local propId = GetHashKey('P_BOTTLEJD01X_PH_R_HAND')
		local itemInteractionState = GetHashKey('DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_UNCORK')
		TaskItemInteraction_2(PlayerPedId(), GetHashKey('CONSUMABLE_SALOON_WHISKEY'), propEntity, propId, itemInteractionState, 1, 0, -1.0)
		while true do 
			Citizen.Wait(1000)
			local interaction = Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, playerPed) -- _GET_ITEM_INTERACTION_FROM_PED
			if interaction == -1318807663 then
				local targetAlcoholContent = DecorGetFloat(player, TAC)
				targetAlcoholContent = targetAlcoholContent + alcoholia
                DecorSetFloat(player, TAC, targetAlcoholContent)
				DeleteEntity(propEntity)
				TriggerEvent("Perry_Needs:UseItemOuter", 0, 5)
				break
			end
			if interaction == false then
				local targetAlcoholContent = DecorGetFloat(player, TAC)
				targetAlcoholContent = targetAlcoholContent + alcoholia
                DecorSetFloat(player, TAC, targetAlcoholContent)
				DeleteEntity(propEntity)
				TriggerEvent("Perry_Needs:UseItemOuter", 0, 5)
				break
			end
		end
	end
end

local volumeArea = Citizen.InvokeNative(0xB3FB80A32BAE3065, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 2.0) -- _CREATE_VOLUME_SPHERE
local itemSet = CreateItemset(1)
Citizen.CreateThread(function()
    while true do
        Wait(5000)
        player = PlayerPedId()
    end
end)

local drunkFxStrength = 0.0

--[[
Citizen.CreateThread(function()
    while true do
        Wait(0)
        player = PlayerPedId()
        local targetAlcoholContent = DecorGetFloat(player, TAC)
        local currentAlcoholContent = DecorGetFloat(player, CAC)
        DrawTxt('TAC: ' .. tostring(targetAlcoholContent), 0.15, 0.5125, 0.25, true, 255, 255, 255, 255, false, 0)
        DrawTxt('CAC: ' .. tostring(currentAlcoholContent), 0.15, 0.5, 0.25, true, 255, 255, 255, 255, false, 0)
        DrawTxt('DFS: ' .. tostring(drunkFxStrength), 0.15, 0.525, 0.25, true, 255, 255, 255, 255, false, 0)
    end
end)]]

local walkModified = false

local targetAdjustmentPerSecond = 1.0 / (60 * 20) -- 1.0 over 30 minutes
local currentAdjustmentPerSecond = 1.0 / (60 * 1.5) -- 1.0 over 1.5 minutes
local lastGameTime = GetGameTimer()
local lastRagdollTime = lastGameTime
Citizen.CreateThread(function()
    Wait(0)
    while true do
        Wait(500)

        player = PlayerPedId()

        -- Game Timer Delta
        local delta = (GetGameTimer() - lastGameTime) / 1000
        lastGameTime = GetGameTimer()

        -- Reduce Target Alcohol Content
        local targetAlcoholContent = DecorGetFloat(player, TAC)

        if not targetAlcoholContent then
            targetAlcoholContent = 0.0
        end

        if targetAlcoholContent > 0.0 then
            targetAlcoholContent = targetAlcoholContent - targetAdjustmentPerSecond
        else
            targetAlcoholContent = 0.0
        end

        -- Move Current Alcohol Content towards Target

        local currentAlcoholContent = DecorGetFloat(player, CAC)

        if currentAlcoholContent ~= targetAlcoholContent then
            if currentAlcoholContent > targetAlcoholContent then
                currentAlcoholContent = currentAlcoholContent - currentAdjustmentPerSecond * delta
                currentAlcoholContent = math.max(currentAlcoholContent, targetAlcoholContent)
            else
                currentAlcoholContent = currentAlcoholContent + currentAdjustmentPerSecond * delta
                currentAlcoholContent = math.min(currentAlcoholContent, targetAlcoholContent)
            end
        end

        if currentAlcoholContent > 0.0 then
            walkModified = true
            Citizen.InvokeNative(0x406CCF555B04FAD3, player, 1, currentAlcoholContent)
            if not IsGameplayCamShaking() then
                ShakeGameplayCam('DRUNK_SHAKE', 1.0)
            end
            if not AnimpostfxIsRunning('PlayerDrunk01') then
                Citizen.InvokeNative(0x5199405EABFBD7F0, 'PlayerDrunk01') -- GRAPHICS::ANIMPOSTFX_*
                AnimpostfxPlay('PlayerDrunk01')
                Citizen.InvokeNative(0x37D7BDBA89F13959, 'PlayerDrunk01')
            end
            if currentAlcoholContent > 0.5 then
                Citizen.InvokeNative(0x89F5E7ADECCCB49C, player, 'very_drunk') -- SET_WALK_TYPE
            else
                Citizen.InvokeNative(0x58F7DB5BD8FA2288, player) -- RESET_WALK ?
            end
            if currentAlcoholContent > 0.6 and not IsPedRagdoll(player) and lastGameTime - lastRagdollTime > lerp(60000, 20000, currentAlcoholContent) then
                if mathRandom() < lerp(0.01, 0.15, currentAlcoholContent) then
                    DecorSetInt(player, SLN_RAGDOLL, 1)
                    SetPedToRagdoll(player, 7500, 7500, 0, false, true, false)
                    Citizen.CreateThread(function()
                        Wait(7500)
                        DecorSetInt(player, SLN_RAGDOLL, 0)
                        lastRagdollTime = lastGameTime
                    end)
                    --AnimpostfxPlay('PlayerDrunk01_PassOut')
                    AnimpostfxPlay('CamTransitionBlink')
                end
            end
            local newDrunkFxStrength = math.max(0.0001, round(currentAlcoholContent / 2, 4))
            if newDrunkFxStrength ~= drunkFxStrength then
                SetGameplayCamShakeAmplitude(newDrunkFxStrength)
                Citizen.InvokeNative(0xCAB4DD2D5B2B7246, 'PlayerDrunk01', newDrunkFxStrength)
                drunkFxStrength = newDrunkFxStrength
            end
        elseif targetAlcoholContent == 0.0 then
            currentAlcoholContent = 0.0
            -- NOT DRUNK
            Citizen.InvokeNative(0x406CCF555B04FAD3, player, 0, currentAlcoholContent)
            if IsGameplayCamShaking() then
                Citizen.InvokeNative(0x4285804FD65D8066, 'DRUNK_SHAKE', 0)
            end
            if AnimpostfxIsRunning('PlayerDrunk01') then
                AnimpostfxStop('PlayerDrunk01')
                drunkFxStrength = 0.0
            end
            if walkModified then
                Citizen.InvokeNative(0x58F7DB5BD8FA2288, player)
                walkModified = false
            end
        end

        DecorSetFloat(player, TAC, targetAlcoholContent)
        DecorSetFloat(player, CAC, currentAlcoholContent)
    end
end)

function lerp(a,b,t) return a * (1-t) + b * t end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function DrawTxt(str, x, y, size, enableShadow, r, g, b, a, centre, font)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(1, size)
    SetTextColor(floor(r), floor(g), floor(b), floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    SetTextFontForCurrentCommand(font)
    DisplayText(str, x, y)
end

function Juoma(objekti)
	local playerPed = PlayerPedId()
    local propEntity = CreateObject(GetHashKey(objekti), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
	Citizen.InvokeNative(0x669655FFB29EF1A9, propEntity, 0, "CTRL_cupFill", 1.0)
	TaskItemInteraction_2(PlayerPedId(), GetHashKey('CONSUMABLE_COFFEE'), propEntity, GetHashKey('P_MUGCOFFEE01X_PH_R_HAND'), GetHashKey('DRINK_COFFEE_HOLD'), 1, 0, -1.0)
	while true do 
		Citizen.Wait(1000)
		local interaction = Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, playerPed) -- _GET_ITEM_INTERACTION_FROM_PED
		if interaction == -1318807663 then
			DeleteEntity(propEntity)
			TriggerEvent("Perry_Needs:UseItemOuter", 0, 30)
			break
		end
		if interaction == false then
			DeleteEntity(propEntity)
			TriggerEvent("Perry_Needs:UseItemOuter", 0, 30)
			break
		end
	end
end

function Lautanen(hash)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local plate = CreateObject(hash, GetEntityCoords(PlayerPedId()), true, true, false, false, true)
	local fork = CreateObject("p_fork01x", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
	Citizen.InvokeNative(0xCAAF2BCCFEF37F77, plate, 20)
	Citizen.InvokeNative(0xCAAF2BCCFEF37F77, fork, 82)
	TaskItemInteraction_2(PlayerPedId(), 599184882, plate, GetHashKey("p_bowl04x_stew_ph_l_hand"), -583731576, 1, 0, -1.0)
	TaskItemInteraction_2(PlayerPedId(), 599184882, fork, GetHashKey("p_spoon01x_ph_r_hand"), -583731576, 1, 0, -1.0)
	Citizen.InvokeNative(0xB35370D5353995CB, PlayerPedId(), -583731576, 1.0)
	while true do 
		Citizen.Wait(1000)
		local interaction = Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, playerPed) -- _GET_ITEM_INTERACTION_FROM_PED
		if interaction == -1318807663 then
			DeleteEntity(plate)
			DeleteEntity(fork)
			TriggerEvent("Perry_Needs:UseItemOuter", 85, 30)
			break
		end
		if interaction == false then
			DeleteEntity(plate)
			DeleteEntity(fork)
			TriggerEvent("Perry_Needs:UseItemOuter", 85, 30)
			break
		end
	end
end

RegisterNetEvent('Perry_Saluuna:soppa') 
AddEventHandler('Perry_Saluuna:soppa', function(objekti)
	local bowl = CreateObject(objekti, GetEntityCoords(PlayerPedId()), true, true, false, false, true)
	local spoon = CreateObject("p_spoon01x", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
	Citizen.InvokeNative(0x669655FFB29EF1A9, bowl, 0, "Stew_Fill", 1.0)
	Citizen.InvokeNative(0xCAAF2BCCFEF37F77, bowl, 20)
	Citizen.InvokeNative(0xCAAF2BCCFEF37F77, spoon, 82)
	TriggerEvent("Perry_Needs:UseItemOuter", 40, 20)
	TaskItemInteraction_2(PlayerPedId(), 599184882, bowl, GetHashKey("p_bowl04x_stew_ph_l_hand"), -583731576, 1, 0, -1.0)
	TaskItemInteraction_2(PlayerPedId(), 599184882, spoon, GetHashKey("p_spoon01x_ph_r_hand"), -583731576, 1, 0, -1.0)
	Citizen.InvokeNative(0xB35370D5353995CB, PlayerPedId(), -583731576, 1.0)
	while true do 
		Citizen.Wait(1000)
		local interaction = Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) -- _GET_ITEM_INTERACTION_FROM_PED
		if interaction == -1318807663 then
			DeleteEntity(bowl)
			DeleteEntity(spoon)
			TriggerEvent("Perry_Needs:UseItemOuter", 50, 50)
			break
		end
		if interaction == false then
			DeleteEntity(bowl)
			DeleteEntity(spoon)
			TriggerEvent("Perry_Needs:UseItemOuter", 50, 50)
			break
		end
	end
end)

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

function avaaPaallikkosedic(society, job)
	SetNuiFocus(false)
	menu = false
	VORPcore.RpcCall('Oku_Accounts:Haetilitiedot',function(maara) -- asynchronous 
		local elements = {
			{label = 'Sinulla on ' .. maara .. ' € tilillä',    value = ''},
			{label = 'Laita tilille rahaa',    value = 'putmoney'},
			{label = 'Ota tililtä rahaa',    value = 'takemoney'},
			{label = "Palkkaa",   value = 'palkkaa'},
			{label = "Potki",   value = 'potki'}
		}
		MenuData.Open(

			'default', GetCurrentResourceName(), 'boss',

			{

				title    = 'JOHTAJA',

				subtext    = 'JOHTAJAN VALIKKO',

				align    = 'top-left',

				elements = elements,

			},

			function(data, menu)
			
			if data.current.value == 'takemoney' then
				menu.close()
				AddTextEntry('FMMC_MPM_NA', "Kuinka paljon haluat ottaa?")
				DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", maxLength)
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait( 0 )
				end
				local amount = GetOnscreenKeyboardResult()
				if amount then
					TriggerServerEvent('Oku_Accounts:Nosta', amount, society)
				end
			elseif data.current.value == 'putmoney' then
				menu.close()
				AddTextEntry('FMMC_MPM_NA', "Kuinka paljon haluat laittaa?")
				DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", maxLength)
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait( 0 )
				end
				local amount = GetOnscreenKeyboardResult()
				if amount then
					TriggerServerEvent('Oku_Accounts:Talleta', amount, society)
				end
			elseif data.current.value == 'palkkaa' then
				menu.close()
				Palkkaa(job)
			elseif data.current.value == 'potki' then
				menu.close()
				Potki(society)
			end
		end, function(data, menu)
			menu.close()
		end) 
		
	end, society)
end

function Potki(society)
	local elements = {}
	VORPcore.RpcCall('Oku_Accounts:HaePalkatut',function(employees) -- asynchronous 
		for i=1, #employees, 1 do
			local name = employees[i].firstname
			local lname = employees[i].lastname
			local grade = employees[i].grade
			local identifier = employees[i].identifier
			local charidentifier = employees[i].charidentifier

            table.insert(elements, { label = "Nimi: "..name.." "..lname.." TASO: "..grade, value = identifier, charid = charidentifier, lname = lname })
        end

        if ( #elements == 0 ) then
            table.insert(elements, { label = 'Ei ole ketään paikalla!',})
        end

		MenuData.Open(

			'default', GetCurrentResourceName(), 'potkupaallikko_menu',

			{

				title    = 'POTKUT',

				subtext    = '',

				align    = 'center',

				elements = elements,

			},

			function(data, menu)
			
			
			identifier = data.current.value
			charid = data.current.charid
			print(identifier)
			print(charid)
			menu.close()
			MenuData.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm', {
				title    = 'Haluatko varmasti potkia?',
				align    = 'center',
				elements = {
					{label = "Ei", value = 'no'},
					{label = "Kyllä", value = 'yes'}
			}}, function(data2, menu2)
				if data2.current.value == 'yes' then
					print("Potkut")
					TriggerServerEvent("Oku_Accounts:PotkiPelaaja", identifier, charid)
					menu2.close()
				elseif data2.current.value == 'no' then
					print("Ei Potkittu")
					menu2.close()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end) 
	end, society)
end

function Palkkaa(job)
	local elements = {}
	VORPcore.RpcCall('Oku_Accounts:HaePelaajat',function(pelaajat) -- asynchronous 

        for _, v in pairs(pelaajat) do
			local name = v.nimi
			local id = v.id
            table.insert(elements, { label = " ID " .. id, value = id })
        end

        if ( #elements == 0 ) then
            table.insert(elements, { label = 'Ei ole ketään paikalla!',})
        end

		MenuData.Open(

			'default', GetCurrentResourceName(), 'palkkauspaallikko_menu',

			{

				title    = 'PALKKAUS',

				subtext    = '',

				align    = 'center',

				elements = elements,

			},

			function(data, menu)
			
			
			TargetId = data.current.value
			menu.close()
			MenuData.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm', {
				title    = 'Haluatko varmasti palkata?',
				align    = 'center',
				elements = {
					{label = "Ei", value = 'no'},
					{label = "Kyllä", value = 'yes'}
			}}, function(data2, menu2)
				if data2.current.value == 'yes' then
					menu2.close()
					maxLength = 5
					AddTextEntry('FMMC_MPM_NA', "Mille arvolle? 1-10")
					DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", maxLength)
					while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
						Citizen.Wait( 0 )
					end
				
					local grade = tonumber(GetOnscreenKeyboardResult())

					TriggerServerEvent("Oku_Accounts:PalkkaaPelaaja", TargetId, job, grade)
				elseif data2.current.value == 'no' then
					menu2.close()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end) 
	end)
end

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if IsControlJustPressed(0, 0xD8F73058) then
			AvaaSaluunaMenu()
			Citizen.Wait(1000)
        end
	end
end)

function AvaaSaluunaMenu()

	VORPcore.RpcCall('Perry_Saluuna:HaeTiedotJob',function(tiedot) -- asynchronous 
		if tiedot.grade >= 2 and tiedot.job == "saluuna" then
			local elements = {
					{label = "Tarkista paperit", value = 'tarkistap'},
					{label = "Tarkista laskut", value = 'laskut'},
					{label = "Anna lasku", value = 'annas'},
					{label = "Animaatiot", value = 'anime'}
			}
			MenuData.Open(

				'default', GetCurrentResourceName(), 'saluuna_menu',

				{

					title    = 'Saluuna',

					subtext    = 'Saluuna valikko',

					align    = 'top-left',

					elements = elements,

				},

				function(data, menu)
				
				local category = data.current.value
				if category == 'tarkistap' then
					menu.close()
					local closestPlayer, closestDistance = GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						print(PlayerPedId())
						print(GetPlayerServerId(closestPlayer))
						local player = PlayerPedId()
						print(GetPlayerServerId(PlayerId()))
						TriggerServerEvent("syn_id:open2",GetPlayerServerId(closestPlayer))
					end
				elseif category == 'annas' then
					menu.close()
					local closestPlayer, closestDistance = GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						exports['mythic_notify']:DoLongHudText('Error', 'Ei ketään lähettyvillä')
					else
						OpenFineMenu(closestPlayer)
					end
				elseif category == 'laskut' then
					menu.close()
					local closestPlayer, closestDistance = GetClosestPlayer()
					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						OpenUnpaidBillsMenu(closestPlayer)
					else
						exports['mythic_notify']:DoLongHudText('Error', 'Ei ketään lähettyvillä')
					end
				elseif category == 'anime' then
					menu.close()
					local elements = {
							{label = "Puhdista laseja", value = 'plasi'},
							{label = "Puhdista pöytä", value = 'ppoyta'},
							{label = "Tarjoile", value = 'tarolut'}
					}
					MenuData.Open(

						'default', GetCurrentResourceName(), 'saluuna_menu',

						{

							title    = 'Saluuna',

							subtext    = 'Saluuna valikko',

							align    = 'top-left',

							elements = elements,

						},

						function(data, menu2)
						
						local category = data.current.value
						if category == "plasi" then
							menu2.close()
							local playerPed = PlayerPedId()
							local prop_name = 'p_glass01x'
							local x,y,z = table.unpack(GetEntityCoords(playerPed))
							local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
							local boneIndex = GetEntityBoneIndexByName(playerPed, "PH_L_HAND")

							RequestAnimDict("amb_work@world_human_bartender@cleaning@glass@male_b@idle_b")
							while not HasAnimDictLoaded("amb_work@world_human_bartender@cleaning@glass@male_b@idle_b") do
								Citizen.Wait(100)
							end
							TaskPlayAnim(playerPed, "amb_work@world_human_bartender@cleaning@glass@male_b@idle_b", "idle_d", 8.0, 8.0, 12600, 1, 0, true, 0, false, 0, false)
							AttachEntityToEntity(prop, playerPed, boneIndex, 0.02, 0.028, 0.001, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
							Citizen.Wait(10000)
							DeleteObject(prop)
						elseif category == "ppoyta" then
							menu2.close()
							local playerPed = PlayerPedId()
							local prop_name = 'p_cs_rag01x'
							local x,y,z = table.unpack(GetEntityCoords(playerPed))
							local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
							local boneIndex = GetEntityBoneIndexByName(playerPed, "PH_R_HAND")

							RequestAnimDict("amb_work@world_human_clean_table@male_b@idle_c")
							while not HasAnimDictLoaded("amb_work@world_human_clean_table@male_b@idle_c") do
								Citizen.Wait(100)
							end
							TaskPlayAnim(playerPed, "amb_work@world_human_clean_table@male_b@idle_c", "idle_g", 8.0, 8.0, 12600, 1, 0, true, 0, false, 0, false)
							AttachEntityToEntity(prop, playerPed, boneIndex, 0.02, 0.028, 0.001, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
							Citizen.Wait(10000)
							DeleteObject(prop)
						elseif category == "tarolut" then
							menu2.close()
							local playerPed = PlayerPedId()
							local prop_name = 'p_beermugglass01x'
							local x,y,z = table.unpack(GetEntityCoords(playerPed))
							local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
							local boneIndex = GetEntityBoneIndexByName(playerPed, "PH_R_HAND")

							RequestAnimDict("amb_rest_drunk@world_human_bottle_pickup@table@box@female_b@react_look@exit@generic")
							while not HasAnimDictLoaded("amb_rest_drunk@world_human_bottle_pickup@table@box@female_b@react_look@exit@generic") do
								Citizen.Wait(100)
							end
							TaskPlayAnim(playerPed, "amb_rest_drunk@world_human_bottle_pickup@table@box@female_b@react_look@exit@generic", "react_look_right_exit", 8.0, 8.0, 3000, 1, 0, true, 0, false, 0, false)
							AttachEntityToEntity(prop, playerPed, boneIndex, 0.02, 0.028, 0.001, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
							Citizen.Wait(10000)	
							DeleteObject(prop)				
						end
					end, function(data, menu2)
						menu2.close()
					end) 
				end
			end, function(data, menu)
				menu.close()
			end) 
		end
	end)
end

function OpenUnpaidBillsMenu(player)
	local elements = {}
	VORPcore.RpcCall('Oku_Laskutus:getTargetBills',function(bills) -- asynchronous 
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, bill.amount),
				billId = bill.id
			})
		end

		MenuData.Open('default', GetCurrentResourceName(), 'billing', {
			title    = "Laskut",
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenFineMenu(player)
	MenuData.Open(
		'dialog', GetCurrentResourceName(), 'vitunpaska_menu',
		{
			title = "Syötä laskun nimi"
		},
	function(data, menu)
		local name = tostring(data.value)
		menu.close()
		if string.len(name) >= 1 and string.len(name) <= 15 and name ~= nil then
			Citizen.Wait(200)
			maxLength = 5
			AddTextEntry('FMMC_MPM_NA', "Syötä laskun hinta")
			DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", maxLength)
			while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
				Citizen.Wait( 0 )
			end
	
			local palkkio = GetOnscreenKeyboardResult()
			UnblockMenuInput()
			if string.len(palkkio) >= 1 and string.len(palkkio) <= 15 and palkkio ~= nil then
				TriggerServerEvent('Oku_Laskutus:sendBill', GetPlayerServerId(player), 'society_saluuna', name, palkkio)
			else
				exports['mythic_notify']:DoLongHudText('Error', 'Palkkio on virheellinen!')
			end
		else
			exports['mythic_notify']:DoLongHudText('Error', 'Nimi on virheellinen!')
		end
	end, function(data, menu)
	end)
end

function IsPlayerNearCoords(x, y, z)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(PlayerPedId(), 0))
    local distance = Vdist2(playerx, playery, playerz, x, y, z, true) -- USE VDIST

    if distance < 1.0 then
        return true
    end
end

Citizen.CreateThread(function()
    for k,v in pairs(Config.Saluunat) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.position)
        SetBlipSprite(blip, 1879260108, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.blipname)
    end
end)

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
    local playerPed, playerId = PlayerPedId(), PlayerId()
    local coords, usePlayerPed = coords, false
    
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end
    
    for i=1, #players, 1 do
        local tgt = GetPlayerPed(players[i])

        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then

            local targetCoords = GetEntityCoords(tgt)
            local distance = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end