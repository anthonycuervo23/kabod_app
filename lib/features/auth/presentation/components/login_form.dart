import 'package:flutter/material.dart';
import 'file:///C:/Users/antho/Desktop/kabod_project/kabod_app/lib/core/presentation/res/constants.dart';

class LoginField extends StatefulWidget {
  final hintText;
  final labelText;
  var isPassword;
  var isSecure;
  Key key;
  final TextInputAction textInputAction;
  FocusNode focusNode;
  VoidCallback onEditingComplete;
  final Function validator;
  final Function onPressed;
  final TextEditingController controller;
  LoginField(
      {this.hintText,
      this.labelText,
      this.isPassword = true,
      this.isSecure = false,
      this.key,
      this.textInputAction,
      this.focusNode,
      this.controller,
      this.onEditingComplete,
      this.onPressed,
      this.validator});

  @override
  _LoginFieldState createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isPassword) {
      return TextFormField(
        key: widget.key,
        textInputAction: widget.textInputAction,
        onEditingComplete: widget.onEditingComplete,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.isSecure,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: kWhiteTextColor),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: kTextColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kButtonColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kButtonColor),
          ),
        ),
      );
    } else {
      return TextFormField(
        key: widget.key,
        textInputAction: widget.textInputAction,
        onEditingComplete: widget.onEditingComplete,
        focusNode: widget.focusNode,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.isSecure,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                widget.isSecure = !widget.isSecure;
              });
            },
            child: Icon(
              widget.isSecure ? Icons.visibility : Icons.visibility_off,
              color: kButtonColor,
            ),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(color: kWhiteTextColor),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: kTextColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kButtonColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kButtonColor),
          ),
        ),
      );
    }
  }
}
