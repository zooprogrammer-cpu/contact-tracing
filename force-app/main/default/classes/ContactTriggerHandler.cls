public class ContactTriggerHandler {
    public static Boolean alreadyExecuted = false; 

    public static void afterInsertHandler(List<Contact> newContacts) {
        for (Contact con : newContacts) {
            //Query accounts where Account.Id = con.AccountId
            if (String.isNotBlank(con.AccountId)){
                // get AccountId from a contact. Get all contacts with this account Id with Active checkbox checked
                String accountId = con.AccountId; 
                // find contact records that have Active checkbox checked

                List<AggregateResult> results = [SELECT AccountId, COUNT(Id) totalContacts FROM Contact WHERE Active__c = true AND AccountId =:accountId GROUP BY AccountId];
                for (AggregateResult result : results) {
                    // get account id and number of active contacts    
                    String accId = String.valueOf(result.get('AccountId')); 
                    Integer totalAccounts =  Integer.valueOf(result.get('totalContacts'));

                    Account acc  = new Account(Id = accId, Active_Contacts__c = totalAccounts);
                    update acc; 
                }
            }
        }

    }

    public static void afterUpdateHandler() {
        
    }

    public static void afterDeleteHandler() {
        
    }

    public static void afterUndeleteHandler() {
        
    }
}
