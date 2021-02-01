/obj/item/stack/tile/mineral/plasma
	name = "plasma tile"
	singular_name = "plasma floor tile"
	desc = "A tile made out of highly flammable plasma. This can only end well."
	icon_state = "tile_plasma"
	origin_tech = "plasmatech=1"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/mineral/plasma
=======
	turf_type = /turf/open/floor/mineral/plasma
>>>>>>> Stashed changes
	mineralType = "plasma"
	materials = list(MAT_PLASMA=500)

/obj/item/stack/tile/mineral/plasma/welder_act(mob/user, obj/item/I)
	if(I.use_tool(src, user, volume = I.tool_volume))
		atmos_spawn_air(LINDA_SPAWN_HEAT | LINDA_SPAWN_TOXINS, 5)
		user.visible_message("<span class='warning'>[user.name] sets the plasma tiles on fire!</span>", \
							"<span class='warning'>You set the plasma tiles on fire!</span>")
		message_admins("Plasma tiles ignited by [key_name_admin(user)](<A HREF='?_src_=holder;adminmoreinfo=\ref[user]'>?</A>) (<A HREF='?_src_=holder;adminplayerobservefollow=\ref[user]'>FLW</A>) in ([x],[y],[z] - <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>JMP</a>)",0,1)
		log_game("Plasma tiles ignited by [key_name(user)] in ([x],[y],[z])")
		investigate_log("was <font color='red'><b>ignited</b></font> by [key_name(user)]","atmos")
		qdel(src)

/obj/item/stack/tile/mineral/uranium
	name = "uranium tile"
	singular_name = "uranium floor tile"
	desc = "A tile made out of uranium. You feel a bit woozy."
	icon_state = "tile_uranium"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/mineral/uranium
=======
	turf_type = /turf/open/floor/mineral/uranium
>>>>>>> Stashed changes
	mineralType = "uranium"
	materials = list(MAT_URANIUM=500)

GLOBAL_LIST_INIT(gold_tile_recipes, list ( \
	new/datum/stack_recipe("fancy gold tile", /obj/item/stack/tile/mineral/gold/fancy, max_res_amount = 20), \
	))

/obj/item/stack/tile/mineral/gold
	name = "gold tile"
	singular_name = "gold floor tile"
	desc = "A tile made out of gold, the swag seems strong here."
	icon_state = "tile_gold"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/mineral/gold
=======
	turf_type = /turf/open/floor/mineral/gold
>>>>>>> Stashed changes
	mineralType = "gold"
	materials = list(MAT_GOLD=500)

/obj/item/stack/tile/mineral/gold/New(loc, amount=null)
	..()
	recipes = GLOB.gold_tile_recipes

GLOBAL_LIST_INIT(goldfancy_tile_recipes, list ( \
	new/datum/stack_recipe("regular gold tile", /obj/item/stack/tile/mineral/gold, max_res_amount = 20), \
	))

/obj/item/stack/tile/mineral/gold/fancy
	icon_state = "tile_goldfancy"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/mineral/gold/fancy
=======
	turf_type = /turf/open/floor/mineral/gold/fancy
>>>>>>> Stashed changes

/obj/item/stack/tile/mineral/gold/fancy/New(loc, amount=null)
	..()
	recipes = GLOB.goldfancy_tile_recipes

GLOBAL_LIST_INIT(silver_tile_recipes, list ( \
	new/datum/stack_recipe("fancy silver tile", /obj/item/stack/tile/mineral/silver/fancy, max_res_amount = 20), \
	))

/obj/item/stack/tile/mineral/silver
	name = "silver tile"
	singular_name = "silver floor tile"
	desc = "A tile made out of silver, the light shining from it is blinding."
	icon_state = "tile_silver"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/mineral/silver
=======
	turf_type = /turf/open/floor/mineral/silver
>>>>>>> Stashed changes
	mineralType = "silver"
	materials = list(MAT_SILVER=500)

/obj/item/stack/tile/mineral/silver/New(loc, amount=null)
	..()
	recipes = GLOB.silver_tile_recipes

GLOBAL_LIST_INIT(silverfancy_tile_recipes, list ( \
	new/datum/stack_recipe("regular silver tile", /obj/item/stack/tile/mineral/silver, max_res_amount = 20), \
	))

/obj/item/stack/tile/mineral/silver/fancy
	icon_state = "tile_silverfancy"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/mineral/silver/fancy
=======
	turf_type = /turf/open/floor/mineral/silver/fancy
>>>>>>> Stashed changes

/obj/item/stack/tile/mineral/silver/fancy/New(loc, amount=null)
	..()
	recipes = GLOB.silverfancy_tile_recipes

/obj/item/stack/tile/mineral/diamond
	name = "diamond tile"
	singular_name = "diamond floor tile"
	desc = "A tile made out of diamond. Wow, just, wow."
	icon_state = "tile_diamond"
	origin_tech = "materials=2"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/mineral/diamond
=======
	turf_type = /turf/open/floor/mineral/diamond
>>>>>>> Stashed changes
	mineralType = "diamond"
	materials = list(MAT_DIAMOND=500)

/obj/item/stack/tile/mineral/bananium
	name = "bananium tile"
	singular_name = "bananium floor tile"
	desc = "A tile made out of bananium, HOOOOOOOOONK!"
	icon_state = "tile_bananium"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/mineral/bananium
=======
	turf_type = /turf/open/floor/mineral/bananium
>>>>>>> Stashed changes
	mineralType = "bananium"
	materials = list(MAT_BANANIUM=500)

/obj/item/stack/tile/mineral/tranquillite
	name = "silent tile"
	singular_name = "silent floor tile"
	desc = "A tile made out of tranquillite, SHHHHHHHHH!"
	icon_state = "tile_tranquillite"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/mineral/tranquillite
=======
	turf_type = /turf/open/floor/mineral/tranquillite
>>>>>>> Stashed changes
	mineralType = "tranquillite"
	materials = list(MAT_TRANQUILLITE=500)

/obj/item/stack/tile/mineral/abductor
	name = "alien floor tile"
	singular_name = "alien floor tile"
	desc = "A tile made out of alien alloy."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "tile_abductor"
	origin_tech = "materials=6;abductor=1"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/mineral/abductor
=======
	turf_type = /turf/open/floor/mineral/abductor
>>>>>>> Stashed changes
	mineralType = "abductor"

/obj/item/stack/tile/mineral/titanium
	name = "titanium tile"
	singular_name = "titanium floor tile"
	desc = "A tile made of titanium, used for shuttles."
	icon_state = "tile_shuttle"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/mineral/titanium
=======
	turf_type = /turf/open/floor/mineral/titanium
>>>>>>> Stashed changes
	mineralType = "titanium"
	materials = list(MAT_TITANIUM=500)

/obj/item/stack/tile/mineral/titanium/purple
<<<<<<< Updated upstream
	turf_type = turf/open/floor/mineral/titanium/purple
=======
	turf_type = /turf/open/floor/mineral/titanium/purple
>>>>>>> Stashed changes
	icon_state = "tile_plasma"

/obj/item/stack/tile/mineral/plastitanium
	name = "plas-titanium tile"
	singular_name = "plas-titanium floor tile"
	desc = "A tile made of plas-titanium, used for very evil shuttles."
	icon_state = "tile_darkshuttle"
<<<<<<< Updated upstream
	turf_type = turf/open/floor/mineral/plastitanium
=======
	turf_type = /turf/open/floor/mineral/plastitanium
>>>>>>> Stashed changes
	mineralType = "plastitanium"
	materials = list(MAT_TITANIUM=250, MAT_PLASMA=250)
