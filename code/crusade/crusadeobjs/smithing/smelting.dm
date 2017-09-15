//smelting.
obj/machinery/smithing/smelter
	name = "Ore Rock thing"
	desc = "A smeltery. often used for smelting ore and other stuff."
	icon_state = "anvil" //todo, incorperate iconstates properly
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
//factor in the temp when melting.
	if(HighOreLiquid>=MaxStorage && MediumOreLiquid>=MaxStorage && LowOreLiquid>=MaxStorage) //if all the storages are full.
		HighOreLiquid = MaxStorage
		MediumOreLiquid = MaxStorage
		LowOreLiquid = MaxStorage
		onFire = FALSE
		visible_message("The Fire on the Smelter goes out!")
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