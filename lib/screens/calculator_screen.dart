import 'package:flutter/material.dart';
import 'package:flutter_calculator/widgets/header_display.dart';
import 'package:flutter_calculator/widgets/input_pad.dart';
import 'package:flutter_calculator/widgets/theme_app_bar.dart';

const kSidePadding = 14.0;

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar.getAppBar(context),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Expanded(child: HeaderDisplay()),
          InputPad(),
          SizedBox(height: kSidePadding),
        ],
      ),
    );
  }
}
