
var/const/ENGSEC			=(1<<0)

var/const/CAPTAIN			=(1<<0)
var/const/HOS				=(1<<1)
var/const/WARDEN			=(1<<2)
var/const/DETECTIVE			=(1<<3)
var/const/OFFICER			=(1<<4)
var/const/CHIEF				=(1<<5)
var/const/ENGINEER			=(1<<6)
var/const/ATMOSTECH			=(1<<7)
var/const/AI				=(1<<8)
var/const/CYBORG			=(1<<9)
var/const/INTERN_SEC		=(1<<10)
var/const/INTERN_ENG		=(1<<11)
var/const/FORENSICS			=(1<<12)


var/const/MEDSCI			=(1<<1)

var/const/RD				=(1<<0)
var/const/SCIENTIST			=(1<<1)
var/const/CHEMIST			=(1<<2)
var/const/CMO				=(1<<3)
var/const/DOCTOR			=(1<<4)
var/const/GENETICIST		=(1<<5)
var/const/VIROLOGIST		=(1<<6)
var/const/PSYCHIATRIST		=(1<<7)
var/const/ROBOTICIST		=(1<<8)
var/const/XENOBIOLOGIST		=(1<<9)
var/const/PARAMEDIC			=(1<<10)
var/const/INTERN_MED		=(1<<11)
var/const/INTERN_SCI		=(1<<12)

var/const/CIVILIAN			=(1<<2)

var/const/HOP				=(1<<0)
var/const/BARTENDER			=(1<<1)
var/const/BOTANIST			=(1<<2)
var/const/CHEF				=(1<<3)
var/const/JANITOR			=(1<<4)
var/const/LIBRARIAN			=(1<<5)
var/const/QUARTERMASTER		=(1<<6)
var/const/CARGOTECH			=(1<<7)
var/const/MINER				=(1<<8)
var/const/LAWYER			=(1<<9)
var/const/CHAPLAIN			=(1<<10)
var/const/CLOWN				=(1<<11)
var/const/MIME				=(1<<12)
var/const/MERCHANT			=(1<<13)
var/const/ASSISTANT			=(1<<14)

var/const/TEAM1				=(1<<0)

var/const/DARKCRUSADER			=(1<<1)
var/const/DARKBLACKSMITH		=(1<<2)
var/const/DARKBARD				=(1<<3)
var/const/DARKPRIEST			=(1<<4)
var/const/DARKFARMER			=(1<<5)

var/const/TEAM2				=(1<<1)

var/const/CRUSADER			=(1<<6)
var/const/BLACKSMITH		=(1<<7)
var/const/BARD				=(1<<8)
var/const/PRIEST			=(1<<9)
var/const/FARMER			=(1<<10)

var/list/assistant_occupations = list() //Leaving this on one line stops Travis complaining ~Scopes

//money shit below. will probably remove the other jobs if it doesn't break anything
var/list/crusader_positions = list(
	"Crusader",
	"Bard",
	"King",
	"Blacksmith",
	"Farmer",
	"Priest",

)

var/list/dark_crusader_positions = list(
	"Dark Crusader",
	"Dark Bard",
	"Dark Blacksmith",
	"Dark Farmer",
	"Dark King",
	"Dark Priest",
)

var/list/command_positions = list(
	"Captain",
	"Head of Personnel",
	"Head of Security",
	"Chief Engineer",
	"Research Director",
	"Chief Medical Officer"
)


var/list/engineering_positions = list(
	"Chief Engineer",
	"Station Engineer",
	"Atmospheric Technician",
	"Engineering Apprentice"
)


var/list/medical_positions = list(
	"Chief Medical Officer",
	"Medical Doctor",
	"Psychiatrist",
	"Chemist",
	"Paramedic",
	"Medical Resident"
)


var/list/science_positions = list(
	"Research Director",
	"Scientist",
	"Geneticist",	//Part of both medical and science
	"Roboticist",
	"Xenobiologist",
	"Lab Assistant"
)

//BS12 EDIT
var/list/cargo_positions = list(
	"Quartermaster",
	"Cargo Technician",
	"Shaft Miner"
)

var/list/civilian_positions = list(
	"Head of Personnel",
	"Internal Affairs Agent",
	"Bartender",
	"Gardener",
	"Chef",
	"Janitor",
	"Librarian",
	"Chaplain",
	"Merchant",
	"Assistant"
)


var/list/security_positions = list(
	"Head of Security",
	"Warden",
	"Detective",
	"Forensic Technician",
	"Security Officer",
	"Security Cadet"
)

var/list/nonhuman_positions = list(
	"AI",
	"Cyborg",
	"pAI"
)

/proc/guest_jobbans(var/job)
	return ((job in command_positions) || job == "Internal Affairs Agent")

/proc/get_job_datums()
	var/list/occupations = list()
	var/list/all_jobs = typesof(/datum/job)

	for(var/A in all_jobs)
		var/datum/job/job = new A()
		if(!job)	continue
		occupations += job

	return occupations

/proc/get_alternate_titles(var/job)
	var/list/jobs = get_job_datums()
	var/list/titles = list()

	for(var/datum/job/J in jobs)
		if(J.title == job)
			titles = J.alt_titles

	return titles

//Mahzel : Job preview not added because code don't exist in BS12
