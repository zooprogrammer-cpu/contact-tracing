public class ContactTriggerHandler {
  public static void afterInsertHandler(List<Contact> newContacts) {
    Set<Id> accountIds = new Set<Id>();
    for (Contact con : newContacts) {
        if (String.isNotBlank(con.AccountId)) {
            // write automation logic here
            accountIds.add(con.AccountId);
        }
    }
    // get aggregate result for all accounts
    List<AggregateResult> results = [
        SELECT AccountId, COUNT(Id) totalContacts
        FROM Contact
        WHERE Active__c = TRUE AND AccountId IN :accountIds
        GROUP BY AccountId
    ];
    // build final list of accounts to update
    List<Account> accountsToUpdate = new List<Account>();
    for (AggregateResult result : results) {
        // get account id and number of active contacts
        String accId = String.valueOf(result.get('AccountId'));
        Integer totalContacts = Integer.valueOf(result.get('totalContacts'));
        // make sure you use Id feild in your account to update it
        Account acc = new Account(Id = accId, Active_Contacts__c = totalContacts);
        accountsToUpdate.add(acc);
    }
    // update the final list of account
    update accountsToUpdate;  
  }

  public static void afterUpdateHandler(List<Contact> newContacts, Map<Id, Contact> oldContactsMap) {
    Set<Id> accountIds = new Set<Id>();
            for (Contact con : newContacts) {
                // capture the account id only if active checkbox value is flipped
                if (String.isNotBlank(con.AccountId) && oldContactsMap.get(con.Id).Active__c != con.Active__c) {
                    // write automation logic here
                    accountIds.add(con.AccountId);
                } else if (oldContactsMap.get(con.Id).AccountId != con.AccountId) {
                    accountIds.add(con.AccountId);
                    accountIds.add(oldContactsMap.get(con.Id).AccountId);
                }
            }
            // get aggregate result for all accounts
            List<AggregateResult> results = [
                SELECT AccountId, COUNT(Id) totalContacts
                FROM Contact
                WHERE Active__c = TRUE AND AccountId IN :accountIds
                GROUP BY AccountId
            ];
            // build final list of accounts to update
            List<Account> accountsToUpdate = new List<Account>();
            for (AggregateResult result : results) {
                // get account id and number of active contacts
                String accId = String.valueOf(result.get('AccountId'));
                Integer totalContacts = Integer.valueOf(result.get('totalContacts'));
                // make sure you use Id feild in your account to update it
                Account acc = new Account(Id = accId, Active_Contacts__c = totalContacts);
                accountsToUpdate.add(acc);
            }
            // update the final list of account
            update accountsToUpdate;
    
  }



}



       