// Modular override handlers for core key item attack procs.

/obj/item/roguekey/lord/proc/modular_chastity_attack(mob/M, mob/user, def_zone)
	if(!ishuman(M))
		return null

	var/mob/living/carbon/human/H = M
	var/obj/item/chastity/device = H.chastity_device
	if(!get_location_accessible(H, BODY_ZONE_PRECISE_GROIN, skipundies = TRUE))
		to_chat(user, span_warning("[H]'s groin is covered. I can't see a cage let alone unlock one!"))
		return TRUE
	if(!device)
		to_chat(user, span_warning("[H] isn't wearing a chastity device. Against Astrata's Will their genitals are free ranged."))
		return TRUE
	if(!device.lockable)
		to_chat(user, span_warning("[H]'s chastity device rejects ordinary lock manipulation."))
		playsound(src, 'sound/foley/doors/lockrattle.ogg', 100)
		return TRUE

	// HARD MODE: Duke's key does not work
	if(device.is_hardmode_active())
		to_chat(user, span_warning("The lock refuses your key. This is a permanent binding - even ducal authority holds no sway here."))
		playsound(src, 'sound/foley/doors/lockrattle.ogg', 100)
		return TRUE

	var/new_locked_state = !device.locked
	if(SEND_SIGNAL(H, COMSIG_CARBON_CHASTITY_LOCK_INTERACT, user, src, new_locked_state, "key") & COMPONENT_CHASTITY_LOCK_INTERACT_BLOCK)
		to_chat(user, span_warning("[H]'s chastity lock resists [src]."))
		playsound(src, 'sound/foley/doors/lockrattle.ogg', 100)
		return TRUE

	if(device.locked)
		user.visible_message(span_notice("[user] unlocks [H]'s chastity device with [src]."))
		playsound(src, 'sound/foley/doors/lock.ogg', 100)
	else
		user.visible_message(span_notice("[user] locks [H]'s chastity device with [src]."))
		playsound(src, 'sound/foley/doors/lock.ogg', 100)

	device.set_chastity_locked_state(H, new_locked_state, user, src, "key", "lock_changed_key")

	return TRUE

/obj/item/lockpick/proc/modular_chastity_attack(mob/M, mob/user, def_zone)
	if(!ishuman(M))
		return null
	if(!ishuman(user))
		to_chat(user, span_warning("I can't get enough control to pick this lock."))
		return TRUE

	var/mob/living/carbon/human/H = M
	var/obj/item/chastity/device = H.chastity_device
	if(!get_location_accessible(H, BODY_ZONE_PRECISE_GROIN, skipundies = TRUE))
		to_chat(user, span_warning("[H]'s groin is covered. I can't see a cage let alone pick one!"))
		return TRUE
	if(!device)
		to_chat(user, span_warning("[H] isn't wearing a chastity device."))
		return TRUE
	if(!device.lockable)
		to_chat(user, span_warning("[H]'s chastity device cannot be picked."))
		playsound(src, 'sound/items/pickbad.ogg', 40, TRUE)
		return TRUE
	if(!device.locked)
		to_chat(user, span_warning("[H]'s chastity device is already unlocked."))
		return TRUE

	// HARD MODE: Lockpicking does not work
	if(device.is_hardmode_active())
		to_chat(user, span_warning("The mechanism is sealed beyond your skill. This binding cannot be picked."))
		playsound(src, 'sound/items/pickbad.ogg', 40, TRUE)
		return TRUE

	var/mob/living/carbon/human/U = user
	var/lockpick_skill = (U.get_skill_level(/datum/skill/misc/lockpicking) || 1)
	var/base_difficulty = 3
	var/difficulty_modifier = max(0, base_difficulty - lockpick_skill)
	var/pick_time = 80 + (difficulty_modifier * 20)
	var/success_chance = min(90, 30 + (lockpick_skill * 15))

	user.visible_message(span_notice("[user] begins picking [H]'s chastity lock..."))
	playsound(src, 'sound/items/pickgood1.ogg', 40, TRUE)

	if(!do_after(user, pick_time, needhand = TRUE, target = H))
		to_chat(user, span_warning("I stop picking the lock."))
		return TRUE

	if(prob(success_chance))
		user.visible_message(span_notice("[user] successfully picks [H]'s chastity lock!"))
		playsound(src, 'sound/foley/doors/lock.ogg', 100)
		device.set_chastity_locked_state(H, FALSE, user, src, "lockpick", "lock_changed_lockpick")
		U.adjust_experience(/datum/skill/misc/lockpicking, round(base_difficulty * 5))
	else
		to_chat(user, span_warning("I fail to pick the lock."))
		playsound(src, 'sound/items/pickbad.ogg', 40, TRUE)
		if(prob(10))
			to_chat(user, span_warning("My lockpick breaks!"))
			qdel(src)

	return TRUE
