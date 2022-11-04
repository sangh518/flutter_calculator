import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calculator/models/input_type.dart';
import 'package:math_expressions/math_expressions.dart';

const _kMaxInputLength = 15;
const _kMaxDecimalLength = 5;

class CalculatorViewModel extends ChangeNotifier {
  String _inputExpression = '';
  double result = 0;

  String get inputHeaderText => _inputExpression.isEmpty
      ? _doubleToDisplayText(result)
      : _convertOperatorForDisplay(_inputExpression);

  bool get _canAddExpression => _inputExpression.length < _kMaxInputLength;

  void onPressButton({
    required InputType inputType,
    required VoidCallback onTextOverflow,
  }) {
    switch (inputType) {
      case InputType.number0:
      case InputType.number1:
      case InputType.number2:
      case InputType.number3:
      case InputType.number4:
      case InputType.number5:
      case InputType.number6:
      case InputType.number7:
      case InputType.number8:
      case InputType.number9:
        var number = inputType.name.replaceFirst('number', '');
        return _onAddExpression(input: number, onTextOverflow: onTextOverflow);
      case InputType.point:
        return _onAddExpression(input: '.', onTextOverflow: onTextOverflow);
      case InputType.addition:
        return _onAddExpression(input: '+', onTextOverflow: onTextOverflow);
      case InputType.subtraction:
        return _onAddExpression(input: '-', onTextOverflow: onTextOverflow);
      case InputType.multiplication:
        return _onAddExpression(input: '*', onTextOverflow: onTextOverflow);
      case InputType.division:
        return _onAddExpression(input: '/', onTextOverflow: onTextOverflow);
      case InputType.percent:
        return _onAddExpression(input: '%', onTextOverflow: onTextOverflow);
      case InputType.equality:
        return _onPressEquality();
      case InputType.clear:
        return _onPressClear();
      case InputType.delete:
        return _onPressDelete();
    }
  }

  void _onAddExpression({
    required String input,
    required VoidCallback onTextOverflow,
  }) {
    if (!_isNumber(input) && !_isLastInputNumber) {
      _inputExpression =
          _inputExpression.substring(0, _inputExpression.length - 1) + input;
      notifyListeners();
      return;
    }

    if (!_canAddExpression) {
      onTextOverflow.call();
      return;
    }

    if (_inputExpression == '0') {
      _inputExpression = '';
    }

    _inputExpression += input;
    notifyListeners();
  }

  bool get _isLastInputNumber {
    if (_inputExpression.isEmpty) {
      return false;
    }

    var lastInput = _inputExpression[_inputExpression.length - 1];
    return _isNumber(lastInput);
  }

  String _convertOperatorForDisplay(String expression) {
    expression = expression.replaceAll('*', '×');
    expression = expression.replaceAll('/', '÷');
    return expression;
  }

  bool _isNumber(String input) {
    return int.tryParse(input) != null;
  }

  void _onPressClear() {
    _inputExpression = '';
    result = 0;
    notifyListeners();
  }

  void _onPressDelete() {
    _inputExpression =
        _inputExpression.substring(0, _inputExpression.length - 1);
    result = 0;
    notifyListeners();
  }

  void _onPressEquality() {
    if (!_isLastInputNumber) {
      _inputExpression =
          _inputExpression.substring(0, _inputExpression.length - 1);
    }

    _updateExpression();
  }

  void _updateExpression() {
    try {
      Expression exp = Parser().parse(_inputExpression);
      var eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      result = eval;
      _inputExpression = _doubleToDisplayText(result);
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
  }

  String _doubleToDisplayText(double value) {
    if (value.truncateToDouble() == value) {
      return value.truncate().toString();
    } else {
      var text = value.toString();
      var decimalIndex = text.indexOf('.');
      var decimalLength = text.length - decimalIndex - 1;
      if (decimalLength > _kMaxDecimalLength) {
        text = value.toStringAsFixed(_kMaxDecimalLength);
      }

      return text;
    }
  }
}
