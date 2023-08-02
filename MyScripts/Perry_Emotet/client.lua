
TriggerEvent("menuapi:getData", function(call)
    MenuData = call
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(0, 0x3C0A40F2) then
            AvaaEmoteValikko()
        end
	end
end)

function AvaaEmoteValikko()

	local elements = {
			{label = "♟ Emotet", value = 'emotet'},
			{label = "🎤 Tanssi Emotet", value = 'tanssi'},
			{label = "🎱 Muut emotet", value = 'memotet'},
			{label = "🕴🏻 Kävelytyylit", value = 'walking'},
			{label = "🕴🏻 Eläin animaatiot", value = 'elainemote'},
			{label = "🕴🏻 Shared", value = 'sharedemotes'},
			{label = "🕴🏻 Prop Animaatiot", value = 'propemotes'},
			{label = "🕴🏻 Lopeta animaatio", value = 'animaatio'},
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'emotevalikko_menu',

		{

			title    = 'Emotet',

			subtext    = '',

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		
		local category = data.current.value
		if category == 'emotet' then
			menu.close()
			Emotet()
		elseif category == 'tanssi' then
			menu.close()
			Tanssi()
		elseif category == 'memotet' then
			menu.close()
			memotet()
		elseif category == 'shared' then
			menu.close()
			Shared()
		elseif category == 'walking' then
			menu.close()
			Walking()
		elseif category == 'elainemote' then
			menu.close()
			ElainEmotet()
		elseif category == 'sharedemotes' then
			menu.close()
			SharedEmotes()
		elseif category == 'propemotes' then
			menu.close()
			PropEmotes()
		elseif category == 'animaatio' then
			menu.close()
			ClearPedTasks(PlayerPedId())
			Citizen.Wait(3000)
			SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
			DeleteObject(prop)
			StopUsingEmote()
		end

	end, function(data, menu)
		menu.close()
	end) 
	
end

function PropEmotes()

	local elements = {
			{label = "Kori", value = 'basket'},
			{label = "Koiranluu", value = 'dogbone'},
			{label = "Pureskele luuta", value = 'dogchewbone'},
			{label = "Sateenvarjo", value = 'parasol'},
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'memeeeeotetmenu_menu',

		{

			title    = 'Shared Emotet',

			subtext    = '',

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		
		local perkele = data.current.value
		menu.close()
		if perkele == 'basket' then
			StartUsingEmote(perkele)
		elseif perkele == 'dogbone' then
			StartUsingEmote(perkele)
		elseif perkele == 'dogchewbone' then
			StartUsingEmote(perkele)
		elseif perkele == 'parasol' then
			StartUsingEmote(perkele)
		end
	end, function(data, menu)
		menu.close()
	end) 
	
end

function SharedEmotes()

	local elements = {
			{label = "Tanssi", value = 'dance'},
			{label = "Rapsuta koiraa (Seisoaltaan)", value = 'pet'},
			{label = "Rapsuta koiraa (Istualtaan)", value = 'pet2'},
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'memeeeeotetmenu_menu',

		{

			title    = 'Shared Emotet',

			subtext    = '',

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		
		local perkele = data.current.value
		menu.close()
		if perkele == 'dance' then
			StartUsingEmote(perkele)
		elseif perkele == 'pet' then
			StartUsingEmote(perkele)
		elseif perkele == 'pet2' then
			StartUsingEmote(perkele)
		end
	end, function(data, menu)
		menu.close()
	end) 
	
end

function Walking()

	local elements = {
			{label = "Normaali", value = 'yksi'},
			{label = "Väsynyt", value = 'kaksi'},
			{label = "Varautunut", value = 'kolme'},
			{label = "Kipittää", value = 'nelja'},
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'memotetmenu_menu',

		{

			title    = 'Emotet',

			subtext    = '',

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		
		local perkele = data.current.value
		menu.close()
		if perkele == 'yksi' then
			Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "arthur_healthy")
			Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "default")
		elseif perkele == 'kaksi' then
			Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
			Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "dehydrated_unarmed")
		elseif perkele == 'kolme' then
			Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
			Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "stealth")
		elseif perkele == 'nelja' then
			Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
			Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "chain_gang_legs")
		end
	end, function(data, menu)
		menu.close()
	end) 
	
end

function memotet()

	local elements = {
			{label = "Argumentoi (Vihainen)", value = 'yksi'},
			{label = "Argumentoi2 (Vihainen)", value = 'kaksi'},
			{label = "Kopeloi lukkoa", value = 'kolme'},
			{label = "Argumentoi", value = 'nelja'},
			{label = "Pelkää", value = 'viisi'},
			{label = "Howdy", value = 'kuusi'},
			{label = "Kumarra", value = 'seiska'},
			{label = "Outo", value = 'kasi'},
			{label = "Känni", value = 'ysi'},
			{label = "Valssi", value = 'kymppi'},
			{label = "Lentosuukko", value = 'ykstoista'},
			{label = "Pure kolikkoa", value = 'kakstoista'},
			{label = "Ylpeile", value = 'kolmetoista'},
			{label = "Katso taskukelloa", value = 'neljatoista'},
			{label = "Heitä kolikkoa", value = 'viisitoista'},
			{label = "Riemuitse", value = 'kuusitoista'},
			{label = "Näytä hauista", value = 'seiskatoista'},
			{label = "Seuraa minua", value = 'kasitoista'},
			{label = "Turhautunut", value = 'ysitoista'},
			{label = "Ulvo", value = 'kaks'},
			{label = "Hypnotisoi", value = 'kol'},
			{label = "Mennään rakentamaan", value = 'nel'},
			{label = "Mennään kalastaa", value = 'viis'},
			{label = "Hei kaikki tuonne", value = 'kuus'},
			{label = "Pelataanko korttia?", value = 'seis'},
			{label = "Tähystä", value = 'kas'},
			{label = "Tonne noin!", value = 'ys'},
			{label = "Katsos tää", value = 'kys'},
			{label = "Tsekkaa tää", value = 'lul'},
			{label = "Kokoontukaa!", value = 'lel'},
			{label = "Rukoile", value = 'kek'},
			{label = "Innostunut (tanssi)", value = 'sek'},
			{label = "Kivi,paperi ja sakset", value = 'rek'},
			{label = "Juoni", value = 'vek'},
			{label = "Ammu ilmaan", value = 'tqq'},
			{label = "Ammu ilmaan (2)", value = 'tww'},
			{label = "Sylje", value = 'tee'},
			{label = "Pelottele", value = 'trr'},
			{label = "Tänne!", value = 'ttt'},
			{label = "Ota muistiinpanoja", value = 'tyy'},
			{label = "Tervehdys", value = 'tuu'},
			{label = "Tanssi", value = 'tii'},
			{label = "Kato perkele", value = 'too'},
			{label = "Tanssi (2)", value = 'tpp'},
			{label = "Tanssi (3)", value = 'taa'},
			{label = "Seiska", value = 'tss'},
			{label = "Tanssi (4)", value = 'tdd'},
			{label = "Tervehdys(2)", value = 'tff'},
			{label = "Tadaa!", value = 'tgg'},
			{label = "Saanko esitellä itseni", value = 'thh'},
			{label = "Vilkutus", value = 'tjj'},
			{label = "Lasso", value = 'tkk'},
			{label = "Tervehdys (4)", value = 'tll'},
			{label = "Peukku", value = 'tzz'},
			{label = "Kädet puuskas", value = 'txx'},
			{label = "Tervehdys (5)", value = 'tcc'},
			{label = "Taputus", value = 'tvv'},
			{label = "Pelokas", value = 'tbb'},
			{label = "Tervehdys", value = 'tnn'},
			{label = "Taputus (2)", value = 'tmm'},
			{label = "Läpsäise", value = 'rqq'},
			{label = "Krapula", value = 'rww'},
			{label = "Hssshh", value = 'ree'},
			{label = "Naura", value = 'rrr'},
			{label = "Anna tulla!", value = 'rtt'},
			{label = "Naura (2)", value = 'ryy'},
			{label = "Säikähdä", value = 'ruu'},
			{label = "Heiluta päätä", value = 'rii'},
			{label = "Esitä ammuttua", value = 'roo'},
			{label = "En minä tiedä", value = 'rpp'},
			{label = "Tanssi (5)", value = 'raa'},
			{label = "Taputus (3)", value = 'rss'},
			{label = "Itke", value = 'rdd'},
			{label = "Antaudu", value = 'rff'},
			{label = "Kunnioita", value = 'rgg'},
			{label = "Peukku alas", value = 'rhh'},
			{label = "Minäkö ?", value = 'rjj'},
			{label = "Iloitse", value = 'rkk'},
			{label = "Esitä itkua", value = 'rll'},
			{label = "Mannanpoika", value = 'rzz'},
			{label = "Puuma", value = 'rxx'},
			{label = "Näytä keskaria", value = 'rcc'},
			{label = "Pelottele", value = 'rvv'},
			{label = "Gorilla", value = 'rbb'},
			{label = "Tarkkailen sinua", value = 'rnn'},
			{label = "Anna tulla!", value = 'rmm'},
			{label = "Puukota", value = 'eqq'},
			{label = "Kaula katki", value = 'eww'},
			{label = "Up in the ass of timo", value = 'eee'},
			{label = "Tapellaanko?", value = 'err'},
			{label = "Huuda", value = 'ett'},
			{label = "Haisee", value = 'eyy'},
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'memotetmenu_menu',

		{

			title    = 'Emotet',

			subtext    = '',

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		
		local emote = data.current.value
		menu.close()
		if emote == 'yksi' then
			RequestAnimDict("script_shows@cancandance@cnc2_out")
			while not HasAnimDictLoaded("script_shows@cancandance@cnc2_out") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "script_shows@cancandance@cnc2_out", "mc_outro_neg", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
		elseif emote == 'kaksi' then
			RequestAnimDict("script_shows@sworddance@shw_swrd_out_pos_neg")
			while not HasAnimDictLoaded("script_shows@sworddance@shw_swrd_out_pos_neg") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "script_shows@sworddance@shw_swrd_out_pos_neg", "mc_outro_neg", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
		elseif emote == 'kolme' then
			RequestAnimDict("script_story@mob3@ig@ig1_dutch_holds_up_cashier")
			while not HasAnimDictLoaded("script_story@mob3@ig@ig1_dutch_holds_up_cashier") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "script_story@mob3@ig@ig1_dutch_holds_up_cashier", "ig1_cashier_idle_01_cashier", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
		elseif emote == 'nelja' then
			RequestAnimDict("script_story@fus2@fus2_ig3_leon_approach_hang")
			while not HasAnimDictLoaded("script_story@fus2@fus2_ig3_leon_approach_hang") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "script_story@fus2@fus2_ig3_leon_approach_hang", "action_leon", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
		elseif emote == 'viisi' then
			RequestAnimDict("script_story@mud5@ig@ig_17_rtlk_bill_get_manager")
			while not HasAnimDictLoaded("script_story@mud5@ig@ig_17_rtlk_bill_get_manager") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "script_story@mud5@ig@ig_17_rtlk_bill_get_manager", "ig6_bill_intimidates_teller01_u_m_m_valbankmanager_01", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
		elseif emote == 'kuusi' then
			RequestAnimDict("ai_gestures@gen_male@standing@speaker@no_hat")
			while not HasAnimDictLoaded("ai_gestures@gen_male@standing@speaker@no_hat") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "ai_gestures@gen_male@standing@speaker@no_hat", "silent_neutral_hat_tip_l_001", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
		elseif emote == 'seiska' then
			RequestAnimDict("ai_gestures@gen_male@standing@speaker@no_hat")
			while not HasAnimDictLoaded("ai_gestures@gen_male@standing@speaker@no_hat") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "ai_gestures@gen_male@standing@speaker@no_hat", "silent_neutral_bow_r_001", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
		elseif emote == 'ykstoista' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_BLOW_KISS_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'kakstoista' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_BITING_GOLD_COIN_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'kolmetoista' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_BOAST_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'neljatoista' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_CHECK_POCKET_WATCH_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'viisitoista' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_COIN_FLIP_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'kuusitoista' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_FIST_PUMP_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'seiskatoista' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_FLEX_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'kasitoista' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_FOLLOW_ME_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'ysitoista' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_HISSYFIT_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'kaks' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_HOWL_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'kol' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_HYPNOSIS_POCKET_WATCH_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'nel' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_LETS_CRAFT_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'viis' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_LETS_FISH_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'kuus' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_LETS_GO_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'seis' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_LETS_PLAY_CARDS_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'kas' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_LOOK_DISTANCE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'ys' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_LOOK_YONDER_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'kys' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_NEWTHREADS_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'lul' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_POINT_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'lel' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_POSSE_UP_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'kek' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_PRAYER_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'sek' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_PROSPECTOR_JIG_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rek' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_ROCK_PAPER_SCISSORS_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'vek' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_SCHEME_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tqq' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_SHOOTHIP_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tww' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_SKYWARD_SHOOTING_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tee' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_SPIT_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'trr' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_SPOOKY_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'ttt' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_STOP_HERE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tyy' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_TAKE_NOTES_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tuu' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_HAT_FLICK_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tii' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_DANCE_CAREFREE_A_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'too' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_HEY_YOU_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tpp' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_DANCE_DRUNK_A_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'taa' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_DANCE_DRUNK_B_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tss' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_SEVEN_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tdd' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_DANCE_GRACEFUL_A_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tff' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_SUBTLE_WAVE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tgg' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_TADA_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'thh' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_FANCY_BOW_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tjj' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_GENTLEWAVE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tkk' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_GET_OVER_HERE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tll' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_GLAD_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tzz' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_THUMBSUP_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'txx' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_TOUGH_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tcc' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_WAVENEAR_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tvv' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_APPLAUSE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tbb' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_BEGMERCY_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tnn' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_CLAP_ALONG_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'tmm' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_HANGOVER_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rqq' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_HOW_DARE_YOU_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rww' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_HURL_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'ree' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_HUSH_YOUR_MOUTH_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rrr' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_JOVIAL_LAUGH_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rtt' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_NOD_HEAD_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'ryy' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_POINTLAUGH_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'ruu' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SCARED_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rii' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SHAKEHEAD_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'roo' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SHOT_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rpp' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SHRUG_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'raa' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SHUFFLE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rss' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SLOW_CLAP_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'ruu' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SNIFFING_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rdd' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SOB_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rff' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SURRENDER_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rgg' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_THANKS_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rhh' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_THUMBSDOWN_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rjj' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_WHO_ME_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rkk' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_YEEHAW_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rll' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_BOOHOO_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rzz' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_CHICKEN_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rxx' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_COUGAR_SNARL_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rcc' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_FLIP_OFF_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rvv' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_FRIGHTEN_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rbb' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_GORILLA_CHEST_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rnn' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_IM_WATCHING_YOU_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'rmm' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_PROVOKE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'eqq' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_RIPPER_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'eww' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_THROAT_SLIT_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'eee' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_UP_YOURS_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'err' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_VERSUS_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'ett' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_WAR_CRY_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		elseif emote == 'eyy' then
			Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_YOUSTINK_1"),0,0,0,0,0)  -- FULL BODY EMOTE
		end
	end, function(data, menu)
		menu.close()
	end) 
	
end

local MenuOuvert = false

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local playerPed = PlayerPedId()
		if IsAppActive(`MAP`) ~= 0 and not MenuOuvert then
            local isMounted = IsPedOnMount(PlayerPedId())
            if not isMounted then
				SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
				MenuOuvert = true
				SortirMap()
				Wait(2000)
				local player = PlayerPedId()
				local coords = GetEntityCoords(player) 
				local props = CreateObject(GetHashKey("s_twofoldmap01x_us"), coords.x, coords.y, coords.z, 1, 0, 1)
				prop = props
				SetEntityAsMissionEntity(prop,true,true)
				RequestAnimDict("mech_carry_box")
				while not HasAnimDictLoaded("mech_carry_box") do
				Citizen.Wait(100)
				end
				Citizen.InvokeNative(0xEA47FE3719165B94, player,"mech_carry_box", "idle", 1.0, 8.0, -1, 31, 0, 0, 0, 0)
				Citizen.InvokeNative(0x6B9BBD38AB0796DF, prop,player,GetEntityBoneIndexByName(player,"SKEL_L_Finger12"), 0.20, 0.00, -0.15, 180.0, 190.0, 0.0, true, true, false, true, 1, true)
			end
		end
        if IsAppActive(`MAP`) ~= 1 and MenuOuvert then
		MenuOuvert = false
        RangerMap()
		ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
     	DetachEntity(prop,false,true)
        ClearPedTasks(player)
        DeleteObject(prop)
		end
	end
end)

function SortirMap()
    local ped = PlayerPedId()
	Animation(ped, "mech_inspection@mini_map@satchel", "enter")
end

function RangerMap()
    local ped = PlayerPedId()
	Animation(ped, "mech_inspection@two_fold_map@satchel", "exit_satchel")
end

function Animation(ped, dict, name)
    if not DoesAnimDictExist(dict) then
      return
    end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
    Citizen.Wait(0)
    end
    TaskPlayAnim(ped, dict, name, -1.0, -0.5, 2000, 1, 0, true, 0, false, 0, false)
    RemoveAnimDict(dict)
end

function Tanssi()

	local elements = {
			{label = "Käärme", value = 'yksi'},
			{label = "Kurki", value = 'kaksi'},
			{label = "Polkka", value = 'kolme'},
			{label = "Polkka2", value = 'nelja'},
			{label = "Isopolkka", value = 'viisi'},
			{label = "Afrikan", value = 'kuusi'},
			{label = "Vanhus", value = 'seiska'},
			{label = "Outo", value = 'kasi'},
			{label = "Känni", value = 'ysi'},
			{label = "Valssi", value = 'kymppi'},
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'emotetmenu_menu',

		{

			title    = 'Emotet',

			subtext    = '',

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		
		local emote = data.current.value
		menu.close()
		if emote == 'yksi' then
			RequestAnimDict("script_shows@snakedancer@act1_p1")
			while not HasAnimDictLoaded("script_shows@snakedancer@act1_p1") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "script_shows@snakedancer@act1_p1", "dance_dancer", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
		elseif emote == 'kaksi' then
			RequestAnimDict("script_shows@firebreather@act2_p1")
			while not HasAnimDictLoaded("script_shows@firebreather@act2_p1") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "script_shows@firebreather@act2_p1", "dancer_dance", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
		elseif emote == 'kolme' then
			RequestAnimDict("script_mp@emotes@dance@drunk@b@male@unarmed@full_looped")
			while not HasAnimDictLoaded("script_mp@emotes@dance@drunk@b@male@unarmed@full_looped") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@drunk@b@male@unarmed@full_looped", "action_alt1_lf", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
			Citizen.Wait(4000)
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@drunk@b@male@unarmed@full_looped", "action_alt1_lf_midstep", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
			Citizen.Wait(4000)
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@drunk@b@male@unarmed@full_looped", "action_alt1_rf", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
			Citizen.Wait(4000)
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@drunk@b@male@unarmed@full_looped", "action_alt1_rf_midstep", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
			Citizen.Wait(4000)
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@drunk@b@male@unarmed@full_looped", "intro", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
			Citizen.Wait(2000)
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@drunk@b@male@unarmed@full_looped", "outro", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
		elseif emote == 'nelja' then
			RequestAnimDict("script_mp@emotes@dance@confident@b@male@unarmed@full")
			while not HasAnimDictLoaded("script_mp@emotes@dance@confident@b@male@unarmed@full") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@confident@b@male@unarmed@full", "fullbody", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false)  
			Citizen.Wait(5000)
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@confident@b@male@unarmed@full", "fullbody_alt1", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false)	
		elseif emote == 'viisi' then
			RequestAnimDict("script_mp@emotes@dance@wild@a@male@unarmed@full")
			while not HasAnimDictLoaded("script_mp@emotes@dance@wild@a@male@unarmed@full") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@wild@a@male@unarmed@full", "fullbody", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false)
		elseif emote == 'kuusi' then
			RequestAnimDict("script_mp@emotes@dance@carefree@b@male@unarmed@full_looped")
			while not HasAnimDictLoaded("script_mp@emotes@dance@carefree@b@male@unarmed@full_looped") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@carefree@b@male@unarmed@full_looped", "action_alt1_lf", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false)  
			Citizen.Wait(3000)
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@carefree@b@male@unarmed@full_looped", "action_alt1_rf", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false)  
			Citizen.Wait(3000)
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@carefree@b@male@unarmed@full_looped", "action_alt2_lf", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
			Citizen.Wait(3000)
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@carefree@b@male@unarmed@full_looped", "action_alt2_rf", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false)
			Citizen.Wait(3000)
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@carefree@b@male@unarmed@full_looped", "action_lf", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false)
			Citizen.Wait(3000)
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@carefree@b@male@unarmed@full_looped", "action_mid_to_left", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false)
			Citizen.Wait(3000)
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@carefree@b@male@unarmed@full_looped", "action_mid_to_right", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false)
			Citizen.Wait(3000)
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@carefree@b@male@unarmed@full_looped", "action_rf", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false)
		elseif emote == 'seiska' then
			RequestAnimDict("script_mp@emotes@dance@old@a@male@unarmed@full")
			while not HasAnimDictLoaded("script_mp@emotes@dance@old@a@male@unarmed@full") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@old@a@male@unarmed@full", "fullbody", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false)  
		elseif emote == 'kasi' then
			RequestAnimDict("script_mp@emotes@dance@awkward@a@male@unarmed@full")
			while not HasAnimDictLoaded("script_mp@emotes@dance@awkward@a@male@unarmed@full") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "script_mp@emotes@dance@awkward@a@male@unarmed@full", "fullbody", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false)  
		elseif emote == 'ysi' then
			RequestAnimDict("script_mp@bounty@legendary@lbowl@ig@lbowl_ig3_dance")
			while not HasAnimDictLoaded("script_mp@bounty@legendary@lbowl@ig@lbowl_ig3_dance") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "script_mp@bounty@legendary@lbowl@ig@lbowl_ig3_dance", "dance_bounty_01", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false)  
		elseif emote == 'kymppi' then
			RequestAnimDict("cnv_camp@rchso@cnv@ccdtc33@player_karen")
			while not HasAnimDictLoaded("cnv_camp@rchso@cnv@ccdtc33@player_karen") do
				Citizen.Wait(100)
			end
			TaskPlayAnim(PlayerPedId(), "cnv_camp@rchso@cnv@ccdtc33@player_karen", "karen_dance_rot_lt_long", 8.0, -8.0, 60000, 0, 0, true, 0, false, 0, false) 
		end
	end, function(data, menu)
		menu.close()
	end) 
	
end



function ElainEmotet()

	local elements = {
			{label = "Juo (Koira)", value = 'WORLD_ANIMAL_DOG_DRINK_GROUND'},
			{label = "Haistele maata (Koira)", value = 'WORLD_ANIMAL_DOG_SNIFFING_GROUND'},
			{label = "Merkkaa alue (Koira)", value = 'WORLD_ANIMAL_DOG_MARK_TERRITORY_A'},
			{label = "Pasko (Koira)", value = 'WORLD_ANIMAL_DOG_POOPING'},
			{label = "Mene kyykkyyn (Koira)", value = 'WORLD_ANIMAL_DOG_BARK_GROWL'},
			{label = "Murise (Koira)", value = 'WORLD_HUMAN_FIRE_TEND_KNEEL'},
			{label = "Hauku maassa (Koira)", value = 'WORLD_ANIMAL_DOG_BARKING_GROUND'},
			{label = "Hauku seisaaltaan (Koira)", value = 'WORLD_ANIMAL_DOG_BARKING_UP'},
			{label = "Hauku vihaisesti (Koira)", value = 'WORLD_ANIMAL_DOG_BARKING_VICIOUS'},
			{label = "Kerjää (Koira)", value = 'WORLD_ANIMAL_DOG_BEGGING'},
			{label = "Kaiva (Koira)", value = 'WORLD_ANIMAL_DOG_DIGGING'},
			{label = "Syö maasta (Koira)", value = 'WORLD_ANIMAL_DOG_EATING_GROUND'},
			{label = "Varoitus haukku (Koira)", value = 'WORLD_ANIMAL_DOG_GUARD_GROWL'},
			{label = "Varoitus murina (Koira)", value = 'WORLD_ANIMAL_DOG_GUARD_GROWL'},
			{label = "Ulvo (Koira)", value = 'WORLD_ANIMAL_DOG_HOWLING'},
			{label = "Ulvo istueltaan (Koira)", value = 'WORLD_ANIMAL_DOG_HOWLING_SITTING'},
			{label = "Loukkaantunut maassa (Koira)", value = 'WORLD_ANIMAL_DOG_INJURED_ON_GROUND'},
			{label = "Levätä (Koira)", value = 'WORLD_ANIMAL_DOG_RESTING'},
			{label = "Kieri (Koira)", value = 'WORLD_ANIMAL_DOG_ROLL_GROUND'},
			{label = "Istu (Koira)", value = 'WORLD_ANIMAL_DOG_SITTING'},
			{label = "Nuku (Koira)", value = 'WORLD_ANIMAL_DOG_SLEEPING'},
			{label = "Terota kynsiä (Kissa)", value = 'WORLD_ANIMAL_CAT_CLAW_SHARPEN'},
			{label = "Juo (Kissa)", value = 'WORLD_ANIMAL_CAT_DRINKING'},
			{label = "Syö (Kissa)", value = 'WORLD_ANIMAL_CAT_EATING'},
			{label = "Lepää (Kissa)", value = 'WORLD_ANIMAL_CAT_RESTING'},
			{label = "Istu (Kissa)", value = 'WORLD_ANIMAL_CAT_SITTING'},
			{label = "Nuku (Kissa)", value = 'WORLD_ANIMAL_CAT_SLEEPING'},
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'emotetmenu_menu',

		{

			title    = 'Eläimien Emotet',

			subtext    = '',

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		
		local emote = data.current.value
		menu.close()
		PlayEmote(emote)

	end, function(data, menu)
		menu.close()
	end) 
	
end

function Emotet()

	local elements = {
			{label = "Istu", value = 'GENERIC_SIT_GROUND_SCENARIO'},
			{label = "Istu tuolilla", value = 'PROP_HUMAN_SEAT_CHAIR'},
			{label = "Istu maassa ja tupakoi", value = 'WORLD_HUMAN_SIT_SMOKE'},
			{label = "Istu maassa ja juo", value = 'WORLD_HUMAN_SIT_DRINK'},
			{label = "Mene kyykkyyn", value = 'WORLD_PLAYER_CAMP_FIRE_SQUAT'},
			{label = "Sytytä nuotio", value = 'WORLD_HUMAN_FIRE_TEND_KNEEL'},
			{label = "Makaa maassa kyljellä", value = 'WORLD_CAMP_FIRE_LAY_GROUND_SIDE'},
			{label = "Makaa selällään", value = 'WORLD_CAMP_FIRE_LAY_BACK_GROUND'},
			{label = "Nuku maassa", value = 'WORLD_HUMAN_SLEEP_GROUND_ARM'},
			{label = "Nojaa seinään", value = 'WORLD_HUMAN_LEAN_BACK_WALL_NO_PROPS'},
			{label = "Nojaa baarintiskiin", value = 'WORLD_HUMAN_BAR_DRINK_BARTENDER'},
			{label = "Puhdista laseja", value = 'WORLD_HUMAN_BARTENDER_CLEAN_GLASS'},
			{label = "Harjaa lattiaa", value = 'WORLD_HUMAN_BROOM'},
			{label = "Puhdista pöytä", value = 'WORLD_HUMAN_CLEAN_TABLE'},
			{label = "Soita trumpettia", value = 'WORLD_HUMAN_TRUMPET'},
			{label = "Soita kitaraa maassa", value = 'WORLD_HUMAN_SIT_GUITAR'},
			{label = "Oksenna", value = 'WORLD_HUMAN_VOMIT'},
			{label = "Oksenna polviltaan", value = 'WORLD_HUMAN_VOMIT_KNEEL'},
			{label = "Pökerry", value = 'WORLD_HUMAN_DRUNK_PASSED_OUT_FLOOR'},
			{label = "Sheriffi idle", value = 'WORLD_HUMAN_BADASS'},
			{label = "Idle 1", value = 'WORLD_HUMAN_WAITING_IMPATIENT'},
			{label = "Tutki maata polvillaan", value = 'WORLD_HUMAN_CROUCH_INSPECT'},
			{label = "Koputa oveen", value = 'WORLD_PLAYER_KNOCK_DOOR'},
			{label = "Kurkista ikkunasta", value = 'WORLD_PLAYER_PEEK_WINDOW'},
			{label = "Kuse", value = 'world_human_pee'},
			{label = "Kirjoita vihkoon", value = 'world_human_write_notebook'},
			{label = "Syötä sikoja", value = 'world_human_feed_pigs'},
			{label = "Sure", value = 'world_human_grave_mourning'},
			{label = "Istu jyrkänteen reunalla", value = 'world_human_seat_ledge'},
			{label = "Istu jyrkänteen reunalla", value = 'world_human_coughing'},
			{label = "Puhdista itsesi (Veden äärellä)", value = 'WORLD_HUMAN_WASH_FACE_BUCKET_GROUND_NO_BUCKET'},
	}
	MenuData.Open(

		'default', GetCurrentResourceName(), 'emotetmenu_menu',

		{

			title    = 'Emotet',

			subtext    = '',

			align    = 'top-left',

			elements = elements,

		},

		function(data, menu)
		
		local emote = data.current.value
		menu.close()
		PlayEmote(emote)

	end, function(data, menu)
		menu.close()
	end) 
	
end

function PlayEmote(emote)
	TaskStartScenarioInPlace(PlayerPedId(), GetHashKey(emote), -1, true, false, false, false)
end

RegisterCommand("kps1", function(source, args, rawCommand)
	Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_ROCK_PAPER_SCISSORS_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

--[[
RegisterCommand("harjaa", function(source, args, rawCommand)
    local Ped = PlayerPedId()
    local Mount = GetMount(Ped)
    local entityCoords = GetOffsetFromEntityInWorldCoords(Ped, -0.9, 0.0, -1.0)
    local heading = (Citizen.InvokeNative(0x230DD956E2F5507, Mount, Citizen.ResultAsFloat()) - 90.0)
    TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey("WORLD_HUMAN_HORSE_TEND_BRUSH_LINK"), entityCoords.x, entityCoords.y, entityCoords.z, heading, 1.0, true, false, "penis", 1, false)
    Wait(15000)
    ClearPedTasksImmediately(PlayerPedId())
end)]]


--[[
RegisterCommand("lopeta", function(source, args, rawCommand)
	local ped = PlayerPedId()
    ClearPedTasksImmediately(ped, true, true)
    Citizen.Wait(1500)
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
    DeleteObject(prop)
end)]]

--[[
RegisterCommand("kelaa", function(source, args, rawCommand)
	Citizen.InvokeNative(0x923583741DC87BCE, PlayerPedId(), "default")
	Citizen.InvokeNative(0x89F5E7ADECCCB49C, PlayerPedId(), "spool")
end)]]

RegisterCommand('spit', function(source)
    local ped = PlayerPedId()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, ped, 0, 0, -2106738342, 1, 1, 0, 0)
    Citizen.Wait(15000)
	ClearPedTasks(PlayerPedId())
end)

--X -- Clearaa pedi task
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		if IsControlJustReleased(0, 0x8CC9CD42) then	
			ClearPedTasks(PlayerPedId())
			ClearPedSecondaryTask(PlayerPedId())
			Citizen.Wait(3000)
			SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
			DeleteObject(prop)
			FreezeEntityPosition(playerPed, false)
			StopUsingEmote()
		end
	end
end)

--------------------Music--------------------

RegisterCommand("trumpetti", function(source, args, rawCommand)
TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_TRUMPET'), 1000000, true, true, true, true)
end)

RegisterCommand('kitara', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_SIT_GUITAR'), -1, true, true, false, false)
end, false)

RegisterCommand('dance', function(source, args, rawCommand)
	RequestAnimDict('amb_misc@world_human_drunk_dancing@male@male_b@idle_a')
    while not HasAnimDictLoaded('amb_misc@world_human_drunk_dancing@male@male_b@idle_a') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_drunk_dancing@male@male_b@idle_a', 'idle_b', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

--------------------Sit / Lay--------------------
RegisterCommand('istu', function(source, args, rawCommand)
        TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('GENERIC_SIT_GROUND_SCENARIO'), -1, true, true, false, false)
end, false)

RegisterCommand('istu2', function(source, args, rawCommand)
	RequestAnimDict('amb_rest_sit@world_human_depressed_sit_ground@male_a@idle_b')
    while not HasAnimDictLoaded('amb_rest_sit@world_human_depressed_sit_ground@male_a@idle_b') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_rest_sit@world_human_depressed_sit_ground@male_a@idle_b', 'idle_d', 8.0, -8.0, 9999999999, 1, 0, true, 0, false, 0, false)
end, false)

RegisterCommand('chair', function(source, args, rawCommand)
        local pos = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey("PROP_HUMAN_SEAT_CHAIR"), pos.x, pos.y, pos.z-0.5, heading, -1, true, false);
end, false)

RegisterCommand('sitsmoke', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_SIT_SMOKE'), -1, true, true, false, false)
end, false)

RegisterCommand('sitdrink', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_SIT_DRINK'), -1, true, true, false, false)
end, false)

RegisterCommand('fkneel', function(source, args, rawCommand) -- Fire Kneel
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_PLAYER_CAMP_FIRE_SQUAT'), -1, true, true, false, false)
end, false)

RegisterCommand('ftend', function(source, args, rawCommand) --Tend Fire
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_FIRE_TEND_KNEEL'), -1, true, true, false, false)
end, false)

RegisterCommand('layonside', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_CAMP_FIRE_LAY_GROUND_SIDE'), -1, true, true, false, false)
end, false)

RegisterCommand('layonback', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_CAMP_FIRE_LAY_BACK_GROUND'), -1, true, true, false, false)
end, false)

RegisterCommand('nuku', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_SLEEP_GROUND_ARM'), -1, true, true, false, false)
end, false)

--------------------Lean--------------------
RegisterCommand('nojaa', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_LEAN_BACK_WALL_NO_PROPS'), -1, true, true, false, false)
end, false)

RegisterCommand('leanbar', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_BAR_DRINK_BARTENDER'), -1, true, true, false, false)
end, false)

--------------------Bartender--------------------
RegisterCommand('cleanglass', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_BARTENDER_CLEAN_GLASS'), -1, true, true, false, false)
end, false)

RegisterCommand('harjaa', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_BROOM'), 1000000, true, true, false, false)
end, false)

RegisterCommand('puhdista', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_CLEAN_TABLE'), -1, true, true, false, false)
end, false)

RegisterCommand('ddrink', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_DRINKING_DRUNK'), -1, true, true, false, false)
end, false)

RegisterCommand('oksennas', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_VOMIT'), -1, true, true, false, false)
end, false)

RegisterCommand('vomitkneel', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_VOMIT_KNEEL'), -1, true, true, false, false)
end, false)

RegisterCommand('sammu', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_DRUNK_PASSED_OUT_FLOOR'), -1, true, true, false, false)
end, false)

RegisterCommand('coffee', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_COFFEE_DRINK'), -1, true, true, false, false)
end, false)

--------------------Stance--------------------
RegisterCommand('cop1', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_BADASS'), -1, true, true, false, false)
end, false)
 
RegisterCommand('cop3', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_WAITING_IMPATIENT'), -1, true, true, false, false)
end, false)

RegisterCommand('cop2', function(source, args, rawCommand)
	RequestAnimDict('amb_misc@world_human_chew_tobacco@male_b@idle_c')
    while not HasAnimDictLoaded('amb_misc@world_human_chew_tobacco@male_b@idle_c') do
        Citizen.Wait(100)
    end
	TaskPlayAnim(PlayerPedId(), 'amb_misc@world_human_chew_tobacco@male_b@idle_c', 'idle_g', 8.0, -8.0, 9999999999, 31, 0, true, 0, false, 0, false)
end, false)

--------------------Interaction--------------------
RegisterCommand("tutki", function(source, args, rawCommand)
TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 1000000, true, true, true, true)
end)

RegisterCommand('koputa', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_PLAYER_KNOCK_DOOR'), 3600, true, true, false, false)
end, false)

RegisterCommand('kurki', function(source, args, rawCommand)
    TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_PLAYER_PEEK_WINDOW'), -1, true, true, false, false)
end, false)

RegisterCommand('kuse', function(source, args, rawCommand)
	Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("world_human_pee"), 100000,true,false, false, false)
end, false)

RegisterCommand('vihkoa', function(source, args, rawCommand)
	Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("world_human_write_notebook"), 100000,true,false, false, false)
end, false)

RegisterCommand('puhdista', function(source, args, rawCommand)
    if IsEntityInWater(PlayerPedId()) then
        TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_WASH_FACE_BUCKET_GROUND_NO_BUCKET'), 20000, true, true, false, false)
    else 
        TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = "You need to be in water to use this emote.", length = 5000, style = { ['background-color'] = '#000000', ['color'] = '#ffffff' } })
    end
end, false)

local CurrentEmote
local SharedEmoteRequest

RegisterNetEvent("emotes:requestSharedEmote")
RegisterNetEvent("emotes:rejectSharedEmote")
RegisterNetEvent("emotes:acceptSharedEmote")
RegisterNetEvent("emotes:stopSharedEmote")

function GetCompatibleAnim(ped, anim)
	if anim and anim.variants then
		for _, variant in ipairs(anim.variants) do
			if variant.isCompatible(ped) then
				return variant
			end
		end
	else
		return anim
	end
end

function PlayAnimation(ped, anim)
	anim = GetCompatibleAnim(ped, anim)

	if not DoesAnimDictExist(anim.dict) then
		print("Invalid animation dictionary: " .. anim.dict)
		return
	end

	RequestAnimDict(anim.dict)

	while not HasAnimDictLoaded(anim.dict) do
		Wait(0)
	end

	if anim.flag == 1 then
		FreezeEntityPosition(ped, true)
	end

	TaskPlayAnim(ped, anim.dict, anim.name, 1.0, 1.0, -1, anim.flag, 0.0, false, false, false, "", false)

	RemoveAnimDict(anim.dict)
end

function StopAnimation(ped, anim)
	anim = GetCompatibleAnim(ped, anim)

	StopAnimTask(ped, anim.dict, anim.name, 1.0)

	if anim.flag == 1 then
		FreezeEntityPosition(ped, false)
	end
end

function IsPlayingAnimation(ped, anim)
	anim = GetCompatibleAnim(ped, anim)

	return IsEntityPlayingAnim(ped, anim.dict, anim.name, anim.flag)
end

function CreateProp()
	CurrentEmote.prop.handle = CreateObjectNoOffset(GetHashKey(CurrentEmote.prop.model), 0.0, 0.0, 0.0, true, false, false, false)
end

function AttachProp(ped)
	local handle = CurrentEmote.prop.handle
	local bone = CurrentEmote.prop.bone
	local position = CurrentEmote.prop.position
	local rotation = CurrentEmote.prop.rotation

	if type(bone) == "string" then
		bone = GetEntityBoneIndexByName(ped, bone)
	end

	AttachEntityToEntity(handle, ped, bone, position, rotation, false, false, true, false, 0, true, false, false)
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

function EnumerateEntities(firstFunc, nextFunc, endFunc)
	return coroutine.wrap(function()
		local iter, id = firstFunc()

		if not id or id == 0 then
			endFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = endFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
			coroutine.yield(id)
			next, id = nextFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		endFunc(iter)
	end)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function GetClosestPedInRange()
	local myPed = PlayerPedId()
	local myPos = GetEntityCoords(myPed)

	local minDist, closestPed

	for ped in EnumeratePeds() do
		if myPed ~= ped then
			local theirPos = GetEntityCoords(ped)
			local distance = #(myPos - theirPos)

			if distance < Config.SharedEmoteRange and (not minDist or distance < minDist) then
				minDist = distance
				closestPed = ped
			end
		end
	end

	return closestPed
end

function GetPlayerFromPed(ped)
	for _, player in ipairs(GetActivePlayers()) do
		if GetPlayerPed(player) == ped then
			return player
		end
	end
end

function GetPlayerServerIdFromPed(ped)
	return GetPlayerServerId(GetPlayerFromPed(ped))
end

function GetPlayerPedFromServerId(serverId)
	return GetPlayerPed(GetPlayerFromServerId(serverId))
end

function GetPlayerNameFromServerId(serverId)
	return GetPlayerName(GetPlayerFromServerId(serverId))
end

function TeleportToPartner(ped, partner, emote)
	local partnerPos = GetEntityCoords(partner)
	local partnerHeading = GetEntityHeading(partner)

	local r = math.rad(partnerHeading)
	local cosr = math.cos(r)
	local sinr = math.sin(r)

	local x = emote.partner.offset.x * cosr - emote.partner.offset.y * sinr + partnerPos.x
	local y = emote.partner.offset.y * cosr + emote.partner.offset.x * sinr + partnerPos.y
	local z = emote.partner.offset.z + partnerPos.z
	local h = emote.partner.offset.w + partnerHeading

	SetEntityCoordsNoOffset(ped, x, y, z)
	SetEntityHeading(ped, h)
end

function DrawText2D(x, y, text)
	SetTextScale(0.35, 0.35)
	SetTextColor(255, 255, 255, 255)
	SetTextCentre(true)
	SetTextDropshadow(1, 0, 0, 0, 200)
	SetTextFontForCurrentCommand(0)
	DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end

function DrawText3D(x, y, z, text)
	local onScreen, screenX, screenY = GetScreenCoordFromWorldCoord(x, y, z)
	SetTextScale(0.35, 0.35)
	SetTextFontForCurrentCommand(1)
	SetTextColor(255, 255, 255, 223)
	SetTextCentre(1)
	DisplayText(CreateVarString(10, "LITERAL_STRING", text), screenX, screenY)
end

function ShowNotification(text, duration)
	local endTime = GetSystemTime() + (duration or 5000)

	CreateThread(function()
		while GetSystemTime() < endTime do
			DrawText2D(0.5, 0.8, text)
			Wait(0)
		end
	end)
end

function SendSharedEmoteRequest(emote)
	local closestPed = GetClosestPedInRange()
	print(closestPed)

	if not closestPed then
		ShowNotification("Nobody in range")
		return
	end

	emote.partner.ped = closestPed

	if IsPedAPlayer(closestPed) then
		TriggerServerEvent("emotes:requestSharedEmote", GetPlayerServerIdFromPed(closestPed), emote)
	else
		NetworkRequestControlOfEntity(closestPed)
		TeleportToPartner(closestPed, PlayerPedId(), emote)
		PlayAnimation(closestPed, emote.partner.animation)
		CurrentEmote = emote
	end
end

function AcceptSharedEmoteRequest()
	TriggerServerEvent("emotes:acceptSharedEmote", SharedEmoteRequest.player, SharedEmoteRequest.emote)

	local partner = GetPlayerPedFromServerId(SharedEmoteRequest.player)

	TeleportToPartner(PlayerPedId(), partner, SharedEmoteRequest.emote)

	local emote = SharedEmoteRequest.emote.partner
	emote.name = SharedEmoteRequest.emote.name
	emote.partner = {ped = partner}

	SharedEmoteRequest = nil

	CurrentEmote = emote
end

function RejectSharedEmoteRequest()
	TriggerServerEvent("emotes:rejectSharedEmote", SharedEmoteRequest.player, SharedEmoteRequest.emote)
	SharedEmoteRequest = nil
end

function StartUsingEmote(name)
	if CurrentEmote then
		StopUsingEmote()
	end

	local emote = Config.Emotes[name]

	if not emote then
		ShowNotification("Invalid emote: " .. name)
		return
	end

	if not emote.name then
		emote.name = name
	end

	if emote.partner then
		SendSharedEmoteRequest(emote)
	else
		CurrentEmote = emote
	end
end

function StopUsingEmote()
	if not CurrentEmote then
		return
	end

	local emote = CurrentEmote
	CurrentEmote = nil

	local ped = PlayerPedId()

	if emote.prop then
		DetachEntity(emote.prop.handle)
		DeleteObject(emote.prop.handle)
	end

	if emote.animation then
		StopAnimation(ped, emote.animation)
	end

	if emote.partner then
		if IsPedAPlayer(emote.partner.ped) then
			TriggerServerEvent("emotes:stopSharedEmote", GetPlayerServerIdFromPed(emote.partner.ped), emote)
		else
			StopAnimation(emote.partner.ped, emote.partner.animation)
		end
	end
end

function DrawSharedEmoteRequestText()
	local player = GetPlayerFromServerId(SharedEmoteRequest.player)
	local pos = GetEntityCoords(GetPlayerPed(player))
	DrawText3D(pos.x, pos.y, pos.z, GetPlayerName(player) .. " emote: " .. SharedEmoteRequest.emote.name .. ". Paina [E] hyväksyäksesi, tai [R] peruaksesi.")
end

function EmoteCommand(source, args, raw)
	if args[1] then
		StartUsingEmote(args[1])
	else
		StopUsingEmote()
	end
end

function GetEmotes()
	local soloEmotes = {}
	local sharedEmotes = {}
	local propEmotes = {}

	for emote, info in pairs(Config.Emotes) do
		if info.type == "solo" then
			table.insert(soloEmotes, {name = info.name, command = emote})
		elseif info.type == "shared" then
			table.insert(sharedEmotes, {name = info.name, command = emote})
		elseif info.type == "prop" then
			table.insert(propEmotes, {name = info.name, command = emote})
		end
	end

	table.sort(soloEmotes, function(a, b) return a.name < b.name end)
	table.sort(sharedEmotes, function(a, b) return a.name < b.name end)
	table.sort(propEmotes, function(a, b) return a.name < b.name end)

	return {
		{name = "Solo Emotes", emotes = soloEmotes},
		{name = "Shared Emotes", emotes = sharedEmotes},
		{name = "Prop Emotes", emotes = propEmotes},
	}
end

function GetEmotesAsJson()
	return json.encode(GetEmotes())
end

exports("getEmotes", GetEmotes)
exports("getEmotesAsJson", GetEmotesAsJson)

RegisterCommand("emote", EmoteCommand)
RegisterCommand("e", EmoteCommand)

AddEventHandler("emotes:requestSharedEmote", function(player, emote)
	SharedEmoteRequest = {player = player, emote = emote, expires = GetSystemTime() + Config.SharedEmoteTimeout}
end)

AddEventHandler("emotes:rejectSharedEmote", function(player, emote)
	ShowNotification(GetPlayerNameFromServerId(player) .. " ei halunnut käyttää emotea " .. emote.name)
end)

AddEventHandler("emotes:acceptSharedEmote", function(player, emote)
	CurrentEmote = emote
end)

AddEventHandler("emotes:stopSharedEmote", function(player, emote)
	StopUsingEmote()
end)

AddEventHandler("onResourceStop", function(resource)
	if GetCurrentResourceName() ~= resource then
		return
	end

	if CurrentEmote then
		StopUsingEmote()
	end
end)

CreateThread(function()
	TriggerEvent("chat:addSuggestion", "/emote", "Use an emote", {
		{name = "emote", help = "Emote to use, or omit to cancel the current emote"}
	})
	TriggerEvent("chat:addSuggestion", "/e", "Use an emote", {
		{name = "emote", help = "Emote to use, or omit to cancel the current emote"}
	})

	while true do
		if SharedEmoteRequest then
			if SharedEmoteRequest.expires <= GetSystemTime() then
				RejectSharedEmoteRequest()
			else
				DrawSharedEmoteRequestText()

				DisableControlAction(0, Config.SharedEmoteAcceptControl, true)
				DisableControlAction(0, Config.SharedEmoteRejectControl, true)

				if IsDisabledControlJustPressed(0, Config.SharedEmoteAcceptControl) then
					AcceptSharedEmoteRequest()
				elseif IsDisabledControlJustPressed(0, Config.SharedEmoteRejectControl) then
					RejectSharedEmoteRequest()
				end
			end
		end

		if CurrentEmote then
			local ped = PlayerPedId()
			local anim = CurrentEmote.animation

			if anim and not IsPlayingAnimation(ped, anim) then
				PlayAnimation(ped, anim)
			end

			if CurrentEmote.prop then
				if not (CurrentEmote.prop.handle and DoesEntityExist(CurrentEmote.prop.handle)) then
					CreateProp()
					AttachProp(ped)
				elseif not IsEntityAttachedToEntity(CurrentEmote.prop.handle, ped) then
					AttachProp(ped)
				end
			end
		end

		Wait(0)
	end
end)

RegisterCommand("1",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_BLOW_KISS_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("2",function()
Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_BITING_GOLD_COIN_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("3",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_BOAST_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("4",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_CHECK_POCKET_WATCH_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("5",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_COIN_FLIP_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("6",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_FIST_PUMP_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("7",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_FLEX_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("8",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_FOLLOW_ME_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("9",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_HISSYFIT_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("10",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_HOWL_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("11",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_HYPNOSIS_POCKET_WATCH_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("12",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_LETS_CRAFT_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("13",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_LETS_FISH_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("14",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_LETS_GO_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("15",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_LETS_PLAY_CARDS_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("16",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_LOOK_DISTANCE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("17",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_LOOK_YONDER_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("18",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_NEWTHREADS_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("19",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_POINT_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("20",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_POSSE_UP_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("21",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_PRAYER_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("22",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_PROSPECTOR_JIG_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("23",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_ROCK_PAPER_SCISSORS_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("24",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_SCHEME_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("25",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_SHOOTHIP_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("26",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_SKYWARD_SHOOTING_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("27",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_SPIT_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("28",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_SPOOKY_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("29",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_STOP_HERE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("30",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_ACTION_TAKE_NOTES_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("31",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_HAT_FLICK_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("32",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_DANCE_CAREFREE_A_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("33",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_HEY_YOU_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("34",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_DANCE_DRUNK_A_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("35",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_DANCE_DRUNK_B_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("36",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_SEVEN_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("37",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_DANCE_GRACEFUL_A_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("38",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_SUBTLE_WAVE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("39",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_TADA_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("40",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_FANCY_BOW_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("41",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_GENTLEWAVE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("42",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_GET_OVER_HERE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("43",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_GLAD_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("44",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_THUMBSUP_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("45",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_TOUGH_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("46",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_GREET_WAVENEAR_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("47",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_APPLAUSE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("48",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_BEGMERCY_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("49",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_CLAP_ALONG_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("50",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_HANGOVER_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("51",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_HOW_DARE_YOU_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("52",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_HURL_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("53",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_HUSH_YOUR_MOUTH_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("54",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_JOVIAL_LAUGH_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("55",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_NOD_HEAD_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("56",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_POINTLAUGH_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("57",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SCARED_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("58",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SHAKEHEAD_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("59",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SHOT_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("60",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SHRUG_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("61",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SHUFFLE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("62",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SLOW_CLAP_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("63",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SNIFFING_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("64",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SOB_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("65",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_SURRENDER_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("66",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_THANKS_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("67",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_THUMBSDOWN_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("68",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_WHO_ME_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("69",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_REACTION_YEEHAW_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("70",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_BOOHOO_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("71",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_CHICKEN_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("72",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_COUGAR_SNARL_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("73",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_FLIP_OFF_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("74",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_FRIGHTEN_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("75",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_GORILLA_CHEST_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("76",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_IM_WATCHING_YOU_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("77",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_PROVOKE_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("78",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_RIPPER_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("79",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_THROAT_SLIT_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("80",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_UP_YOURS_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("81",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_VERSUS_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("82",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_WAR_CRY_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("83",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF,PlayerPedId(),1,2,GetHashKey("KIT_EMOTE_TAUNT_YOUSTINK_1"),0,0,0,0,0)  -- FULL BODY EMOTE
end)

RegisterCommand("84",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -166523388 , 1, 1, 0, 0)
end)

RegisterCommand("85",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -1457020913 , 1, 1, 0, 0)
end)--TipHat

RegisterCommand("86",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1256841324 , 1, 1, 0, 0)
end)--Slit Throut

RegisterCommand("87",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1023735814 , 1, 1, 0, 0)
end)--Slow Clap

RegisterCommand("88",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -653113914 , 1, 1, 0, 0)
end)--smh

RegisterCommand("89",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -2106738342, 1, 1, 0, 0)
end)--Spit

RegisterCommand("90",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 1509171361, 1, 1, 0, 0)
end)--Thumbs Down

RegisterCommand("91",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 425751659, 1, 1, 0, 0)
end)--Thumbs Up

RegisterCommand("92",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, -339257980, 1, 1, 0, 0)
end)--wave

RegisterCommand("93",function()
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, 969312568 , 1, 1, 0, 0)
end)--smh