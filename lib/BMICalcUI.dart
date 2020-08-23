import 'package:AllInOneCalci/customAppBar.dart';
import 'package:flutter/material.dart';

class BMICalcUI extends StatefulWidget {
  @override
  _BMICalcUIState createState() => _BMICalcUIState();
}

class _BMICalcUIState extends State<BMICalcUI> {
  TextEditingController myController = TextEditingController();
  TextEditingController myController2 = TextEditingController();

  double Result;
  double BMIHeight;
  double BMIWidth;
  double Result_round;
  String condition = '';

  @override
  void dispose() {
    myController.dispose();
    myController2.dispose();
    super.dispose();
  }

  double BMIResult() {
    BMIHeight = double.parse(myController.text);
    BMIWidth = double.parse(myController2.text);
    Result = (BMIWidth / (BMIHeight * BMIHeight)) * 10000;
    Result_round = double.parse(Result.toStringAsFixed(2));
    setState(() {
      if (Result <= 18.5) {
        condition = 'Mild Thinness';
      } else if (Result >= 18.5 && Result <= 25) {
        condition = 'Normal';
      } else {
        condition = 'Overweight';
      }
    });
  }

  Widget CustomTextField(
      String LabelTextField,
      String HelperTextField,
      Color ColorBorder,
      Color ColorField,
      Color ColorCursor,
      var TextController) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: TextField(
        cursorColor: ColorCursor,
        style: TextStyle(
          color: ColorField,
        ),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        controller: TextController,
        decoration: InputDecoration(
            enabledBorder: new OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: ColorBorder)),
            border: OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.cyan[200]),
                borderRadius: new BorderRadius.all(Radius.circular(20.0))),
            helperText: HelperTextField,
            labelText: LabelTextField,
            labelStyle: TextStyle(
              color: Colors.black26,
              fontSize: 20.0,
              fontFamily: 'DancingScript',
            ),
            icon: Icon(
              Icons.apps,
            )),
      ),
    );
  }

  Widget CustomButton() {
    return MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        color: Colors.redAccent,
        elevation: 10.0,
        splashColor: Colors.redAccent,
        child: Container(
          width: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Result',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19.0,
                    fontFamily: 'DancingScript'),
              )
            ],
          ),
        ),
        onPressed: () {
          BMIResult();
        });
  }

  @override
  Widget build(BuildContext context) {
    double AppBarHeight = MediaQuery.of(context).size.height;
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
      body: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Container(
          width: 300.0,
          child: Column(
            children: [
              CustomTextField(
                  'Height',
                  'Input height in Meters',
                  Colors.cyan[200],
                  Colors.redAccent,
                  Colors.redAccent,
                  myController),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomTextField(
                    'Weight',
                    'Input weight in Kgs',
                    Colors.redAccent,
                    Colors.cyan,
                    Colors.cyan[200],
                    myController2),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60.0, top: 20.0),
                child: CustomButton(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                  left: 50.0,
                ),
                child: Text(
                  '$condition',
                  style: TextStyle(
                    color: Colors.cyan[200],
                    fontWeight: FontWeight.bold,
                    fontSize: 45.0,
                    fontFamily: 'DancingScript',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
