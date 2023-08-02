local prompts = GetRandomIntInRange(0, 0xffffff)
local PromptPlacerGroup = GetRandomIntInRange(0, 0xffffff)
local modeltodelete
katkot, katkoObj = {}, {}

local check = false

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

local buttons_prompt1 = GetRandomIntInRange(0, 0xffffff)

function Button_Prompt1()
	Citizen.CreateThread(function()
        local str = "Avaa"
        Omyt1 = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(Omyt1, 0x27D1C284)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Omyt1, str)
        PromptSetEnabled(Omyt1, true)
        PromptSetVisible(Omyt1, true)
        PromptSetHoldMode(Omyt1, true)
        PromptSetGroup(Omyt1, buttons_prompt1)
        PromptRegisterEnd(Omyt1)
	end)
end

Citizen.CreateThread(function()
    Button_Prompt1()
    local inCorrect = {}

	while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
    local function createProp()
        local object = `p_strongbox_muddy_01x`
        if ( #katkot > 0) then
            for i,v in ipairs(katkot) do
                local cord = json.decode(v.coords)
                local obj = CreateObject(object, vector3(cord['x'],cord['y'],cord['z']), false, true, false)
                SetEntityHeading(obj, cord['h'])
                FreezeEntityPosition(obj, true)
                PlaceObjectOnGroundProperly(obj)

                local x,y,z = table.unpack(GetEntityCoords(obj))
                local heading = GetEntityHeading(obj)

                v.coords = {}
                v.coords['x'] = x
                v.coords['y'] = y
                v.coords['z'] = z
                v.coords['h'] = heading
                v.coords = json.encode(v.coords)
                table.insert(katkoObj, obj)
            end
        end
    end
	function OpenHallinta(katkotID)
		local elements = {
            { label = 'Laita tavara', value = 'put' },
            { label = 'Ota tavara', value = 'take' },
        }
		
		table.insert(elements, {label = 'Pura maastokätkö', value = 'siirto'})
        MenuData.Open('default', GetCurrentResourceName(), 'lel',
            {
                title    = 'Maastokätkö',
                align    = 'bottom-right',
                elements = elements
            }, function(data, menu)

                if data.current.value == 'put' then
					menu.close()
					check = false
					LaitaTavaraa(katkot[katkotID].id)
                elseif data.current.value == 'take' then
					menu.close()
					check = false
					OtaTavaraa(katkot[katkotID].id)
                elseif data.current.value == 'siirto' then       
                    menu.close()
					check = false
                    ESX.TriggerServerCallback('Perry_Katko:remove', function(data)
                        ClearPedTasks(GetPlayerPed(-1))
                    end, katkot[katkotID].id)
                end
        end, function(data, menu)
            menu.close()
			check = false
        end)
	end
    ESX.TriggerServerCallback('Perry_Katko:getData', function(data)
        katkot = data
        createProp(katkot)
    end)
    Citizen.CreateThread(function()
        while true do
			sleep = 3000
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
            if ( #katkot > 0 ) then
                local pedCoords = GetEntityCoords(PlayerPedId())
                for i,v in ipairs(katkot) do
					sleep = 5
					local cord = json.decode(v.coords)
					if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, cord['x'],cord['y'],cord['z'], false) <= 3.0 then
						if not check then
							local item_name2 = CreateVarString(10, 'LITERAL_STRING', "Maastokätkö")
							PromptSetActiveGroupThisFrame(buttons_prompt1, item_name2)
							if PromptHasHoldModeCompleted(Omyt1) then
								check = true
								OpenHallinta(i)
							end
						end
					else
						sleep = 3000
					end
                end 
                Citizen.Wait(sleep)
            else
                Citizen.Wait(sleep)
            end
        end
    end)
    RegisterNetEvent('Perry_Katko:load')
    AddEventHandler('Perry_Katko:load', function()
        ESX.TriggerServerCallback('Perry_Katko:getData', function(data)
            katkot = data
            if ( #katkoObj > 0 ) then
                for i,v in pairs(katkoObj) do
                    DeleteEntity(v)
                end
            end
            createProp(katkot)
        end)
    end)
end)

function OtaTavaraa(stashid)
    ESX.TriggerServerCallback('Perry_Katko:HaeKaappiTavarat', function(inventory)
        local elements = {}

        for i,v in ipairs(inventory.items) do
            if v['amount'] > 0 then
                table.insert(elements, { label = v['label'] .. ' x' .. v['amount'], value = v['name'], labeli = v['label'] })
            end
        end

        if ( #elements == 0 ) then
            table.insert(elements, { label = 'Tyhjä!',})
        end

        MenuData.Open('default', GetCurrentResourceName(), 'kaappi22-inventory',
        {
            title    = 'Tavarat',
            align    = 'center',
            elements = elements
        }, function(data, menu)
			
			menu.close()
            MenuData.Open('dialog', GetCurrentResourceName(), 'get_item_count', {
                title = 'Määrä'
            }, function(data2, menu)
                local quantity = tonumber(data2.value)
                if quantity == nil then
					exports['mythic_notify']:DoLongHudText('Error', 'Virheellinen määrä!')
                else
                    menu.close()
					TriggerServerEvent("Perry_Katko:OtaTavaraKaapista", data.current.value, quantity, stashid, data.current.labeli)
                end
            end, function(data2,menu)
                menu.close()
            end)
            
        end, function(data, menu)
            menu.close()
        end)
    end, stashid)
end

function LaitaTavaraa(stashid)
	ESX.TriggerServerCallback('Perry_Katko:HaeTavarat', function(inventory)
	
        local elements = {}
        for i=1, #inventory.items, 1 do
            local item = inventory.items[i]
			table.insert(elements, { label = item.label .. " (" .. item.count .. " KPL)", id = item.name, qt = item.count, labeli = item.label })
        end
        
        if ( #elements == 0 ) then
            table.insert(elements, { label = 'Sinulla ei ole mitään!',})
        end
	
		MenuData.Open(

			'default', GetCurrentResourceName(), 'ryostomenuu2_menu',

			{

				title    = 'Pelaajan tavarat',

				subtext    = '',

				align    = 'center',

				elements = elements,

			},

			function(data, menu)
			menu.close()
			local id = data.current.id
			local qt = data.current.qt
			local label = data.current.labeli
			MenuData.Open('dialog', GetCurrentResourceName(), 'kaappi_laitto_tavara', {
				title = 'Kuinka monta haluat laittaa?'
			}, function(data3, menu3)
				menu3.close()
				local count = tonumber(data3.value)
				if count <= tonumber(qt) then
					TriggerServerEvent("Perry_Katko:LaitaTavara", id, count, stashid, label)
				else
					exports['mythic_notify']:DoLongHudText('Error', 'Sinulla ei ole noin paljoa!')
				end
			end, function(data3, menu3)
				menu3.close()
			end)
		end, function(data, menu)
			menu.close()
			opened = false
		end) 
	end, stashid)
end

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	DeleteObject(obj)
    for i,v in pairs(katkoObj) do
		DeleteObject(v)
		DeleteEntity(v)
    end
end)


Citizen.CreateThread(function()
    Set()
    Del()
    RotateLeft()
    RotateRight()
end)

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
        PromptSetControlAction(SetPrompt, 0x07CE1E61)
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

local EkatInput = {
	type = "enableinput", -- dont touch
	inputType = "input", -- or text area for sending messages
	button = "Hyväksy", -- button name
	placeholder = "", --placeholdername
	style = "block", --- dont touch
	attributes = {
		inputHeader = "Syötä salasana (Vain numeroita)", -- header
		type = "number", -- inputype text, number,date.etc if number comment out the pattern
		pattern = "[0-9]{1,20}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
		title = "must be only numbers min 1 max 20", -- if input doesnt match show this message
		style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
	}
}

local paska = false

RegisterNetEvent('Perry_Katkot:LaitaKatko') 
AddEventHandler('Perry_Katkot:LaitaKatko', function()	
	local ObjectModel = "p_strongbox_muddy_01x"
	laittaa = true
	local x, y, z
	local PropHash = GetHashKey(ObjectModel)
	local tempObj = CreateObject(PropHash, x, y, z, false, true, false, false, true)
	local heading = GetEntityHeading(PlayerPedId())
	SetEntityAlpha(tempObj, 60)
	SetEntityCompletelyDisableCollision(tempObj, true, true)
	SetEntityCollision(tempObj, false, false)
	while laittaa do
		Citizen.Wait(0)
		x, y, z = table.unpack(SceneTarget())
		Citizen.InvokeNative(0x203BEFFDBE12E96A,tempObj, x, y, z, heading, true, true, true)
		local pPos = GetEntityCoords(tempObj)
		local PropPlacerGroupName  = CreateVarString(10, 'LITERAL_STRING', "PropPlacer")
		PromptSetActiveGroupThisFrame(PromptPlacerGroup, PropPlacerGroupName)
		if PromptHasStandardModeCompleted(RotateLeftPrompt) then
			heading = heading - 5
		end
		if PromptHasStandardModeCompleted(RotateRightPrompt) then
			heading = heading + 5
		end
		if PromptHasHoldModeCompleted(SetPrompt) then
			FreezeEntityPosition(PlayerPedId() , true)
			DeleteEntity(tempObj)
			local tempObj3 = CreateObject(PropHash, pPos.x , pPos.y , pPos.z , true, true, false, false, true)
			SetEntityHeading(tempObj3, heading)
			PlaceObjectOnGroundProperly(tempObj3)
			FreezeEntityPosition(tempObj3 , true)
			FreezeEntityPosition(PlayerPedId() , false)
			local pass1,pass2 = nil,nil
			local elements = {
				{ label = 'Hyväksy', value = 'hyvaksy' },
				{ label = 'Peruuta', value = 'hylkaa' },
			}
			MenuData.Open('default', GetCurrentResourceName(), 'lel',
				{
					title    = 'Oletko varma?',
					align    = 'middle',
					elements = elements
				}, function(data, menu)

					if data.current.value == 'hyvaksy' then
						menu.close()
						DeleteEntity(tempObj3)
						TriggerServerEvent("Perry_Katko:LaitaDatabase", pPos.x , pPos.y , pPos.z, heading, pass1)
						modeltodelete = tempObj3
					elseif data.current.value == 'hylkaa' then
						menu.close()
						DeleteEntity(tempObj3)
						TriggerServerEvent("Perry_Katko:AnnaTakas")
					end
			end, function(data, menu)
				menu.close()
			end)
			break
		end

		if PromptHasHoldModeCompleted(CancelPrompt) then
			DeleteEntity(tempObj2)
			DeleteEntity(tempObj)
			SetModelAsNoLongerNeeded(PropHash)
			TriggerServerEvent("Perry_Katko:AnnaTakas")
			break
		end
	end
end)

