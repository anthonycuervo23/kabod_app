import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

//my imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/screens/home/model/wod_model.dart';
import 'package:kabod_app/screens/home/repository/wod_repository.dart';
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
          IconButton(
            icon: widget.currentWod != null
                ? Image.asset('assets/icons/trash_icon.png')
                : Container(),
            onPressed: () async {
              final confirm = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: kBackgroundColor,
                      title: Text('Warning!',
                          style: TextStyle(
                              color: kButtonColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                      content:
                          Text('Are you sure you want to delete this WOD?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(
                            'Delete',
                            style: TextStyle(
                                color: kButtonColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ) ??
                  false;
              if (confirm) {
                await context
                    .read<WodRepository>()
                    .deleteWod(widget.currentWod.id);
                Navigator.pop(context);
              }
            },
          )
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
