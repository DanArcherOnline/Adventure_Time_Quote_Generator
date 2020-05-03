import 'package:flutter/material.dart';

class BmoBody extends StatelessWidget {
  final Widget diskDrive;
  final Widget plusButton;
  final Widget longOvalButtonLeft;
  final Widget longOvalButtonRight;
  final Widget blueOvalButton;
  final Widget trinagleButton;
  final Widget greenOvalButton;
  final Widget redOvalButton;

  const BmoBody({
    Key key,
    this.diskDrive,
    this.plusButton,
    this.longOvalButtonLeft,
    this.longOvalButtonRight,
    this.blueOvalButton,
    this.trinagleButton,
    this.greenOvalButton,
    this.redOvalButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // color: Colors.yellow,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Image.asset(BmoImages.diskDrive),
                    this.diskDrive ?? Container(),
                    SizedBox(height: 52.0),
                    Container(
                      height: 102.0,
                      width: 99.0,
                      child: this.plusButton ?? Container(),
                    ),
                    SizedBox(height: 56.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: this.longOvalButtonLeft ?? Container(),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: this.longOvalButtonRight ?? Container(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                // color: Colors.blue,
                padding: EdgeInsets.only(top: 7.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Align(
                      child: Container(
                        height: 31.0,
                        width: 31.0,
                        child: this.blueOvalButton ?? Container(),
                      ),
                      alignment: Alignment.topCenter,
                    ),
                    Positioned(
                      child: Container(
                        height: 59.0,
                        width: 74.0,
                        child: this.trinagleButton ?? Container(),
                      ),
                      top: 85.0,
                      left: 20.0,
                    ),
                    Positioned(
                      child: Container(
                        height: 44.0,
                        width: 44.0,
                        child: this.greenOvalButton ?? Container(),
                      ),
                      top: 117.0,
                      left: 120.0,
                    ),
                    Positioned(
                      child: Container(
                        height: 104.0,
                        width: 104.0,
                        child: this.redOvalButton ?? Container(),
                      ),
                      top: 160.0,
                      left: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
