local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--cuff

RegisterServerEvent('Perry_Raudat:Cuff')
AddEventHandler('Perry_Raudat:Cuff', function(target)
    TriggerClientEvent('Perry_Raudat:Cuff', target)
end)

RegisterServerEvent('Perry_Raudat:UnCuff')
AddEventHandler('Perry_Raudat:UnCuff', function(target)
    TriggerClientEvent('Perry_Raudat:UnCuff', target)
end)

RegisterNetEvent("Perry_Raudat:giveBack")
AddEventHandler("Perry_Raudat:giveBack", function(item, qty)
    VorpInv.addItem(source, item, qty)
end)


--[[
RegisterCommand("hihat", function(source, args) 
    local _source = source
    local user = VorpCore.getUser(_source).getUsedCharacter
    local comps = user.comps
    local User = VorpCore.getUser(source)
    local _source = source
    local Character = User.getUsedCharacter
    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT compPlayer FROM characters WHERE identifier=@identifier AND charidentifier = @charidentifier', {['identifier'] = u_identifier, ['charidentifier'] = u_charid}, function(result)
        local playeroutfits = {}
        if result[1] ~= nil then           
            _clothes        = result[1].compPlayer
            TriggerClientEvent("syn_verst:sleeves",_source, _clothes)
        end
    end)
end)
RegisterCommand("hihat2", function(source, args) 
    local _source = source
    local user = VorpCore.getUser(_source).getUsedCharacter
    local comps = user.comps
    local User = VorpCore.getUser(source)
    local _source = source
    local Character = User.getUsedCharacter
    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier
    exports.ghmattimysql:execute('SELECT compPlayer FROM characters WHERE identifier=@identifier AND charidentifier = @charidentifier', {['identifier'] = u_identifier, ['charidentifier'] = u_charid}, function(result)
        local playeroutfits = {}
        if result[1] ~= nil then           
            _clothes        = result[1].compPlayer
            TriggerClientEvent("syn_verst:sleeves2",_source, _clothes)
        end
    end)
end)]]


Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("aseoljy", function(data)
		local _source = data.source
		TriggerClientEvent('cleaning:startcleaningshort', _source, cleaning)
		VorpInv.subItem(_source,"aseoljy", 1)
	end)
	VorpInv.RegisterUsableItem("oldwatch", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Tarpeet:PerkelenTaskukello", _source)
	end)
	VorpInv.RegisterUsableItem("kasirauta", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Raudat:Raudoita", _source)
		VorpInv.subItem(_source,"kasirauta", 1)
	end)
	VorpInv.RegisterUsableItem("kasiavain", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Raudat:UnRaudoita", _source)
	end)
	VorpInv.RegisterUsableItem("hairpomade", function(data)
		local _source = data.source
		--TriggerClientEvent("Perry_Needs:hairpomade", _source)
		TriggerClientEvent('interact2:hairPomade', _source)
		VorpInv.subItem(_source,"hairpomade", 1)
	end)
	--[[VorpInv.RegisterUsableItem("notebook", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Needs:ledger", _source)
	end)]]
	VorpInv.RegisterUsableItem("book", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Needs:book", _source)
	end)
	VorpInv.RegisterUsableItem("puruja", function(data)
		local _source = data.source
		local itemCount = VorpInv.getItemCount(_source, "pipe")
		if itemCount >= 1 then
			TriggerClientEvent("Perry_Needs:pipe", _source)
			VorpInv.subItem(_source,"puruja", 1)
		else
			TriggerClientEvent("vorp:TipBottom", _source, "Sinulla ei ole piippua!", 5000)
		end
	end)
	VorpInv.RegisterUsableItem("pipe", function(data)
		local _source = data.source
		local itemCount = VorpInv.getItemCount(_source, "puruja")
		if itemCount >= 1 then
			TriggerClientEvent("Perry_Needs:pipe", _source)
			VorpInv.subItem(_source,"puruja", 1)
		else
			TriggerClientEvent("vorp:TipBottom", _source, "Sinulla ei ole puruja!", 5000)
		end
	end)
	VorpInv.RegisterUsableItem("chewingtobacco", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Needs:chewingtobacco", _source)
	end)
	VorpInv.RegisterUsableItem("fan", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Needs:fan", _source)
	end)
	VorpInv.RegisterUsableItem("cigarette", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Needs:cigarettes", _source) 
		VorpInv.subItem(_source,"cigarette", 1)
	end)
	VorpInv.RegisterUsableItem("cigar", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_Needs:cigar", _source) 
		VorpInv.subItem(_source,"cigar", 1)
	end)
	VorpInv.RegisterUsableItem("kotikaljapilalla", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_tarpeet:pilallajuomat", _source, "kotikalja") 
		VorpInv.subItem(_source,"kotikaljapilalla", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)
	VorpInv.RegisterUsableItem("omenakiljupilalla", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_tarpeet:pilallajuomat", _source, "omenakilju") 
		VorpInv.subItem(_source,"omenakiljupilalla", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)
	VorpInv.RegisterUsableItem("paarynakiljupilalla", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_tarpeet:pilallajuomat", _source, "paarynakilju") 
		VorpInv.subItem(_source,"paarynakiljupilalla", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)
	VorpInv.RegisterUsableItem("karhunvatukkaolutpilalla", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_tarpeet:pilallajuomat", _source, "karhunvatukkaolut") 
		VorpInv.subItem(_source,"karhunvatukkaolutpilalla", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)
	VorpInv.RegisterUsableItem("inkiolutpilalla", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_tarpeet:pilallajuomat", _source, "inkiolut") 
		VorpInv.subItem(_source,"inkiolutpilalla", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)
	VorpInv.RegisterUsableItem("rommipilalla", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_tarpeet:pilallajuomat", _source, "rommi") 
		VorpInv.subItem(_source,"rommipilalla", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)
	VorpInv.RegisterUsableItem("kotiviinipilalla", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_tarpeet:pilallajuomat", _source, "kotiviini") 
		VorpInv.subItem(_source,"kotiviinipilalla", 1)
		VorpInv.addItem(_source,"lasipullo", 1)
	end)
	VorpInv.RegisterUsableItem("laakehiili", function(data)
		local _source = data.source
		TriggerClientEvent("Perry_tarpeet:laakehiili", _source) 
		VorpInv.subItem(_source,"laakehiili", 1)
	end)
	VorpInv.RegisterUsableItem("pakettifilter", function(data)
		local _source = data.source
		local canCarry = VorpInv.canCarryItem(_source, "cigarettefilter", 10)
		if canCarry then
			VorpInv.subItem(_source,"pakettifilter", 1)
			Citizen.Wait(2000)
			VorpInv.addItem(_source,"cigarettefilter", 10)
			TriggerClientEvent('vorp:TipBottom', _source, "+10x filtteri", 4000)
		else
			TriggerClientEvent('vorp:TipBottom', _source, "Sinulla ei ole tilaa repussa!", 4000)
		end
	end)
	VorpInv.RegisterUsableItem("askitupakka", function(data)
		local _source = data.source
		local canCarry = VorpInv.canCarryItem(_source, "cigarette", 10)
		if canCarry then
			VorpInv.subItem(_source,"askitupakka", 1)
			Citizen.Wait(2000)
			VorpInv.addItem(_source,"cigarette", 10)
			TriggerClientEvent('vorp:TipBottom', _source, "+10x tupakka", 4000)
		else
			TriggerClientEvent('vorp:TipBottom', _source, "Sinulla ei ole tilaa repussa!", 4000)
		end
	end)
end)

--Hairpomade cache--

local tempPomade = {}
RegisterServerEvent('tempsavePomade', function(hash)
    local src = source
    local Player = VorpCore.getUser(src)
    local charid = Player.getUsedCharacter.charIdentifier
    tempPomade[charid] = {}
    table.insert(tempPomade[charid], hash)
end)

RegisterServerEvent('applyPomade', function()
    local src = source
    local Player = VorpCore.getUser(src)
    local charid = Player.getUsedCharacter.charIdentifier
    if tempPomade[charid] then
        TriggerClientEvent('applyPomadeCL', src, tempPomade[charid], false)
    end
end)

RegisterServerEvent('resetPomade', function()
    local src = source
    local Player = VorpCore.getUser(src)
    local charid = Player.getUsedCharacter.charIdentifier
    if tempPomade[charid] then
        TriggerClientEvent('applyPomadeCL', src,tempPomade[charid], true)
        tempPomade[charid] = {}
    end
end)