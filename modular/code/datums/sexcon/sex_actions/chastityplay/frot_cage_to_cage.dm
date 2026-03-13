/datum/sex_action/chastityplay/frot_cage_to_cage
    name = "Grind cage to cage"

/datum/sex_action/chastityplay/frot_cage_to_cage/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(!requires_other_target(user, target))
        return FALSE
    if(!target_has_cage(user))
        return FALSE
    if(!target_has_cage(target))
        return FALSE
    return TRUE

/datum/sex_action/chastityplay/frot_cage_to_cage/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(!requires_other_target(user, target))
        return FALSE
    if(!target_has_cage(user))
        return FALSE
    if(!target_has_cage(target))
        return FALSE
    if(!can_reach_target_groin(user, user))
        return FALSE
    if(!can_reach_target_groin(user, target))
        return FALSE
    return TRUE

/datum/sex_action/chastityplay/frot_cage_to_cage/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
    var/user_device = get_chastity_device_name(user)
    var/target_device = get_chastity_device_name(target)
    if(HAS_TRAIT(user, TRAIT_CHASTITY_SPIKED) || HAS_TRAIT(target, TRAIT_CHASTITY_SPIKED))
        user.visible_message(span_warning("[user] presses [user.p_their()] [user_device] to [target]'s [target_device], steel scraping over spikes..."))
        return
    user.visible_message(span_warning("[user] presses [user.p_their()] [user_device] to [target]'s [target_device]."))

/datum/sex_action/chastityplay/frot_cage_to_cage/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
    var/user_device = get_chastity_device_name(user)
    var/target_device = get_chastity_device_name(target)
    if(HAS_TRAIT(user, TRAIT_DEATHBYSNUSNU))
        user.sexcon.try_pelvis_crush(target)

    if(HAS_TRAIT(user, TRAIT_CHASTITY_SPIKED) || HAS_TRAIT(target, TRAIT_CHASTITY_SPIKED))
        user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] grinds [user_device] to [target_device] so spikes scrape and bite with every pass."))
        user.sexcon.outercourse_noise(target, TRUE)
        user.sexcon.perform_sex_action(user, 0.6, 2.2, TRUE)
        user.sexcon.perform_sex_action(target, 0.6, 2.2, TRUE)
        user.sexcon.try_do_pain_scream(user, 2.2)
        user.sexcon.try_do_pain_scream(target, 2.2)
        user.sexcon.handle_passive_ejaculation(target)
        target.sexcon.handle_passive_ejaculation(user)
        return
    user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] scrapes [user_device] against [target]'s [target_device]."))
    user.sexcon.outercourse_noise(target, TRUE)
    user.sexcon.perform_sex_action(user, 1, 1, TRUE)
    user.sexcon.perform_sex_action(target, 1, 1, TRUE)
    user.sexcon.handle_passive_ejaculation(target)
    target.sexcon.handle_passive_ejaculation(user)

/datum/sex_action/chastityplay/frot_cage_to_cage/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
    user.visible_message(span_warning("[user] stops grinding [get_chastity_device_name(user)] to [target]'s [get_chastity_device_name(target)]."))

/datum/sex_action/chastityplay/frot_cage_to_cage/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(target.sexcon.finished_check())
        return TRUE
    return FALSE
