
RegisterCommand("jumpscareon", function(source, args)
	local target = args[1]
    TriggerClientEvent("jumpscare:toggleNUI", target, true)
end)

RegisterCommand("jumpscareoff", function(source, args)
	local target = args[1]
    TriggerClientEvent("jumpscare:toggleNUI", target, false)
end)