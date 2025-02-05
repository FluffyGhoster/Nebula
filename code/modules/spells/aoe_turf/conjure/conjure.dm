/*
Conjure spells spawn things (mobs, objs, turfs) in their summon_type
How they spawn stuff is decided by behaviour vars, which are explained below
*/

/spell/aoe_turf/conjure
	name = "Conjure"
	desc = "This spell conjures objs of the specified types in range."

	school = "conjuration" //funny, that

	var/list/summon_type = list() //determines what exactly will be summoned
	//should NOT be text, like list(/obj/machinery/bot/ed209)

	range = 0		//default values: only spawn on the player tile
	selection_type = "view"

	duration = 0 // 0=permanent, any other time in deciseconds - how long the summoned objects last for
	var/summon_amt = 1 //amount of objects summoned
	var/summon_exclusive = 0 //spawn one of everything, instead of random things

	var/list/newVars = list() //vars of the summoned objects will be replaced with those where they meet
	//should have format of list("emagged" = 1,"name" = "Justicebot"), for example

	cast_sound = 'sound/magic/castsummon.ogg'

/spell/aoe_turf/conjure/cast(list/targets, mob/user)

	for(var/i=1,i <= summon_amt,i++)
		if(!targets.len)
			break
		var/summoned_object_type
		if(summon_exclusive)
			if(!summon_type.len)
				break
			summoned_object_type = summon_type[1]
			summon_type -= summoned_object_type
		else
			summoned_object_type = pick(summon_type)
		var/turf/spawn_place = pick(targets)
		var/atom/summoned_object
		if(ispath(summoned_object_type,/turf))
			spawn_place.ChangeTurf(summoned_object_type)
			summoned_object = spawn_place
		else
			summoned_object = new summoned_object_type(spawn_place)
		var/atom/movable/overlay/animation = new /atom/movable/overlay(summoned_object)
		animation.SetName("conjure")
		animation.set_density(0)
		animation.anchored = TRUE
		animation.icon = 'icons/effects/effects.dmi'
		animation.layer = BASE_HUMAN_LAYER
		if(ismob(summoned_object)) //we want them to NOT attack us.
			var/mob/M = summoned_object
			M.faction = user.faction
		apply_vars(summoned_object, user)

		if(duration)
			spawn(duration)
				if(summoned_object && !isturf(summoned_object))
					qdel(summoned_object)
		conjure_animation(animation, spawn_place)
	return

/spell/aoe_turf/conjure/proc/conjure_animation(var/atom/movable/overlay/animation, var/turf/target)
	qdel(animation)

/spell/aoe_turf/conjure/proc/apply_vars(atom/summoned_object, mob/caster)
	if(!istype(summoned_object) || !length(newVars))
		return
	for(var/varName in newVars)
		if(varName in summoned_object.vars)
			summoned_object.vars[varName] = newVars[varName]
