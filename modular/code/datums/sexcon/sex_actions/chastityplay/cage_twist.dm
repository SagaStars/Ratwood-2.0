/datum/sex_action/chastityplay/cage_twist
    name = "Twist their cage"
    category = SEX_CATEGORY_HANDS
    target_sex_part = SEX_PART_COCK

/datum/sex_action/chastityplay/cage_twist/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(!requires_other_target(user, target))
        return FALSE
    if(!target_has_cage(target))
        return FALSE
    return TRUE

/datum/sex_action/chastityplay/cage_twist/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(!requires_other_target(user, target))
        return FALSE
    if(!target_has_cage(target))
        return FALSE
    if(!can_reach_target_groin(user, target))
        return FALSE
    return TRUE

/datum/sex_action/chastityplay/cage_twist/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(HAS_TRAIT(target, TRAIT_CHASTITY_SPIKED))
        user.visible_message(span_warning("[user] grips [target]'s spiked [get_chastity_device_name(target)] and begins a slow, cruel twist..."))
        return
    user.visible_message(span_warning("[user] grips [target]'s [get_chastity_device_name(target)] and starts to slowly twist it..."))

/datum/sex_action/chastityplay/cage_twist/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(HAS_TRAIT(user, TRAIT_DEATHBYSNUSNU))
        user.sexcon.try_pelvis_crush(target)

    if(HAS_TRAIT(target, TRAIT_CHASTITY_SPIKED))
        play_chastity_impact_sound(target, 'sound/combat/fracture/fracturedry (1).ogg', 50)
        user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] twists [target]'s spiked [get_chastity_device_name(target)], making the spikes corkscrew into tender flesh..."))
        user.sexcon.perform_sex_action(target, 0.2, 8.8, TRUE)
        user.sexcon.try_do_pain_scream(target, 8.8)
        target.sexcon.handle_passive_ejaculation(user)
        return
    play_chastity_impact_sound(target, list('sound/combat/hits/onmetal/grille (2).ogg', 'sound/combat/hits/onmetal/grille (3).ogg'), 42, 50)
    user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] twists [target]'s [get_chastity_device_name(target)] to make [target.p_them()] squirm..."))
    user.sexcon.perform_sex_action(target, 0.4, 6, TRUE)
    target.sexcon.handle_passive_ejaculation(user)

/datum/sex_action/chastityplay/cage_twist/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
    user.visible_message(span_warning("[user] lets [target]'s [get_chastity_device_name(target)] settle back into place."))

/datum/sex_action/chastityplay/cage_twist/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
    if(target.sexcon.finished_check())
        return TRUE
    return FALSE
