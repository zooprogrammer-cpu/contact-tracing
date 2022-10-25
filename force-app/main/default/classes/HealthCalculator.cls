public class HealthCalculator {
  public static Decimal calculateBMI(Decimal weight, Decimal height) {
    if (height <= 0 || weight < 0) {
      return -1;
    } else {
      Decimal bmi = weight / (height * height);
      return bmi;
    }
  }

  public static Decimal calculatePace(Decimal distance, Decimal minutes) {
    if (distance < 0 || minutes <= 0) {
      return -1;
    } else {
      Decimal hr = minutes / 60;
      Decimal pace;
      return pace = distance / hr;
    }
  }
}