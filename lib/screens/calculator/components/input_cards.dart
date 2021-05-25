import 'package:flutter/material.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/utils/decimalTextInputFormatter.dart';

class TextInputCard extends StatefulWidget {
  final String cardTitle;
  final String hintText;
  final bool decimal;
  final ValueChanged<String> onChanged;
  final String text;

  TextInputCard(
      {@required this.cardTitle,
      @required this.decimal,
      @required this.onChanged,
      this.text,
      this.hintText,
      Key key})
      : super(key: key);

  @override
  _TextInputCardState createState() => _TextInputCardState();
}

class _TextInputCardState extends State<TextInputCard>
    with SingleTickerProviderStateMixin {
  TextEditingController _controller;
  FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focus?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: widget.cardTitle,
      child: TextField(
        autofocus: false,
        maxLines: 1,
        textAlign: TextAlign.center,
        controller: _controller,
        focusNode: _focus,
        style: TextStyle(fontSize: 20, color: kWhiteTextColor),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText ?? "",
            hintStyle: TextStyle(color: kTextColor)),
        keyboardType: TextInputType.numberWithOptions(
            signed: false, decimal: widget.decimal),
        inputFormatters: [
          DecimalTextInputFormatter(
              decimalRange: widget.decimal ? 2 : 0, signed: false)
        ],
        onChanged: (val) => widget.onChanged(val),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Widget child;
  final String title;
  final double elevation;

  const CustomCard(
      {@required this.title, @required this.child, this.elevation: 0, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kPrimaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: EdgeInsets.all(16 * MediaQuery.of(context).size.height / 825),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(this.title,
                style: TextStyle(
                    color: kButtonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            child
          ],
        ),
      ),
    );
  }
}
