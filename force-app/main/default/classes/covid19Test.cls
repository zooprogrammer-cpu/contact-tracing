@isTest
public class covid19Test {
    @isTest
    public static void treatPatientTest() {
        //create the instance of the class
        covid19 dubuque = new covid19(10); 

        //check if the recoveredInArea is 10 or not
        Integer treated = dubuque.getTreated();
        System.assertEquals(10, treated, 'Treated count does not match');

   
        //create the instance of the class
        covid19 madison = new covid19(112);

        //check if the recoveredInArea is 112 or not
        treated = madison.getTreated();
        System.assertEquals(112, treated, 'Treated count does not match');

        //check the count of reoveredInCountry, it should be 122
        System.assertEquals(122, covid19.recoveredInCountry, 'Treated cound does not match');

        dubuque.treatPatient();
        treated = dubuque.getTreated();
        System.assert(treated == 11, 'Treated cound does not match');
        System.assert(covid19.recoveredInCountry == 123, 'Treated cound does not match');

    }

    @isTest
    public static void treatPatientTestNegative() {
        //create the instance of the class
        covid19 dubuque = new covid19(-10); 

        //check if the recoveredInArea is 0 or not
        Integer treated = dubuque.getTreated();
        System.assertEquals(0, treated, 'Treated count does not match');



    }
}