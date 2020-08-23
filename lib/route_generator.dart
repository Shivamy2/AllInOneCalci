import 'package:AllInOneCalci/AgeCalcUI.dart';
import 'package:AllInOneCalci/BMICalcUI.dart';
import 'package:AllInOneCalci/LoveCalUI.dart';
import 'package:AllInOneCalci/main.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AppLayout());
        break;
      case '/AgeCalcUI':
        return MaterialPageRoute(
          builder: (_) => AgeCalcUI(),
        );
        break;
      case '/BMICalcUI':
        return MaterialPageRoute(
          builder: (_) => BMICalcUI(),
        );
        break;
      case '/LoveCalUI':
        return MaterialPageRoute(
          builder: (_) => LoveCalUI(),
        );
        break;
      default:
        _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'ERROR',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
