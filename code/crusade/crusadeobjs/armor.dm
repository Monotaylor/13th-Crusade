//Crusader Stuff goes here
/obj/item/clothing/suit/armor/crusader
	icon = 'icons/crusade/armour/crusader.dmi'
	contained_sprite = 1

/obj/item/clothing/suit/armor/crusader
	name = "Crusader Armour"
	desc = "A suit of armour that excels in Cleansing the infidels."
	icon_state = "knight_templar"
	item_state = "knight_templar"
	armor = list(melee = 60, bullet = 80, laser = 25, energy = 10, bomb = 0, bio = 0, rad = 0)
	pocket_slots = 4
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/suit/armor/crusader/heavycrusader
	name = "Heavy Crusader Armour"
	desc = "A suit of armor that excels in protecting the wearer from angry Infidels."
	icon_state = "knight_grey"
	item_state = "knight_grey"
	armor = list(melee = 80, bullet = 80, laser = 25, energy = 10, bomb = 0, bio = 0, rad = 0)
	pocket_slots = 2
	slowdown = 3
	w_class = 4//bulky item
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
//Helmet
/obj/item/clothing/head/helmet/crusader
	icon = 'icons/crusade/armour/crusader.dmi'
	name = "Crusader Helmet"
	desc = "Deus Vult."
	icon_state = "knight_templar_helm"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR
	body_parts_covered = HEAD|FACE
	siemens_coefficient = 1
