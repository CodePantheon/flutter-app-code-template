import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void pushPage(final BuildContext context, final Widget page) {
  Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.rightToLeft,
      child: page,
    ),
  );
}

void replacePage(final BuildContext context, final Widget page) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) => page,
    ),
  );
}

String getTimeText(int timeInSeconds) {
  final int hours = timeInSeconds ~/ 3600;
  final int minutes = (timeInSeconds % 3600) ~/ 60;
  final int seconds = (timeInSeconds % 3600) % 60;

  return '${hours.toString().padLeft(2, '0')}'
      ':${minutes.toString().padLeft(2, '0')}'
      ':${seconds.toString().padLeft(2, '0')}';
}
