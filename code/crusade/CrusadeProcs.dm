/*
"showstatus" is a proc designed to handle temporary overlays on a target. 
ideally you'd use these to represent status effects, EG: spell shit. but 
it should be fine to use for whatever.
*/
mob/living/var/oldverlay
/mob/living/proc/showstatus(time,state)
    if(oldverlay)
        cut_overlay(oldverlay)
    var/image/I = new('icons/effects/status.dmi', state)
    add_overlay(I, TRUE)
    oldverlay = I
    CUT_OVERLAY_IN_PRIORITY(I, time)