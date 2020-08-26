import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  String LabelTextField;
  String HelperTextField;
  Color ColorBorder;
  Color ColorField;
  Color ColorCursor;
  var TextController;
  CustomTextField(this.LabelTextField, this.HelperTextField, this.ColorBorder,
      this.ColorField, this.ColorCursor, this.TextController);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: TextField(
        cursorColor: widget.ColorCursor,
        style: TextStyle(
          color: widget.ColorField,
        ),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        controller: widget.TextController,
        decoration: InputDecoration(
            enabledBorder: new OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: widget.ColorBorder)),
            border: OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.cyan[200]),
                borderRadius: new BorderRadius.all(Radius.circular(20.0))),
            helperText: widget.HelperTextField,
            labelText: widget.LabelTextField,
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
}
