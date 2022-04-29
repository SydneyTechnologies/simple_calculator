import 'package:flutter/material.dart';

class CalculatorBrain extends ChangeNotifier {
  String entryValue = "";
  List<String> currentCalculation = [];
  List<String> actions = ["+", "-", "×", "÷", "%"];
  List<String> specialActions = ["AC", "+/-", "="];
  List<String> fullActions = ["AC", "+/-", "=", "+", "-", "×", "÷", "%"];
  void addNumber(double newNumber, {bool decimalNumber = false}) {
    if (currentCalculation.isNotEmpty) {
      //if there is some character in the current calculation
      if (fullActions.contains(currentCalculation.last) == false) {
        //check if the last character was a number or an operation,
        //if it is a number
        //remove the last number and append the new number to form a larger number
        var lastValue = currentCalculation.removeLast();
        //debugPrint(lastValue + newNumber.toString());
        //this will print the bigger number
        if (decimalNumber) {
          currentCalculation.add(lastValue + ".");
        } else {
          currentCalculation.add(lastValue + newNumber.toInt().toString());
        }

        //then append the larger number to the list
      } else {
        //if the last character in the current calculation is an operation
        //then just add the new number
        currentCalculation.add(rectifyValue(newNumber.toString()));
      }
    } else {
      //if there was no previous value in the calculation then add a new number
      currentCalculation.add(rectifyValue(newNumber.toString()));
    }

    debugPrint(newNumber.toString());
    entry();
  }

  void addOperation(String action) {
    if (actions.contains(action)) {
      //check if the input placed is a regular operation
      // if it is a regular action then add the operation to current calculation
      if (currentCalculation.length > 2) {
        //however if the current calculation has three items then perform a calculation
        calculate();
      }
      currentCalculation.add(action);
    } else if (specialActions.contains(action)) {
      //if the input placed is a special operation/action then act accordingly
      if (action == "=") {
        debugPrint("calculate the operation");
        debugPrint("list length" + currentCalculation.length.toString());
        calculate();
      } else if (action == "AC") {
        currentCalculation.clear();
      }
    }

    entry();
  }

  void calculate() {
    double result = 0;
    if (currentCalculation.length > 2) {
      if (currentCalculation.contains("+")) {
        result = addition(double.parse(currentCalculation[0]),
            double.parse(currentCalculation[2]));
        debugPrint(currentCalculation.toString());
        currentCalculation.clear();
        currentCalculation.add(rectifyValue(result.toString()));
      }

      if (currentCalculation.contains("-")) {
        debugPrint(actions.contains("-").toString());
        result = subtration(double.parse(currentCalculation[0]),
            double.parse(currentCalculation[2]));
        debugPrint(currentCalculation.toString());
        currentCalculation.clear();
        currentCalculation.add(rectifyValue(result.toString()));
      }
      if (currentCalculation.contains("×")) {
        result = multiplication(double.parse(currentCalculation[0]),
            double.parse(currentCalculation[2]));
        debugPrint(currentCalculation.toString());
        debugPrint(result.toString());
        currentCalculation.clear();
        currentCalculation.add(rectifyValue(result.toString()));
      }
      if (currentCalculation.contains("÷")) {
        result = division(double.parse(currentCalculation[0]),
            double.parse(currentCalculation[2]));
        debugPrint(currentCalculation.toString());
        currentCalculation.clear();
        currentCalculation.add(rectifyValue(result.toString()));
      }
      if (currentCalculation.contains("%")) {}
    }
  }

  String rectifyValue(String value) {
    String rectifiedValue = "";
    if (value.contains(".0")) {
      debugPrint("it has");
      rectifiedValue = value.replaceAll(".0", '');
    } else {
      rectifiedValue = value;
    }
    return rectifiedValue;
  }

  void entry() {
    entryValue = currentCalculation.join();
    notifyListeners();
  }

  double multiplication(numberOne, numberTwo) {
    double result = numberOne * numberTwo;
    return result;
  }

  double division(numberOne, numberTwo) {
    double result = numberOne / numberTwo;
    return result;
  }

  double addition(numberOne, numberTwo) {
    double result = numberOne + numberTwo;
    return result;
  }

  double subtration(numberOne, numberTwo) {
    double result = numberOne - numberTwo;
    return result;
  }
}
