var/AssignmentValue
/mob/living/carbon/human/proc/get_team()//Returns the Team of the target it's called on, if no team is found: assigns a team and returns it. if team is unable to be decided, sets the team to "Unassigned"
    if(teamvalue)
        return(teamvalue)
    else
        AssignmentValue= get_assignment()//scan the mob's job to find department, then assign a team based on the department.
        //return(AssignmentValue)
        if(AssignmentValue in crusader_positions)
            teamvalue="Crusaders"
            return(teamvalue)
        if(AssignmentValue in dark_crusader_positions)
            teamvalue="Dark Crusaders"
            return(teamvalue)
        else
            teamvalue="Unknown"
            return("Unable to assign a proper team: setting to Unknown. something's borked.")

    
    