public class LeadTriggerHandler {
  public static Boolean alreadyExecuted = false; 
  public static void beforeInsertHandler(List<Lead> newRecords) {
    for (Lead leadRecord : newRecords) {
      if (String.isBlank(leadRecord.LeadSource)) {
        leadRecord.LeadSource = 'Other';
      }

      if (String.isBlank(leadRecord.Industry)) {
        leadRecord.addError('The industry field cannot be blank');
      }
    }
  }

  public static void afterInsertHandler(List<Lead> newRecords) {
    List<Task> leadTasks = new List<Task>();
    for (Lead leadRecord : newRecords) {
      // create a task
      Task leadTask = new Task(
        Subject = 'Follow up on Lead Status',
        WhoId = leadRecord.Id
      );
      leadTasks.add(leadTask);
    }
    insert leadTasks;

    //insert another lead that causes recursive error
    // solution is to check if it has aleady executed or not
    if (LeadTriggerHandler.alreadyExecuted == false){
      LeadTriggerHandler.alreadyExecuted = true;
      Lead anotherLead = new Lead(LastName='Another Last Name',FirstName = 'Another First Name',Industry = 'Banking', Status = 'Open - Not Contacted', Company ='ABC Corp', LeadSource = 'Other');
      insert anotherLead;     
    }
  }

  public static void beforeUpdateHandler(
    List<Lead> newRecords,
    Map<Id, Lead> oldRecordsMap
  ) {
    for (Lead leadRecord : newRecords) {
      if (String.isBlank(leadRecord.LeadSource)) {
        leadRecord.LeadSource = 'Other';
      }

      if (
        (leadRecord.Status == 'Closed - Converted' ||
        leadRecord.Status == 'Closed - Not Converted') &&
        oldRecordsMap.get(leadRecord.Id).Status == 'Open - Not Contacted'
      ) {
        leadRecord.Status.addError('Cannot close an open lead record');
      }
    }
  }
}
