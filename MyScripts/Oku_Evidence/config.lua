Config = {

-- IMPORTANT! To configure report text navigate to /html/script.js and find the text you want to replace

EvidenceReportInformationBullet = "firstname, lastname, job", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)
EvidenceReportInformationBlood = "firstname, lastname, job", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)

PlayClipboardAnimation = true, -- Play clipboard animation when reading report

JobRequired = 'police', -- The job needed to use evidence system
JobGradeRequired = 6, -- The MINIMUM job grade required to use evidence system (If you use 0 all job grades can use the system)

CloseReportKey = 'BACKSPACE', -- The key used to close the report
PickupEvidenceKey = 'G', -- The key used to pick up evidence

EvidenceAlanysisLocation = vector3(2505.87, -1299.5, 39.93), -- The place where the evidence will be analyzed and report generated
TimeToAnalyze = 10000, -- Time in miliseconds to analyze the given evidence

--UPDATE V2
RainRemovesEvidence = true, -- Removes evidence when it starts raining!
TimeBeforeCrimsCanDestory = 120, -- Seconds before Criminals can destroy evidence (300 is the time when evidence coolsdown and shows up as WARM)
EvidenceStorageLocation = vector3(2513.44, -1299.43, 39.94), -- The place where all evidence are being archived! You can view old evidence or delete it
--

Text = {

	--UPDATE V2
	['not_in_vehicle'] = 'To use this you need to be in a vehicle!',
	['remove_evidence'] = '~q~Tuhoa todiste ~t~[~e~ALT~t~]',
	['cooldown_before_pickup'] = 'Todiste on liian tuore/kuuma hävittämiseen',
	['evidence_removed'] = 'Todiste hävitetty!',
	['open_evidence_archive'] = '~t~[~e~ALT~t~] Tutki todistevarastoa',
	['evidence_archive'] = 'Todistevarasto',
	['view'] = 'Tutki',
	['delete'] = 'Poista',
	['report_list'] = 'Raportti #',
	['evidence_deleted_from_archive'] = 'Todisteaineisto tuhottu!',
	--

	['evidence_colleted'] = 'Todiste otettu numero: ',
	['no_more_space'] = 'Ei enempää tilaa todisteille 3/3!',
	['analyze_evidence'] = '~t~[~e~ALT~t~] Tutki todistetta',
	['evidence_being_analyzed'] = 'Tutkijat selvittävät asiaa! Odota hetki',
	['evidence_being_analyzed_hologram'] = 'Todistetta tutkitaan',
	['read_evidence_report'] = '~t~[~e~ALT~t~] Lue raportti',
	['pick_up_evidence_text'] = '~q~Ota todiste ~t~[~e~ALT~t~]',
	['no_evidence_to_analyze'] = "Ei todisteita tutkittavaksi!",
	['shell_hologram'] = '~t3~ {guncategory} | ~q~hylsy',
	['blood_hologram'] = 'Veritahra',

	['blood_after_0_minutes'] = '~t6~Tila~t~: ~e~TUORE',
	['blood_after_5_minutes'] = '~t6~Tila~t~: ~d~VANHENTUNUT',
	['blood_after_10_minutes'] = '~t6~Tila~t~: ~o~VANHA',

	['shell_after_0_minutes'] = '~t6~Tila~t~: ~e~KUUMA',
	['shell_after_5_minutes'] = '~t6~Tila~t~: ~o~LÄMMIN',
	['shell_after_10_minutes'] = '~t6~Tila~t~: ~pa~KYLMÄ',


	['group_shotgun'] = 'Haulikko',
	['pistol_category'] = 'Revolveri',
	['shotgun_category'] = 'Haulikko',
	['repeater_category'] = 'Vipulukko',
	['lightmachine_category'] = 'Light Machine Gun',
	['sniper_category'] = 'Kiikarikivääri',
	['heavy_category'] = 'Heavy Weapon'


}
	

}
