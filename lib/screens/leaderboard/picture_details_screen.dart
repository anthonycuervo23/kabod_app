import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';

class PictureDetailsScreen extends StatelessWidget {
  final String picture;

  PictureDetailsScreen({this.picture});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: kAppBarShape,
        title: Text(
          'Results Details',
          style: TextStyle(
              color: kTextColor, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
            child: picture != null
                ? CachedNetworkImage(
                    imageUrl: picture,
                    placeholder: (context, url) => CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kButtonColor)))
                : Container()),
      ),
    );
  }
}
