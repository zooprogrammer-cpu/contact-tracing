public with sharing class CTLocationTracingController {

    //Get last 30 days visitors
  public static List<Location_Tracing__c> getVisitors(String locationId) {
    return [
      SELECT
        Id,
        Person__c,
        Person__r.Name,
        Person__r.Token__c,
        Person__r.Health_Status__c,
        Location__c,
        Visit_Date__c
      FROM Location_Tracing__c
      WHERE Id = :locationId
      ORDER BY Visit_Date__c DESC
    ];
  }

// Get all location ids for Visitors
  public static List<Location_Tracing__c> getLocationsByPersonIds(Set<Id> personIds) {
    return [
      SELECT Id, Person__c, Location__c, Visit_Date__c
      FROM Location_Tracing__c
      WHERE Person__c IN :personIds AND Visit_Date__c < LAST_N_DAYS:10
    ];
  }

  //Get all vistor ids for locations

  public static List<Location_Tracing__c> getLocationsByLocationIds(Set<Id> locationIds) {
    return [
      SELECT Id, Person__c, Location__c, Visit_Date__c
      FROM Location_Tracing__c
      WHERE Location__c IN: locationIds 
      AND Person__r.Health_Status__c= 'Green' 
      AND Visit_Date__c < LAST_N_DAYS:10
    ];
  }
}
