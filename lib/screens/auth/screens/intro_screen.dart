import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;

//My imports
import 'package:kabod_app/screens/auth/components/intro_profile_form.dart';
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/screens/auth/components/background_image.dart';
import 'package:kabod_app/screens/auth/model/user_repository.dart';
import 'package:kabod_app/screens/commons/reusable_button.dart';
import 'package:kabod_app/screens/auth/model/intro_profile_repository.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _IntroScreenState extends State<IntroScreen> {
  bool _processing;
  AppState state;
  File _image;
  String _uploadedFileURL;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    _processing = false;
    state = AppState.free;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userRepository = Provider.of<UserRepository>(context);
    final introScreenProvider = Provider.of<IntroRepository>(context);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/intro_background.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: kDefaultPadding, right: kDefaultPadding, top: 28),
                  child: Text(
                    'You\'re almost ready to get started. We just need a couple more details to complete your profile.',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: _pickImageButtonPressed,
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: CircleAvatar(
                              backgroundImage:
                                  _image != null ? FileImage(_image) : null,
                              radius: size.width * 0.14,
                              backgroundColor: Colors.grey[400].withOpacity(
                                0.4,
                              ),
                              child: _image == null
                                  ? Icon(
                                      Icons.person,
                                      color: kWhiteTextColor,
                                      size: size.width * 0.1,
                                    )
                                  : Container(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: kButtonColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: kWhiteTextColor, width: 2),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: kWhiteTextColor,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Column(
                  children: [
                    IntroProfileForm(formKey: _formKey),
                    SizedBox(
                      height: 25,
                    ),
                    ReusableButton(
                      child: _processing
                          ? CircularProgressIndicator()
                          : Text('CONTINUE', style: kTextButtonStyle),
                      onPressed: _processing
                          ? null
                          : () async {
                              bool validated = _formKey.currentState.validate();
                              if (validated &&
                                  (_image == null ||
                                      state != AppState.cropped)) {
                                _formKey.currentState.save();
                                final data = Map<String, dynamic>.from(
                                    _formKey.currentState.value);
                                data['birth_date'] =
                                    (data['birth_date'] as DateTime)
                                        .millisecondsSinceEpoch;
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userRepository.user.uid)
                                    .update(data);
                                introScreenProvider.finishIntroScreen(
                                    context, userRepository.user.uid);
                              }
                              if (validated &&
                                  (_image != null &&
                                      state == AppState.cropped)) {
                                setState(() {
                                  _processing = false;
                                });
                                String path =
                                    '${'users'}/${userRepository.user.uid}/${Path.basename(_image.path)}';
                                introScreenProvider.uploadFile(path, _image);
                                _formKey.currentState.save();
                                final data = Map<String, dynamic>.from(
                                    _formKey.currentState.value);
                                data['birth_date'] =
                                    (data['birth_date'] as DateTime)
                                        .millisecondsSinceEpoch;
                                _uploadedFileURL = await introScreenProvider
                                    .uploadFile(path, _image);
                                data['photo_url'] = _uploadedFileURL;
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userRepository.user.uid)
                                    .update(data);
                                introScreenProvider.finishIntroScreen(
                                    context, userRepository.user.uid);
                              }
                              if (mounted) {
                                setState(() {
                                  _processing = true;
                                });
                              }
                            },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
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
      _cropImage(_image);
      Navigator.pop(context);
    });
  }

  Future<Null> _cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: _image.path,
      maxWidth: 800,
      cropStyle: CropStyle.circle,
      androidUiSettings: AndroidUiSettings(
        statusBarColor: kBackgroundColor,
        toolbarColor: kBackgroundColor,
        toolbarWidgetColor: kWhiteTextColor,
        activeControlsWidgetColor: kButtonColor,
      ),
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }
}
