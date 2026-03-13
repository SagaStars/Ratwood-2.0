/datum/sex_action/chastityplay/kick_cage
	name = "Kick their chastity"
	check_same_tile = FALSE
	category = SEX_CATEGORY_HANDS

/datum/sex_action/chastityplay/kick_cage/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!requires_other_target(user, target))
		return FALSE
	if(!HAS_TRAIT(user, TRAIT_NUTCRACKER))
		return FALSE
	if(!target_has_front_chastity(target))
		return FALSE
	return TRUE

/datum/sex_action/chastityplay/kick_cage/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!requires_other_target(user, target))
		return FALSE
	if(!HAS_TRAIT(user, TRAIT_NUTCRACKER))
		return FALSE
	if(user.resting)
		return FALSE
	if(!target_has_front_chastity(target))
		return FALSE
	if(!user.Adjacent(target))
		return FALSE
	if(!can_reach_target_groin(user, target))
		return FALSE
	if(!check_location_accessible(user, user, BODY_ZONE_PRECISE_L_FOOT) && !check_location_accessible(user, user, BODY_ZONE_PRECISE_R_FOOT))
		return FALSE
	return TRUE

/datum/sex_action/chastityplay/kick_cage/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/device = target.sexcon.has_chastity_cage() ? "cage" : "belt"
	play_chastity_impact_sound(target, 'sound/combat/hits/kick/kick.ogg', 40, 100, TRUE, -1)
	if(HAS_TRAIT(target, TRAIT_CHASTITY_SPIKED))
		user.visible_message(span_warning("[user] plants a foot against [target]'s spiked [device] and tests the pressure..."))
		return
	user.visible_message(span_warning("[user] lines up [user.p_their()] foot against [target]'s [device]..."))

/datum/sex_action/chastityplay/kick_cage/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/force = user.sexcon.force
	var/device = target.sexcon.has_chastity_cage() ? "cage" : "belt"
	var/msg
	var/arousal_amt = 0.7
	var/pain_amt = 2

	if(HAS_TRAIT(user, TRAIT_DEATHBYSNUSNU))
		user.sexcon.try_pelvis_crush(target)

	switch(force)
		if(SEX_FORCE_LOW)
			msg = "[user] [user.sexcon.get_generic_force_adjective()] rubs and taps [user.p_their()] foot over [target]'s [device]..."
			arousal_amt = 1.0
			pain_amt = 1.5
		if(SEX_FORCE_MID)
			msg = "[user] [user.sexcon.get_generic_force_adjective()] gives [target]'s [device] a rough kick, making metal bite into tender flesh..."
			arousal_amt = 0.6
			pain_amt = 4.5
		if(SEX_FORCE_HIGH)
			msg = "[user] [user.sexcon.get_generic_force_adjective()] drives repeated kicks into [target]'s [device], each impact harder than the last..."
			arousal_amt = 0.25
			pain_amt = 7.5
		if(SEX_FORCE_EXTREME)
			msg = "[user] [user.sexcon.get_generic_force_adjective()] stomps [target]'s [device], grinding heel and steel together..."
			arousal_amt = 0.0
			pain_amt = 11

	user.visible_message(user.sexcon.spanify_force(msg))
	if(force >= SEX_FORCE_EXTREME)
		play_chastity_impact_sound(target, 'sound/combat/hits/kick/stomp.ogg', 65, 100, TRUE, -1)
	else
		play_chastity_impact_sound(target, 'sound/combat/hits/kick/kick.ogg', 55, 100, TRUE, -1)
	user.sexcon.perform_sex_action(target, arousal_amt, pain_amt, TRUE)

	if(HAS_TRAIT(target, TRAIT_CHASTITY_SPIKED))
		play_chastity_impact_sound(target, 'sound/combat/hits/bladed/genstab (1).ogg', 45, 45)
		user.visible_message(span_warning("The inward spikes punish every strike, digging deeper with each impact!"))
		user.sexcon.perform_sex_action(target, 0, 3.2, TRUE)
		user.sexcon.try_do_pain_scream(target, pain_amt + 3.2)
		if(force >= SEX_FORCE_HIGH && prob(35))
			to_chat(user, span_warning("A spike catches your foot during the kick, stinging sharply."))
			user.sexcon.perform_sex_action(user, 0, 1.2, TRUE)
			user.sexcon.try_do_pain_scream(user, 1.2)

	target.sexcon.handle_passive_ejaculation(user)

/datum/sex_action/chastityplay/kick_cage/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/device = target.sexcon.has_chastity_cage() ? "cage" : "belt"
	user.visible_message(span_warning("[user] eases off and lowers [user.p_their()] foot from [target]'s [device]."))

/datum/sex_action/chastityplay/kick_cage/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
