/* A never ending hoarde of shit code from yours truly
-Pacmandevil
*/
obj/machinery/smithing/
	name = "hmmmm"
	desc = "It's broke"
	icon = 'icons/obj/crusade/smithing.dmi'

obj/machinery/smithing/anvil //I have no idea what I am doing.
	var/storedmetal = 0 //current metal reserve
	var/currentobj
	var/hits = 0
	var/maxmetal = 100	//maximum metal stored
	var/minmetal = 0	//duh
	var/cooldown		//current time remaining in the cooldown
	var/limiter = TRUE //if there's a cooldown
	var/spawneditem		//currently spawned item
	var/hitcost			//metal removed from reserve on hit.
	name = "Anvil"
	desc = "Clang"
	icon_state = "anvil"
	anchored = 1
	use_power = 0
	density = 1

obj/machinery/smithing/anvil/examine(mob/user)
	..()	//I have no clue what this does, yet am scared to remove it.
	if(storedmetal > 0)
		user << "It has [storedmetal] units of metal left in it's storage. "
	else
		user << "It looks like it has no metal left."

/obj/machinery/smithing/anvil/verb/changetargetitem()
	set name = "Select item"
	set category = "Object"
	set src in oview(1)
	change_item()

/obj/machinery/smithing/anvil/proc/change_item()
	var/mob/M = usr
	if(M.stat || M.paralysis || M.stunned || M.weakened || M.restrained())
		usr << "you cannot decide on what to make at an Anvil when you're not in a state where you can concentrate, dingus."
		return

	var/list/possibleitems = list("Longsword","Shortsword","Battle Axe",
	"Battle Hammer","Sabre","Dao","Claymore",
	"Great Helm","Basic Armor","Heavy Armor","Buckler","Large Shield","Kite Sheild")
//I wonder if I can do this.

	if(get_dist(usr, src) > 1)
		usr << "You have moved too far away."
		return
	if (hits > 0)
		usr << "You've already started work! Finish what you've started, asshole!"
		return
	var/currentobj = input("Anvil Selection", "what would you like to make?") as null|anything in possibleitems
	usr << "you've decided to make a [currentobj]."
	switch (currentobj) //todo: make this datumised baybee - update the item paths so they work.
		if ("Longsword")
			hits = 10
			spawneditem = /obj/item/weapon/material/sword/longsword
			hitcost = 5
		if ("Shortsword")
			hits = 2
			spawneditem = /obj/item/weapon/material/sword/gladius
			hitcost = 10
		if ("Battle Axe")
			hits = 3
			spawneditem = /obj/item/weapon/material/sword/axe
			hitcost = 0
		if ("Battle Hammer")
			hits = 4
			spawneditem = /mob/living/simple_animal/corgi/Ian //todo, add the battle hammer, 2 handed. skyrim style.
			hitcost = 0
		if ("Sabre")
			hits = 5
			spawneditem = /mob/living/simple_animal/corgi/Ian
			hitcost = 0
		if ("Dao")
			hits = 6
			spawneditem = /mob/living/simple_animal/corgi/Ian
			hitcost = 0
		if ("Claymore")
			hits = 7
			spawneditem = /mob/living/simple_animal/corgi/Ian
			hitcost = 0
		if ("Great Helm")
			hits = 8
			spawneditem = /obj/item/clothing/head/helmet/crusader
			hitcost = 0
		if ("Basic Armor")
			hits = 9
			spawneditem = /obj/item/clothing/suit/armor/crusader
			hitcost = 0
		if ("Heavy Armor")
			hits = 10
			spawneditem = /obj/item/clothing/suit/armor/heavycrusader
			hitcost = 0
		if ("Test11")
			hits = 11
			spawneditem = /mob/living/simple_animal/corgi/Ian
			hitcost = 0
		if ("Test12")
			hits = 12
			spawneditem = /mob/living/simple_animal/corgi/Ian
		if ("Test13")
			hits = 13
			spawneditem = /mob/living/simple_animal/corgi/Ian
			hitcost = 0
		if ("Test14")
			hits = 14
			spawneditem = /mob/living/simple_animal/corgi/Ian
			hitcost = 0
			
/obj/machinery/smithing/anvil/proc/clang()//CLANG CLANG CLANG CLANG CLANG CLANG CLANG CLANG CLANG CLANG CLANG CLANG CLANG CLANG CLANG CLANG
	//This is the on hit shit for an anvil.
	if (cooldown > world.time)
		if (limiter == TRUE) //should act as a cooldown, untill the limiter is removed.
			return
	if (storedmetal <= minmetal || storedmetal < hitcost)
		visible_message("The anvil makes a dull sounding tinking noise. looks like there's not enough metal on it to keep working.")
		playsound(src, 'sound/machines/anvil4.ogg', 50, 1)
		cooldown = world.time + 1 SECONDS
		return
	if (currentobj == null)
		visible_message("The anvil makes a empty sounding tinking noise. looks like there's no point to hitting an anvil if you aren't working on something on it.")
		playsound(src, 'sound/machines/anvil3.ogg', 50, 1)
		cooldown = world.time + 1 SECONDS
		return

	if (hits == 0)
		playsound(src, 'sound/machines/anvil3.ogg', 50, 1)
		cooldown = world.time + 1 SECONDS
		spawnitem()
		hits = 0
	else
		cooldown = world.time + 1 SECONDS
		hits-- //subtracts one hit somehow?
		storedmetal -= hitcost
		playsound(src, 'sound/machines/anvil3.ogg', 50, 1)

/obj/machinery/smithing/anvil/proc/refill()
	if(storedmetal + 20 > maxmetal)
		return
	else
		storedmetal = storedmetal + 20

/obj/machinery/smithing/anvil/proc/spawnitem()
	if (!spawneditem) return
	//spawns the currently selected item, and changes the currentobj var to null.
	new spawneditem(get_turf(src))
	visible_message("<FONT size = 3>The anvil is supposed to make something here.</FONT>")
	currentobj = null
	spawneditem = null
	playsound(src, 'sound/machines/anvil1.ogg', 50, 1)//todo, replace this with a good finishing sound.

/obj/machinery/smithing/anvil/attackby(var/obj/item/O)
	if(istype(O, /obj/item/weapon/smithing/hammer))
		clang()
	if(istype(O, /obj/item/weapon/smithing/ingot))
		if (storedmetal > 80)
			return
		else
			refill()
			qdel(O)
//this needs work ^


//////////////////////////////
///    HAMMER TIME BOYS    ///
//////////////////////////////
obj/item/weapon/smithing
	name = "hmmmm"
	desc = "It's broke"
	icon = 'icons/obj/crusade/smithing.dmi'

obj/item/weapon/smithing/hammer
	name = "hammer"
	desc = "Clang"
	icon_state = "hammer"
	force = 10

obj/item/weapon/smithing/ingot
	name = "iron ingot"
	desc = "A low quality iron Ingot - This should be enough to add to your anvil"
	icon_state = "ingot"

	/* Todo
	* Make it remove metal on hit using the usedmetal var
	* Make the desc reflect the current metal value
	* make this sane please
	*/