public class LeadAsynchronous {
    @future
    public static void updateLeadRecords(Set<Id> existingRecordIds) {
        List<Lead> existingRecords = [SELECT Id, LeadSource FROM Lead WHERE Id in :existingRecordIds];
        for (Lead record : existingRecords) {
            record.LeadSource = 'Web';    
        }
        update existingRecords; 
    }

    @future
    public static void createLeadRecords() {
        Lead anotherLead = new Lead(LastName = 'Test Lead Single', Status = 'Open - Not Contacted', Company = 'Ash Condulting', Industry = 'Banking'); 
        insert anotherLead;    
    }
}
