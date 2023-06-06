import 'package:flutter/material.dart';

class GroupButtons extends StatelessWidget {
  const GroupButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      child: Wrap(
        direction: Axis.horizontal,
        children: const <Widget>[
          Text("A"),
          Text("B"),
          Text("C"),
          Text("D"),
          Text("E"),
          Text("F"),
          Text("G"),
        ],
      ),
    );
  }
}
