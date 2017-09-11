/*/////////////////////////
Unlike Normal Mining in SS13, this is more as a chore the blacksmith has to do every now and again to get materials.
materials by design are rare- to promote the use of lower tier weapons/items. it gets less interesting if everyone's in the top tier stuff.
*/////////////////////////
obj/machinery/smithing/ore
	name = "Ore Rock thing"
	desc = "Looks like a vein of ore, neat."
	icon_state = "anvil"
	anchored = 1
	use_power = 0
	density = 1
	var/storedore
	var/cooldown
	var/regentime
	var/lastrecordedtime
	var/diff
	var/maxore = 5 //This should really be adjusted later depending on how I do the smelting.

obj/machinery/smithing/ore/Initialize()
	lastrecordedtime = world.time

obj/machinery/smiting/ore/proc/regenore()//regenerates the ore based on the time that's passed.
	diff = (world.time - lastrecordedtime)/60
	storedore = storedore + diff
	if storedore > maxore
		storedore = maxore

obj/machinery/smithing/ore/examine(mob/user)
	..()	//I have no clue what this does, yet am scared to remove it.
	regenore()
	//usr << "it has [storedore] units of ore remaining"
	switch(storedore) //this might be impractical based on how I do the smelting. 
		if(1)
			usr << "blah1"
		if(2)
			usr << "bla2h"
		if(3)
			usr << "blah3"
		if(4)
			usr << "blah4"
		if(5)
			usr << "blah5"

obj/machinery/smithing/ore/proc/mine()
	lastrecordedtime = world.time
	playsound(src, 'sound/machines/anvil3.ogg', 50, 1)//give this it's own thing?
	storedore = storedore - 1
	new obj/item/weapon/smithing/ore (get_turf(src))

obj/machinery/smithing/ore/attackby(var/obj/item/weapon/W as obj, var/mob/user as mob)
	if (!istype(W, /obj/item/weapon/wrench))//todo, replace with a weilded pick fuck my life, also reduce the damage on weilded picks lmao they're still probably OP as fuck here.
		return ..()
	regenore()
	mine()

obj/item/weapon/smithing/ore
	name = "Ore"
	desc = "A chunk of ore - With enough processing, this could one day be used for something useful."
	icon_state = "ore"



	