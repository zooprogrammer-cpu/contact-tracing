public class ContactTriggerHandler {
  public static Boolean alreadyExecuted = false;

  public static void afterInsertHandler(List<Contact> newContacts) {
    // build a uniqueAccountIds set
    Set<Id> uniqueAccountIds = new Set<Id>();
    // iterate over all contacts that we get in Trigger.new
    for (Contact con : newContacts) {
      if (String.isNotBlank(con.AccountId)) {
        String accountId = con.AccountId;
        uniqueAccountIds.add(accountId);
        // find contact records that have Active checkbox checked 
        // and have AccountId in the uniqueAccountIds set
        List<AggregateResult> results = [
          SELECT AccountId, COUNT(Id) totalContacts
          FROM Contact
          WHERE Active__c = TRUE AND AccountId IN :uniqueAccountIds
          GROUP BY AccountId
        ];

        // Build accounts list we need to update
        List<Account> accountsToUpdate = new List<Account>();

        for (AggregateResult result : results) {
          // get account id and number of active contacts
          String accId = String.valueOf(result.get('AccountId'));
          Integer totalAccounts = Integer.valueOf(result.get('totalContacts'));

          Account acc = new Account(
            Id = accId,
            Active_Contacts__c = totalAccounts
          );
          accountsToUpdate.add(acc);
        }
        update accountsToUpdate;
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
