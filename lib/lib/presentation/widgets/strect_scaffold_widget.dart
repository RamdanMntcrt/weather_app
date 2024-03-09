import 'package:flutter/material.dart';

class StretchScaffold extends StatelessWidget {
  final Widget child;

  const StretchScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StretchingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: child,
        ));
  }
}
