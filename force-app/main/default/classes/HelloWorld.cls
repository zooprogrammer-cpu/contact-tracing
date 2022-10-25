public class HelloWorld {
  public void printMessage(String msg) {
    System.debug(msg);
  }

  public String getDay(Integer dayNumber) {
    String dayString = '';
    switch on dayNumber {
      when 0 {
        dayString = 'Sunday';
      }
      when 1 {
        dayString = 'Monday';
      }
      when 2 {
        dayString = 'Tuesday';
      }
      when 3 {
        dayString = 'Wednesday';
      }
      when 4 {
        dayString = 'Thursday';
      }
      when 5 {
        dayString = 'Friday';
      }
      when 6 {
        dayString = 'Saturday';
      }
      when else {
        dayString = 'Invalid day number'; 
      }
    }
    return dayString;
  }

  public String getDay(String dayAbbreviation){
    String dayString = '';
    switch on dayAbbreviation {
      when 'SUN' {
        dayString = 'Sunday';
      }
      when 'MON' {
        dayString = 'Monday';
      }
      when 'TUE' {
        dayString = 'Tuesday';
      }
      when 'WED' {
        dayString = 'Wednesday';
      }
      when 'THU' {
        dayString = 'Thursday';
      }
      when 'FRI' {
        dayString = 'Friday';
      }
      when 'SAT' {
        dayString = 'Saturday';
      }
      when else {
        dayString = 'Invalid day number'; 
      }
    }
    return dayString;
  }
}