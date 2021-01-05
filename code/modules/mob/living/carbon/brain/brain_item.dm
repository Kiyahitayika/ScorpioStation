/obj/item/organ/internal/brain
	name = "brain"
	max_damage = 120
	icon_state = "brain2"
	force = 1.0
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 1.0
	throw_speed = 3
	throw_range = 5
	origin_tech = "biotech=5"
	attack_verb = list("attacked", "slapped", "whacked")
	var/mob/living/carbon/brain/brainmob = null
	organ_tag = "brain"
	parent_organ = "head"
	slot = "brain"
	vital = TRUE
	hidden_pain = TRUE //the brain has no pain receptors, and brain damage is meant to be a stealthy damage type.
	var/mmi_icon = 'icons/obj/assemblies.dmi'
	var/mmi_icon_state = "mmi_full"
	var/list/datum/brain_trauma/traumas = list()

/obj/item/organ/internal/brain/xeno
	name = "xenomorph brain"
	desc = "We barely understand the brains of terrestial animals. Who knows what we may find in the brain of such an advanced species?"
	icon_state = "brain-x"
	origin_tech = "biotech=6"
	mmi_icon = 'icons/mob/alien.dmi'
	mmi_icon_state = "AlienMMI"

/obj/item/organ/internal/brain/Destroy()
	QDEL_NULL(brainmob)
	return ..()

/obj/item/organ/internal/brain/proc/transfer_identity(var/mob/living/carbon/H)
	brainmob = new(src)
	if(isnull(dna)) // someone didn't set this right...
		log_runtime(EXCEPTION("[src] at [loc] did not contain a dna datum at time of removal."), src)
		dna = H.dna.Clone()
	name = "\the [dna.real_name]'s [initial(src.name)]"
	brainmob.dna = dna.Clone() // Silly baycode, what you do
//	brainmob.dna = H.dna.Clone() Putting in and taking out a brain doesn't make it a carbon copy of the original brain of the body you put it in
	brainmob.name = dna.real_name
	brainmob.real_name = dna.real_name
	brainmob.timeofhostdeath = H.timeofdeath
	if(H.mind)
		H.mind.transfer_to(brainmob)

	to_chat(brainmob, "<span class='notice'>You feel slightly disoriented. That's normal when you're just a [initial(src.name)].</span>")

/obj/item/organ/internal/brain/examine(mob/user) // -- TLE
	. = ..()
	if(brainmob && brainmob.client)//if thar be a brain inside... the brain.
		. += "You can feel the small spark of life still left in this one."
	else
		. += "This one seems particularly lifeless. Perhaps it will regain some of its luster later.."

/obj/item/organ/internal/brain/remove(var/mob/living/user, special = 0)

	if(dna)
		name = "[dna.real_name]'s [initial(name)]"
	if(!owner)
		return ..() // Probably a redundant removal; just bail

	for(var/X in traumas)
		var/datum/brain_trauma/BT = X
		BT.on_lose(TRUE)
		BT.owner = null

	var/obj/item/organ/internal/brain/B = src
	if(!special)
		var/mob/living/simple_animal/borer/borer = owner.has_brain_worms()
		if(borer)
			borer.leave_host() //Should remove borer if the brain is removed - RR

		if(owner.mind && !non_primary)//don't transfer if the owner does not have a mind.
			B.transfer_identity(user)

	if(istype(owner, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = owner
		H.update_hair()
	. = ..()

/obj/item/organ/internal/brain/insert(var/mob/living/target, special = 0)
	name = "[initial(name)]"
	var/brain_already_exists = FALSE

	if(istype(target,/mob/living/carbon/human)) // No more IPC multibrain shenanigans
		if(target.get_int_organ(/obj/item/organ/internal/brain))
			brain_already_exists = TRUE

		var/mob/living/carbon/human/H = target
		H.update_hair()

	if(!brain_already_exists)
		if(brainmob)
			if(target.key)
				target.ghostize()
			if(brainmob.mind)
				brainmob.mind.transfer_to(target)
			else
				target.key = brainmob.key
		for(var/X in traumas)
			var/datum/brain_trauma/BT = X
			BT.owner = owner
			BT.on_gain()
	else
		log_debug("Multibrain shenanigans at ([target.x],[target.y],[target.z]), mob '[target]'")
	..(target, special = special)

/obj/item/organ/brain/proc/get_brain_damage()
	var/brain_damage_threshold = max_integrity * BRAIN_DAMAGE_INTEGRITY_MULTIPLIER
	var/offset_integrity = obj_integrity - (max_integrity - brain_damage_threshold)
	. = (1 - (offset_integrity / brain_damage_threshold)) * BRAIN_DAMAGE_DEATH

/obj/item/organ/brain/proc/adjust_brain_damage(amount, maximum)
	var/adjusted_amount
	if(amount >= 0 && maximum)
		var/brainloss = get_brain_damage()
		var/new_brainloss = Clamp(brainloss + amount, 0, maximum)
		if(brainloss > new_brainloss) //brainloss is over the cap already
			return 0
		adjusted_amount = new_brainloss - brainloss
	else
		adjusted_amount = amount

	adjusted_amount *= BRAIN_DAMAGE_INTEGRITY_MULTIPLIER
	if(adjusted_amount)
		if(adjusted_amount >= 0.1)
			take_damage(adjusted_amount)
		else if(adjusted_amount <= -0.1)
			obj_integrity = min(max_integrity, obj_integrity-adjusted_amount)
	. = adjusted_amount

/obj/item/organ/internal/brain/receive_damage(amount, silent = 0) //brains are special; if they receive damage by other means, we really just want the damage to be passed ot the owner and back onto the brain.
	if(owner)
		owner.adjustBrainLoss(amount)

/obj/item/organ/internal/brain/necrotize(update_sprite = TRUE) //Brain also has special handling for when it necrotizes
	damage = max_damage
	status |= ORGAN_DEAD
	STOP_PROCESSING(SSobj, src)
	if(dead_icon && !is_robotic())
		icon_state = dead_icon
	if(owner && vital)
		owner.setBrainLoss(120)

/obj/item/organ/internal/brain/prepare_eat()
	return // Too important to eat.

/*
 * Species Brain Types
 */

/obj/item/organ/internal/brain/slime
	name = "slime core"
	desc = "A complex, organic knot of jelly and crystalline particles."
	icon = 'icons/mob/slimes.dmi'
	icon_state = "green slime extract"
	mmi_icon_state = "slime_mmi"
//	parent_organ = "chest" Hello I am from the ministry of rubber forehead aliens how are you

/obj/item/organ/internal/brain/golem
	name = "Runic mind"
	desc = "A tightly furled roll of paper, covered with indecipherable runes."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scroll"

/obj/item/organ/internal/brain/Destroy() //copypasted from MMIs.
	QDEL_NULL(brainmob)
	return ..()

/obj/item/organ/internal/brain/cluwne

/obj/item/organ/internal/brain/cluwne/insert(mob/living/target, special = 0, make_cluwne = 1)
	..(target, special = special)
	if(ishuman(target) && make_cluwne)
		var/mob/living/carbon/human/H = target
		H.makeCluwne() //No matter where you go, no matter what you do, you cannot escape

/*
 * Traumas
 */

/obj/item/organ/brain/proc/has_trauma_type(brain_trauma_type, consider_permanent = FALSE)
	for(var/X in traumas)
		var/datum/brain_trauma/BT = X
		if(istype(BT, brain_trauma_type) && (consider_permanent || !BT.permanent))
			return BT

//Add a specific trauma
/obj/item/organ/brain/proc/gain_trauma(datum/brain_trauma/trauma, permanent = FALSE, list/arguments)
	var/trauma_type
	if(ispath(trauma))
		trauma_type = trauma
		traumas += new trauma_type(arglist(list(src, permanent) + arguments))
	else
		traumas += trauma
		trauma.permanent = permanent

//Add a random trauma of a certain subtype
/obj/item/organ/brain/proc/gain_trauma_type(brain_trauma_type = /datum/brain_trauma, permanent = FALSE)
	var/list/datum/brain_trauma/possible_traumas = list()
	for(var/T in subtypesof(brain_trauma_type))
		var/datum/brain_trauma/BT = T
		if(initial(BT.can_gain))
			possible_traumas += BT
	var/trauma_type = pick(possible_traumas)
	traumas += new trauma_type(src, permanent)

//Cure a random trauma of a certain subtype
/obj/item/organ/brain/proc/cure_trauma_type(brain_trauma_type, cure_permanent = FALSE)
	var/datum/brain_trauma/trauma = has_trauma_type(brain_trauma_type)
	if(trauma && (cure_permanent || !trauma.permanent))
		qdel(trauma)

/obj/item/organ/brain/proc/cure_all_traumas(cure_permanent = FALSE)
	for(var/X in traumas)
		var/datum/brain_trauma/trauma = X
		if(cure_permanent || !trauma.permanent)
			qdel(trauma)
