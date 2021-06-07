import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';
import 'package:photo_view/photo_view.dart';

class FullPhoto extends StatelessWidget {
  final String url;

  FullPhoto({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FULL PHOTO',
          style: TextStyle(color: kWhiteTextColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FullPhotoScreen(url: url),
    );
  }
}

class FullPhotoScreen extends StatefulWidget {
  final String url;

  FullPhotoScreen({Key key, @required this.url}) : super(key: key);

  @override
  FullPhotoScreenState createState() => FullPhotoScreenState(url: url);
}

class FullPhotoScreenState extends State<FullPhotoScreen> {
  final String url;

  FullPhotoScreenState({Key key, @required this.url});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("url = $url");
    return url != null
        ? Container(
            child: PhotoView(imageProvider: CachedNetworkImageProvider(url)))
        : Container();
  }
}
