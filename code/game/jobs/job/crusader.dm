//Crusader roles

/datum/job/crusader
	title = "Crusader"
	flag = CRUSADER
	department = "Team 1"
	department_flag = TEAM1
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "Fill This out you fucking normie"
	selection_color = "#dddddd"
	idtype = /obj/item/weapon/card/id //change this to a key whenever that's added. Port the locking code from No man's land, perhaps.

/datum/job/crusader/equip(var/mob/living/carbon/human/H)
	if(!H)
		return FALSE
	var/obj/item/clothing/under/color/grey/G = new /obj/item/clothing/under/color/grey(H)
	if(H.equip_to_slot_or_del(G, slot_w_uniform))
		G.autodrobe_no_remove = TRUE
	var/obj/item/clothing/shoes/black/B = new /obj/item/clothing/shoes/black(H)
	if(H.equip_to_slot_or_del(B, slot_shoes))
		B.autodrobe_no_remove = TRUE
	return TRUE

/datum/job/Blacksmith
	title = "Blacksmith"
	flag = BLACKSMITH
	department = "Team 1"
	department_flag = TEAM1
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Fill This out you fucking normie"
	selection_color = "#dddddd"
	idtype = /obj/item/weapon/card/id //change this to a key whenever that's added. Port the locking code from No man's land, perhaps.
	

/datum/job/Blacksmith/equip(var/mob/living/carbon/human/H)
	if(!H)
		return FALSE
	var/obj/item/clothing/under/color/grey/G = new /obj/item/clothing/under/color/grey(H)
	if(H.equip_to_slot_or_del(G, slot_w_uniform))
		G.autodrobe_no_remove = TRUE
	var/obj/item/clothing/shoes/black/B = new /obj/item/clothing/shoes/black(H)
	if(H.equip_to_slot_or_del(B, slot_shoes))
		B.autodrobe_no_remove = TRUE
	return TRUE

/datum/job/farmer
	title = "Farmer"
	flag = FARMER
	department = "Team 1"
	department_flag = TEAM1
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Fill This out you fucking normie"
	selection_color = "#dddddd"
	idtype = /obj/item/weapon/card/id //change this to a key whenever that's added. Port the locking code from No man's land, perhaps.

/datum/job/farmer/equip(var/mob/living/carbon/human/H)
	if(!H)
		return FALSE
	var/obj/item/clothing/under/color/grey/G = new /obj/item/clothing/under/color/grey(H)
	if(H.equip_to_slot_or_del(G, slot_w_uniform))
		G.autodrobe_no_remove = TRUE
	var/obj/item/clothing/shoes/black/B = new /obj/item/clothing/shoes/black(H)
	if(H.equip_to_slot_or_del(B, slot_shoes))
		B.autodrobe_no_remove = TRUE
	return TRUE

/datum/job/bard
	title = "Bard"
	flag = BARD
	department = "Team 1"
	department_flag = TEAM1
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Fill This out you fucking normie"
	selection_color = "#dddddd"
	idtype = /obj/item/weapon/card/id //change this to a key whenever that's added. Port the locking code from No man's land, perhaps.

/datum/job/bard/equip(var/mob/living/carbon/human/H)
	if(!H)
		return FALSE
	var/obj/item/clothing/under/color/grey/G = new /obj/item/clothing/under/color/grey(H)
	if(H.equip_to_slot_or_del(G, slot_w_uniform))
		G.autodrobe_no_remove = TRUE
	var/obj/item/clothing/shoes/black/B = new /obj/item/clothing/shoes/black(H)
	if(H.equip_to_slot_or_del(B, slot_shoes))
		B.autodrobe_no_remove = TRUE
	return TRUE

/datum/job/priest
	title = "Bard"
	flag = PRIEST
	department = "Team 1"
	department_flag = TEAM1
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Fill This out you fucking normie"
	selection_color = "#dddddd"
	idtype = /obj/item/weapon/card/id //change this to a key whenever that's added. Port the locking code from No man's land, perhaps.

/datum/job/priest/equip(var/mob/living/carbon/human/H)
	if(!H)
		return FALSE
	var/obj/item/clothing/under/color/grey/G = new /obj/item/clothing/under/color/grey(H)
	if(H.equip_to_slot_or_del(G, slot_w_uniform))
		G.autodrobe_no_remove = TRUE
	var/obj/item/clothing/shoes/black/B = new /obj/item/clothing/shoes/black(H)
	if(H.equip_to_slot_or_del(B, slot_shoes))
		B.autodrobe_no_remove = TRUE
	return TRUE