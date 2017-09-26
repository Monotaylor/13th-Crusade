/*todo:
* consider lifeweb-like parry shit idk
* add different "hit speeds" use - user.setClickCooldown(something) for this. DEFAULT_ATTACK_COOLDOWN is 8ds. perhaps make it add on.
*



*/
/obj/item/weapon/crusade
	name = "Shortsword"
	desc = "A thick, sharp blade with a simple handle."
	icon = 'icons/obj/sword.dmi'
	icon_state = "canesword"
	item_state = "canesword"
	force = 20 //tweak this 
	throwforce = 5
	w_class = 4
	sharp = 1
	edge = 1
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	contained_sprite = 1

/obj/item/weapon/crusade/axe
	name = "Battle Axe"
	desc = "A small, Simple Axe - probably not the type used to chop wood."
	icon = 'icons/obj/sword.dmi'
	icon_state = "canesword"
	item_state = "canesword"
	force = 16 //tweak this 
	throwforce = 22
	w_class = 4
	sharp = 1
	edge = 1
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "chopped", "hacked")
	hitsound = 'sound/weapons/bladeslice.ogg'
	contained_sprite = 1

/obj/item/weapon/crusade/flail
	name = "Flail"
	desc = "A heavy iron ball on a stick."
	icon = 'icons/obj/sword.dmi'
	icon_state = "canesword"
	item_state = "canesword"
	force = 20 //tweak this 
	throwforce = 5
	w_class = 4
	sharp = 0
	edge = 0
	attack_verb = list("smashed", "crushed","Bashed",)
	hitsound = 'sound/weapons/bladeslice.ogg'
	contained_sprite = 1

/obj/item/weapon/crusade
	name = "Shortsword"
	desc = "A thick, sharp blade with a simple handle."
	icon = 'icons/obj/sword.dmi'
	icon_state = "canesword"
	item_state = "canesword"
	force = 20 //tweak this 
	throwforce = 5
	w_class = 4
	sharp = 1
	edge = 1
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	contained_sprite = 1