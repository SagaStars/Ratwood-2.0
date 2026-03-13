/datum/sex_action/chastityplay/fondle_cage
	name = "Fondle their chastity device"
	user_sex_part = SEX_PART_NULL
	category = SEX_CATEGORY_HANDS

/datum/sex_action/chastityplay/fondle_cage/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!requires_other_target(user, target))
		return FALSE
	if(!target_has_cage(target))
		return FALSE
	if(!can_reach_target_groin(user, target))
		return FALSE
	return TRUE

/datum/sex_action/chastityplay/fondle_cage/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!requires_other_target(user, target))
		return FALSE
	if(!target_has_cage(target))
		return FALSE
	if(!can_reach_target_groin(user, target))
		return FALSE
	return TRUE

/datum/sex_action/chastityplay/fondle_cage/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(HAS_TRAIT(target, TRAIT_CHASTITY_SPIKED))
		user.visible_message(span_warning("[user] traces [user.p_their()] fingers over the inward spikes in [target]'s [get_chastity_device_name(target)]..."))
		return
	user.visible_message(span_warning("[user] starts fondling [target]'s [get_chastity_device_name(target)]..."))

/datum/sex_action/chastityplay/fondle_cage/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(HAS_TRAIT(target, TRAIT_CHASTITY_SPIKED))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rubs and presses on [target]'s spiked chastity, making each twitch drive spikes inward..."))
		user.sexcon.perform_sex_action(target, 0.2, 3.6, TRUE)
		user.sexcon.try_do_pain_scream(target, 3.6)
		if(target.sexcon.check_active_ejaculation())
			target.sexcon.ejaculate()
		return
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fondles [target]'s [get_chastity_device_name(target)]..."))
	// user.sexcon.chastitycourse_noise(user)

	user.sexcon.perform_sex_action(target, 0.5, 0, TRUE)
	if(target.sexcon.check_active_ejaculation())
		target.sexcon.ejaculate()

/datum/sex_action/chastityplay/fondle_cage/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops fondling [target]'s [get_chastity_device_name(target)]..."))

/datum/sex_action/chastityplay/fondle_cage/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
