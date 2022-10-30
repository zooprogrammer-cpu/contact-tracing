trigger LeadTrigger on Lead(before insert, after insert, before update, after update) {
  switch on Trigger.operationType {
    when BEFORE_INSERT {
      for (Lead leadRecord : Trigger.new) {
        if (String.isBlank(leadRecord.LeadSource)) {
          leadRecord.LeadSource = 'Other';
        }

        if (String.isBlank(leadRecord.Industry)) {
          leadRecord.addError('The industry field cannot be blank');
        }
      }
    }

    when AFTER_INSERT{
        // for (Lead leadRecord : Trigger.new) {
        //     Task newTask = new Task(Subject='Call back tomorrow', WhoId = leadRecord.Id);
        //     insert newTask;
        //   }
          // Bulkified approach -   
          List<Task> leadTasks = new List<Task>();
            for(Lead leadRecord : Trigger.new){
                // create a task
                Task leadTask = new Task(Subject='Follow up on Lead Status', WhoId=leadRecord.Id);
                leadTasks.add(leadTask);
            }
            insert leadTasks;
            // Recursive Trigger Problem. Insert another lead which intiates the same lead trigger again. 
            // Lead anotherLead = new Lead(LastName='Another Last Name',FirstName = 'Another First Name',Industry = 'Banking', Status = 'Open - Not Contacted', Company ='ABC Corp', LeadSource = 'Other');
            // insert anotherLead; 
          }

    when BEFORE_UPDATE {
      for (Lead leadRecord : Trigger.new) {
        if (String.isBlank(leadRecord.LeadSource)) {
          leadRecord.LeadSource = 'Other';
        }

        if (
          (leadRecord.Status == 'Closed - Converted' ||
          leadRecord.Status == 'Closed - Not Converted') &&
          Trigger.oldMap.get(leadRecord.Id).Status == 'Open - Not Contacted'
        ) {
          leadRecord.Status.addError('Cannot close an open lead record');
        }
      }
    }
  }
}