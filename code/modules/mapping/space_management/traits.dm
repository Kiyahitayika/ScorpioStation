// Look up levels[z].flags[trait]
/datum/controller/subsystem/mapping/proc/level_trait(z, trait)
	if (!isnum(z) || z < 1)
		return null
	if (z_list)
		if (z > z_list.len)
			stack_trace("Unmanaged z-level [z]! maxz = [world.maxz], z_list.len = [z_list.len]")
			return list()
		var/datum/space_level/S = get_level(z)
		return S.flags[trait]
	else
		var/list/default = DEFAULT_MAP_flags
		if (z > default.len)
			stack_trace("Unmanaged z-level [z]! maxz = [world.maxz], default.len = [default.len]")
			return list()
		return default[z][DL_flags][trait]

// Check if levels[z] has any of the specified flags
/datum/controller/subsystem/mapping/proc/level_has_any_trait(z, list/flags)
	for (var/I in flags)
		if (level_trait(z, I))
			return TRUE
	return FALSE

// Check if levels[z] has all of the specified flags
/datum/controller/subsystem/mapping/proc/level_has_all_flags(z, list/flags)
	for (var/I in flags)
		if (!level_trait(z, I))
			return FALSE
	return TRUE

// Get a list of all z which have the specified trait
/datum/controller/subsystem/mapping/proc/levels_by_trait(trait)
	. = list()
	var/list/_z_list = z_list
	for(var/A in _z_list)
		var/datum/space_level/S = A
		if (S.flags[trait])
			. += S.zpos

// Get a list of all z which have any of the specified flags
/datum/controller/subsystem/mapping/proc/levels_by_any_trait(list/flags)
	. = list()
	var/list/_z_list = z_list
	for(var/A in _z_list)
		var/datum/space_level/S = A
		for (var/trait in flags)
			if (S.flags[trait])
				. += S.zpos
				break

// Attempt to get the turf below the provided one according to Z flags
/datum/controller/subsystem/mapping/proc/get_turf_below(turf/T)
	if (!T)
		return
	var/offset = level_trait(T.z, "Down")
	if (!offset)
		return
	return locate(T.x, T.y, T.z + offset)

// Attempt to get the turf above the provided one according to Z flags
/datum/controller/subsystem/mapping/proc/get_turf_above(turf/T)
	if (!T)
		return
	var/offset = level_trait(T.z, "Up")
	if (!offset)
		return
	return locate(T.x, T.y, T.z + offset)

// Prefer not to use this one too often
/datum/controller/subsystem/mapping/proc/get_station_center()
	var/station_z = levels_by_trait("Station")[1]
	return locate(round(world.maxx * 0.5, 1), round(world.maxy * 0.5, 1), station_z)
