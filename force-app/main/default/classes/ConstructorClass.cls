public with sharing class ConstructorClass {
    public Integer recoveredInArea = 0;
  
    public static Integer recoveredInCountry = 0;
    // Here we create a new constructor class. Needs to have the same name as the apex class. 
    // This overrides the constructor that apex creates behind the scenes. 
    public ConstructorClass(){
        System.debug('Constructor is called'); 
    }
    // another constructor but with Integer as a parameter
    public ConstructorClass(Integer patientsRecovered){
        System.debug('Second constructor is called');
        recoveredInArea = recoveredInArea;
        recoveredInCountry = recoveredInArea;
    }
  
    public void treatPatient() {
      recoveredInArea++;
      recoveredInCountry++;
    }
  
    public static void printTreated() {
      System.debug('Recovered in country: '+ recoveredInCountry);
    }
}