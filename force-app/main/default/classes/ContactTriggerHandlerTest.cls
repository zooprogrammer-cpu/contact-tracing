@isTest
public with sharing class ContactTriggerHandlerTest {
    // first test without any Active Contacts
  @isTest
  public static void afterInsertHandlerTest1() {
    List<Account> testAccounts = new List<Account>();
    testAccounts.add(new Account(Name = 'Test Account 1'));
    testAccounts.add(new Account(Name = 'Test Account 2'));
    insert testAccounts; 

    List<Contact> testContacts = new List<Contact>();
    testContacts.add(new Contact(LastName= 'Test Last 1', AccountId= testAccounts[0].Id));
    testContacts.add(new Contact(LastName= 'Test Last 2', AccountId= testAccounts[0].Id));
    testContacts.add(new Contact(LastName= 'Test Last 3', AccountId= testAccounts[0].Id));
    testContacts.add(new Contact(LastName= 'Test Last 4', AccountId= testAccounts[0].Id));
    testContacts.add(new Contact(LastName= 'Test Last 5', AccountId= testAccounts[1].Id));
    // this is going to call ContactTriggerHandler and afterInsertHandler method will run 
    // and then updateActiveContacts from AccountContactService class will be called
    insert testContacts; 
    //In the test data above, we have not checked the Active checkbox true. 
    //In order to get the active contact field value, we need to do a SOQL query
    //When you write SOQL query in TEST class, it does not query the org for the data, just the test data
    List<Account> accs = [SELECT Id, Active_Contacts__c FROM Account];
    // Let's check the List size with assert
    System.assertEquals(2, accs.size());
    // Assert on the Active Contacts, we are expecting 0 Active Contacts for First Account and Second Account
    System.assertEquals(0, accs[0].Active_Contacts__c);
    System.assertEquals(0, accs[1].Active_Contacts__c);

    //Assert for 5 contacts size
    List<Contact> allContacts = [SELECT Id FROM Contact];
    System.assertEquals(5, allContacts.size());
  }

  // Another test with Active Contact checked
  public static void afterInsertHandlerTest2() {
    List<Account> testAccounts = new List<Account>();
    testAccounts.add(new Account(Name = 'Test Account 1'));
    testAccounts.add(new Account(Name = 'Test Account 2'));
    insert testAccounts; 

    List<Contact> testContacts = new List<Contact>();
    testContacts.add(new Contact(LastName= 'Test Last 1', AccountId= testAccounts[0].Id, Active__c = true));
    testContacts.add(new Contact(LastName= 'Test Last 2', AccountId= testAccounts[0].Id, Active__c = true));
    testContacts.add(new Contact(LastName= 'Test Last 3', AccountId= testAccounts[0].Id));
    testContacts.add(new Contact(LastName= 'Test Last 4', AccountId= testAccounts[0].Id));
    testContacts.add(new Contact(LastName= 'Test Last 5', AccountId= testAccounts[1].Id));
    // this is going to call ContactTriggerHandler and afterInsertHandler method will run 
    // and then updateActiveContacts from AccountContactService class will be called
    insert testContacts; 
    //In the test data above, we have not checked the Active checkbox true. 
    //In order to get the active contact field value, we need to do a SOQL query
    //When you write SOQL query in TEST class, it does not query the org for the data, just the test data
    List<Account> accs = [SELECT Id, Active_Contacts__c FROM Account];
    // Let's check the List size with assert
    System.assertEquals(2, accs.size());
    // Assert on the Active Contacts, we are expecting 2 Active Contacts for First Account and 0 Second Account

    for (Account acc : accs) {
        if(acc.Name == 'Test Account 1'){
            System.assertEquals(2, acc.Active_Contacts__c);
        }
        if(acc.Name == 'Test Account 2'){
            System.assertEquals(0, acc.Active_Contacts__c);
        }
    }
   
    //Assert for 5 contacts size
    List<Contact> allContacts = [SELECT Id FROM Contact];
    System.assertEquals(5, allContacts.size());
  }

}
