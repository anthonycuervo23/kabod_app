import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

//My imports
import 'package:kabod_app/core/presentation/constants.dart';

class DurationPickerDialog extends StatefulWidget {
  final Duration initialDuration;
  final EdgeInsets titlePadding;
  final Widget title;
  final Widget confirmWidget;
  final Widget cancelWidget;

  DurationPickerDialog({
    @required this.initialDuration,
    this.title,
    this.titlePadding,
    Widget confirmWidget,
    Widget cancelWidget,
  })  : confirmWidget = confirmWidget ??
            new Text('OK', style: TextStyle(color: kTextColor)),
        cancelWidget = cancelWidget ??
            new Text('CANCEL', style: TextStyle(color: kTextColor));

  @override
  State<StatefulWidget> createState() =>
      new _DurationPickerDialogState(initialDuration);
}

class _DurationPickerDialogState extends State<DurationPickerDialog> {
  int minutes;
  int seconds;

  _DurationPickerDialogState(Duration initialDuration) {
    minutes = initialDuration.inMinutes;
    seconds = initialDuration.inSeconds % Duration.secondsPerMinute;
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      backgroundColor: kBackgroundColor,
      title: widget.title,
      titlePadding: widget.titlePadding,
      content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        new NumberPicker.integer(
          selectedTextStyle: TextStyle(color: kButtonColor, fontSize: 24),
          listViewWidth: 65,
          initialValue: minutes,
          minValue: 0,
          maxValue: 10,
          zeroPad: true,
          onChanged: (value) {
            this.setState(() {
              minutes = value;
            });
          },
        ),
        Text(
          ':',
          style: TextStyle(fontSize: 30),
        ),
        new NumberPicker.integer(
          selectedTextStyle: TextStyle(color: kButtonColor, fontSize: 24),
          listViewWidth: 65,
          initialValue: seconds,
          minValue: 0,
          maxValue: 59,
          zeroPad: true,
          onChanged: (value) {
            this.setState(() {
              seconds = value;
            });
          },
        ),
      ]),
      actions: [
        new TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: widget.cancelWidget,
        ),
        new TextButton(
          onPressed: () => Navigator.of(context)
              .pop(new Duration(minutes: minutes, seconds: seconds)),
          child: widget.confirmWidget,
        ),
      ],
    );
  }
}

class DurationEmomPickerDialog extends StatefulWidget {
  final Duration initialDuration;
  final EdgeInsets titlePadding;
  final Widget title;
  final Widget confirmWidget;
  final Widget cancelWidget;

  DurationEmomPickerDialog({
    @required this.initialDuration,
    this.title,
    this.titlePadding,
    Widget confirmWidget,
    Widget cancelWidget,
  })  : confirmWidget = confirmWidget ??
            new Text('OK', style: TextStyle(color: kTextColor)),
        cancelWidget = cancelWidget ??
            new Text('CANCEL', style: TextStyle(color: kTextColor));

  @override
  State<StatefulWidget> createState() =>
      new _DurationEmomPickerDialogState(initialDuration);
}

class _DurationEmomPickerDialogState extends State<DurationEmomPickerDialog> {
  int minutes;
  int seconds;

  _DurationEmomPickerDialogState(Duration initialDuration) {
    minutes = initialDuration.inMinutes;
    seconds = initialDuration.inSeconds % Duration.secondsPerMinute;
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      backgroundColor: kBackgroundColor,
      title: widget.title,
      titlePadding: widget.titlePadding,
      content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        new NumberPicker.integer(
          selectedTextStyle: TextStyle(color: kButtonColor, fontSize: 24),
          listViewWidth: 65,
          initialValue: minutes,
          minValue: 1,
          maxValue: 10,
          zeroPad: true,
          onChanged: (value) {
            this.setState(() {
              minutes = value;
            });
          },
        ),
        Text(
          ':',
          style: TextStyle(fontSize: 30),
        ),
        new NumberPicker.integer(
          selectedTextStyle: TextStyle(color: kButtonColor, fontSize: 24),
          listViewWidth: 65,
          initialValue: seconds,
          minValue: 0,
          maxValue: 0,
          zeroPad: true,
          onChanged: (value) {
            this.setState(() {
              seconds = value;
            });
          },
        ),
      ]),
      actions: [
        new TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: widget.cancelWidget,
        ),
        new TextButton(
          onPressed: () => Navigator.of(context)
              .pop(new Duration(minutes: minutes, seconds: seconds)),
          child: widget.confirmWidget,
        ),
      ],
    );
  }
}

// class RepsPickerDialog extends StatefulWidget {
//   final int initialDuration;
//   final EdgeInsets titlePadding;
//   final Widget title;
//   final Widget confirmWidget;
//   final Widget cancelWidget;
//
//   RepsPickerDialog({
//     @required this.initialDuration,
//     this.title,
//     this.titlePadding,
//     Widget confirmWidget,
//     Widget cancelWidget,
//   })  : confirmWidget = confirmWidget ??
//             new Text('OK', style: TextStyle(color: kTextColor)),
//         cancelWidget = cancelWidget ??
//             new Text('CANCEL', style: TextStyle(color: kTextColor));
//
//   @override
//   State<StatefulWidget> createState() => new _RepsPickerDialogState();
// }
//
// class _RepsPickerDialogState extends State<RepsPickerDialog> {
//   int reps = 1;
//   int seconds;
//
//   @override
//   Widget build(BuildContext context) {
//     return new AlertDialog(
//       backgroundColor: kBackgroundColor,
//       title: widget.title,
//       titlePadding: widget.titlePadding,
//       content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//         new NumberPicker.integer(
//           selectedTextStyle: TextStyle(color: kButtonColor, fontSize: 24),
//           listViewWidth: 65,
//           initialValue: reps,
//           minValue: 1,
//           maxValue: 20,
//           zeroPad: true,
//           onChanged: (value) {
//             this.setState(() {
//               reps = value;
//             });
//           },
//         ),
//       ]),
//       actions: [
//         new TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: widget.cancelWidget,
//         ),
//         new TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: widget.confirmWidget,
//         ),
//       ],
//     );
//   }
// }
