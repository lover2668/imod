package imod

class ScheduleEvent {
	String title
	Date startDate
	Date endDate
	// learnO-> LearningObjective, knowD -> knowledgeDimension; temporarily stored as string for dev prototype
	String learnO
	String knowD
	//
	String enviro
	Double workTime
	String notes

	// relationship with learning objective
	static belongsTo = [
		LearningObjective
	]

	// various constraints for validation
    static constraints = {
    	title	blank: false
    	endDate  blank: false, validator: { endDate, schedule ->
			endDate >= schedule.startDate
		}
		learnO	blank: false
		knowD	blank: false
		enviro	blank: false
		workTime	blank: false
		notes	nullable: true
    }

    static mapping = {
	}

	String toString() {
		title + ' ' + startDate.toString() + ' ' + endDate.toString()  + ' ' + learnO + ' ' + knowD + ' ' + enviro + ' ' + workTime + ' ' + notes
	}
}
