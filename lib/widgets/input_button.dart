import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calculator/models/input_type.dart';
import 'package:flutter_calculator/viewmodels/calculator_viewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

const _kTextButtonPadding = 0.2;
const _kIconButtonPadding = 0.3;

enum _InputButtonColorType {
  primary,
  secondary,
  normal,
}

class InputButton extends StatelessWidget {
  const InputButton({
    Key? key,
    required this.inputType,
    required this.size,
  }) : super(key: key);
  final InputType inputType;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: MaterialButton(
        textColor: _getForegroundColor(context),
        onPressed: () => _onPressButton(context),
        padding: EdgeInsets.zero,
        highlightColor: _getHighlightColor(context),
        color: _getButtonColor(context),
        highlightElevation: 0,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.height / 2),
        ),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: _getSymbol(),
        ),
      ),
    );
  }

  void _onPressButton(BuildContext context) {
    var viewmodel = context.read<CalculatorViewModel>();
    viewmodel.onPressButton(
      inputType: inputType,
      onTextOverflow: () {
        showDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            content: const Text('You can\'t enter more than 18 characters.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _getSymbol() {
    switch (inputType) {
      case InputType.point:
        return _getTextSymbol('.');
      case InputType.addition:
        return _getIconSymbol(FontAwesomeIcons.plus);
      case InputType.subtraction:
        return _getIconSymbol(FontAwesomeIcons.minus);
      case InputType.multiplication:
        return _getIconSymbol(FontAwesomeIcons.xmark);
      case InputType.division:
        return _getIconSymbol(FontAwesomeIcons.divide);
      case InputType.equality:
        return _getIconSymbol(FontAwesomeIcons.equals);
      case InputType.clear:
        return _getTextSymbol('C');
      case InputType.delete:
        return _getIconSymbol(FontAwesomeIcons.deleteLeft);
      case InputType.percent:
        return _getIconSymbol(FontAwesomeIcons.percent);
      default:
        return _getTextSymbol(inputType.name.replaceFirst('number', ''));
    }
  }

  Widget _getIconSymbol(IconData iconData) {
    return Padding(
      padding: EdgeInsets.all(size.height * _kIconButtonPadding),
      child: FittedBox(child: FaIcon(iconData)),
    );
  }

  Widget _getTextSymbol(String text) {
    return Padding(
      padding: EdgeInsets.all(size.height * _kTextButtonPadding),
      child: FittedBox(
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  _InputButtonColorType _getColorType() {
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
      case InputType.point:
        return _InputButtonColorType.normal;
      case InputType.addition:
      case InputType.subtraction:
      case InputType.multiplication:
      case InputType.division:
      case InputType.equality:
        return _InputButtonColorType.primary;
      case InputType.clear:
      case InputType.delete:
      case InputType.percent:
        return _InputButtonColorType.secondary;
    }
  }

  Color _getButtonColor(BuildContext context) {
    switch (_getColorType()) {
      case _InputButtonColorType.primary:
        return Theme.of(context).colorScheme.primary;
      case _InputButtonColorType.secondary:
        return Theme.of(context).colorScheme.secondary;
      case _InputButtonColorType.normal:
        return Theme.of(context).colorScheme.surfaceVariant;
    }
  }

  Color _getHighlightColor(BuildContext context) {
    switch (_getColorType()) {
      case _InputButtonColorType.primary:
        return Theme.of(context).colorScheme.primaryContainer;
      case _InputButtonColorType.secondary:
        return Theme.of(context).colorScheme.secondaryContainer;
      case _InputButtonColorType.normal:
        return Theme.of(context).colorScheme.tertiaryContainer;
    }
  }

  Color _getForegroundColor(BuildContext context) {
    switch (_getColorType()) {
      case _InputButtonColorType.primary:
        return Theme.of(context).colorScheme.onPrimary;
      case _InputButtonColorType.secondary:
        return Theme.of(context).colorScheme.onSecondary;
      case _InputButtonColorType.normal:
        return Theme.of(context).colorScheme.onSurfaceVariant;
    }
  }
}
