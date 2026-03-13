/datum/sex_action/chastityplay/cockcage_to_belt
    name = "Press cage to belt"
    category = SEX_CATEGORY_PENETRATE

/datum/sex_action/chastityplay/cockcage_to_belt/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(!requires_other_target(user, target))
        return FALSE
    if(!target_has_cage(user))
        return FALSE
    if(!target.sexcon.has_chastity_vagina())
        return FALSE
    return TRUE

/datum/sex_action/chastityplay/cockcage_to_belt/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(!requires_other_target(user, target))
        return FALSE
    if(!target_has_cage(user))
        return FALSE
    if(!target.sexcon.has_chastity_vagina())
        return FALSE
    if(!can_reach_target_groin(user, user))
        return FALSE
    if(!can_reach_target_groin(user, target))
        return FALSE
    return TRUE

/datum/sex_action/chastityplay/cockcage_to_belt/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
    user.visible_message(span_warning("[user] presses [user.p_their()] cage against [target]'s locked belt."))

/datum/sex_action/chastityplay/cockcage_to_belt/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
    user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rubs cage against belt, metal scraping on metal..."))
    user.sexcon.outercourse_noise(target, TRUE)

    user.sexcon.perform_sex_action(user, 1.1, 1, TRUE)
    user.sexcon.perform_sex_action(target, 1.1, 1, TRUE)
    user.sexcon.handle_passive_ejaculation(target)
    target.sexcon.handle_passive_ejaculation(user)

/datum/sex_action/chastityplay/cockcage_to_belt/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
    user.visible_message(span_warning("[user] breaks contact between [user.p_their()] cage and [target]'s belt."))

/datum/sex_action/chastityplay/cockcage_to_belt/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(user.sexcon.finished_check())
        return TRUE
    return FALSE
