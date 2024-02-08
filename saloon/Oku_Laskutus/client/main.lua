local VORPcore = {} -- core object

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

function ShowBillsMenu()
	VORPcore.RpcCall('Oku_Laskutus:getBills',function(bills) -- asynchronous 
		if #bills > 0 then
			local elements = {}

			for k,v in ipairs(bills) do
				table.insert(elements, {
					label  = ('%s - <span style="color:red;">%s</span>'):format(v.label, v.amount),
					billId = v.id
				})
			end

			MenuData.Open('default', GetCurrentResourceName(), 'billing', {
				title    = "Laskut",
				align    = 'bottom-right',
				elements = elements
			}, function(data, menu)
				menu.close()

				VORPcore.RpcCall('Oku_Laskutus:payBill',function() -- asynchronous 
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

