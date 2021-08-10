import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabod_app/core/repository/user_repository.dart';
import 'package:kabod_app/screens/Stories/model/userStories.dart';
import 'package:kabod_app/screens/Stories/display_story.dart';
import 'package:provider/provider.dart';

class StoryViewer extends StatefulWidget {
  final List<UserStories> userStories;
  final int initialPage;

  const StoryViewer({Key key, this.userStories, this.initialPage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _StoryViewer(userStories);
}

class _StoryViewer extends State<StoryViewer> {
  PageController pageController;
  final List<UserStories> userStories;
  var currentPageValue;

  _StoryViewer(this.userStories);

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialPage);

    currentPageValue = widget.initialPage.toDouble();

    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRepo = Provider.of<UserRepository>(context);
    final userId = userRepo?.userModel?.id;
    return ColoredBox(
      color: Colors.black,
      child: PageView.builder(
        controller: pageController,
        itemCount: widget.userStories.length,
        itemBuilder: (context, index) {
          final isLeaving = (index - currentPageValue) <= 0;
          final t = (index - currentPageValue);
          final rotationY = lerpDouble(0, 30, t);
          final maxOpacity = 0.8;
          final opacity =
              lerpDouble(0, maxOpacity, t.abs()).clamp(0.0, maxOpacity);
          final isPaging = opacity != maxOpacity;
          final transform = Matrix4.identity();
          transform.setEntry(3, 2, 0.003);
          transform.rotateY(-rotationY * (pi / 180.0));
          return Transform(
            alignment: isLeaving ? Alignment.centerRight : Alignment.centerLeft,
            transform: transform,
            child: Stack(
              children: [
                StoryDisplay(
                  userStories[index],
                  userId,
                  onComplete: index+1==userStories.length?()=>Navigator.pop(context):() {
                    pageController.animateToPage(index+1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
                  },
                ),
                if (isPaging && !isLeaving)
                  Positioned.fill(
                    child: Opacity(
                      opacity: opacity,
                      child: ColoredBox(
                        color: Colors.black87,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
