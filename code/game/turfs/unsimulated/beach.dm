/turf/open/beach
	name = "Beach"
	icon = 'icons/misc/beach.dmi'
	var/water_overlay_image = null
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/turf/open/beach/Initialize(mapload)
	. = ..()
	if(water_overlay_image)
		var/image/overlay_image = image('icons/misc/beach.dmi', icon_state = water_overlay_image, layer = ABOVE_MOB_LAYER)
		overlay_image.plane = GAME_PLANE
		overlays += overlay_image

/turf/open/beach/sand
	name = "Sand"
	icon_state = "desert"
	mouse_opacity = MOUSE_OPACITY_ICON

/turf/open/beach/sand/Initialize(mapload)
	. = ..()			//adds some aesthetic randomness to the beach sand
	icon_state = pick("desert", "desert0", "desert1", "desert2", "desert3", "desert4")

/turf/open/beach/sand/dense			//for boundary "walls"
	density = 1

/turf/open/beach/coastline
	name = "Coastline"
	//icon = 'icons/misc/beach2.dmi'
	//icon_state = "sandwater"
	icon_state = "beach"
	water_overlay_image = "water_coast"

/turf/open/beach/coastline/dense		//for boundary "walls"
	density = 1

/turf/open/beach/water
	name = "Shallow Water"
	icon_state = "seashallow"
	water_overlay_image = "water_shallow"
	var/obj/machinery/poolcontroller/linkedcontroller = null

/turf/open/beach/water/Entered(atom/movable/AM, atom/OldLoc)
	. = ..()
	if(!linkedcontroller)
		return
	if(ismob(AM))
		linkedcontroller.mobinpool += AM

/turf/open/beach/water/Exited(atom/movable/AM, atom/newloc)
	. = ..()
	if(!linkedcontroller)
		return
	if(ismob(AM))
		linkedcontroller.mobinpool -= AM

/turf/open/beach/water/InitializedOn(atom/A)
	if(!linkedcontroller)
		return
	if(istype(A, /obj/effect/decal/cleanable)) // Better a typecheck than looping through thousands of turfs everyday
		linkedcontroller.decalinpool += A

/turf/open/beach/water/dense			//for boundary "walls"
	density = 1

/turf/open/beach/water/edge_drop
	name = "Water"
	icon_state = "seadrop"
	water_overlay_image = "water_drop"

/turf/open/beach/water/drop
	name = "Water"
	icon = 'icons/turf/floors/seadrop.dmi'
	icon_state = "seadrop"
	water_overlay_image = null
	smooth = SMOOTH_TRUE
	canSmoothWith = list(
		/turf/open/beach/water/drop, /turf/open/beach/water/drop/dense,
		/turf/open/beach/water, /turf/open/beach/water/dense,
		/turf/open/beach/water/edge_drop)
	var/obj/effect/beach_drop_overlay/water_overlay

/turf/open/beach/water/drop/Initialize(mapload)
	. = ..()
	water_overlay = new(src)

/turf/open/beach/water/drop/Destroy()
	QDEL_NULL(water_overlay)
	return ..()

/obj/effect/beach_drop_overlay
	name = "Water"
	icon = 'icons/turf/floors/seadrop-o.dmi'
	layer = MOB_LAYER + 0.1
	smooth = SMOOTH_TRUE
	anchored = 1
	canSmoothWith = list(
		/turf/open/beach/water/drop, /turf/open/beach/water/drop/dense,
		/turf/open/beach/water, /turf/open/beach/water/dense,
		/turf/open/beach/water/edge_drop)

/turf/open/beach/water/drop/dense
	density = 1

/turf/open/beach/water/deep
	name = "Deep Water"
	icon_state = "seadeep"
	water_overlay_image = "water_deep"

/turf/open/beach/water/deep/dense
	density = 1

/turf/open/beach/water/deep/wood_floor
	name = "Sunken Floor"
	icon = 'icons/turf/floors.dmi'
	icon_state = "wood"

/turf/open/beach/water/deep/sand_floor
	name = "Sea Floor"
	icon_state = "sand"

/turf/open/beach/water/deep/rock_wall
	name = "Reef Stone"
	icon_state = "desert7"
	density = 1
	opacity = 1
	explosion_block = 2
	mouse_opacity = MOUSE_OPACITY_ICON
