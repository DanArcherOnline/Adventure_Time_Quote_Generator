import 'package:flutter/material.dart';

import '../images.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 33,
        right: 86,
        top: 60,
        bottom: 90.0,
      ),
      child: Image.asset(
        BmoImages.faceThink,
      ),
    );
  }
}
