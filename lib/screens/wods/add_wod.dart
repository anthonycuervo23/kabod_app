import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

//my imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/screens/home/model/wod_model.dart';
import 'package:kabod_app/screens/wods/components/delete_wod_button.dart';
import 'package:kabod_app/screens/wods/components/add_wod_form.dart';

class AddWodScreen extends StatefulWidget {
  final Wod currentWod;
  final DateTime selectedDay;
  AddWodScreen({this.selectedDay, this.currentWod});
  @override
  _AddWodScreenState createState() => _AddWodScreenState();
}

class _AddWodScreenState extends State<AddWodScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: kAppBarShape,
        title: Text(widget.currentWod != null ? 'Edit WOD' : 'Create WOD'),
        leading: IconButton(
            icon: Icon(Icons.clear, color: kButtonColor),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.homeRoute)),
        actions: [
          widget.currentWod != null
              ? DeleteWodButton(widget: widget)
              : Container()
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(kDefaultPadding),
        children: [
          AddWodForm(formKey: _formKey, widget: widget),
        ],
      ),
    );
  }
}
