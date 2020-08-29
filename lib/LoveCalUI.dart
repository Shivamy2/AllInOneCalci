import 'dart:io';

import 'package:AllInOneCalci/CustomTextField.dart';
import 'package:AllInOneCalci/Post.dart';
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
  int percentage = 0;
  String result = "";

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController secondNameController = new TextEditingController();

  Future<Post> _getData({String name1, String name2}) async {
    final response = await http.get(
        'https://love-calculator.p.rapidapi.com/getPercentage?fname=$name1&sname=$name2',
        headers: {
          'x-rapidapi-host': 'love-calculator.p.rapidapi.com',
          'x-rapidapi-key':
              '84e84770b9msh59a96d8b03cb4aap1615a1jsn1cd0efaeedfe',
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

  Widget ErrorDesign() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          'Error: Kindly Connect to Internet',
          style: TextStyle(
            color: Colors.redAccent,
            fontFamily: 'DancingScript',
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget FetchedCalculationValues() {
    return Column(
      children: [
        Container(
            child: FutureBuilder<Post>(
                future: _getData(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Container(
                        child: ErrorDesign(),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text('Percentage is $percentage %',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                            Text('Result is: $result',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      );
                    }
                  }
                })),
      ],
    );
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
                onPressed: () {
                  _getData(
                    name1: firstNameController.text,
                    name2: secondNameController.text,
                  );
                }),
          ),
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
      ),
    );
  }

  @override
  // ignore: must_call_super
  void initState() {
    _getData();
  }
}
