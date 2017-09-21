//Item Defs Below
obj/item/weapon/smithing
	name = "hmmmm"
	desc = "It's broke"
	icon = 'icons/crusade/smithing.dmi'

obj/item/weapon/smithing/hammer
	name = "hammer"
	desc = "Clang"
	icon_state = "hammer"
	force = 10

obj/item/weapon/smithing/ingot
	name = "iron ingot"
	desc = "Bluh"
	icon_state = "ingot"
	var/High
	var/Medium //this is for quality boyz
	var/Low

//ores below//

obj/item/weapon/smithing/ore
	name = "Ore"
	desc = "A chunk of ore - With enough processing, this could one day be used for something useful."
	icon_state = "ore"
	var/quality = "low"

obj/item/weapon/smithing/ore/medium
	quality = "medium"

obj/item/weapon/smithing/ore/high
	quality = "high"

obj/item/weapon/smithing/coal/
	name = "Coal"
	desc = "A rock, that burns!"
	icon_state = "coal"
	var/quality
