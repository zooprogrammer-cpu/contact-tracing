public with sharing class OpportunityController {
  public static void updateProfileValue(List<Id> oppIds) {
    // List<Opportunity> oppLessThan10k = new List<Opportunity>();
    // List<Opportunity> oppMoreThan10kLessThan50k = new List<Opportunity>();
    // List<Opportunity> oppMoreThan50k = new List<Opportunity>();

    List<Opportunity> opps = [
      SELECT Id, Amount, Profile__c
      FROM Opportunity
      WHERE Id IN :oppIds
    ];

    for (Opportunity opp : opps) {
      //get opp record
      if (opp.Amount < 10000) {
        opp.Profile__c = 'Low';
      } else if (opp.Amount > 10000 && opp.Amount < 50000) {
        opp.Profile__c = 'Medium';
      } else if (opp.Amount > 50000) {
        opp.Profile__c = 'High';
      }
    }
    update opps;
  }
}