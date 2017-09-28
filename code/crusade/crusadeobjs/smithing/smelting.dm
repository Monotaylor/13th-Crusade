//smelting.
obj/machinery/smithing/smelter
	name = "Smeltery"
	desc = "A smeltery. often used for Smelting ore."
	icon = 'icons/crusade/smelting.dmi'
	icon_state = "smelter" //todo, incorperate iconstates properly
	anchored = 1
	use_power = 0
	density = 1
	var/onFire = FALSE
	var/CastLevelHigh
	var/CastLevelMedium
	var/CastLevelLow
	var/HighOreSolid
	var/MediumOreSolid
	var/LowOreSolid
	var/HighOreLiquid
	var/MediumOreLiquid
	var/LowOreLiquid
	var/Temp = 0
	var/Fuel
	var/MaxStorage = 1000 //This might need changing later.
	var/currentlypouring = FALSE

//Relavant Verbs.

/obj/machinery/smithing/smelter/verb/light()
	set name = "Light Fire"
	set category = "Smithing"
	set src in oview(1)
	light_smelter()

/obj/machinery/smithing/smelter/verb/snuff()
	set name = "Snuff Fire"
	set category = "Smithing"
	set src in oview(1)
	snuff_smelter()

/obj/machinery/smithing/smelter/verb/pourverb()
	set name = "Pour Metal"
	set category = "Smithing"
	set src in oview(1)
	pour()

// Big loop boiz

obj/machinery/smithing/smelter/machinery_process()
	updateFire()//also Updates the temp
	if (onFire == 0)
		while(!onFire)//Loop that cools down the smelter if there's no fire.
			sleep(1 SECOND)
			if (Temp > 5)
				Temp -= 5
			else
				Temp = 0
			if (Temp == 0)
				return
	if (Temp>0)
		meltOre()
	//idk what I'm actually doing here send help
obj/machinery/smithing/smelter/proc/updateicons()
	if(currentlypouring==FALSE && onFire==FALSE)
		icon_state = "smelter"
	if(currentlypouring==FALSE && onFire==TRUE)
		icon_state = "onfire"
	if(currentlypouring==TRUE && onFire==TRUE)
		icon_state = "onfirepour"
	if(currentlypouring == TRUE && onFire == FALSE)
		icon_state = "pour"
		queue_icon_update()

obj/machinery/smithing/smelter/proc/updateFire()//Also handles temp and fuel.
	updateicons()
	if(onFire)
		if (Temp >= 70 && Temp <= 100)
			Temp += 10
			if (Fuel < 8)
				if (Fuel < 0)
					return
				Fuel -= Fuel
			else
				Fuel -= 8
		if (Temp >= 40 && Temp <= 69)
			Temp += 8
			if (Fuel < 10)
				if (Fuel < 0)
					Fuel = 0
					onFire = FALSE
					return			
				Fuel -= Fuel
			else
				Fuel -= 10
		if (Temp >= 20 && Temp <= 39)
			Temp += 6
			if (Fuel<15)
				if (Fuel < 0)
					onFire = FALSE
					return			
				Fuel -= Fuel
			else
				Fuel -= 15
		if (Temp >= 1 && Temp <= 19)
			Temp += 4
			if (Fuel<20)
				if (Fuel < 0)
					Fuel = 0
					onFire = FALSE
					return
				Fuel -= Fuel
	updateicons()
obj/machinery/smithing/smelter/proc/meltOre()
//factor in the temp when melting.
	if(HighOreLiquid>=MaxStorage && MediumOreLiquid>=MaxStorage && LowOreLiquid>=MaxStorage) //if all the storages are full.
		HighOreLiquid = MaxStorage
		MediumOreLiquid = MaxStorage
		LowOreLiquid = MaxStorage
		onFire = FALSE
		//visible_message("The Fire on the Smelter goes out!")
			return
	else
		//gets the remaining storage for liquids.
		var/HQremainder = MaxStorage - HighOreLiquid
		if (HQremainder < 0)
			HQremainder = 0
			HighOreLiquid = MaxStorage

		var/MQremainder = MaxStorage - MediumOreLiquid
		if (MQremainder < 0)
			MQremainder = 0
			MediumOreLiquid = MaxStorage

		var/LQremainder = MaxStorage - LowOreLiquid
		if (LQremainder < 0)
			LQremainder = 0
			LowOreLiquid = MaxStorage

		//gets the Solid ore melt ammount? - this is really shit oh god
		var/MeltAmmount = round(Temp/10)
		var/HMeltAmmount = MeltAmmount
		var/MMeltAmmount = MeltAmmount
		var/LMeltAmmount = MeltAmmount

		if (HighOreSolid < MeltAmmount)
			HMeltAmmount = HighOreSolid

		if (MediumOreSolid < MeltAmmount)
			MMeltAmmount = MediumOreSolid

		if (LowOreSolid < MeltAmmount)
			LMeltAmmount = LowOreSolid

		//actually melts it the mad lad.

		if (LowOreLiquid + LMeltAmmount < MaxStorage)
			LowOreLiquid += round(LMeltAmmount/1.2)//change this later to be represented by heat probably idk I just want this to work
			LowOreSolid -= LMeltAmmount

		if (MediumOreLiquid + MMeltAmmount < MaxStorage)
			MediumOreLiquid += round(MMeltAmmount/1.2)
			MediumOreSolid -= MMeltAmmount

		if (HighOreLiquid + HMeltAmmount < MaxStorage)
			HighOreLiquid += round(HMeltAmmount/1.2)
			HighOreSolid -= HMeltAmmount


//Pouring
obj/machinery/smithing/smelter/proc/pour()


	//evenly distributes material into the cast, then "hardens" - doing dispenseingot()

	//this takes EVERYTHING avalible up to a max to put in an ingot, it does not need all of it.
	var/ingotmax = 100
	var/pourammount = 3

	currentlypouring = TRUE
	while (currentlypouring == TRUE)
		sleep(.1 SECOND)//this might be laggy idk.
		//Icon updates//
		if(onFire == TRUE)
			icon_state = "onfirepour"
			queue_icon_update()
		if (currentlypouring)
			icon_state = "pour"
			queue_icon_update()
		else
			icon_state = "smelter"
			queue_icon_update()

		if (CastLevelLow+CastLevelMedium+CastLevelHigh > ingotmax-pourammount) //if there's no more room in the ingot, return.
			currentlypouring = FALSE
			dispenseingot()
			return

		//drain either the pourammount if there's room, the remainder of the storage, or all needed to fill up the ingot. High.
		if (ingotmax-CastLevelLow+CastLevelMedium+CastLevelHigh >= pourammount)
			var/remainingspaceiningot = CastLevelLow+CastLevelMedium+CastLevelHigh
			if (remainingspaceiningot > pourammount)
				continue
			else
				pourammount = remainingspaceiningot

		if (pourammount > HighOreLiquid)
			pourammount = HighOreLiquid

		CastLevelHigh += pourammount		// actually does the pouring.
		HighOreLiquid -= pourammount

		//drain either the pourammount if there's room, the remainder of the storage, or all needed to fill up the ingot. Medium.
		if (ingotmax-CastLevelLow+CastLevelMedium+CastLevelHigh >= pourammount)
			var/remainingspaceiningot = CastLevelLow+CastLevelMedium+CastLevelHigh
			if (remainingspaceiningot > pourammount)
				continue
			else
				pourammount = remainingspaceiningot

		if (pourammount > MediumOreLiquid)
			pourammount = MediumOreLiquid

		CastLevelMedium += pourammount
		MediumOreLiquid -= pourammount

		//drain either the pourammount if there's room, the remainder of the storage, or all needed to fill up the ingot. Low.
		if (ingotmax-CastLevelLow+CastLevelMedium+CastLevelHigh >= pourammount)
			var/remainingspaceiningot = CastLevelLow+CastLevelMedium+CastLevelHigh
			if (remainingspaceiningot > pourammount)
				continue
			else
				pourammount = remainingspaceiningot

		if (pourammount > HighOreLiquid)
			pourammount = HighOreLiquid

		CastLevelLow += pourammount
		LowOreLiquid -= pourammount

		var/remainingspaceiningot = CastLevelLow+CastLevelMedium+CastLevelHigh
		//checks the space left in the ingot.
		if (remainingspaceiningot > pourammount*3)
			continue
		else
			return

obj/machinery/smithing/smelter/proc/dispenseingot() // the thing that actually spawns the ingot
	var/obj/item/weapon/smithing/ingot/ingot = new
	name = "Iron Ingot"
	ingot.High = CastLevelHigh
	ingot.Medium = CastLevelMedium
	ingot.Low = CastLevelLow

obj/machinery/smithing/smelter/proc/refuel(F)
	var/quality = F
	switch(quality)
		if ("high")
			Fuel += 50
		if ("medium")
			Fuel += 30
		else
			Fuel += 15

obj/machinery/smithing/smelter/proc/snuff_smelter()
	onFire = FALSE

obj/machinery/smithing/smelter/proc/light_smelter()
	onFire = TRUE

/obj/machinery/smithing/smelter/attackby(var/obj/item/O, x as mob)
	if(istype(O, /obj/item/weapon/smithing/coal))
		var/obj/item/weapon/smithing/coal/C = O
		var/q = C.quality
		visible_message("[x] refuels the smelter.")
		refuel(q)
		qdel(C)

	if(istype(O, /obj/item/weapon/smithing/ore))
		refill(3)
		qdel(O)
		visible_message("[x] tosses some fuel in the smelter.")

	if(istype(O, /obj/item/weapon/smithing/ore/medium))
		refill(2)
		qdel(O)
		visible_message("[x] plops some ore in the smelter.")

	if(istype(O, /obj/item/weapon/smithing/ore/high))
		refill(1)
		qdel(O)
		visible_message("[x] puts some ore in the smelter.")
	else //this should never happen. but probably will anyway.
		return


obj/machinery/smithing/smelter/proc/refill(X)
	if (X==1)
		HighOreSolid += 50 //When changing this, keep in mind the maxstorage value.
	if (X==2)
		MediumOreSolid += 50
	if (X==3)
		LowOreSolid += 50
	else //hopefully this would NEVER happen
		return

obj/machinery/smithing/smelter/examine(mob/user)//debug code.
	..()
	usr << "HighOreSolid = [HighOreSolid]"
	usr << "MediumOreSolid = [MediumOreSolid]"
	usr << "LowOreSolid = [LowOreSolid]"
	usr << "HighOreLiquid = [HighOreLiquid]"
	usr << "MediumOreLiquid = [MediumOreLiquid]"
	usr << "LowOreLiquid = [LowOreLiquid]"
	usr << "Temp = [Temp]"
	usr << "OnFire = [onFire]"
	usr << "CastLevelHigh = [CastLevelHigh]"
	usr << "CastLevelMedium = [CastLevelMedium]"
	usr << "CastLevelLow = [CastLevelLow]"
