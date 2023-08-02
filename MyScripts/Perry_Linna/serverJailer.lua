local VorpCore = {}

TriggerEvent("getCore", function(core)
    VorpCore = core
end)

ESX = nil

local ESX = exports['vorp_core']:GetObj()

RegisterServerEvent("Perry_Jail:CheckJail")
AddEventHandler("Perry_Jail:CheckJail", function()
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter
	local identifier = Character.identifier
	local charid = Character.charIdentifier
	exports.oxmysql:execute('SELECT TIMESTAMPDIFF(SECOND, CURRENT_TIMESTAMP,J_Time) as timeleft, J_Cell as cellule, isjailed as isjailed from jail where identifier =@id and charid =@charid', {['@id'] = identifier, ['@charid'] = charid}, function(result)
		if result[1] ~= nil then
			if result[1].timeleft > 0 then
				if result[1].cellule ~= nil then
					TriggerClientEvent("Perry_Jail:JailInStation", _source,result[1].timeleft)
				end
			elseif result[1].isjailed == true then
				if result[1].cellule ~= nil then
					TriggerClientEvent("Perry_Jail:JailInStation", _source,result[1].timeleft)
				end
			end
		end
	end)
end)


function round(num, numDecimalPlaces)
  if numDecimalPlaces and numDecimalPlaces>0 then
    local mult = 10^numDecimalPlaces
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

RegisterServerEvent("Perry_Jail:PutInJail")
AddEventHandler("Perry_Jail:PutInJail", function(jailtime, playerid)
	--calculate jailtime
    local User = VorpCore.getUser(playerid) 
    local Character = User.getUsedCharacter 
	local LinnaAika = tonumber(jailtime)
	local remainingjailseconds = LinnaAika/ 60
	local jailseconds =  math.floor(LinnaAika) % 60 
	local remainingjailminutes = remainingjailseconds / 60
	local jailminutes =  math.floor(remainingjailseconds) % 60
	local remainingjailhours = remainingjailminutes / 24
	local jailhours =  math.floor(remainingjailminutes) % 24
	local remainingjaildays = remainingjailhours / 365 
	local jaildays =  math.floor(remainingjailhours) % 365
	
	--end calculate jailtime
	local identifier = GetPlayerIdentifiers(playerid)[1]
	local name = GetPlayerName(source)
	local id = GetPlayerIdentifiers(source)[1]
	local charid = Character.charIdentifier
	local jail = "FederalJail"
	-- print(os.date('%d.%m.%Y %H:%M:%S'))
	local year = round(os.date('%Y'),0)
	local month = round(os.date('%m'),0)
	local day = round(os.date('%d')+jaildays,0)
	local hour = round(os.date('%H')+jailhours,0)
	local minutes =round(os.date('%M')+jailminutes,0)
	local seconds =round(os.date('%S')+jailseconds,0)
	if hour >= 24 then
		hour = hour - 24
		day = day +1
	end
	if ((month == 1 or month == 2 or month == 5 or month == 7 or month == 8 or month == 10 or month == 12) and day > 31) then
		month = month +1
		day = day -31
	elseif (month == 3 and day > 28) then
		month = month +1
		day = day -28
	elseif ((month == 4 or month == 6 or month == 9 or month == 11) and day > 30) then
		month = month +1
		day = day -30
	end
	
	if jail ~= nil then
			print("[Perry_Jail] Laitettu vankilaan ".. jail.." :".. GetPlayerName(playerid).. " ".. LinnaAika .." sekuntia - komennon kirjoitti ".. GetPlayerName(source))
			exports.oxmysql:execute("INSERT INTO jail (identifier,charid,isjailed,J_Time,J_Cell,Jailer,Jailer_ID) VALUES (@identifier,@charid,@isjailed,@J_Time,@J_Cell,@JAILER,@JID) ON DUPLICATE KEY UPDATE identifier=@identifier,charid=@charid,isjailed=@isjailed,J_Time=@J_Time, J_Cell=@J_Cell, Jailer=@JAILER, Jailer_ID=@JID", { ['@identifier'] = identifier,['@charid'] = charid,['@isjailed'] = true, ['@J_Time'] = year..'-'..month..'-'..day..' '..hour..':'..minutes..':'..seconds, ['@J_Cell'] = jail, ['@JAILER'] = name, ['@JID'] = id})
			TriggerClientEvent("Perry_Jail:JailInStation", playerid,LinnaAika)
	end
	
end)


RegisterCommand('jail', function(source, args)
	local _source = tonumber(source)
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter 
	local target_id
	if tonumber(args[1]) then
		target_id = tonumber(args[1])
	else
		print(args[1])
		ESX.Notify(_source, 5, 'Virheellinen ID'..args[1])
		return
	end

	if Character.job == 'sheriff' then
		local user2 = VorpCore.getUser(target_id) 
		if user2 == nil then
			print("Admin command Feedback: this user doesnt exist")
		else
			TriggerClientEvent('Perry_Jail:LaitaLinnaanKekw', source, target_id)
		end	
	end
end)

RegisterCommand('unjail', function(source, args)
	local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter 
	if tonumber(args[1]) then
		target_id = tonumber(args[1])
	else
		print(args[1])
		ESX.Notify(_source, 5, 'Virheellinen ID')
		return
	end
	if Character.job == 'sheriff' then
		local _source = source
		local user2 = VorpCore.getUser(target_id) 
		if user2 == nil then
			print("Admin command Feedback: this user doesnt exist")
		else		
			print(_source, target_id)
			TriggerClientEvent('Perry_Jail:UnjailaaLinna', _source, target_id)
		end
	end
end)

RegisterServerEvent("Perry_Jail:UnJailplayer")
AddEventHandler("Perry_Jail:UnJailplayer", function(playerid)
    local User = VorpCore.getUser(playerid) 
    local Character = User.getUsedCharacter 
	local charid = Character.charIdentifier
	local identifier = GetPlayerIdentifiers(playerid)[1]
	if GetPlayerName(playerid) ~= nil then
		TriggerClientEvent("Perry_Jail:UnJail", playerid)
		exports.oxmysql:execute("DELETE FROM jail WHERE identifier=identifier AND charid=charid", {['@identifier'] = identifier,['@charid'] = charid})
	end
end)

RegisterServerEvent("Perry_Jail:UnJailplayer2")
AddEventHandler("Perry_Jail:UnJailplayer2", function()
    local User = VorpCore.getUser(source) 
    local Character = User.getUsedCharacter 
	local charid = Character.charIdentifier
	local identifier = GetPlayerIdentifiers(source)[1]
	if GetPlayerName(source) ~= nil then
		TriggerClientEvent("Perry_Jail:UnJail", source)
		exports.oxmysql:execute("DELETE FROM jail WHERE identifier=identifier AND charid=charid", {['@identifier'] = identifier,['@charid'] = charid})
	end
end)

function dump(o, nb)
  if nb == nil then
    nb = 0
  end
   if type(o) == 'table' then
      local s = ''
      for i = 1, nb + 1, 1 do
        s = s .. "    "
      end
      s = '{\n'
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
          for i = 1, nb, 1 do
            s = s .. "    "
          end
         s = s .. '['..k..'] = ' .. dump(v, nb + 1) .. ',\n'
      end
      for i = 1, nb, 1 do
        s = s .. "    "
      end
      return s .. '}'
   else
      return tostring(o)
   end
end

---------------------------------------------------------------------------------
--------------------------JAILESCAPE---------------------------------------------
---------------------------------------------------------------------------------
