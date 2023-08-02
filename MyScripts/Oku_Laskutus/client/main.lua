ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

function ShowBillsMenu()
	ESX.TriggerServerCallback('Oku_Laskutus:getBills', function(bills)
		if #bills > 0 then
			ESX.UI.Menu.CloseAll()
			local elements = {}

			for k,v in ipairs(bills) do
				table.insert(elements, {
					label  = ('%s - <span style="color:red;">%s</span>'):format(v.label, ESX.Math.GroupDigits(v.amount)),
					billId = v.id
				})
			end

			MenuData.Open('default', GetCurrentResourceName(), 'billing', {
				title    = "Laskut",
				align    = 'bottom-right',
				elements = elements
			}, function(data, menu)
				menu.close()

				ESX.TriggerServerCallback('Oku_Laskutus:payBill', function()
					ShowBillsMenu()
				end, data.current.billId)
			end, function(data, menu)
				menu.close()
			end)
		else
			exports['mythic_notify']:DoLongHudText('Error', "Sinulla ei ole laskuja")
		end
	end)
end

