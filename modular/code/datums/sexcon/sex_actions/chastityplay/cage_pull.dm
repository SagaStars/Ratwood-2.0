/datum/sex_action/chastityplay/cage_pull
    name = "Tug on their cage"
    category = SEX_CATEGORY_HANDS
    target_sex_part = SEX_PART_COCK

/datum/sex_action/chastityplay/cage_pull/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(!requires_other_target(user, target))
        return FALSE
    if(!target_has_cage(target))
        return FALSE
    return TRUE

/datum/sex_action/chastityplay/cage_pull/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(!requires_other_target(user, target))
        return FALSE
    if(!target_has_cage(target))
        return FALSE
    if(!can_reach_target_groin(user, target))
        return FALSE
    return TRUE

/datum/sex_action/chastityplay/cage_pull/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(HAS_TRAIT(target, TRAIT_CHASTITY_SPIKED))
        user.visible_message(span_warning("[user] hooks [user.p_their()] fingers around [target]'s spiked [get_chastity_device_name(target)] and gives it a deliberate testing pull..."))
        return
    user.visible_message(span_warning("[user] hooks [user.p_their()] fingers on [target]'s [get_chastity_device_name(target)] and gives it a testing tug..."))

/datum/sex_action/chastityplay/cage_pull/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(HAS_TRAIT(user, TRAIT_DEATHBYSNUSNU))
        user.sexcon.try_pelvis_crush(target)

    if(HAS_TRAIT(target, TRAIT_CHASTITY_SPIKED))
        play_chastity_impact_sound(target, 'sound/combat/hits/bladed/genstab (1).ogg', 45, 45)
        user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] yanks [target]'s spiked [get_chastity_device_name(target)], dragging the inward spikes painfully across [target.p_their()] flesh..."))
        user.sexcon.perform_sex_action(target, 0.25, 6.6, TRUE)
        user.sexcon.try_do_pain_scream(target, 6.6)
        target.sexcon.handle_passive_ejaculation(user)
        return
    play_chastity_impact_sound(target, list('sound/combat/hits/onmetal/grille (1).ogg', 'sound/combat/hits/onmetal/grille (2).ogg'), 40, 40)
    user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] yanks on [target]'s [get_chastity_device_name(target)]..."))
    user.sexcon.perform_sex_action(target, 0.6, 4, TRUE)
    target.sexcon.handle_passive_ejaculation(user)

/datum/sex_action/chastityplay/cage_pull/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
    user.visible_message(span_warning("[user] releases [target]'s [get_chastity_device_name(target)]."))

/datum/sex_action/chastityplay/cage_pull/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(target.sexcon.finished_check())
        return TRUE
    return FALSE
