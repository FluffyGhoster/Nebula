/decl/submap_archetype
	var/descriptor = "generic ship archetype"
	var/list/whitelisted_species = list()
	var/list/blacklisted_species = list()
	var/call_webhook
	var/list/crew_jobs = list(
		/datum/job/submap
	)
	/// Used to order submaps on the occupation preference menu.
	var/sort_priority = 0
	/// Whether the job preferences for this submap archetype are collapsed by default.
	var/default_to_hidden = TRUE

/decl/submap_archetype/validate()
	. = ..()
	if(!descriptor)
		. += "no descriptor set"

// Generic ships to populate the list.
/decl/submap_archetype/derelict
	descriptor = "drifting wreck"

/decl/submap_archetype/abandoned_ship
	descriptor = "abandoned ship"
