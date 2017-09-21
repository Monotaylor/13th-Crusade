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
	var/spawnedore
obj/machinery/smithing/ore/Initialize()
	lastrecordedtime = world.time

obj/machinery/smithing/ore/proc/regenore()//regenerates the ore based on the time that's passed.
	diff = (world.time - lastrecordedtime)/60
	storedore = storedore + diff
	if (storedore > maxore)
		storedore = maxore

obj/machinery/smithing/ore/examine(mob/user)
	..()	//I have no clue what this does, yet am scared to remove it.
	regenore()
	switch(storedore) //this might be impractical based on how I do the smelting.
		if(1)
			usr << "the Rock looks baren, with few visible examples of ore"
		if(2)
			usr << "the Rock has a few examples of ore in it, though not much"
		if(3)
			usr << "the Rock appears to have a decent ammount of ore in it."
		if(4)
			usr << "The rock has a large ammount of ore in it."
		if(5)
			usr << "the rock is rich and full of ore. neat."

obj/machinery/smithing/ore/proc/mine()
	//decide on a random ore quality. 60% chance for low, 40% for medium, and 10% for GOOD SHIT
	//if (storedore != 5) in case I think adding a bonus for richer ore is a good idea.
	switch(rand(1,10))
		if (1 to 4)
			spawnedore = /obj/item/weapon/smithing/ore
		if (5 to 7)
			spawnedore = /obj/item/weapon/smithing/ore/medium
		else
			spawnedore = /obj/item/weapon/smithing/ore/high
			switch(rand(1,3))
				if (1)
					var/obj/item/weapon/smithing/coal/coal = new
					coal.quality = "low"
				if (2)
					var/obj/item/weapon/smithing/coal/coal = new
					coal.quality = "medium"
				if (3)
					var/obj/item/weapon/smithing/coal/coal = new
					coal.quality = "high"



	lastrecordedtime = world.time
	playsound(src, 'sound/machines/anvil3.ogg', 50, 1)//give this it's own thing?
	storedore = storedore - 1
	new spawnedore(get_turf(src))

obj/machinery/smithing/ore/attackby(var/obj/item/weapon/W as obj, var/mob/user as mob)
	if (!istype(W, /obj/item/weapon/pickaxe))//todo, make this weilded.
		return ..()
	regenore()
	mine()

obj/item/weapon/smithing/ore/examine(mob/user)
	..()
	if(quality)
		user << "It is a [quality] sample of ore."
	else
		return
	//ree
