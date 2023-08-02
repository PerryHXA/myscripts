VorpCore = {}
TriggerEvent("getCore",function(core)
    VorpCore = core
end)
ESX = exports['vorp_core']:GetObj()


AddEventHandler('chatMessage', function(source, color, msg)
	local src = source
	cm = stringsplit(msg, " ")
	if cm[1] == "/vastaa" or cm[1] == "/v" then
		CancelEvent()
		if not tonumber(cm[2]) then ESX.Notify(src, 5, 'ID ei ole numero') return end
		if tablelength(cm) > 1 then
			local tPID = tonumber(cm[2])
			local names2 = GetPlayerName(tPID)
			local names3 = GetPlayerName(src)
			local textmsg = ""
			for i=1, #cm do
				if i ~= 1 and i ~=2 then
					textmsg = (textmsg .. " " .. tostring(cm[i]))
				end
			end
			local Player = VorpCore.getUser(src)
		    if IsPlayerAceAllowed(src, "vorp.staff.AdminActions") then
			    TriggerClientEvent('textmsg', tPID, source, textmsg, names2, names3)
			    TriggerClientEvent('textsent', source, tPID, names2)
		    else
			    TriggerClientEvent('chatMessage', source, "ERROR: ", {255, 0, 0}, "Ei oikeuksia!")
			end
		end
	end	
	
	if cm[1] == "/report" then
		CancelEvent()
		if tablelength(cm) > 1 then
			local names1 = GetPlayerName(source)
			local textmsg = ""
			for i=1, #cm do
				if i ~= 1 then
					textmsg = (textmsg .. " " .. tostring(cm[i]))
				end
			end
		    TriggerClientEvent("sendReport", -1, source, names1, textmsg)
		end
	end	

	if cm[1] == "/togglereport" then
		CancelEvent()
		TriggerClientEvent("togglereport", source)
	end	

	if cm[1] == "/kuittaa" then
		CancelEvent()
		if not tonumber(cm[2]) then ESX.Notify(src, 5, 'ID ei ole numero') return end
		if tablelength(cm) > 1 then
			local tPID = tonumber(cm[2])
			local names2 = GetPlayerName(tPID)
			local names3 = GetPlayerName(src)
			local textmsg = ""
			for i=1, #cm do
				if i ~= 1 and i ~=2 then
					textmsg = (textmsg .. " " .. tostring(cm[i]))
				end
			end
			local Player = VorpCore.getUser(src)
		    if Player.getUsedCharacter.job == 'medic' then
				local etunimi = Player.getUsedCharacter.firstname
				local sukunimi =Player.getUsedCharacter.lastname
			    TriggerClientEvent('answerAlert', tPID, source, textmsg, etunimi, sukunimi)
			    TriggerClientEvent('alertanswered', source)
		    else
			    TriggerClientEvent('chatMessage', source, "ERROR: ", {255, 0, 0}, "Ei oikeuksia!")
			end
		end
	end	
end)

RegisterServerEvent('s_report:msg',function(id, name, msg)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		if IsPlayerAceAllowed(xPlayers[i], "vorp.staff.AdminActions") then
			TriggerClientEvent('chat:addMessage',xPlayers[i], {args = {'^0[^2REPORT^0] | [^2' ..id..'^0] ^2'..name..'^0', msg}})
		end
	end
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end



function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end
