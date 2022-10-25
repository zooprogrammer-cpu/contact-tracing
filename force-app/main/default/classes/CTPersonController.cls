public with sharing class CTPersonController {
  public static String getToken(String mobileNo) {
    // generate unique hash using md5 algorithm
    Blob value = Blob.valueOf(mobileNo);
    Blob hash = Crypto.generateDigest('MD5', value);

    //get the string value of has blob
    return EncodingUtil.base64Encode(hash);
  }

  // get 100 contacts with recent health status change
  public static List<Person__c> getRecentHealthChanges() {
    return [
      SELECT
        Id,
        Name,
        Health_Status__c,
        Mobile__c,
        Status_Update_Date__c,
        Token__c
      FROM Person__c
      ORDER BY Status_Update_Date__c DESC NULLS LAST
      LIMIT 100
    ];
  }

  // search contacts matching Name, Mobile or Token
  public static List<Person__c> searchPeople(String searchTerm) {
    searchTerm = searchTerm + '%';
    return [
      SELECT
        Id,
        Name,
        Health_Status__c,
        Mobile__c,
        Status_Update_Date__c,
        Token__c
      FROM Person__c
      WHERE
        Name LIKE :searchTerm
        OR Token__c LIKE :searchTerm
        OR Mobile__c LIKE :searchTerm
      ORDER BY Status_Update_Date__c DESC NULLS LAST
    ];
  }

  // query a person record where Id matches the personId parameter
  public static Person__c getPersonById(String personId) {
    List<Person__c> people = [
      SELECT
        Id,
        Name,
        Health_Status__c,
        Mobile__c,
        Status_Update_Date__c,
        Token__c
      FROM Person__c
      WHERE Id = :personId
    ];

    if (people != null && people.size() > 0) {
      return people[0];
    }
    //if no people found on the list, return null
    return null;
  }

  public static Map<String, Integer> getHealthStatusCount() {
    //using total to alias COUNT(Id)
    Map<String, Integer> healthCountMap = new Map<String, Integer>();
    for (AggregateResult ar : [
      SELECT Health_Status__c, COUNT(Id) total
      FROM Person__c
      GROUP BY Health_Status__c
    ]) {
      //need to type cast the Health Status and total before adding to the map 
      String healthStatus = String.valueOf(ar.get('Health_Status__c'));
      Integer count = Integer.valueOf(ar.get('total'));
      healthCountMap.put(healthStatus, count);
    }
    return healthCountMap; 
  }
}
