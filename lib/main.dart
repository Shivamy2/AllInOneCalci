import 'package:AllInOneCalci/route_generator.dart';
import 'package:flutter/material.dart';

import 'customAppBar.dart';

void main() {
  runApp(MaterialApp(
    title: 'All In One Calci',
    initialRoute: '/',
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}

class AppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var AppBarHeight = MediaQuery.of(context).size.height;
    var AppBarWidth = MediaQuery.of(context).size.width;

    Widget CustomCardView(String titleString, String bodyString, String path) {
      return Container(
        decoration: new BoxDecoration(
            color: Colors.cyan[200],
            borderRadius: BorderRadius.all(Radius.circular(40.0))),
        height: (AppBarHeight / 4) * 1.5,
        width: (AppBarWidth / 2) * 1.7,
        child: new Card(
          shadowColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  titleString,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DancingScript',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    bodyString,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      color: Colors.redAccent,
                      elevation: 10.0,
                      splashColor: Colors.redAccent,
                      child: Container(
                        width: 60.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Load',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19.0,
                                  fontFamily: 'DancingScript'),
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(path);
                      }),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: customAppBar(
        height: (AppBarHeight / 3) * 0.4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text(
                'All In One Cali',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35.0,
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CustomCardView('BMI Calculator', 'This is BMI Calculator',
                          '/BMICalcUI'),
                      CustomCardView('Age Calculator', 'This is Age Calculator',
                          '/AgeCalcUI'),
                      CustomCardView('Love Calculator',
                          'This is Love Calculator', '/LoveCalUI'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
