ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

ESX.RegisterServerCallback('Perry_tislain:HaeTavarat', function(source, cb, kategoria)
	local _source = source
	if kategoria == "kotikalja" then
		local count = VorpInv.getItemCount(_source, "lasipullo")
		if count >= 1 then
			local count2 = VorpInv.getItemCount(_source, "sugarcaneseed")
			if count2 >= 4 then
				local count3 = VorpInv.getItemCount(_source, "tammitynnyri")
				if count3 >= 1 then
					TriggerClientEvent("vorp:TipRight", _source, "Poistettu 1x lasipullo, 1x sokeriruonsiemen, 1x tammitynnyri", 5000) -- from server side
					VorpInv.subItem(source, "lasipullo", 1) 
					VorpInv.subItem(source, "sugarcaneseed", 1) 
					VorpInv.subItem(source, "tammitynnyri", 1) 
					cb(true)
				else
					cb(false)
					TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
				end
			else
				cb(false)
				TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
			end
		else
			cb(false)
			TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
		end
	elseif kategoria == "omenakilju" then
		local count = VorpInv.getItemCount(_source, "lasipullo")
		if count >= 1 then
			local count2 = VorpInv.getItemCount(_source, "sugarcaneseed")
			if count2 >= 4 then
				local count3 = VorpInv.getItemCount(_source, "tammitynnyri")
				if count3 >= 1 then
					TriggerClientEvent("vorp:TipRight", _source, "Poistettu 1x lasipullo, 1x sokeriruonsiemen, 1x tammitynnyri", 5000) -- from server side
					VorpInv.subItem(source, "lasipullo", 1) 
					VorpInv.subItem(source, "sugarcaneseed", 1) 
					VorpInv.subItem(source, "tammitynnyri", 1) 
					cb(true)
				else
					cb(false)
					TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
				end
			else
				cb(false)
				TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
			end
		else
			cb(false)
			TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
		end
	elseif kategoria == "paarynakilju" then
		local count = VorpInv.getItemCount(_source, "lasipullo")
		if count >= 1 then
			local count2 = VorpInv.getItemCount(_source, "sugarcaneseed")
			if count2 >= 4 then
				local count3 = VorpInv.getItemCount(_source, "tammitynnyri")
				if count3 >= 1 then
					TriggerClientEvent("vorp:TipRight", _source, "Poistettu 1x lasipullo, 1x sokeriruonsiemen, 1x tammitynnyri", 5000) -- from server side
					VorpInv.subItem(source, "lasipullo", 1) 
					VorpInv.subItem(source, "sugarcaneseed", 1) 
					VorpInv.subItem(source, "tammitynnyri", 1) 
					cb(true)
				else
					cb(false)
					TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
				end
			else
				cb(false)
				TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
			end
		else
			cb(false)
			TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
		end
	elseif kategoria == "karhunvatukkaolut" then
		local count = VorpInv.getItemCount(_source, "lasipullo")
		if count >= 1 then
			local count2 = VorpInv.getItemCount(_source, "sugarcaneseed")
			if count2 >= 4 then
				local count3 = VorpInv.getItemCount(_source, "tammitynnyri")
				if count3 >= 1 then
					TriggerClientEvent("vorp:TipRight", _source, "Poistettu 1x lasipullo, 1x sokeriruonsiemen, 1x tammitynnyri", 5000) -- from server side
					VorpInv.subItem(source, "lasipullo", 1) 
					VorpInv.subItem(source, "sugarcaneseed", 1) 
					VorpInv.subItem(source, "tammitynnyri", 1) 
					cb(true)
				else
					cb(false)
					TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
				end
			else
				cb(false)
				TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
			end
		else
			cb(false)
			TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
		end
	elseif kategoria == "inkiolut" then
		local count = VorpInv.getItemCount(_source, "lasipullo")
		if count >= 1 then
			local count2 = VorpInv.getItemCount(_source, "sugarcaneseed")
			if count2 >= 4 then
				local count3 = VorpInv.getItemCount(_source, "tammitynnyri")
				if count3 >= 1 then
					TriggerClientEvent("vorp:TipRight", _source, "Poistettu 1x lasipullo, 1x sokeriruonsiemen, 1x tammitynnyri", 5000) -- from server side
					VorpInv.subItem(source, "lasipullo", 1) 
					VorpInv.subItem(source, "sugarcaneseed", 1) 
					VorpInv.subItem(source, "tammitynnyri", 1) 
					cb(true)
				else
					cb(false)
					TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
				end
			else
				cb(false)
				TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
			end
		else
			cb(false)
			TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
		end
	elseif kategoria == "rommi" then
		local count = VorpInv.getItemCount(_source, "lasipullo")
		if count >= 1 then
			local count2 = VorpInv.getItemCount(_source, "sugarcaneseed")
			if count2 >= 4 then
				local count3 = VorpInv.getItemCount(_source, "tammitynnyri")
				if count3 >= 1 then
					TriggerClientEvent("vorp:TipRight", _source, "Poistettu 1x lasipullo, 1x sokeriruonsiemen, 1x tammitynnyri", 5000) -- from server side
					VorpInv.subItem(source, "lasipullo", 1) 
					VorpInv.subItem(source, "sugarcaneseed", 1) 
					VorpInv.subItem(source, "tammitynnyri", 1) 
					cb(true)
				else
					cb(false)
					TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
				end
			else
				cb(false)
				TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
			end
		else
			cb(false)
			TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
		end
	elseif kategoria == "kotiviini" then
		local count = VorpInv.getItemCount(_source, "lasipullo")
		if count >= 1 then
			local count2 = VorpInv.getItemCount(_source, "sugarcaneseed")
			if count2 >= 4 then
				local count3 = VorpInv.getItemCount(_source, "tammitynnyri")
				if count3 >= 1 then
					TriggerClientEvent("vorp:TipRight", _source, "Poistettu 1x lasipullo, 1x sokeriruonsiemen, 1x tammitynnyri", 5000) -- from server side
					VorpInv.subItem(source, "lasipullo", 1) 
					VorpInv.subItem(source, "sugarcaneseed", 1) 
					VorpInv.subItem(source, "tammitynnyri", 1) 
					cb(true)
				else
					cb(false)
					TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
				end
			else
				cb(false)
				TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
			end
		else
			cb(false)
			TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarvittavia tavaroita", 5000) -- from server side
		end
	end
end)

ESX.RegisterServerCallback('Perry_tislain:HaePuuta', function(source, cb)
	local _source = source
	local count = VorpInv.getItemCount(_source, "wood")
	if count >= 1 then 
		VorpInv.subItem(_source, "wood", 1)
		TriggerClientEvent("vorp:TipRight", _source, "Laitoit puuta uuniin", 5000) -- from server side
		cb(true)
	else
		TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole puuta", 5000) -- from server side
		cb(false)
	end
end)

RegisterServerEvent('Perry_tislain:Palkkio')
AddEventHandler('Perry_tislain:Palkkio', function(juoma, paine,lampotila)
	local _source = source
	if paine < 4 or lampotila < 60 then
		local randomi = math.random(1,5)
		if juoma == "kotikalja" then
			VorpInv.addItem(source, "kotikaljapilalla", randomi) -- source, itemname, quantity
			TriggerClientEvent("vorp:TipRight", _source, 'Keitetty '..juoma.." "..randomi.." KPL", 5000)
		elseif juoma == "omenakilju" then
			VorpInv.addItem(source, "omenakiljupilalla", randomi) -- source, itemname, quantity
			TriggerClientEvent("vorp:TipRight", _source, 'Keitetty '..juoma.." "..randomi.." KPL", 5000)
		elseif juoma == "paarynakilju" then
			VorpInv.addItem(source, "paarynakiljupilalla", randomi) -- source, itemname, quantity
			TriggerClientEvent("vorp:TipRight", _source, 'Keitetty '..juoma.." "..randomi.." KPL", 5000)
		elseif juoma == "karhunvatukkaolut" then
			VorpInv.addItem(source, "karhunvatukkaolutpilalla", randomi) -- source, itemname, quantity
			TriggerClientEvent("vorp:TipRight", _source, 'Keitetty '..juoma.." "..randomi.." KPL", 5000)
		elseif juoma == "inkiolut" then
			VorpInv.addItem(source, "inkiolutpilalla", randomi) -- source, itemname, quantity
			TriggerClientEvent("vorp:TipRight", _source, 'Keitetty '..juoma.." "..randomi.." KPL", 5000)
		elseif juoma == "rommi" then
			VorpInv.addItem(source, "rommipilalla", randomi) -- source, itemname, quantity
			TriggerClientEvent("vorp:TipRight", _source, 'Keitetty '..juoma.." "..randomi.." KPL", 5000)
		elseif juoma == "kotiviini" then
			VorpInv.addItem(source, "kotiviinipilalla", randomi) -- source, itemname, quantity
			TriggerClientEvent("vorp:TipRight", _source, 'Keitetty '..juoma.." "..randomi.." KPL", 5000)
		end
	else
		local randomi = math.random(1,5)
		VorpInv.addItem(source, juoma, randomi) -- source, itemname, quantity
		TriggerClientEvent("vorp:TipRight", _source, 'Keitetty '..juoma.." "..randomi.." KPL", 5000)
	end
end)