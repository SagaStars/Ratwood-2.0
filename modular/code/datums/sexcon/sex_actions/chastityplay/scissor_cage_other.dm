/datum/sex_action/chastityplay/scissor_cage_other
    name = "Scissor with your locked slit"
    user_sex_part = SEX_PART_CUNT
    target_sex_part = SEX_PART_CUNT

/datum/sex_action/chastityplay/scissor_cage_other/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(!requires_other_target(user, target))
        return FALSE
    if(!user.sexcon.has_chastity_vagina())
        return FALSE
    if(!target.getorganslot(ORGAN_SLOT_VAGINA))
        return FALSE
    if(target.sexcon.has_chastity_vagina())
        return FALSE
    return TRUE

/datum/sex_action/chastityplay/scissor_cage_other/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(!requires_other_target(user, target))
        return FALSE
    if(!user.sexcon.has_chastity_vagina())
        return FALSE
    if(!target.getorganslot(ORGAN_SLOT_VAGINA))
        return FALSE
    if(target.sexcon.has_chastity_vagina())
        return FALSE
    if(!can_reach_target_groin(user, user))
        return FALSE
    if(!can_reach_target_groin(user, target))
        return FALSE
    return TRUE

/datum/sex_action/chastityplay/scissor_cage_other/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
    user.visible_message(span_warning("[user] presses [user.p_their()] locked slit against [target]'s cunt."))

/datum/sex_action/chastityplay/scissor_cage_other/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
    user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] grinds [user.p_their()] belt slit against [target]'s cunt."))
    user.sexcon.outercourse_noise(target, TRUE)
    user.sexcon.perform_sex_action(user, 1.6, 0.5, TRUE)
    user.sexcon.perform_sex_action(target, 1.7, 0.5, TRUE)
    user.sexcon.handle_passive_ejaculation(target)
    target.sexcon.handle_passive_ejaculation(user)

/datum/sex_action/chastityplay/scissor_cage_other/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
    user.visible_message(span_warning("[user] stops grinding [user.p_their()] belt slit against [target]."))

/datum/sex_action/chastityplay/scissor_cage_other/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(target.sexcon.finished_check())
        return TRUE
    return FALSE
