/proc/do_after_bow(mob/user, obj/target, delay)//untested and probably doesn't work.

    var/goaltime = world.time + delay

    var/starttime = world.time

    var/datum/progressbar/prog = new(user, delay, target)

    while (world.time < goaltime)

        if (!QDELETED(user) && !QDELETED(target) && !target.use_check(user, show_messages = FALSE))

            . = TRUE

            break

        prog.update(world.time - starttime)

        stoplag()

    qdel(prog)

    return !.