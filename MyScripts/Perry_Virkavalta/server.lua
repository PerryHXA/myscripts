local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Perry_Poliisijobi:HaeTiedotJob', function(source, cb)
	local _source = source
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter 
	local tiedot = {
		job       = Character.job,
		grade = Character.jobGrade
	}
	cb(tiedot)
end)

ESX.RegisterServerCallback('Perry_Virkavalta:HaeKavijat', function(source, cb)
    local _source = source
    local User = VorpCore.getUser(_source).getUsedCharacter
    u_identifier = User.identifier
    u_charid = User.charIdentifier

    exports.ghmattimysql:execute('SELECT * FROM guarma', function(kavijat)
        if kavijat[1] then
			cb(kavijat)
		else
			cb(kavijat)
        end
    end)
end)

RegisterServerEvent('Perry_Virkavalta:PoistaKavija')
AddEventHandler('Perry_Virkavalta:PoistaKavija', function(identifier, charid)
	local _source = source
	MySQL.Async.execute( "DELETE FROM guarma WHERE identifier=@identifier AND charid=@charid", {["identifier"] = identifier,["charid"] = charid})
end)

RegisterServerEvent('lawmen:handcuff')
AddEventHandler('lawmen:handcuff', function(player)
    TriggerClientEvent('lawmen:handcuff', player)
end)

ESX.RegisterServerCallback('Perry_Poliisi:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

RegisterServerEvent('vorp_ml_policejob:metervehiculo')
AddEventHandler('vorp_ml_policejob:metervehiculo', function(target)
	print(target)
    TriggerClientEvent('Perry_Poliisi:meter', target)
end)

RegisterServerEvent('vorp_ml_policejob:sacarvehiculo')
AddEventHandler('vorp_ml_policejob:sacarvehiculo', function(target)
    TriggerClientEvent('vorp_ml_policejob:sacar', target)
end)

RegisterServerEvent('ml_policejob:lassoplayer')
AddEventHandler('ml_policejob:lassoplayer', function(target)
TriggerEvent('redemrp:getPlayerFromId', target, function()
        --TriggerClientEvent('ml_policejob:lasso', target)
		TriggerClientEvent('ml_policejob:hogtie', target)
    end)
end)

ESX.RegisterServerCallback('Perry_Poliisijobi:Haetilitiedot', function(source, cb)
	local src = source
	local identifier = GetPlayerIdentifiers(source)[1]
	local tiliomistus = "society_police"

	MySQL.Async.fetchAll('SELECT money FROM addon_account_data WHERE `account_name`=@account_name;', {account_name = tiliomistus}, function(name)
		if name[1]then
			local maara = name[1].money
			cb(maara)
		end
	end)
end)

--[[
RegisterCommand('grade', function(source, args, rawCommand)
	local _source = source
	local User = VorpCore.getUser(source) -- Return User with functions and all characters
	local Character = User.getUsedCharacter -- Return character selected by user
	Character.setJobGrade(10)
end)]]

RegisterServerEvent('slerbafixaa:palkkaa', function(id, grade)
	if VorpCore.getUser(source).getUsedCharacter.job == "sheriff" and VorpCore.getUser(source).getUsedCharacter.jobGrade >= 9 then
		local xPlayer = VorpCore.getUser(id).getUsedCharacter
		xPlayer.setJob('sheriff')
		xPlayer.setJobGrade(tonumber(grade))
	end
end)

RegisterServerEvent('slerbafixaa:fireplayer', function(identifier, charid)
	local Players = GetPlayers()

	for _,plyid in pairs(Players) do
		local xPlayer = VorpCore.getUser(plyid).getUsedCharacter
		if xPlayer.identifier == identifier then
			xPlayer.setJob('unemployed')
			xPlayer.setJobGrade(0)
			break
		end
	end

end)

RegisterServerEvent('Perry_Poliisijobi:Talleta')
AddEventHandler('Perry_Poliisijobi:Talleta', function(amount)
	local _source = source
	local User = VorpCore.getUser(_source) -- Return User with functions and all characters
	local Character = User.getUsedCharacter -- Return character selected by user
	local tiliomistus = "society_police"
	if tonumber(Character.money) <= tonumber(amount) then
		TriggerClientEvent("vorp:TipRight", _source, "Sinulla ei ole tarpeeksi rahaa", 5000)
	else
		Character.removeCurrency(0, tonumber(amount)) -- Remove money 1000 | 0 = money, 1 = gold, 2 = rol
		MySQL.Async.execute( 'UPDATE addon_account_data SET money = money + @amount WHERE account_name = @account_name', { amount = amount, account_name = tiliomistus })
		TriggerClientEvent("vorp:TipRight", _source, 'Talletettu tilille '..amount, 5000)
	end
	
end)

RegisterServerEvent("Perry_Poliisijobi:ostapyssy")
AddEventHandler("Perry_Poliisijobi:ostapyssy", function(ase, hinta)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local playername = Character.firstname .. ' ' .. Character.lastname
    local money = Character.money
    local total = money - hinta
    TriggerEvent("vorpCore:canCarryWeapons", tonumber(_source), 1, function(canCarry)
        if canCarry then
            if total >= 0 then
               Character.removeCurrency(0, hinta)
                local ammo = {["nothing"] = 0}
                local components =  {["nothing"] = 0}
                VorpInv.createWeapon(tonumber(_source), ase)
                TriggerClientEvent("vorp:TipBottom", _source, "Ostit Virkavallan Tukusta "..ase.. " Hintaan: "..hinta.."$", 3000)
            end
        end
    end)
end)

RegisterServerEvent("Perry_Poliisijobi:ostaitemi")
AddEventHandler("Perry_Poliisijobi:ostaitemi", function(itemi, hinta)
    local _source = source
	if count == nil then 
        count = 1
    end
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local playername = Character.firstname .. ' ' .. Character.lastname
    local money = Character.money
    local take = hinta * 1
    local total = money - take
    TriggerEvent("vorpCore:canCarryItems", tonumber(_source), 1, function(canCarry)
        if canCarry then
            if total >= 0 then
                Character.removeCurrency(0, take)
                VorpInv.addItem(_source, itemi, 1)
                TriggerClientEvent("vorp:TipBottom", _source, "Ostit "..itemi.." x1 hintaan "..take, 3000)
            else
                TriggerClientEvent("vorp:TipBottom", _source, "Sinulla ei ole tarpeeksi rahaa", 3000)
            end
        else
            TriggerClientEvent("vorp:TipBottom", _source, "Et voi kantaa enempää tavaraa", 3000)
		end
	end)
end)

RegisterServerEvent('Perry_Poliisijobi:Nosta')
AddEventHandler('Perry_Poliisijobi:Nosta', function(amount)
	local _source = source
	local User = VorpCore.getUser(_source) -- Return User with functions and all characters
	local Character = User.getUsedCharacter -- Return character selected by user
	local tiliomistus = "society_police"
	MySQL.Async.fetchAll('SELECT money FROM addon_account_data WHERE `account_name`=@account_name;', {account_name = tiliomistus}, function(name)
		if name[1]then
			local maara = name[1].money
			if tonumber(maara) >= tonumber(amount) then
				Character.addCurrency(0, amount) -- Add money 1000 | 0 = money, 1 = gold, 2 = rol
				MySQL.Async.execute( 'UPDATE addon_account_data SET money = money - @amount WHERE account_name = @account_name', { amount = amount, account_name = tiliomistus })
				TriggerClientEvent("vorp:TipRight", _source, 'Nostettu tililtä '..amount, 5000)
			else 
				TriggerClientEvent("vorp:TipRight", _source, "Firman tilillä ei ole tarpeeksi rahaa", 5000)
			end
		end
	end)
end)



