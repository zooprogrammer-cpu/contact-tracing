@isTest
public class HealthCalculatorTest {
    @isTest
    public static void calculateBMITest1() {
        //HealthCalculator ashHealth = new HealthCalculator();
        Decimal weight = 60;
        Decimal height = 1.2;
        Decimal result = HealthCalculator.calculateBMI(weight,height);
        result = result.setScale(2);
        System.assertEquals(41.67, result, 'BMI should be 41.67 for 60 kg wight and 1.2 mtr height'); 
    }

    @isTest
    public static void calculateBMITest2() {
        Decimal weight = 0;
        Decimal height = 1.2;
        Decimal result = HealthCalculator.calculateBMI(weight,height);
        System.assertEquals(0, result, 'BMI should be 0 for 0 kg wight and 1.2 mtr height');  
    }

    @isTest
    public static void calculateBMITest3() {
        Decimal weight = 60;
        Decimal height = 0;
        Decimal result = HealthCalculator.calculateBMI(weight,height);
        System.assertEquals(-1, result, 'Invalid Input');
    }

    @isTest
    public static void calculateBMITest4() {
        Decimal weight = -60;
        Decimal height = 1.2;
        Decimal result = HealthCalculator.calculateBMI(weight,height);
        System.assertEquals(-1, result, 'Invalid Input');
    }


    @isTest
    public static void calculateBMITest5() {
        Decimal weight = 60;
        Decimal height = -1.2;
        Decimal result = HealthCalculator.calculateBMI(weight,height);
        System.assertEquals(-1, result, 'Invalid Input');
    }

    @isTest
    public static void calculatePaceTest1() {
        Decimal distance = 10;
        Decimal minutes = 60;
        Decimal result = HealthCalculator.calculatePace(distance, minutes);
        System.assertEquals(10,result,'Pace should be 10 for distance of 10 and 60 minutes');    
    }

    @isTest
    public static void calculatePaceTest2() {
        Decimal distance = 10;
        Decimal minutes = 0;
        Decimal result = HealthCalculator.calculatePace(distance, minutes);
        System.assertEquals(-1,result,'Invalid Input');    
    }

    @isTest
    public static void calculatePaceTest3() {
        Decimal distance = 0;
        Decimal minutes = 60;
        Decimal result = HealthCalculator.calculatePace(distance, minutes);
        System.assertEquals(0,result,'Pace should be 0 for distance of 0 and 60 minutes');    
    }

    @isTest
    public static void calculatePaceTest4() {
        Decimal distance = -10;
        Decimal minutes = 60;
        Decimal result = HealthCalculator.calculatePace(distance, minutes);
        System.assertEquals(-1,result,'Invalid Input');    
    }

    @isTest
    public static void calculatePaceTest5() {
        Decimal distance = 10;
        Decimal minutes = -60;
        Decimal result = HealthCalculator.calculatePace(distance, minutes);
        System.assertEquals(-1,result,'Invalid Input');    
    }

}