import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

//My imports
import 'package:kabod_app/core/repository/intro_profile_repository.dart';
import 'package:kabod_app/core/presentation/results_repository.dart';
import 'package:kabod_app/screens/results/components/add_results_form.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/utils/general_utils.dart';
import 'package:kabod_app/core/repository/user_repository.dart';
import 'package:kabod_app/screens/commons/appbar.dart';
import 'package:kabod_app/screens/commons/dividers.dart';
import 'package:kabod_app/screens/commons/reusable_button.dart';
import 'package:kabod_app/screens/commons/reusable_card.dart';
import 'package:kabod_app/screens/wods/model/wod_model.dart';

class AddResultsScreen extends StatefulWidget {
  final Wod currentWod;
  AddResultsScreen({this.currentWod});
  @override
  _AddResultsScreenState createState() => _AddResultsScreenState();
}

class _AddResultsScreenState extends State<AddResultsScreen> {
  bool _processing;

  File _image;

  String _uploadedFileURL;

  Duration initialTimer = Duration();

  bool rx = false;
  final _formKey = GlobalKey<FormBuilderState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _processing = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        scaffoldKey: _scaffoldKey,
        shape: kAppBarShape,
        title: Text('Add WOD Result'),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: kDefaultPadding),
        children: [
          DefaultCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DividerMedium(),
                Text(widget.currentWod.title,
                    style: TextStyle(fontSize: 24, color: kWhiteTextColor)),
                AddResultsForm(
                  formKey: _formKey,
                  currentWod: widget.currentWod,
                  initialTimer: initialTimer,
                  onTimerDurationChanged: (value) {
                    setState(() {
                      initialTimer = value;
                    });
                  },
                ),
                Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, color: kTextColor),
                        SizedBox(width: 8),
                        Text(DateFormat('MMM d, yyy')
                            .format(widget.currentWod.date)
                            .toString())
                      ],
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: _pickImageButtonPressed,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.camera_alt_outlined,
                              color:
                                  _image != null ? kButtonColor : kTextColor),
                          SizedBox(width: 8),
                          _image != null
                              ? Text('Change Image',
                                  style: TextStyle(color: kButtonColor))
                              : Text('Add Picture'),
                        ],
                      ),
                    )),
                  ],
                ),
                DividerSmall(),
              ],
            ),
          ),
          DividerBig(),
          ReusableButton(
            onPressed: _processing ? null : _saveWodResultsButtonPressed,
            child: _processing
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kBackgroundColor),
                  )
                : Text('SAVE RESULT', style: kTextButtonStyle),
          ),
          DividerMedium(),
        ],
      ),
    );
  }

  _saveWodResultsButtonPressed() async {
    ResultRepository resultRepository =
        Provider.of<ResultRepository>(context, listen: false);
    UserRepository userRepository =
        Provider.of<UserRepository>(context, listen: false);
    bool validated = _formKey.currentState.validate();
    if (validated && _image != null) {
      _formKey.currentState.save();
      setState(() {
        _processing = true;
      });
      String path =
          '${'users'}/${userRepository.user.uid}/${'result_photos'}/${Path.basename(_image.path)}';
      _uploadedFileURL =
          await Provider.of<IntroRepository>(context, listen: false)
              .uploadFile(path, _image);
      final data = Map<String, dynamic>.from(_formKey.currentState.value);
      data['time'] = stringFromDuration(initialTimer);
      data['result_date'] = widget.currentWod.date;
      data['result_photo'] = _uploadedFileURL;
      resultRepository.addResult(data, userRepository.user.uid);
      Navigator.pop(context);
    } else if (validated && _image == null) {
      _formKey.currentState.save();
      setState(() {
        _processing = true;
      });
      final data = Map<String, dynamic>.from(_formKey.currentState.value);
      data['time'] = stringFromDuration(initialTimer);
      data['result_date'] = widget.currentWod.date;
      resultRepository.addResult(data, userRepository.user.uid);
      Navigator.pop(context);
    }
  }

  void _pickImageButtonPressed() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: kBackgroundColor,
            title: Text('Pick an image',
                style: TextStyle(
                    color: kButtonColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ...ListTile.divideTiles(
                  color: Theme.of(context).dividerColor,
                  tiles: [
                    ListTile(
                      onTap: () {
                        getImage(ImageSource.gallery);
                      },
                      title: Text('Gallery',
                          style: TextStyle(
                              color: kWhiteTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22)),
                    ),
                    ListTile(
                      onTap: () {
                        getImage(ImageSource.camera);
                      },
                      title: Text('Camera',
                          style: TextStyle(
                              color: kWhiteTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22)),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future getImage(ImageSource source) async {
    PickedFile image = await ImagePicker().getImage(source: source);
    if (image == null) return;
    setState(() {
      _image = File(image.path);
      Navigator.pop(context);
    });
  }
}
