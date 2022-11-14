public class LeadBatch implements Database.Batchable<SObject> {
    // Start: create batch scope
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead');
    }

    // Execute: iterates multiple times till we process all records in batch scope
    public void execute(Database.BatchableContext BC, List<Lead> scope) {
        for (Lead leadRecord : scope) {
           leadRecord.LeadSource = 'Phone Inquiry'; 
        }
        update scope; 
    }

    //Finish
    public void finish(Database.BatchableContext BC) {
        System.debug('batch size finshed'); 
        // can also call another batch class like this
        //Database.executeBatch(leadBatchInstance, 50);   
    }
}
