import 'dart:io';

import 'package:AllInOneCalci/CustomTextField.dart';
import 'package:AllInOneCalci/Post.dart';
import 'package:AllInOneCalci/apiKeys.dart';
import 'package:AllInOneCalci/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class LoveCalUI extends StatelessWidget {
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
                'Love Calculator',
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
      body: CustomFetchData(),
    );
  }
}

class CustomFetchData extends StatefulWidget {
  @override
  _CustomFetchDataState createState() => _CustomFetchDataState();
}

class _CustomFetchDataState extends State<CustomFetchData> {
  ApiKeys apis = new ApiKeys();
  int percentage = 0;
  String result = "";

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController secondNameController = new TextEditingController();

  Future<Post> _getData({String name1, String name2}) async {
    final response = await http.get(
        'https://love-calculator.p.rapidapi.com/getPercentage?fname=$name1&sname=$name2',
        headers: {
          'x-rapidapi-host': 'love-calculator.p.rapidapi.com',
          'x-rapidapi-key': apis.keyHost,
        });

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      setState(() {
        percentage = int.parse(responseJson['percentage']);
        result = responseJson['result'];
      });
    } else {
      throw Exception('Failed to load api');
    }
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alertD = new AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 5.0),
            child: Text(
              'Loading...',
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alertD;
      },
    );
  }

  bool isLoaded = false;
  _getText() {
    if (isLoaded) {
      return Column(
        children: [
          Text(
            'Your Score Is: $percentage%',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              '$result',
              style: TextStyle(
                color: Colors.redAccent,
                fontFamily: 'DancingScript',
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool visibilitySwitch = false;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 15.0),
            child: CustomTextField('First Name', "", Colors.cyan, Colors.cyan,
                Colors.redAccent, firstNameController, firstNameController),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: CustomTextField(
                'Second Name',
                "",
                Colors.red,
                Colors.redAccent,
                Colors.cyanAccent,
                secondNameController,
                secondNameController),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: MaterialButton(
                color: Colors.redAccent,
                child: Text(
                  'Result',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  showAlertDialog(context);
                  await _getData(
                    name1: firstNameController.text,
                    name2: secondNameController.text,
                  );
                  Navigator.pop(context);
                  setState(() {
                    isLoaded = true;
                  });
                }),
          ),
          _getText(),
        ],
      ),
    );
  }

  @override
  // ignore: must_call_super
  void initState() {
    _getData();
  }
}
