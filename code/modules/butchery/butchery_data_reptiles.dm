/decl/butchery_data/animal/reptile
	abstract_type = /decl/butchery_data/animal/reptile
	skin_material = /decl/material/solid/organic/skin/lizard

/decl/butchery_data/animal/reptile/small
	meat_amount   = 1
	bone_amount   = 1
	skin_amount   = 1
	must_use_hook = FALSE

/decl/butchery_data/animal/reptile/drake/harvest_bones(mob/living/donor)
	. = ..()
	LAZYADD(., new /obj/item/whip/tail(get_turf(donor)))
