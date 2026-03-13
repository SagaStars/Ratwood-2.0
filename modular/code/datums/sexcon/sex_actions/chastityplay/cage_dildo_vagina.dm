/datum/sex_action/chastityplay/cage_dildo_vagina
    name = "Work their inverted dildo"
    category = SEX_CATEGORY_HANDS
    target_sex_part = SEX_PART_CUNT

/datum/sex_action/chastityplay/cage_dildo_vagina/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(!requires_other_target(user, target))
        return FALSE
    if(!target.getorganslot(ORGAN_SLOT_VAGINA))
        return FALSE
    if(!target.sexcon.has_chastity_vagina())
        return FALSE
    return TRUE

/datum/sex_action/chastityplay/cage_dildo_vagina/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(!requires_other_target(user, target))
        return FALSE
    if(!target.getorganslot(ORGAN_SLOT_VAGINA))
        return FALSE
    if(!target.sexcon.has_chastity_vagina())
        return FALSE
    if(!can_reach_target_groin(user, target))
        return FALSE
    return TRUE

/datum/sex_action/chastityplay/cage_dildo_vagina/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(HAS_TRAIT(target, TRAIT_CHASTITY_SPIKED))
        user.visible_message(span_warning("[user] braces [target]'s spiked belt and starts to work the cruel inverted spikes inside [target.p_them()]..."))
        return
    user.visible_message(span_warning("[user] gets a grip on [target]'s chastity belt and starts working the built-in inverted dildo..."))

/datum/sex_action/chastityplay/cage_dildo_vagina/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(HAS_TRAIT(user, TRAIT_DEATHBYSNUSNU))
        user.sexcon.try_pelvis_crush(target)

    if(HAS_TRAIT(target, TRAIT_CHASTITY_SPIKED))
        user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rocks [target]'s spiked belt so the inverted spikes scour their insides..."))
        user.sexcon.outercourse_noise(target, TRUE)
        user.sexcon.perform_sex_action(target, 1.3, 4.8, TRUE)
        user.sexcon.try_do_pain_scream(target, 4.8)
        target.sexcon.handle_passive_ejaculation(user)
        return
    user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rocks [target]'s belt to work the inverted dildo inside [target.p_them()]..."))
    user.sexcon.outercourse_noise(target, TRUE)
    user.sexcon.perform_sex_action(target, 2.3, 1.5, TRUE)
    target.sexcon.handle_passive_ejaculation(user)

/datum/sex_action/chastityplay/cage_dildo_vagina/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
    user.visible_message(span_warning("[user] stops working [target]'s inverted belt dildo."))

/datum/sex_action/chastityplay/cage_dildo_vagina/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(target.sexcon.finished_check())
        return TRUE
    return FALSE
