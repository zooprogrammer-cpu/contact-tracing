public with sharing class CTPersonTriggerHandler {
  //Before insert function for Person__c Object
  public static void beforeInsert(List<Person__c> newRecords) {
    for (Person__c person : newRecords) {
      //Update health status to green
      person.Health_Status__c = 'Green';
      //Generate unique token for the person record
      person.Token__c = CTPersonController.getToken(person.Mobile__c);
    }
  }
  //Before update operation for Person__c object
  //need to use oldMap to check if the status field really updated or not
  public static void beforeUpdate(
    List<Person__c> newRecords,
    Map<Id, Person__c> oldRecordsMap
  ) {
    for (Person__c person : newRecords) {
      // check if the status changed in thie transaction
      // if the new value is not equal to old value, then we will update the status date
      if (
        person.Health_Status__c != oldRecordsMap.get(person.id).Health_Status__c
      ) {
        person.Status_Update_Date__c = Date.today();
      }
    }
  }
}
