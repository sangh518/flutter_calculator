import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calculator/viewmodels/theme_viewmodel.dart';
import 'package:provider/provider.dart';

class ThemeAppBar {
  static AppBar getAppBar(BuildContext context) {
    var viewmodel = context.watch<ThemeViewModel>();

    return AppBar(
      actions: [
        Row(
          children: kThemeSeedColors
              .map((e) => _buildSeedColorButton(e, context))
              .toList(),
        ),
        const SizedBox(width: 10),
        CupertinoSwitch(
          value: viewmodel.brightness == Brightness.light,
          onChanged: (value) {
            viewmodel.brightness = value ? Brightness.light : Brightness.dark;
          },
          activeColor: Theme.of(context).colorScheme.primary,
          trackColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  static Widget _buildSeedColorButton(Color color, BuildContext context) {
    var viewmodel = context.watch<ThemeViewModel>();
    return GestureDetector(
      onTap: () {
        viewmodel.seedColorIndex = kThemeSeedColors.indexOf(color);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: CircleAvatar(
          radius: 16,
          backgroundColor: color,
          child: viewmodel.seedColor == color
              ? const Icon(
                  Icons.check,
                  size: 16.0,
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
  }
}
