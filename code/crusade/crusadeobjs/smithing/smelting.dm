//smelting.
obj/machinery/smithing/smelter
	name = "Ore Rock thing"
	desc = "A smeltery. often used for smelting ore and other stuff."
	icon_state = "anvil"
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
	var/Temp
	var/Fuel
	var/MaxStorage = 1000 //This might need changing later.
	var/CastTemp
	var/MeltAmmount

obj/machinery/smithing/smelter/proc/loopcheck //the main loop. this is probably a reaLly bad way of doing it. have an "igite" verb to start it.
	while (onFire)
	sleep(1 SECOND)
	updateFire()//also Updates the temp
		if onFire = 0
			while(!onFire)//Loop that cools down the smelter if there's no fire.
				sleep(1 SECOND)
				if (Temp > 5)
					Temp -= 5
				else
					Temp = 0
				if (Temp = 0)
					return

			//return

	meltOre()
		updateCast()
	updateCastTemp()
	//idk what I'm actually doing here send help

obj/machinery/smithing/smelter/proc/updateFire()
	if (Fuel = 0)
		onFire = 0
		//return
	else
		switch (Temp)
			if (Temp>80)
				Fuel -= 40
			if (Temp<40)
				Fuel -= 60
			else
				Fuel -= 50 //might not work, idk. if it doesn't subtract 50 from fuel, just do it the shit way
	//temp Update
	switch(Fuel)
		if(Fuel>(MaxStorage/2))
			if (Temp > 95)
				Temp = 100
			else
				Temp += 5
		else
			if (Temp > 97)
				Temp = 100
			else
				Temp += 3


obj/machinery/smithing/smelter/proc/meltOre

//todo aaaa.
//factor in the temp when melting.
	MeltAmmount = Temp/10 //round this?
	if (MeltAmmount < 1)
		MeltAmmount = 1
	if (HighOreLiquid >= MaxStorage)
		HighOreLiquid = MaxStorage
		continue
	else
		if (HighOreLiquid + MeltAmmount/2)
			//do the math to do this right alright

