/mob/living/carbon/human/proc/modular_handle_chastitything(mob/user)
	if(!user)
		return TRUE
	if(!get_location_accessible(src, BODY_ZONE_PRECISE_GROIN, grabs = FALSE, skipundies = TRUE))
		to_chat(user, span_warning("I can't reach that! Something is covering it."))
		return TRUE
	if(!chastity_device)
		return TRUE
	
	// HARD MODE: Locked devices cannot be removed at all
	if(chastity_device.is_hardmode_active() && HAS_TRAIT(src, TRAIT_CHASTITY_LOCKED))
		to_chat(user, span_warning("The device is sealed by a permanent binding. No amount of force will break it - only the key."))
		return TRUE
	
	if(HAS_TRAIT(src, TRAIT_CHASTITY_LOCKED))
		to_chat(user, span_warning("I can't remove [src]'s chastity device while it's locked!"))
		return TRUE
	
	user.visible_message(span_notice("[user] removes [src]'s chastity device."))
	chastity_device.remove_chastity(src)
	if(!user.put_in_hands(chastity_device))
		chastity_device.forceMove(get_turf(src))
	return TRUE

/mob/living/carbon/human/proc/modular_handle_chastity_middleclick_strip(mob/user)
	if(!user)
		return TRUE
	if(chastity_device && !chastity_device.locked)
		return modular_handle_chastitything(user)

	if(chastity_device && chastity_device.locked)
		// HARD MODE: Chisel removal blocked
		if(chastity_device.is_hardmode_active())
			to_chat(user, span_warning("The metal refuses to yield. This binding cannot be broken by mortal tools."))
			playsound(src, 'sound/items/pickbad.ogg', 40, TRUE)
			return TRUE
		
		if(chastity_device.attempt_forced_removal(src, user))
			return TRUE
	return FALSE

/mob/living/carbon/human/proc/modular_strippanel_chastity_row()
	if(!get_location_accessible(src, BODY_ZONE_PRECISE_GROIN, skipundies = TRUE))
		return null
	var/chastity_action = "Nothing"
	if(chastity_device)
		if(HAS_TRAIT(src, TRAIT_CHASTITY_LOCKED))
			chastity_action = "Locked"
		else
			chastity_action = "Remove"
	var/chastity_row = "<tr><td><BR><B>Chastity:</B> <A href='?src=[REF(src)];chastitything=1'>"
	chastity_row += chastity_action
	chastity_row += "</A></td></tr>"
	return chastity_row

/mob/living/carbon/human/proc/modular_chastity_attached_toy_overlay()
	if(!istype(chastity_device?.attached_toy, /obj/item/dildo))
		return null

	var/mutable_appearance/mchastitydildo = mutable_appearance('modular/icons/obj/lewd/dildo.dmi', "dildo_belt_[chastity_device.attached_toy.dildo_size]", layer = -ABOVE_BODY_FRONT_LAYER)
	mchastitydildo.color = chastity_device.attached_toy.color

	if(dna && dna.species.sexes && !dna.species.custom_clothes)
		if(gender == MALE)
			if(OFFSET_BELT in dna.species.offset_features)
				mchastitydildo.pixel_x += dna.species.offset_features[OFFSET_BELT][1]
				mchastitydildo.pixel_y += dna.species.offset_features[OFFSET_BELT][2]
		else
			if(OFFSET_BELT_F in dna.species.offset_features)
				mchastitydildo.pixel_x += dna.species.offset_features[OFFSET_BELT_F][1]
				mchastitydildo.pixel_y += dna.species.offset_features[OFFSET_BELT_F][2]

	return mchastitydildo

/client/proc/modular_handle_chastity_toggle_disable()
	if(!ishuman(mob))
		return
	var/mob/living/carbon/human/human_mob = mob
	var/obj/item/chastity/device = human_mob.chastity_device
	if(!device)
		return
	
	// HARD MODE: Toggle does not remove device
	if(device.is_hardmode_active() && device.locked)
		to_chat(src, span_warning("The device remains locked upon you. Even divine will cannot break a permanent binding."))
		to_chat(src, span_notice("You remain bound. Only the key can grant freedom."))
		return
	
	// Normal mode: remove device
	device.remove_chastity(human_mob)
	device.forceMove(get_turf(human_mob))
	human_mob.visible_message(span_notice("the divine hand of Eora slipped [device] free from [human_mob]'s loins!"))
