import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabod_app/screens/Stories/image_story_editor.dart';
import 'package:kabod_app/screens/Stories/video_story_editor.dart';
import 'package:permission_handler/permission_handler.dart';

class StoryCreate extends StatefulWidget {
  StoryCreate();

  @override
  _StoryCreateState createState() => _StoryCreateState();
}

class _StoryCreateState extends State<StoryCreate> {
  List<CameraDescription> camera;
  int camIndex = 1;
  CameraController controller;
  final Stopwatch stopwatch = Stopwatch();
  String time = "00:00";
  Timer timer;
  bool timerVisibility = false;

  void onNewCameraSelected(List<CameraDescription> cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    controller = new CameraController(
      cameraDescription[camIndex],
      ResolutionPreset.high,
      enableAudio: true,
    );
    controller.addListener(() {
      if (mounted) setState(() {});
    });

    await controller.initialize().onError((error, stackTrace) {
      final snackBar = SnackBar(content: Text('Camera Initialization Failed'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  initState() {
    super.initState();
    availableCameras().then((value) {
      camera = value;
      onNewCameraSelected(camera);
    });
  }

  @override
  void dispose() {
    print("dispose method called");
    controller?.dispose();
    timer?.cancel();
    stopwatch?.stop();
    stopwatch?.reset();
    super.dispose();
  }

  updateVideoTimer() {
    if (timer != null && timer.isActive) {
      timer?.cancel();
      setState(() {
        time = "00:00";
      });
    } else
      timer = Timer.periodic(new Duration(milliseconds: 1000), (t) {
        print(this.stopwatch.elapsedMilliseconds);
        setState(() {
          time = stopwatch.elapsed.toString().substring(2, 7);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Stack(
            children: [
              controller != null && controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: 1 / controller.value.aspectRatio,
                      child: controller.buildPreview())
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              Positioned(
                  top: 10,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  )),
              Visibility(
                visible: timerVisibility,
                child: Positioned(
                  top: 50,
                  child: Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: Text(
                      time ?? " ",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.perm_media_sharp,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          //flutter grant storage permission
                          if (await Permission.storage.isDenied) {
                            Permission.storage.request();
                          } else {
                            //pick a file using file picker
                            var file = FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.media,
                            );
                            await file.then((value) {
                              if (value != null) if (value
                                          .files.first.extension ==
                                      "jpg" ||
                                  value.files.first.extension == "png" ||
                                  value.files.first.extension == "jpeg") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ImageStoryEditor(
                                              filePath: value.paths[0],
                                            )));
                              } else if (value.files.first.extension == "mp4" ||
                                  value.files.first.extension == "mkv" ||
                                  value.files.first.extension == 'mov' ||
                                  value.files.first.extension == 'm4v') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => VideoStoryEditor(
                                            File(value.paths[0]))));
                              } else {
                                print(
                                    'error =====> ${value.files.first.extension}');
                                final snackBar = SnackBar(
                                    content: Text(value.files.first.extension));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar,
                                );
                              }
                            }, onError: (e) {
                              final snackBar = SnackBar(
                                  content: Text('Something went wrong!'));
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackBar,
                              );
                            });
                          }
                        },
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.camera,
                          size: 60,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          await controller.takePicture().then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ImageStoryEditor(
                                          filePath: value.path,
                                        )));
                          }, onError: (e, stack) {
                            CameraException ex = e;
                            final snackBar =
                                SnackBar(content: Text(ex.description));
                            print(ex.description +
                                (stack as StackTrace).toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBar,
                            );
                          });
                          print(Directory.current.path.toString());
                        },
                        onLongPressStart: (void v) async {
                          await controller.startVideoRecording().then((value) {
                            setState(() {
                              timerVisibility = true;
                            });
                            stopwatch.start();
                            updateVideoTimer();
                          });
                        },
                        onLongPressEnd: (void v) async {
                          await controller.stopVideoRecording().then((value) {
                            setState(() {
                              timerVisibility = false;
                            });
                            stopwatch.stop();
                            stopwatch.reset();
                            updateVideoTimer();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        VideoStoryEditor(File(value.path))));
                          }, onError: (e) {
                            CameraException ex = e;
                            final snackBar =
                                SnackBar(content: Text(ex.description));
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBar,
                            );
                          });
                          print("video captured");
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            //switch camera
                            camIndex = camIndex == 0 ? 1 : 0;
                            onNewCameraSelected(camera);
                          },
                          icon: Icon(
                            Icons.cameraswitch,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
