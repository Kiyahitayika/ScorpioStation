/obj/effect/decal/cleanable/liquid_fuel
	//Liquid fuel is used for things that used to rely on volatile fuels or plasma being contained to a couple tiles.
	icon = 'icons/effects/effects.dmi'
	icon_state = "fuel"
	layer = LATTICE_LAYER
	anchored = TRUE
	var/amount = 1 //Basically moles.

/obj/effect/decal/cleanable/liquid_fuel/Initialize(mapload, amt = 1)
	. = ..()
	amount = amt

	//Be absorbed by any other liquid fuel in the tile.
	for(var/obj/effect/decal/cleanable/liquid_fuel/other in loc)
		if(other != src)
			other.amount += amount
			spawn other.Spread()
			qdel(src)

	Spread()

/obj/effect/decal/cleanable/liquid_fuel/proc/Spread()
	//Allows liquid fuels to sometimes flow into other tiles.
	if(amount < 0.5)
		return
	var/turf/S = loc
	if(!isopenturf(S))
		return
	for(var/D in GLOB.cardinal)
		if(rand(25))
			var/turf/open/target = get_step(src, D)
			var/turf/open/origin = get_turf(src)
			if(origin.CanPass(null, target, 0, 0) && target.CanPass(null, origin, 0, 0))
				if(!locate(/obj/effect/decal/cleanable/liquid_fuel) in target)
					new/obj/effect/decal/cleanable/liquid_fuel(target, amount * 0.25)
					amount *= 0.75

/obj/effect/decal/cleanable/liquid_fuel/flamethrower_fuel
	icon_state = "mustard"
	anchored = FALSE

/obj/effect/decal/cleanable/liquid_fuel/flamethrower_fuel/Initialize(newLoc, amt = 1, d = 0)
	dir = d //Setting this direction means you won't get torched by your own flamethrower.
	. = ..()

/obj/effect/decal/cleanable/liquid_fuel/flamethrower_fuel/Spread()
	//The spread for flamethrower fuel is much more precise, to create a wide fire pattern.
	if(amount < 0.1)
		return
	var/turf/S = loc
	if(!issimulatedturf(S))
		return
	for(var/D in list(turn(dir, 90), turn(dir, -90), dir))
		var/turf/O = get_step(S, D)
		if(locate(/obj/effect/decal/cleanable/liquid_fuel/flamethrower_fuel) in O)
			continue
		if(O.CanPass(null, S, 0, 0) && S.CanPass(null, O, 0, 0))
			new/obj/effect/decal/cleanable/liquid_fuel/flamethrower_fuel(O, amount * 0.25, D)
			O.hotspot_expose((T20C*2) + 380,500) //Light flamethrower fuel on fire immediately.

	amount *= 0.25
