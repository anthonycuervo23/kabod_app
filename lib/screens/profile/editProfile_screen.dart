import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:kabod_app/core/repository/intro_profile_repository.dart';
import 'package:kabod_app/core/repository/user_repository.dart';
import 'package:kabod_app/screens/auth/model/user_model.dart';
import 'package:kabod_app/screens/commons/reusable_button.dart';
import 'package:kabod_app/screens/profile/components/avatar.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameController;
  TextEditingController _phoneController;
  bool _processing;
  AppState state;
  File _image;
  String _uploadedFileURL;

  @override
  void initState() {
    super.initState();
    _processing = false;
    state = AppState.free;
    _nameController = TextEditingController(text: widget.user.name);
    _phoneController = TextEditingController(text: widget.user.phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'EDIT PROFILE',
          style: TextStyle(fontSize: 24, color: kTextColor),
        ),
        shape: kAppBarShape,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          Center(
            child: Avatar(
              showButton: true,
              onButtonPressed: _pickImageButtonPressed,
              radius: 70,
              image: state == AppState.cropped && _image != null
                  ? FileImage(_image)
                  : widget.user.photoUrl != null
                      ? NetworkImage(widget.user.photoUrl)
                      : AssetImage('images/profile_image.jpg'),
            ),
          ),
          const SizedBox(height: 20.0),
          Center(
              child: Text(
            widget.user.email,
            style: TextStyle(color: kWhiteTextColor, fontSize: 20),
          )),
          const SizedBox(height: 20.0),
          TextField(
            style: TextStyle(color: kWhiteTextColor, fontSize: 20),
            controller: _nameController,
            decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: kButtonColor, fontSize: 18)),
          ),
          const SizedBox(height: 10.0),
          TextField(
            style: TextStyle(color: kWhiteTextColor, fontSize: 20),
            controller: _phoneController,
            decoration: InputDecoration(
                labelText: 'Phone',
                labelStyle: TextStyle(color: kButtonColor, fontSize: 18)),
          ),
          const SizedBox(height: 10.0),
          SizedBox(height: 10.0),
          Center(
            child: ReusableButton(
              child: _processing
                  ? CircularProgressIndicator()
                  : Text('SAVE', style: TextStyle(fontSize: 20)),
              onPressed: _processing
                  ? null
                  : () async {
                      final UserRepository userRepository =
                          Provider.of<UserRepository>(context, listen: false);
                      if (_nameController.text.isEmpty &&
                          (_image == null || state != AppState.cropped)) return;
                      setState(() {
                        _processing = true;
                      });
                      if (_image != null && state == AppState.cropped) {
                        await uploadImage();
                      }
                      Map<String, dynamic> data = {};
                      if (_nameController.text.isNotEmpty)
                        data['name'] = _nameController.text;
                      if (_phoneController.text.isNotEmpty)
                        data['phone'] = _phoneController.text;
                      if (_uploadedFileURL != null)
                        data['photo_url'] = _uploadedFileURL;
                      if (data.isNotEmpty) {
                        print(widget.user.id);
                        userRepository.updateData(
                            userRepository.user.uid, data);
                      }
                      if (mounted) {
                        setState(() {
                          _processing = false;
                        });
                        Navigator.pop(context);
                      }
                    },
            ),
          )
        ],
      ),
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

  Future uploadImage() async {
    final introScreenProvider =
        Provider.of<IntroRepository>(context, listen: false);
    final UserRepository userRepository =
        Provider.of<UserRepository>(context, listen: false);

    String path =
        '${'users'}/${userRepository.user.uid}/${Path.basename(_image.path)}';

    String url = await introScreenProvider.uploadFile(path, _image);
    setState(() {
      _uploadedFileURL = url;
    });
  }
}
