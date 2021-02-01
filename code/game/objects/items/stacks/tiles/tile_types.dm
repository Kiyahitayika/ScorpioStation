/obj/item/stack/tile
	name = "broken tile"
	singular_name = "broken tile"
	desc = "A broken tile. This should not exist."
	icon = 'icons/obj/tiles.dmi'
	icon_state = "tile"
	item_state = "tile"
	w_class = WEIGHT_CLASS_NORMAL
	force = 1
	throwforce = 1
	throw_speed = 5
	throw_range = 20
	max_amount = 60
	flags = CONDUCT
	origin_tech = "materials=1"
	var/turf_type = null
	var/mineralType = null

/obj/item/stack/tile/New(loc, amount)
	..()
	pixel_x = rand(-3, 3)
	pixel_y = rand(-3, 3) //randomize a little

/obj/item/stack/tile/welder_act(mob/user, obj/item/I)
	if(get_amount() < 4)
		to_chat(user, "<span class='warning'>You need at least four tiles to do this!</span>")
		return
	. = TRUE
	if(!I.use_tool(src, user, volume = I.tool_volume))
		to_chat(user, "<span class='warning'>You can not reform this!</span>")
		return
	if (mineralType == "metal")
		var/obj/item/stack/sheet/metal/new_item = new(user.loc)
		user.visible_message("[user.name] shaped [src] into metal with the welding tool.", \
					 "<span class='notice'>You shaped [src] into metal with the welding tool.</span>", \
					 "<span class='italics'>You hear welding.</span>")
		var/obj/item/stack/rods/R = src
		src = null
		var/replace = (user.get_inactive_hand()==R)
		R.use(4)
		if(!R && replace)
			user.put_in_hands(new_item)

//Grass
/obj/item/stack/tile/grass
	name = "grass tiles"
	gender = PLURAL
	singular_name = "grass floor tile"
	desc = "A patch of grass like they often use on golf courses"
	icon_state = "tile_grass"
	origin_tech = "biotech=1"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/grass
=======
	turf_type = /turf/open/floor/grass
>>>>>>> Stashed changes
	resistance_flags = FLAMMABLE

//Wood
/obj/item/stack/tile/wood
	name = "wood floor tiles"
	gender = PLURAL
	singular_name = "wood floor tile"
	desc = "an easy to fit wood floor tile"
	icon_state = "tile-wood"
	origin_tech = "biotech=1"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/wood
=======
	turf_type = /turf/open/floor/wood
>>>>>>> Stashed changes
	resistance_flags = FLAMMABLE

//Carpets
/obj/item/stack/tile/carpet
	name = "carpet"
	singular_name = "carpet"
	desc = "A piece of carpet. It is the same size as a floor tile"
	icon_state = "tile-carpet"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/carpet
=======
	turf_type = /turf/open/floor/carpet
>>>>>>> Stashed changes
	resistance_flags = FLAMMABLE

/obj/item/stack/tile/carpet/twenty
	amount = 20

/obj/item/stack/tile/carpet/black
	name = "black carpet"
	icon_state = "tile-carpet-black"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/carpet/black
=======
	turf_type = /turf/open/floor/carpet/black
>>>>>>> Stashed changes

/obj/item/stack/tile/carpet/black/twenty
	amount = 20

//Plasteel
/obj/item/stack/tile/plasteel
	name = "floor tiles"
	gender = PLURAL
	singular_name = "floor tile"
	desc = "Those could work as a pretty decent throwing weapon."
	icon_state = "tile"
	force = 6
	materials = list(MAT_METAL=500)
	throwforce = 10
	throw_speed = 3
	throw_range = 7
	flags = CONDUCT
<<<<<<< Updated upstream
	turf_type = turf/open/floor/plasteel
=======
	turf_type = /turf/open/floor/plasteel
>>>>>>> Stashed changes
	mineralType = "metal"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 70)
	resistance_flags = FIRE_PROOF

//Light
/obj/item/stack/tile/light
	name = "light tiles"
	gender = PLURAL
	singular_name = "light floor tile"
	desc = "A floor tile, made out off glass. Use a multitool on it to change its color."
	icon_state = "tile_light blue"
	force = 3
	throwforce = 5
	attack_verb = list("bashed", "battered", "bludgeoned", "thrashed", "smashed")
<<<<<<< Updated upstream
	turf_type = turf/open/floor/light
=======
	turf_type = /turf/open/floor/light
>>>>>>> Stashed changes

//Fakespace
/obj/item/stack/tile/fakespace
	name = "astral carpet"
	singular_name = "astral carpet"
	desc = "A piece of carpet with a convincing star pattern."
	icon_state = "tile_space"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/fakespace
=======
	turf_type = /turf/open/floor/fakespace
>>>>>>> Stashed changes
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/fakespace

/obj/item/stack/tile/fakespace/loaded
	amount = 30

//High-traction
/obj/item/stack/tile/noslip
	name = "high-traction floor tile"
	singular_name = "high-traction floor tile"
	desc = "A high-traction floor tile. It feels rubbery in your hand."
	icon_state = "tile_noslip"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/noslip
=======
	turf_type = /turf/open/floor/noslip
>>>>>>> Stashed changes
	origin_tech = "materials=3"
	merge_type = /obj/item/stack/tile/noslip

/obj/item/stack/tile/noslip/loaded
	amount = 20

//Pod floor
/obj/item/stack/tile/pod
	name = "pod floor tile"
	singular_name = "pod floor tile"
	desc = "A grooved floor tile."
	icon_state = "tile_pod"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/pod
=======
	turf_type = /turf/open/floor/pod
>>>>>>> Stashed changes

/obj/item/stack/tile/pod/light
	name = "light pod floor tile"
	singular_name = "light pod floor tile"
	desc = "A lightly colored grooved floor tile."
	icon_state = "tile_podlight"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/pod
=======
	turf_type = /turf/open/floor/pod
>>>>>>> Stashed changes

/obj/item/stack/tile/pod/dark
	name = "dark pod floor tile"
	singular_name = "dark pod floor tile"
	desc = "A darkly colored grooved floor tile."
	icon_state = "tile_poddark"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/pod/dark
=======
	turf_type = /turf/open/floor/pod/dark
>>>>>>> Stashed changes

/obj/item/stack/tile/arcade_carpet
	name = "arcade carpet"
	singular_name = "arcade carpet"
	desc= "A piece of carpet with a retro spaceship pattern."
	icon_state = "tile_space"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/carpet/arcade
=======
	turf_type = /turf/open/floor/carpet/arcade
>>>>>>> Stashed changes
	merge_type = /obj/item/stack/tile/arcade_carpet
	resistance_flags = FLAMMABLE

/obj/item/stack/tile/arcade_carpet/loaded
	amount = 20
