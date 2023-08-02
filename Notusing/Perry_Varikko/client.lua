ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

local modeltodelete = nil

Citizen.CreateThread(function()
	local model = "cs_nbxpolicechiefformal"
	local _model = GetHashKey( model )
    while not HasModelLoaded( _model ) do
        Wait(1)
        modelrequest( _model )
    end
	NpcPed = CreatePed(_model, 2482.53, -1311.98, 48.87-1.0, 267.61, false, false, 0, 0)
	Citizen.InvokeNative(0x283978A15512B2FE, NpcPed, true)
	FreezeEntityPosition(NpcPed, true) 
	SetEntityInvincible(NpcPed, true)
	SetBlockingOfNonTemporaryEvents(NpcPed, true)
	TaskStartScenarioInPlace(NpcPed, GetHashKey("world_human_write_notebook"), -1, true, false, false, false)
	
end)

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  DeletePed(NpcPed)
  SetModelAsNoLongerNeeded(NpcPed)
end)

RegisterNetEvent('Perry_Varikko:AvaaVarikko')
AddEventHandler('Perry_Varikko:AvaaVarikko', function()
	local elements = {}
	ESX.TriggerServerCallback('Perry_Varikko:Tarkistakaikki', function(kaikki)
        for _, v in pairs(kaikki) do
			local model = v.model
			local name = v.name
			local talli = v.talli
			local hinta = 5
            table.insert(elements, { label = "Nimi: "..name.." | TALLI: "..talli.." | HINTA: "..hinta.."$", value = name, model = model, name = name, hinta = hinta })
        end

        if ( #elements == 0 ) then
            table.insert(elements, { label = 'Sinulla ei ole hevosia varikolla!',})
        end
		MenuData.Open(

			'default', GetCurrentResourceName(), 'sellit222233_menu_menu',

			{

				title    = 'Varikko',

				subtext    = '',

				align    = 'top-left',

				elements = elements,

			},

			function(data, menu)
			
			local category = data.current.value
			local hinta = data.current.hinta
			local name = data.current.name
			local model = data.current.model
			if category == category then
				menu.close()	
				MenuData.Open('default', GetCurrentResourceName(), 'hahaaaaa_confirm', {
					title    = 'Palautetaanko talliin?',
					align    = 'center',
					elements = {
						{label = "Ei", value = 'no'},
						{label = "Kyllä", value = 'yes'}
				}}, function(data2, menu2)
					if data2.current.value == 'yes' then
						menu2.close()
						TriggerServerEvent("Perry_Varikko:OtetaanTalliin", model, name, hinta)
					elseif data2.current.value == 'no' then
						print("Ei vapautettu")
						menu2.close()
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			end
		end, function(data, menu)
			menu.close()
		end) 
	end)
end)