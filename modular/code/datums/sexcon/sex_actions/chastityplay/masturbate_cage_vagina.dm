/datum/sex_action/chastityplay/masturbate_cage_vagina
    name = "Rub your locked slit"
    category = SEX_CATEGORY_HANDS
    user_sex_part = SEX_PART_CUNT

/datum/sex_action/chastityplay/masturbate_cage_vagina/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(user != target)
        return FALSE
    if(!user.getorganslot(ORGAN_SLOT_VAGINA))
        return FALSE
    if(!user.sexcon.has_chastity_vagina())
        return FALSE
    return TRUE

/datum/sex_action/chastityplay/masturbate_cage_vagina/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(user != target)
        return FALSE
    if(!user.getorganslot(ORGAN_SLOT_VAGINA))
        return FALSE
    if(!user.sexcon.has_chastity_vagina())
        return FALSE
    if(!check_location_accessible(user, user, BODY_ZONE_PRECISE_GROIN, TRUE))
        return FALSE
    return TRUE

/datum/sex_action/chastityplay/masturbate_cage_vagina/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
    user.visible_message(span_warning("[user] starts rubbing [user.p_their()] fingers over [user.p_their()] locked slit."))

/datum/sex_action/chastityplay/masturbate_cage_vagina/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
    user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] traces and presses along [user.p_their()] chastity slit..."))
    user.sexcon.perform_sex_action(user, 1.6, 0.5, TRUE)
    user.sexcon.handle_passive_ejaculation()

/datum/sex_action/chastityplay/masturbate_cage_vagina/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
    user.visible_message(span_warning("[user] stops rubbing [user.p_their()] locked slit."))

/datum/sex_action/chastityplay/masturbate_cage_vagina/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(user.sexcon.finished_check())
        return TRUE
    return FALSE
