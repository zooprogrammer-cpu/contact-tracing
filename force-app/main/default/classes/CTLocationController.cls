public with sharing class CTLocationController {
  // Get 100 locations with recent status changes
  public static List<Location__c> getRecentStatusChanges() {
    return [
      SELECT Id, PinCode__c, Address__c, Name
      FROM Location__c
      ORDER BY Status_Update_Date__c DESC NULLS LAST
      LIMIT 100
    ];
  }
  // search location by search term
  public static List<Location__c> searchLocations(String searchTerm) {
    searchTerm = searchTerm + '%';
    return [
      SELECT Id, PinCode__c, Address__c, Name
      FROM Location__c
      WHERE
        Name LIKE :searchTerm
        OR PinCode__c LIKE :searchTerm
        OR Address__c LIKE :searchTerm
      ORDER BY Status_Update_Date__c DESC NULLS LAST
    ];
  }
  // Search location by Id
  public static Location__c getLocationById(String locationId) {
    List<Location__c> location = [
      SELECT Id, PinCode__c, Address__c, Name
      FROM Location__c
      WHERE Id = :locationId
    ];

    if (location !=null && location.size() > 0 ){
        return location[0];
    }
    return null;
  }
}
