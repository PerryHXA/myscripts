ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


local paine = 0
local lampotila = 0 
local jaahdytys = -10
local kunto = 0 
local aika = 20
local keittaa = false
local firstart = true

local prompts = GetRandomIntInRange(0, 0xffffff)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = "Paina"
	AvaaJuomia = PromptRegisterBegin()
	PromptSetControlAction(AvaaJuomia,  0x760A9C6F) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(AvaaJuomia, str)
	PromptSetEnabled(AvaaJuomia, 1)
	PromptSetVisible(AvaaJuomia, 1)
	PromptSetStandardMode(AvaaJuomia,1)
    PromptSetHoldMode(AvaaJuomia, 1)
	PromptSetGroup(AvaaJuomia, prompts)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,AvaaJuomia,true)
	PromptRegisterEnd(AvaaJuomia)
end)

local prompts2 = GetRandomIntInRange(0, 0xffffff)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = "Paina"
	Laitapuuta = PromptRegisterBegin()
	PromptSetControlAction(Laitapuuta,  0x760A9C6F) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(Laitapuuta, str)
	PromptSetEnabled(Laitapuuta, 1)
	PromptSetVisible(Laitapuuta, 1)
	PromptSetStandardMode(Laitapuuta,1)
    PromptSetHoldMode(Laitapuuta, 1)
	PromptSetGroup(Laitapuuta, prompts2)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,Laitapuuta,true)
	PromptRegisterEnd(Laitapuuta)
end)

local prompts3 = GetRandomIntInRange(0, 0xffffff)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = "Paina"
	saadaPaine = PromptRegisterBegin()
	PromptSetControlAction(saadaPaine,  0x760A9C6F) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(saadaPaine, str)
	PromptSetEnabled(saadaPaine, 1)
	PromptSetVisible(saadaPaine, 1)
	PromptSetStandardMode(saadaPaine,1)
    PromptSetHoldMode(saadaPaine, 1)
	PromptSetGroup(saadaPaine, prompts3)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,saadaPaine,true)
	PromptRegisterEnd(saadaPaine)
end)

local prompts4 = GetRandomIntInRange(0, 0xffffff)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    local str = "Paina"
	saadaJaahy = PromptRegisterBegin()
	PromptSetControlAction(saadaJaahy,  0x760A9C6F) 
	str = CreateVarString(10, 'LITERAL_STRING', str)
	PromptSetText(saadaJaahy, str)
	PromptSetEnabled(saadaJaahy, 1)
	PromptSetVisible(saadaJaahy, 1)
	PromptSetStandardMode(saadaJaahy,1)
    PromptSetHoldMode(saadaJaahy, 1)
	PromptSetGroup(saadaJaahy, prompts4)
	Citizen.InvokeNative(0xC5F428EE08FA7F2C,saadaJaahy,true)
	PromptRegisterEnd(saadaJaahy)
end)

AddEventHandler("Perry_tislain:menut",function()
    while keittaa do
		Citizen.Wait(0)
		if keittaa then
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
			local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 1484.03, -7157.30, 72.92, true)
			if dist < 1.8 then
				DrawText3Ds(1484.03, -7157.30, 72.92 + 0.8, "Lämpötila: ~e~"..lampotila.." °C")
				DrawText3Ds(1484.03, -7157.30, 72.92 + 0.7, "Paine: ~e~"..paine.." (kPa)")
				DrawText3Ds(1484.03, -7157.30, 72.92 + 0.6, "Jäähdytin: "..GetColor(jaahdytys)..jaahdytys.." °C")
				DrawText3Ds(1484.03, -7157.30, 72.92 + 0.4, "Aikaa "..aika.." sekuntia")
			end
		else
			break
		end
	end
end)

AddEventHandler("Perry_tislain:timeri",function(category)
	while keittaa do
		Citizen.Wait(1000)
		aika = aika - 1
		if aika <= 0 then
			TriggerServerEvent("Perry_tislain:Palkkio",category, paine, lampotila)
			aika = 0
			paine = 0
			lampotila = 0 
			jaahdytys = -10
			kunto = 0 
			aika = 60
			keittaa = false
			firstart = true
		end
	end
end)

Citizen.CreateThread(function(time)
    while true do
		Citizen.Wait(0)
	    local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
		local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 1483.88, -7161.66, 72.93, true)
		if dist < 1.8  and keittaa == false then
			local label  = CreateVarString(10, 'LITERAL_STRING', "KEITIN") -- TRANSLATE HERE
			PromptSetActiveGroupThisFrame(prompts, label)
			if Citizen.InvokeNative(0xC92AC953F0A982AE,AvaaJuomia) then
				AvaaJuomat()
			end
		end
	end
end)

function AvaaJuomat()
	local elements = {}

	local elements = {
		{label = 'Keitä Kotikaljaa', value = 'kotikalja'},
		{label = "Keitä Omenakilju", value = 'omenakilju'},
		{label = "Keitä Päärynäkiljua", value = 'paarynakilju'},
		{label = "Keitä Karhunvatukkaolut", value = 'karhunvatukkaolut'},
		{label = "Keitä Inkivääriolutta", value = 'inkiolut'},
		{label = "Keitä Rommia", value = 'rommi'},
		{label = "Keitä Kotiviiniä", value = 'kotiviini'},
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'keittinnn_menu',

		{

			title    = 'KOTIKEITIN',

			subtext    = '',

			align    = 'center',

			elements = elements,

		},

		function(data, menu)
		
		local category = data.current.value
		if category == "kotikalja" then
			menu.close()
			ESX.TriggerServerCallback('Perry_tislain:HaeTavarat', function(hasTavarat)
				if hasTavarat then
					keittaa = true
					TriggerEvent("Perry_tislain:funktiot",category)
				end
			end, "kotikalja")
		elseif category == "omenakilju" then
			ESX.TriggerServerCallback('Perry_tislain:HaeTavarat', function(hasTavarat)
				if hasTavarat then
					keittaa = true
					TriggerEvent("Perry_tislain:funktiot",category)
				end
			end, "omenakilju")
		elseif category == "paarynakilju" then
			ESX.TriggerServerCallback('Perry_tislain:HaeTavarat', function(hasTavarat)
				if hasTavarat then
					keittaa = true
					TriggerEvent("Perry_tislain:funktiot",category)
				end
			end, "paarynakilju")
		elseif category == "karhunvatukkaolut" then
			ESX.TriggerServerCallback('Perry_tislain:HaeTavarat', function(hasTavarat)
				if hasTavarat then
					keittaa = true
					TriggerEvent("Perry_tislain:funktiot",category)
				end
			end, "karhunvatukkaolut")
		elseif category == "inkiolut" then
			ESX.TriggerServerCallback('Perry_tislain:HaeTavarat', function(hasTavarat)
				if hasTavarat then
					keittaa = true
					TriggerEvent("Perry_tislain:funktiot",category)
				end
			end, "inkiolut")
		elseif category == "rommi" then
			ESX.TriggerServerCallback('Perry_tislain:HaeTavarat', function(hasTavarat)
				if hasTavarat then
					keittaa = true
					TriggerEvent("Perry_tislain:funktiot",category)
				end
			end, "rommi")
		elseif category == "kotiviini" then
			ESX.TriggerServerCallback('Perry_tislain:HaeTavarat', function(hasTavarat)
				if hasTavarat then
					keittaa = true
					TriggerEvent("Perry_tislain:funktiot",category)
				end
			end, "kotiviini")
		end
	end, function(data, menu)
		menu.close()
	end)
end

AddEventHandler("Perry_tislain:funktiot",function(category)
	exports['mythic_notify']:DoLongHudText('Error', 'Käynnistä uuni!')
    while keittaa do
		Citizen.Wait(0)
	    local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
		local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 1477.20, -7161.54, 72.92, true)
		local dist2 = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 1492.43, -7151.97, 72.92, true)
		local dist3 = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 1477.85, -7166.91, 72.92, true)
		print(dist2)
		if dist < 1.8 then
			local label  = CreateVarString(10, 'LITERAL_STRING', "UUNI") -- TRANSLATE HERE
			PromptSetActiveGroupThisFrame(prompts2, label)
			if Citizen.InvokeNative(0xC92AC953F0A982AE,Laitapuuta) then
				ESX.TriggerServerCallback('Perry_tislain:HaePuuta', function(hasPuuta)
					if hasPuuta then
						if firstart == true then
							lampotila = lampotila + 50
							firstart = false
							TriggerEvent("Perry_tislain:timeri", category)
							TriggerEvent("Perry_tislain:menut")
						else
							if lampotila > 100 then
								Savuttaa()
							else
								lampotila = lampotila + 10
							end
						end
					end
				end)
			end
		end
		if dist2 < 1.8 and firstart == false then 
			local label  = CreateVarString(10, 'LITERAL_STRING', "PAINE") -- TRANSLATE HERE
			PromptSetActiveGroupThisFrame(prompts3, label)
			if Citizen.InvokeNative(0xC92AC953F0A982AE,saadaPaine) then
				local elements = {}

				local elements = {
					{label = 'Nosta painetta', value = 'nosta'},
					{label = "Laske painetta", value = 'laske'},
				}
				MenuData.Open(

					'default', GetCurrentResourceName(), 'paineanturi_menu',

					{

						title    = 'PAINEANTURI',

						subtext    = '',

						align    = 'center',

						elements = elements,

					},

					function(data, menu)
					
					local category = data.current.value
					if category == "nosta" then
						menu.close()
						if paine > 10 then
							Rajahdys()
						else
							paine = paine + 1
							exports['mythic_notify']:DoLongHudText('Error', 'Nostettu painetta!')
						end
					elseif category == "laske" then
						if paine > 0 then
							menu.close()
							paine = paine - 1
							exports['mythic_notify']:DoLongHudText('Error', 'Laskettu painetta!')
						else
							menu.close()
						end
					end
				end, function(data, menu)
					menu.close()
				end)
			end
		end
		if dist3 < 1.8 and firstart == false then 
			local label  = CreateVarString(10, 'LITERAL_STRING', "JÄÄHDYTYS") -- TRANSLATE HERE
			PromptSetActiveGroupThisFrame(prompts4, label)
			if Citizen.InvokeNative(0xC92AC953F0A982AE,saadaJaahy) then
				exports['mythic_notify']:DoLongHudText('Error', 'Jäähdytetty!')
				lampotila = lampotila - 10
			end
		end
	end
end)

function Savuttaa()

end

function Rajahdys()
	Citizen.InvokeNative(0x7D6F58F69DA92530, 1484.03, -7157.30, 72.92, 26, 1.0, true, false, true)
	aika = 0
	paine = 0
	lampotila = 0 
	jaahdytys = -10
	kunto = 0 
	aika = 60
	keittaa = false
	firstart = true
end

function GetColor(v)
  if not v then return " ~s~"; end
  if v>=95.0 then return " ~t1~"
  elseif v>=80.0 then return " ~pa~"
  elseif v>=60.0 then return " ~t6~"
  elseif v>=40.0 then return " ~o~"
  elseif v>=20.0 then return " ~d~"
  elseif v>=0.0 then return " ~e~"
  else return " ~s~"
  end
end

function GetColor2(v)
  if not v then return " ~s~"; end
  if v>=95.0 then return " ~t1~"
  elseif v>=80.0 then return " ~pa~"
  elseif v>=60.0 then return " ~t6~"
  elseif v>=40.0 then return " ~o~"
  elseif v>=20.0 then return " ~d~"
  elseif v>=0.0 then return " ~e~"
  else return " ~s~"
  end
end

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
end