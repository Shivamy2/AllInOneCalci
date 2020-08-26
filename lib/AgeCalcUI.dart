import 'package:AllInOneCalci/customAppBar.dart';
import 'package:flutter/material.dart';

class AgeCalcUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var AppBarHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: customAppBar(
        height: (AppBarHeight / 3) * 0.4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text(
                'Age Calculator',
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
      body: CustomDatePicker(),
    );
  }
}

enum DateSelection { first, second }

class CustomDatePicker extends StatefulWidget {
  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  //getting the current date
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  DateTime selectedDate = DateTime.now();
  Duration DifferenceTime;

  int parsedTimeResult = 0;

  Future<void> selectDateTime1(
      BuildContext context, DateSelection dateSelection) async {
    final DateTime chosen = await showDatePicker(
      context: context,
      initialDate: selectedDate1,
      firstDate: DateTime(1700),
      lastDate: DateTime(2030),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (chosen != null && chosen != selectedDate2) {
      setState(() {
        switch (dateSelection) {
          case DateSelection.first:
            selectedDate1 = chosen;
            break;
          case DateSelection.second:
            selectedDate2 = chosen;
            break;
        }
      });
    }
  }

  Function TimeSubtraction() {
    setState(() {
      parsedTimeResult = selectedDate2.difference(selectedDate1).inDays;
    });
  }

  //widget for displaying and choosing date onTap
  Widget CustomButtonDatePicker(
      Color ButtonColor, Color TextColor, DateSelection dateSelection) {
    return Column(
      children: [
        Text(
          dateSelection == DateSelection.first
              ? "${selectedDate1.toLocal()}".split(' ')[0]
              : "${selectedDate2.toLocal()}".split(' ')[0],
          style: TextStyle(
            color: TextColor,
            fontSize: 30.0,
            fontFamily: 'DancingScript',
            fontWeight: FontWeight.w900,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            elevation: 10.0,
            onPressed: () {
              selectDateTime1(context, dateSelection);
            },
            color: ButtonColor,
            child: Text(
              'Select',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: (MediaQuery.of(context).size.height) / 2,
          alignment: Alignment.center,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [Colors.black, Colors.redAccent, Colors.black],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft),
            borderRadius: new BorderRadius.circular(30.0),
          ),
          child: Column(
            children: [
              Spacer(
                flex: 2,
              ),
              CustomButtonDatePicker(
                  Colors.cyan, Colors.cyan[200], DateSelection.first),
              Spacer(),
              CustomButtonDatePicker(
                  Colors.cyan, Colors.black, DateSelection.second),
              Spacer(),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 250.0,
          height: 150.0,
          decoration: new BoxDecoration(
              color: Colors.black,
              borderRadius: new BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0))),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                elevation: 10.0,
                onPressed: () {
                  TimeSubtraction();
                },
                color: Colors.redAccent,
                child: Text(
                  'Result',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$parsedTimeResult days",
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 30.0,
                    fontFamily: 'DancingScript',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
