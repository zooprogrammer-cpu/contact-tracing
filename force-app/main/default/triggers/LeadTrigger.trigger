trigger LeadTrigger on Lead (before insert, before update, after update) {
	//System.debug('Lead Trigger called');
    for(Lead leadRecord : Trigger.new){
        // if (String.isBlank(leadRecord.LeadSource)){
            if (Trigger.isBefore){
                leadRecord.LeadSource = 'Other';
            }
        // }

        if (String.isBlank(leadRecord.Industry) && Trigger.isInsert){
            leadRecord.addError('The industry cannot be blank.'); 
        }
    }  
    System.debug('Lead Source updating');       
}