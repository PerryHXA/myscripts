VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("Perry_Guarma:OtaLipuke")
AddEventHandler("Perry_Guarma:OtaLipuke", function()
    local _source = source
	local count = VorpInv.getItemCount(_source, "lipuke")
    if count >= 1 then
		VorpInv.subItem(_source, "lipuke", 1) -- source, itemname, quantity
        TriggerClientEvent('start:boat', _source)
		TriggerEvent("Perry_Guarma:MeniGuarmaan", _source)
    else
		TriggerClientEvent("vorp:TipBottom", _source, "Sinulla ei ole lippua..", 5000) -- from server side
    end     
end)

--Guarma logit
--[[
RegisterCommand("guarmatest", function(source, args, rawCommand)
	local _source = source
    TriggerEvent("Perry_Guarma:MeniGuarmaan", _source)
end, true) ]]

RegisterServerEvent('Perry_Guarma:MeniGuarmaan')
AddEventHandler( 'Perry_Guarma:MeniGuarmaan', function (source)
    local _src   = source
	local User = VorpCore.getUser(source).getUsedCharacter
    u_identifier = User.identifier
    u_charid = User.charIdentifier
    u_money = User.money
    local nimi = User.firstname
    local sukunimi = User.lastname
	local year = round(os.date('%Y'),0)
	local month = round(os.date('%m'),0)
	local day = round(os.date('%d'),0)
    local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['nimi'] = nimi,  ['sukunimi'] = sukunimi, ['@aika'] = year..'-'..month..'-'..day,}
    MySQL.Async.execute("INSERT INTO guarma ( `identifier`, `charid`, `nimi`, `sukunimi`, `aika` ) VALUES ( @identifier, @charid, @nimi, @sukunimi, @aika )", Parameters)
end)


function round(num, numDecimalPlaces)
  if numDecimalPlaces and numDecimalPlaces>0 then
    local mult = 10^numDecimalPlaces
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end