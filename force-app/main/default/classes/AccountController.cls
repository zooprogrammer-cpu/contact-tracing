public class AccountController {
  public static Account insertAccount(Account accountToInsert) {
    insert accountToInsert;
    return accountToInsert;
  }

  public static List<Account> addAccounts() {
    List<Account> accountsToAdd = new List<Account>();
    Account acc6 = new Account(Name = 'Test Account 6', Phone = '23432432');
    Account acc7 = new Account(Name = 'Test Account 7', Phone = '543534544');
    Account acc8 = new Account(Name = 'Test Account 8', Phone = '2342342343');
    Account acc9 = new Account(Name = 'Test Account 9', Phone = '546546546');

    accountsToAdd.add(acc6);
    accountsToAdd.add(acc7);
    accountsToAdd.add(acc8);
    accountsToAdd.add(acc9);

    return accountsToAdd;
  }

  public static List<Account> insertAccounts() {
    List<Account> accounts = addAccounts();
    insert accounts;
    return accounts;
  }

  public static List<Account> getAllAccounts() {
    // Retreive all accounts and assign to a List Collection
    List<Account> accounts = [SELECT Id, Name, Phone FROM Account];
    return accounts;
  }
  //using void here since we are not returning anything
  public static void printAllAccounts() {
    // Retreive all accounts and assign to a List Collection
    List<Account> accounts = getAllAccounts();
    // iterate over all accounts and print account information
    for (Account account : accounts) {
      System.debug(
        'Account Name: ' +
        account.Name +
        ' Account Phone: ' +
        account.Phone
      );
    }
  }

  public static Integer getAccountSize() {
    List<Account> accounts = getAllAccounts();
    return accounts.size();
  }

  public static List<Account> getAccountsToUpdate() {
    // Retreive all accounts and assign to a List Collection
    List<Account> accounts = [
      SELECT Id, Name, Phone
      FROM Account
      WHERE Name = 'sForce'
    ];
    return accounts;
  }

  public static void updateAccounts() {
    // Retreive all accounts and assign to a List Collection
    List<Account> accounts = getAccountsToUpdate();
    for (Account account : accounts) {
      account.Name = 'sForce';
      account.Rating = 'Warm';
    }
    //update accounts;
    //OR
    Database.update(accounts, true);
  }

  //Bulkification challenge
  public static void updateAvgCaseResolutionDays(List<Id> accountIds) {
    // Make new maps to store total cases and total days for each account
    Map<Id, Integer> accountTotalCaseMap = new Map<Id, Integer>();
    Map<Id, Integer> accountTotalCaseDaysMap = new Map<Id, Integer>();

    // retrive all the cases for this account
    // get resolution days for each account (ClosedDate - CreatedDate)
    for (Case caseObj : [
      SELECT Id, CreatedDate, ClosedDate, AccountId
      FROM Case
      WHERE IsClosed = true AND AccountId IN :accountIds
    ]) {
      // if map does not have current account id, then add it
      if (!accountTotalCaseMap.containsKey(caseObj.AccountId)){
        accountTotalCaseMap.put(caseObj.AccountId, 0);
        accountTotalCaseDaysMap.put(caseObj.AccountId, 0);  
      }

      //get total number of cases for the map
      Integer totalCases = accountTotalCaseMap.get(caseObj.AccountId);
      //increment count
      accountTotalCaseMap.put(caseObj.AccountId, totalCases + 1);

      // get duration in days and add it to totalDays
      Integer totalDays = accountTotalCaseDaysMap.get(caseObj.AccountId);
      totalDays += caseObj.CreatedDate.date()
        .daysBetween(caseObj.ClosedDate.date());
      accountTotalCaseDaysMap.put(caseObj.AccountId, totalDays + caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date()));
    }

    //list of accounts to update
    List <Account> accountsToUpdate = new List<Account>();
    for (Id accountId: accountTotalCaseMap.keySet()){
      Decimal resolutionDays = accountTotalCaseDaysMap.get(accountId) / accountTotalCaseMap.get(accountId);
      //update account Object
      accountsToUpdate.add(new Account(Id= accountId, Avg_Case_Resolution_Days__c = resolutionDays));
    }

    // update account objects
    update accountsToUpdate;
  }
}