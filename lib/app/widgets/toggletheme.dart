import 'package:easycount/app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme.dart';

class ToggleTheme extends StatefulWidget {
  const ToggleTheme({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<ToggleTheme> {
  List<bool> isSelected = [
    true,
    false
  ]; // Initial state for light mode selected

  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // Access ThemeProvider

    // Update the selection based on the current theme
    isSelected = [
      themeProvider.themeData == LightMode,
      themeProvider.themeData == DarkMode
    ];

    return ToggleButtons(
      isSelected: isSelected,
      children: const [
        Icon(Icons.light_mode),
        Icon(Icons.dark_mode),
      ],
      onPressed: (int index) {
        setState(() {
          // Update selection state
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == index;
          }

          // Switch the theme based on index
          if (index == 0 && themeProvider.themeData != LightMode) {
            // Switch to light mode
            themeProvider.toggleTheme();
          } else if (index == 1 && themeProvider.themeData != DarkMode) {
            // Switch to dark mode
            themeProvider.toggleTheme();
          }
        });
      },
    );
  }
}
