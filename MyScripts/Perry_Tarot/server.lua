local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("tarotpakka", function(data)
		local _source = data.source
		local numero = tostring(math.random(1,56))
		local final = "tarot"..numero..""
		local numero2 = tostring(math.random(1,56))
		local final2 = "tarot"..numero2..""
		local numero3 = tostring(math.random(1,56))
		local final3 = "tarot"..numero3..""
		VorpInv.addItem(_source, tostring(final), 1)
		VorpInv.addItem(_source, tostring(final2), 1)
		VorpInv.addItem(_source, tostring(final3), 1)
	end)
	VorpInv.RegisterUsableItem("tarot1", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_10c"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot2", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_10p"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot3", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_10s"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot4", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_10w"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot5", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_2c"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot6", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_2p"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot7", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_2s"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot8", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_2w"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot9", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_3c"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot10", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_3p"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot11", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_3s"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot12", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_3w"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot13", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_4c"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot14", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_4p"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot15", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_4s"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot16", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_4w"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot17", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_5c"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot18", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_5p"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot19", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_5s"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot20", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_5w"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot21", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_6c"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot22", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_6p"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot23", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_6s"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot24", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_6w"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot25", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_7c"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot26", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_7p"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot27", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_7w"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot28", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_7s"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot29", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_8c"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot30", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_8p"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot31", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_8s"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot32", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_8w"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot33", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_9c"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot34", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_9p"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot35", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_9s"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot36", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_9w"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot37", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_acc"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot38", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_acp"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot39", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_acs"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot40", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_acw"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot41", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_kic"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot42", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_kip"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot43", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_kis"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot44", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_kiw"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot45", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_knc"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot46", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_knp"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot47", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_knsmp005_s_cardt_kns"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot48", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_knw"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot49", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_pac"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot50", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_pap"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot51", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_pas"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot52", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_paw"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot53", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_quc"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot54", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_qup"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot55", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_qus"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
	VorpInv.RegisterUsableItem("tarot56", function(data)
		local _source = source
		local kortti = "mp005_s_cardt_quw"
		TriggerClientEvent("Perry_Tarot:KatsoKortti", data.source, kortti)
	end)
end)