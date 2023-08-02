RegisterNetEvent('health:client:trigger-fall-damage')
AddEventHandler('health:client:trigger-fall-damage', function(fallHeight, damagedBoneId)
	print("Tippui korkeudelta ",fallHeight," Osui kohtaan ", damagedBoneId)
end)
