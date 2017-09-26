  /* A never ending hoarde of shit code from yours truly
-Pacmandevil
*/
var/global/list/anvil_sheilds = list()
var/global/list/anvil_weapons = list()
var/global/list/anvil_armour = list()
var/global/list/anvil_tools = list()



obj/machinery/smithing/
	name = "hmmmm"
	desc = "It's broke"
	icon = 'icons/crusade/smithing.dmi'

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
	var/current_category

obj/machinery/smithing/anvil/examine(mob/user)
	..()	//I have no clue what this does, yet am scared to remove it.
	if(storedmetal > 0)
		user << "It has [storedmetal] units of metal left in it's storage. "
	else
		user << "It looks like it has no metal left."

	user << "It looks like [currentobj] is being made here."

/obj/machinery/smithing/anvil/proc/generatelists()
	for (var/type in subtypesof(/datum/anvil_products/weapon))
		var/datum/anvil_products/P = new type
		anvil_weapons[P.name] = P

	for (var/type in subtypesof(/datum/anvil_products/armour))
		var/datum/anvil_products/P = new type
		anvil_armour[P.name] = P

	for (var/type in subtypesof(/datum/anvil_products/tool))
		var/datum/anvil_products/P = new type
		anvil_tools[P.name] = P

	for (var/type in subtypesof(/datum/anvil_products/shield))
		var/datum/anvil_products/P = new type
		anvil_sheilds[P.name] = P

/obj/machinery/smithing/anvil/verb/changetargetitem()
	set name = "Select item"
	set category = "Smithing"
	set src in oview(1)
	change_item()

/obj/machinery/smithing/anvil/Initialize()
	.=..()
	generatelists()//this is probably cancer tier performance wise. the lists don't change. move this to Initialise.


/obj/machinery/smithing/anvil/proc/change_item()
	var/mob/M = usr
	if(M.stat || M.paralysis || M.stunned || M.weakened || M.restrained())
		usr << "you cannot decide on what to make at an Anvil when you're not in a state where you can concentrate, dingus."
		return

	if(get_dist(usr, src) > 1)
		usr << "You have moved too far away."
		return
	if (hits > 0)
		usr << "You've already started work! Finish what you've started, asshole!"
		return
	
	switch(alert("What would you like to make?",,"Armour","Weapons","Tools","Shields"))
		if("Armour")
			current_category = anvil_armour
		if("Weapons")
			current_category = anvil_weapons
		if("Tools")
			current_category = anvil_tools
		if("Shields")
			current_category = anvil_sheilds
		else
			return 1

	var/datum/anvil_products/current_product = input("Select a product.", "Anvil") as null|anything in current_category

	hits = current_product.hits
	currentobj = current_product.currentobj
	hitcost = current_product.hitcost
	spawneditem = current_product.spawneditem


////

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

//todo: DATUMISE ME BAYBEE
/datum/anvil_products
	var/name
	var/hits
	var/hitcost
	var/spawneditem
	var/currentobj = "whew"

//sheilds below.
/datum/anvil_products/shield
	name = "Shield"
	hits = 0
	hitcost = 0
	spawneditem = null
	currentobj = "shield"

//weapons below
/datum/anvil_products/weapon
	name = "Sword"
	hits = 0
	hitcost = 0
	spawneditem = null

//Armour below
/datum/anvil_products/armour
	name = "Sword"
	hits = 0
	hitcost = 0
	spawneditem = null
	currentobj = "Some Armour"

/datum/anvil_products/armour/templar
	name = "Chainmail Armour"//probably isnt actually chainmail.
	hits = 0
	hitcost = 0
	spawneditem = /obj/item/clothing/suit/armor/crusader
	currentobj = "some chainmail"

/datum/anvil_products/armour/templar_heavy
	name = "Plate Armour"
	hits = 0
	hitcost = 0
	spawneditem = /obj/item/clothing/suit/armor/crusader/heavycrusader
	currentobj = "some plate armour"

/datum/anvil_products/armour/greathelm
	name = "Great Helm"
	hits = 0
	hitcost = 0
	spawneditem = /obj/item/clothing/head/helmet/crusader

//tools below
/datum/anvil_products/tool
	name = "tool"
	hits = 0
	hitcost = 0
	spawneditem = null