local cooldown = 0

RegisterNetEvent("dr-scratching:isActiveCooldown", function()
	TriggerServerEvent("dr-scratching:handler", cooldown > 0 and true or false, cooldown)
end)

RegisterNetEvent("dr-scratching:setCooldown", function()
  cooldown = Config.ScratchCooldownInSeconds
	CreateThread(function()
		while (cooldown ~= 0) do
			Wait(1000)
			cooldown = cooldown - 1
		end
	end)
end)

RegisterNetEvent("dr-scratching:startScratchingEmote", function()
	TaskPlayAnim(PlayerPedId(), 'script_story@mob3@ig@ig1_dutch_holds_up_cashier', 'ig1_cashier_idle_01_cashier', 8.0, -8.0, 14000, 0, 0, true, 0, false, 0, false) 
end)

RegisterNetEvent("dr-scratching:stopScratchingEmote", function()
	ClearPedTasksImmediately(GetPlayerPed(-1))
end)

RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('dr-scratching:deposit', data.key, data.price, data.amount, data.type)
end)