
GLOBAL_LIST_INIT(body_accessory_by_name, list("None" = null))
GLOBAL_LIST_INIT(body_accessory_by_species, list("None" = null))

/proc/initialize_body_accessory_by_species()
	for(var/B in GLOB.body_accessory_by_name)
		var/datum/body_accessory/accessory = GLOB.body_accessory_by_name[B]
		if(!istype(accessory))	continue

		for(var/species in accessory.allowed_species)
			if(!GLOB.body_accessory_by_species["[species]"])
				GLOB.body_accessory_by_species["[species]"] = list()
			GLOB.body_accessory_by_species["[species]"] += accessory

	if(GLOB.body_accessory_by_species.len)
		return TRUE
	return FALSE

/proc/__init_body_accessory(ba_path)
	if(ispath(ba_path))
		var/_added_counter = 0

		for(var/A in subtypesof(ba_path))
			var/datum/body_accessory/B = new A
			if(istype(B))
				GLOB.body_accessory_by_name[B.name] += B
				++_added_counter

		if(_added_counter)
			return TRUE
	return FALSE

/datum/body_accessory
	var/name = "default"
	var/icon = null
	var/icon_state = ""
	var/animated_icon = null
	var/animated_icon_state = ""
	var/blend_mode = null
	var/pixel_x_offset = 0
	var/pixel_y_offset = 0
	var/list/allowed_species = list()

/datum/body_accessory/proc/try_restrictions(mob/living/carbon/human/H)
	return TRUE

/datum/body_accessory/proc/get_animated_icon() //return animated if it has it, return static if it does not.
	if(animated_icon)
		return animated_icon

	else	return icon

/datum/body_accessory/proc/get_animated_icon_state()
	if(animated_icon_state)
		return animated_icon_state

	else	return icon_state


//Bodies
/datum/body_accessory/body
	blend_mode = ICON_MULTIPLY

/datum/body_accessory/body/snake
	name = "Snake"

	icon = 'icons/mob/body_accessory_64.dmi'
	icon_state = "snake"

	pixel_x_offset = -16


//Tails
/datum/body_accessory/tail
	icon = 'icons/mob/body_accessory.dmi'
	animated_icon = 'icons/mob/body_accessory.dmi'
	blend_mode = ICON_ADD
	icon_state = "null"
	animated_icon_state = "null"

/datum/body_accessory/tail/try_restrictions(mob/living/carbon/human/H)
	if(!H.wear_suit || !(H.wear_suit.flags_inv & HIDEBACK))
		return TRUE
	return FALSE

//Tajaran
/datum/body_accessory/tail/wingler_tail // Jay wingler fluff tail
	name = "Striped Tail"
	icon_state = "winglertail"
	animated_icon_state = "winglertail_a"
	allowed_species = list("Tajaran")

/datum/body_accessory/tail/tiny //Pretty ambiguous as to what species it belongs to, tail could've been injured or docked.
	name = "Tiny Tail"
	icon_state = "tiny"
	animated_icon_state = "tiny_a"
	allowed_species = list("Vulpkanin", "Tajaran")

/datum/body_accessory/tail/short //Same as above.
	name = "Short Tail"
	icon_state = "short"
	animated_icon_state = "short_a"
	allowed_species = list("Vulpkanin", "Tajaran")

//Vulpkanin
/datum/body_accessory/tail/bushy
	name = "Bushy Tail"
	icon_state = "bushy"
	animated_icon_state = "bushy_a"
	allowed_species = list("Vulpkanin")

/datum/body_accessory/tail/straight
	name = "Straight Tail"
	icon_state = "straight"
	animated_icon_state = "straight_a"
	allowed_species = list("Vulpkanin")

/datum/body_accessory/tail/straight_bushy
	name = "Straight Bushy Tail"
	icon_state = "straightbushy"
	animated_icon_state = "straightbushy_a"
	allowed_species = list("Vulpkanin")

//Wryn
/datum/body_accessory/tail/wryn
	name = "Bee Tail"
	icon_state = "wryntail"
	allowed_species = list("Wryn")

//Wings
datum/body_accessory/wings/try_restrictions(mob/living/carbon/human/H)
	if(!H.wear_suit || !(H.wear_suit.flags_inv & HIDEBACK))
		return TRUE
	return FALSE

//Sprites Ported from /tg/'s Moths
/datum/body_accessory/wings
	icon = 'icons/mob/sprite_accessories/wryn/wryn_body_accessories.dmi'
	animated_icon = "null"
	blend_mode = ICON_ADD
	icon_state = "null"
	animated_icon_state = "null"
	allowed_species = list("Wryn")

/datum/body_accessory/wings/monarch
	name = "Monarch Wings"
	icon_state = "wings_monarch"

/datum/body_accessory/wings/luna
	name = "Luna Wings"
	icon_state = "wings_luna"

/datum/body_accessory/wings/altas
	name = "Altas Wings"
	icon_state = "wings_altas"

/datum/sprite_accessory/wings/plain
	name = "Plain Wings"
	icon_state = "wings_plain"

/datum/body_accessory/wings/reddish
	name = "Reddish Wings"
	icon_state = "wings_reddish"

/datum/body_accessory/wings/royal
	name = "Royal Wings"
	icon_state = "wings_royal"

/datum/body_accessory/wings/gothic
	name = "Gothic Wings"
	icon_state = "wings_gothic"

/datum/body_accessory/wings/lovers
	name = "Lovers Wings"
	icon_state = "wings_lovers"

/datum/body_accessory/wings/whitefly
	name = "Whitefly Wings"
	icon_state = "wings_whitefly"

/datum/body_accessory/wings/burnt
	name = "Burnt Off Wings"
	icon_state = "wings_burnt_off"

/datum/body_accessory/wings/firewatch
	name = "Firewatch Wings"
	icon_state = "wings_firewatch"

/datum/body_accessory/wings/deathhead
	name = "Deathhead Wings"
	icon_state = "wings_deathhead"

/datum/body_accessory/wings/poisonous
	name = "Poisonous Wings"
	icon_state = "wings_poison"

/datum/body_accessory/wings/ragged
	name = "Ragged Wings"
	icon_state = "wings_ragged"

/datum/body_accessory/wings/moonglow
	name = "Moonglow Wings"
	icon_state = "wings_moonglow"

/datum/body_accessory/wings/snow
	name = "Snow Wings"
	icon_state = "wings_snow"

/datum/body_accessory/wings/oakworm
	name = "Oakworm Wings"
	icon_state = "wings_oakworm"

/datum/body_accessory/wings/witchwing
	name = "Witchwing Wings"
	icon_state = "wings_witchwing"

/datum/body_accessory/wings/jungle
	name = "Jungle Wings"
	icon_state = "wings_jungle"
