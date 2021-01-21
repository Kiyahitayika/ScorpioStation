/turf/open/lava
	name = "lava"
	desc = "That looks... a bit dangerous"
	icon = 'icons/turf/floors/lava.dmi'
	icon_state = "smooth"
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/open/lava)
	var/lava_damage = 250
	var/lava_fire = 20
	light_range = 2
	light_color = "#FFC040"
	intact = TRUE

/turf/open/lava/Entered(mob/living/M, atom/OL, ignoreRest = 0)
	if(istype(M))
		M.apply_damage(lava_damage, BURN)
		M.adjust_fire_stacks(lava_fire)
		M.IgniteMob()

/turf/open/lava/dense
	density = TRUE

/turf/open/lava/water_act(volume, temperature, source)
	return

/turf/open/lava/MakeSlippery(wet_setting = TURF_WET_WATER, time = null)
	return

/turf/open/lava/MakeDry(wet_setting = TURF_WET_WATER)
	return

/turf/open/lava/acid_act(acidpwr, acid_volume)
	return FALSE

/turf/open/lava/singularity_act()
	return

/turf/open/lava/singularity_pull(S, current_size)
	return

/turf/open/lava/can_lay_cable()
	return FALSE

/turf/open/lava/rpd_act()
	return
