local group 
local seereports = true


RegisterNetEvent('togglereport')
AddEventHandler('togglereport', function()
	seereports = not seereports
end)

RegisterCommand('clear', function()
  TriggerEvent('chat:clear')
end)

RegisterNetEvent("textsent")
AddEventHandler('textsent', function(tPID, names2)
	TriggerEvent('chatMessage', "", {240, 40, 40}, " ^0Vastasit henkilölle^0: ^2" .. names2 .."  ".."^0  - ^2ID: ^0" .. tPID)
end)

RegisterNetEvent("textmsg")
AddEventHandler('textmsg', function(source, textmsg, names2, names3 )
	TriggerEvent('chatMessage', "", {240, 40, 40}, "[ADMIN] ^2" .. names3 .."^0: " .. textmsg)
end)

--Medic stuff--
RegisterNetEvent("alertanswered")
AddEventHandler('alertanswered', function(tPID, names2)
	TriggerEvent('chatMessage', "", {240, 40, 40}, " ^6Avunhuuto kuitattu onnistuneesti")
end)

RegisterNetEvent("answerAlert")
AddEventHandler('answerAlert', function(source, textmsg, etunimi, sukunimi )
	TriggerEvent('chatMessage', "", {240, 40, 40}, "[Tohtori] ^4" ..etunimi.." "..sukunimi.."^0: " .. textmsg)
end)

local sent = false
RegisterNetEvent('sendReport')
AddEventHandler('sendReport', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    if not sent then
      sent = true
      TriggerEvent('chatMessage', "", {160, 160, 160}, "[Lähetit reportin]")
      TriggerServerEvent('s_report:msg', id, name, message) 
      Wait(10000)
      sent = false
    else
      TriggerEvent('chatMessage', "", {255, 60, 60}, "Lähetit jo reportin, odota hetki!")
    end
  end
end)
