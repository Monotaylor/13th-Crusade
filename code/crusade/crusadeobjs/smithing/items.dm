//Item Defs Below
obj/item/weapon/smithing
	name = "hmmmm"
	desc = "It's broke"
	icon = 'icons/crusade/smithing.dmi'

obj/item/weapon/smithing/hammer
	name = "Hammer"
	desc = "Clang"
	icon_state = "hammer"
	item_state = "hammer"
	force = 10
	contained_sprite = 1
	
obj/item/weapon/smithing/ingot
	name = "iron billet"
	desc = "Not to be confused with an Ingot. they're completely different. Apperently."
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
