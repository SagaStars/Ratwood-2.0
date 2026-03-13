// Chastity key logic split into modular file so core keys.dm only keeps broad lock override behavior.

/obj/item/roguekey/chastity
	name = "chastity key"
	desc = "Default chastity cage desc before changed upon generation"
	icon_state = "mazekey" // Puritanical type key, Astrata smiles on the abstinent.

/obj/item/roguekey/chastity/attack_self(mob/user)
	if(!hardmode_indestructible)
		return ..()
	
	// Hard mode keys require confirmation to destroy
	var/confirm = alert(user,
		"This key bears the mark of a permanent binding.\n\n\
		Destroying it may condemn someone to eternal chastity.\n\n\
		Do you truly wish to destroy this key?",
		"Destroy Binding Key",
		"Yes, destroy it forever",
		"No, preserve it")
	
	if(confirm != "Yes, destroy it forever")
		to_chat(user, span_notice("You decide the key is too important to destroy."))
		return
	
	user.visible_message(
		span_boldwarning("[user] snaps [src] in half with deliberate finality!"),
		span_boldwarning("You destroy [src]. Someone's fate is now sealed..."))
	
	log_game("[key_name(user)] destroyed hard mode chastity key [src] (hash: [lockhash]).")
	message_admins("[key_name_admin(user)] destroyed hard mode chastity key (hash: [lockhash]).")
	
	playsound(src, 'sound/items/gem.ogg', 50, TRUE)
	qdel(src)

/obj/item/roguekey/chastity/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(target == user && ishuman(user))
		attack(user, user, user.zone_selected)
		return
	return ..()

/obj/item/roguekey/chastity/attack(mob/M, mob/user, def_zone)
	if(!ishuman(M))
		return ..()

	var/mob/living/carbon/human/H = M
	var/obj/item/chastity/device = H.chastity_device
	if(!get_location_accessible(H, BODY_ZONE_PRECISE_GROIN, skipundies = TRUE))
		to_chat(user, span_warning("[H]'s groin is covered. I can't see a cage let alone unlock one!"))
		return
	if(!device)
		to_chat(user, span_warning("[H] isn't wearing a chastity device. Against Astrata's Will their genitals are free ranged."))
		return TRUE
	if(!device.lockable)
		to_chat(user, span_warning("[H]'s chastity device cannot be manipulated with a key."))
		playsound(src, 'sound/foley/doors/lockrattle.ogg', 100)
		return TRUE

	if(device.lockhash != src.lockhash)
		var/found_key = FALSE
		for(var/obj/item/storage/keyring/K in user.held_items)
			if(!K.contents.Find(/obj/item/roguekey/chastity))
				continue
			for(var/obj/item/roguekey/chastity/KE in K.contents)
				if(KE.lockhash == device.lockhash)
					found_key = TRUE
					break
			if(found_key)
				break
		if(!found_key)
			to_chat(user, span_warning("This key doesn't fit [H]'s chastity device."))
			playsound(src, 'sound/foley/doors/lockrattle.ogg', 100)
			return TRUE

	var/new_locked_state = !device.locked
	if(SEND_SIGNAL(H, COMSIG_CARBON_CHASTITY_LOCK_INTERACT, user, src, new_locked_state, "key") & COMPONENT_CHASTITY_LOCK_INTERACT_BLOCK)
		to_chat(user, span_warning("[H]'s chastity lock resists [src]."))
		playsound(src, 'sound/foley/doors/lockrattle.ogg', 100)
		return TRUE

	if(device.locked)
		// Optional fumble: low luck users can snap the key in the lock.
		var/break_chance = 0
		if(ishuman(user))
			var/mob/living/carbon/human/U = user
			if(U.STALUC <= 9)
				// 9 luck = 5%, 8 luck = 10%, down to 0 luck = 50%.
				break_chance = (10 - U.STALUC) * 5
		if(break_chance && prob(break_chance))
			user.visible_message(span_warning("[user]'s [src] snaps off inside [H]'s chastity lock!"), span_warning("My [src] snaps off inside the lock!"))
			playsound(src, 'sound/foley/doors/lockrattle.ogg', 100)
			qdel(src)
			return TRUE

		user.visible_message(span_notice("[user] unlocks [H]'s chastity device with [src]."))
		playsound(src, 'sound/foley/doors/lock.ogg', 100)
	else
		user.visible_message(span_notice("[user] locks [H]'s chastity device with [src]."))
		playsound(src, 'sound/foley/doors/lock.ogg', 100)

	device.set_chastity_locked_state(H, new_locked_state, user, src, "key", "lock_changed_key")

	return TRUE
