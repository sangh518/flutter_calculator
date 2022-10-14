import 'package:flutter/material.dart';
import 'package:flutter_calculator/viewmodels/calculator_viewmodel.dart';
import 'package:provider/provider.dart';

class HeaderDisplay extends StatelessWidget {
  const HeaderDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewmodel = context.watch<CalculatorViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Spacer(),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerRight,
          child: Text(
            viewmodel.inputHeaderText,
            style: TextStyle(
              fontSize: 70,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
