/turf/proc/CanAtmosPass(var/turf/T)

/turf/closed/CanAtmosPass(turf/T)
	return FALSE

/turf/open/CanAtmosPass(turf/T)
	if(!istype(T))
		return FALSE
	var/R = FALSE
	if(blocks_air || T.blocks_air)
		R = TRUE

	for(var/J in contents+T.contents)
		var/turf/other = J
		if(!O.CanAtmosPass(T))
			R = TRUE
			if(O.BlockSuperconductivity()) 	//the direction and open/closed are already checked on CanAtmosPass() so there are no arguments
				var/D = get_dir(src, T)
				atmos_supeconductivity |= D
				D = get_dir(T, src)
				T.atmos_supeconductivity |= D
				return FALSE						//no need to keep going, we got all we asked

	var/D = get_dir(src, T)
	atmos_supeconductivity &= ~D
	D = get_dir(T, src)
	T.atmos_supeconductivity &= ~D
	return !R

/atom/movable/proc/CanAtmosPass()
	return TRUE

/atom/proc/CanPass(atom/movable/mover, turf/target, height=1.5)
	return (!density || !height)

/turf/CanPass(atom/movable/mover, turf/target, height=1.5)
	if(!target) return FALSE

	if(istype(mover)) // turf/Enter(...) will perform more advanced checks
		return !density

	else // Now, doing more detailed checks for air movement and air group formation
		if(target.blocks_air||blocks_air)
			return FALSE

		for(var/obj/obstacle in src)
			if(!obstacle.CanPass(mover, target, height))
				return FALSE
		for(var/obj/obstacle in target)
			if(!obstacle.CanPass(mover, src, height))
				return FALSE

		return TRUE

/atom/movable/proc/BlockSuperconductivity() // objects that block air and don't let superconductivity act. Only firelocks atm.
	return FALSE

/turf/proc/CalculateAdjacentTurfs()
	atmos_adjacent_turfs_amount = 0
	for(var/direction in GLOB.cardinal)
		var/turf/open/T = get_step(src, direction)
		if(!istype(T))
			continue
		var/counterdir = get_dir(T, src)
		if(CanAtmosPass(T))
			atmos_adjacent_turfs_amount += 1
			atmos_adjacent_turfs |= direction
			if(!(T.atmos_adjacent_turfs & counterdir))
				T.atmos_adjacent_turfs_amount += 1
			T.atmos_adjacent_turfs |= counterdir
		else
			atmos_adjacent_turfs &= ~direction
			if(T.atmos_adjacent_turfs & counterdir)
				T.atmos_adjacent_turfs_amount -= 1
			T.atmos_adjacent_turfs &= ~counterdir

//returns a list of adjacent turfs that can share air with this one.
//alldir includes adjacent diagonal tiles that can share
//	air with both of the related adjacent cardinal tiles
/turf/proc/GetAtmosAdjacentTurfs(alldir = FALSE)
	var/adjacent_turfs = list()
	var/turf/simulated/curloc = src

	for(var/direction in GLOB.cardinal)
		if(!(curloc.atmos_adjacent_turfs & direction))
			continue

		var/turf/simulated/S = get_step(curloc, direction)
		if(istype(S))
			adjacent_turfs += S
	if(!alldir)
		return adjacent_turfs

	for(var/direction in GLOB.diagonals)
		var/matchingDirections = 0
		var/turf/simulated/S = get_step(curloc, direction)

		for(var/checkDirection in GLOB.cardinal)
			if(!(S.atmos_adjacent_turfs & checkDirection))
				continue
			var/turf/simulated/checkTurf = get_step(S, checkDirection)

			if(checkTurf in adjacent_turfs)
				matchingDirections++
			if(matchingDirections >= 2)
				adjacent_turfs += S
				break
	return adjacent_turfs

/atom/movable/proc/air_update_turf(command = FALSE)
	if(!istype(loc,/turf) && command)
		return
	for(var/turf/T in locs) // used by double wide doors and other nonexistant multitile structures
		T.air_update_turf(command)

/turf/proc/air_update_turf(command = FALSE)
	if(command)
		CalculateAdjacentTurfs()
	if(SSair)
		SSair.add_to_active(src, command)

/atom/movable/proc/move_update_air(turf/T)
	if(istype(T,/turf))
		T.air_update_turf(TRUE)
	air_update_turf(TRUE)

/atom/movable/proc/atmos_spawn_air(text, amount) //because a lot of people loves to copy paste awful code lets just make a easy proc to spawn your plasma fires
	var/turf/open/T = get_turf(src)
	if(!istype(T))
		return
	T.atmos_spawn_air(text, amount)

/turf/open/proc/atmos_spawn_air(flag, amount)
	if(!text || !amount || !air)
		return
	var/datum/gas_mixture/G = new
	if(flag & LINDA_SPAWN_20C)
		G.temperature = T20C
	if(flag & LINDA_SPAWN_HEAT)
		G.temperature += 1000
	if(flag & LINDA_SPAWN_TOXINS)
		G.toxins += amount
	if(flag & LINDA_SPAWN_OXYGEN)
		G.oxygen += amount
	if(flag & LINDA_SPAWN_CO2)
		G.carbon_dioxide += amount
	if(flag & LINDA_SPAWN_NITROGEN)
		G.nitrogen += amount
	if(flag & LINDA_SPAWN_N2O)
		G.sleeping_agent += amount
	if(flag & LINDA_SPAWN_AGENT_B)
		G.agent_b += amount
	if(flag & LINDA_SPAWN_AIR)
		G.oxygen += MOLES_O2STANDARD * amount
		G.nitrogen += MOLES_N2STANDARD * amount
	air.merge(G)
	SSair.add_to_active(src, FALSE)
