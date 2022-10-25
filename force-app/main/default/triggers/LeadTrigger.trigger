trigger LeadTrigger on Lead (before insert, before update) {
	//System.debug('Lead Trigger called');
    for(Lead leadRecord : Trigger.new){
        if (String.isBlank(leadRecord.LeadSource)){
            leadRecord.LeadSource = 'Other';
        }
    }        
}