import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kabod_app/screens/Stories/story_add.dart';
import 'package:video_trimmer/video_trimmer.dart';


class VideoStoryEditor extends StatefulWidget {
  final File file;

  VideoStoryEditor(this.file);

  @override
  _VideoStoryEditor createState() => _VideoStoryEditor();
}

class _VideoStoryEditor extends State<VideoStoryEditor> {
  final Trimmer _trimmer = Trimmer();

  double _startValue;
  double _endValue;
  
  bool _isFileUploading = false;

  @override
  void initState(){
    super.initState();
    _startValue = 0.0;
    _endValue = 30000.0;
    _trimmer?.loadVideo(videoFile: widget.file);
  }

  bool _isPlaying = false;

  Future<String> _saveVideo() async {
    setState(() {
      _isFileUploading = true;
    });
    _trimmer?.videoPlayerController?.pause();

    return await _trimmer.saveTrimmedVideo(
        startValue: _startValue,
        endValue: _endValue,
        videoFileName: DateTime.now().toString());
  }

  @override
  void dispose() {
    widget.file?.deleteSync();
    _trimmer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddStory(
      getFile: ()=>_saveVideo().then((value) => File(value)),
      duration: () => (_endValue - _startValue).round(),
      shareButtonEnable: !_isPlaying&&!_isFileUploading,
      fileType: "video",
      child: Builder(
        builder: (context) => Center(
          child: Container(
            padding: EdgeInsets.only(bottom: 20.0,top: 10),
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: VideoViewer(trimmer: _trimmer),
                ),
                Center(
                  child: TrimEditor(
                    trimmer: _trimmer,
                    viewerHeight: 50.0,
                    viewerWidth: MediaQuery.of(context).size.width,
                    maxVideoLength: Duration(seconds: 30),
                    onChangeStart: _isFileUploading?null:(value) {
                      _startValue = value;
                    },
                    onChangeEnd: _isFileUploading?null:(value) {
                      _endValue = value;
                    },
                    onChangePlaybackState: _isFileUploading?null:(value) {
                      setState(() {
                        _isPlaying = value;
                      });
                    },
                  ),
                ),
                TextButton(
                  child: _isPlaying
                      ? Icon(
                          Icons.pause,
                          size: 60.0,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.play_arrow,
                          size: 60.0,
                          color: Colors.white,
                        ),
                  onPressed: _isFileUploading?null:() async {
                    bool playbackState = await _trimmer.videPlaybackControl(
                      startValue: _startValue,
                      endValue: _endValue,
                    );
                    setState(() {
                      _isPlaying = playbackState;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
