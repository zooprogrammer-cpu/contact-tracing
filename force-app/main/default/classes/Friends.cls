public with sharing class Friends {
  final Integer ONE_SLICE = 8;
  final Integer UPTO_THREE_SLICES = 7;
  final Integer MORE_THAN_THREE_SLICES = 6;

  public Integer getBill(Integer numberOfSlices) {
    Integer billToPay = numberOfSlices == 1 ? (ONE_SLICE * numberOfSlices) :
                        numberOfSlices <= 3 ? (UPTO_THREE_SLICES * numberOfSlices) : 
                            (MORE_THAN_THREE_SLICES * numberOfSlices);
    return billToPay;
  }
}