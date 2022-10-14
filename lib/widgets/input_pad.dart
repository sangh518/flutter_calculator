import 'package:flutter/material.dart';
import 'package:flutter_calculator/models/input_type.dart';
import 'package:flutter_calculator/screens/calculator_screen.dart';
import 'package:flutter_calculator/widgets/input_button.dart';

const _inputPadOrder = [
  InputType.clear,
  InputType.delete,
  InputType.percent,
  InputType.division,
  InputType.number7,
  InputType.number8,
  InputType.number9,
  InputType.multiplication,
  InputType.number4,
  InputType.number5,
  InputType.number6,
  InputType.subtraction,
  InputType.number1,
  InputType.number2,
  InputType.number3,
  InputType.addition,
  InputType.number0,
  InputType.point,
  InputType.equality,
];

class InputPad extends StatelessWidget {
  const InputPad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 2 * kSidePadding;
    var buttonsSize = width / 4 * 0.9;
    var buttonSpace = (width - buttonsSize * 4) / 3;

    return Wrap(
      spacing: buttonSpace,
      runSpacing: buttonSpace,
      children: _inputPadOrder
          .map(
            (e) => InputButton(
              inputType: e,
              size: e == InputType.number0
                  ? Size(buttonsSize * 2 + buttonSpace, buttonsSize)
                  : Size(buttonsSize, buttonsSize),
            ),
          )
          .toList(),
    );
  }
}
