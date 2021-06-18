import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  ButtonIcon({@required this.icon, @required this.onPress});

  final icon;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        child: Icon(
          icon,
          color: Colors.black,
        ),
        onPressed: onPress,
        constraints: BoxConstraints.tightFor(
          height:27.0,
          width: 27.0,
        ),
    );
  }
}
