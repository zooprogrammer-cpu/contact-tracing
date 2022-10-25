trigger LeadTrigger on Lead(before insert, before update, after update) {
  System.debug('Trigger Size: ' + Trigger.size);
  System.debug('is Trigger: ' + Trigger.isExecuting);
  System.debug('Operation Type: ' + Trigger.operationType);
  for (Lead leadRecord : Trigger.new) {
    // if lead source is blank, make it other
    if (Trigger.isBefore) {
      leadRecord.LeadSource = 'Other';
    }
    // if the current status value of lead record is Closed - Converted or Closed - Not Converted
    // and the old status valaue was Working - Contacted, throw an error

    if (
      (leadRecord.Status == 'Closed - Converted' ||
      leadRecord.Status == 'Closed - Not Converted') &&
      Trigger.oldMap.get(leadRecord.Id).Status == 'Open - Not Contacted'
    ) {
      leadRecord.Status.addError('Cannot close an open lead record');
    }

    // validation rules on Industry fields
    if (String.isBlank(leadRecord.Industry) && Trigger.isInsert) {
      leadRecord.addError('The industry cannot be blank.');
    }
  }
  System.debug('Lead Source updating');
}
