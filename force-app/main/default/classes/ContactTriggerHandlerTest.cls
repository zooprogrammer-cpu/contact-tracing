@isTest
public with sharing class ContactTriggerHandlerTest {
    @TestSetup
    static void makeData(){
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
    }
  
  // Another test with Active Contact checked
  @isTest
  public static void afterInsertHandlerTest2() {
    //In the test data above, we have not checked the Active checkbox true. 
    //In order to get the active contact field value, we need to do a SOQL query
    //When you write SOQL query in TEST class, it does not query the org for the data, just the test data
    List<Account> accs = [SELECT Id, Name, Active_Contacts__c FROM Account];
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

  // Another test for Bulk Contacts - inserting 1000 contacts as Active
  @isTest
  public static void afterInsertHandlerTestBulk() {
    Account testAccount1 = [SELECT Id FROM Account WHERE Name = 'Test Account 1' ];

    List<Contact> testContacts = new List<Contact>();
    for (Integer i = 0; i < 1000; i++) {
        testContacts.add(new Contact(LastName= 'Test Last ' + i, AccountId= testAccount1.Id, Active__c = true));
    }
   
    // this is going to call ContactTriggerHandler and afterInsertHandler method will run 
    // and then updateActiveContacts from AccountContactService class will be called
    insert testContacts; 
    //In the test data above, we have not checked the Active checkbox true. 
    //In order to get the active contact field value, we need to do a SOQL query
    //When you write SOQL query in TEST class, it does not query the org for the data, just the test data
    List<Account> accs = [SELECT Id, Name, Active_Contacts__c FROM Account];
    // Let's check the List size with assert
    System.assertEquals(2, accs.size());
    // Assert on the Active Contacts, we are expecting 2 Active Contacts for First Account and 0 Second Account

    for (Account acc : accs) {
        if(acc.Name == 'Test Account 1'){
            System.assertEquals(1002, acc.Active_Contacts__c);
        }
        if(acc.Name == 'Test Account 2'){
            System.assertEquals(0, acc.Active_Contacts__c);
        }
    }
   
    //Assert for 5 contacts size
    List<Contact> allContacts = [SELECT Id FROM Contact];
    System.assertEquals(1005, allContacts.size());
  }

  // first test for afterUpdateHandler when two contacts will be updated to Active

  @isTest
  public static void afterUpdateHandlerTest1() {
    //Rertieve contacts and update some as active
    List<Contact> allContacts = [SELECT Id, LastName FROM Contact];
    for (Contact con : allContacts) {
        if (con.LastName == 'Test Last 3' || con.LastName == 'Test Last 4') {
            con.Active__c = true;     
        }
    }
    //allocated new set of Governor Limits
    Test.startTest(); 
    update allContacts; 
    Test.stopTest(); 

    List<Account> accs = [SELECT Id, Name, Active_Contacts__c FROM Account];
    // Let's check the List size with assert
    System.assertEquals(2, accs.size());

    for (Account acc : accs) {
        if(acc.Name == 'Test Account 1'){
            System.assertEquals(4, acc.Active_Contacts__c);
        }
        if(acc.Name == 'Test Account 2'){
            System.assertEquals(0, acc.Active_Contacts__c);
        }
    }
   
    //Assert for 5 contacts size
    System.assertEquals(5, allContacts.size());
  }

  //second test for updateHandler method where the accountId is going to changed
  // and the active checkbox is going to be changed. 
  @isTest
  public static void afterUpdateHandlerTest2() { 
    //Rertieve a contact and update it as active and change the accountId
    List<Contact> allContacts = [SELECT Id, LastName FROM Contact];
    Account testAccount2 = [SELECT Id FROM Account WHERE Name = 'Test Account 2'];
    for (Contact con : allContacts) {
        if (con.LastName == 'Test Last 3') {
            con.Active__c = true;
            con.AccountId = testAccount2.Id;     
        }
    }
    //allocated new set of Governor Limits
    Test.startTest(); 
    update allContacts; 
    Test.stopTest(); 

    List<Account> accs = [SELECT Id, Name, Active_Contacts__c FROM Account];
    // Let's check the List size with assert
    System.assertEquals(2, accs.size());

    for (Account acc : accs) {
        if(acc.Name == 'Test Account 1'){
            System.assertEquals(2, acc.Active_Contacts__c);
        }
        if(acc.Name == 'Test Account 2'){
            System.assertEquals(1, acc.Active_Contacts__c);
        }
    }
   
    //Assert for 5 contacts size
    System.assertEquals(5, allContacts.size());
  }

}
