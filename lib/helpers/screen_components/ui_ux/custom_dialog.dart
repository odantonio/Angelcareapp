import 'package:flutter/material.dart';

import '../theme/angel-care_theme.dart';

class CustomDialog extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final Widget content;
  final List<Map<String, dynamic>>? actions;
  final EdgeInsetsGeometry padding;
  final double height;
  const CustomDialog(
      {Key? key,
      this.leading,
      this.title,
      required this.content,
      this.actions,
      this.trailing,
      this.height = 242,
      this.padding = const EdgeInsets.fromLTRB(24, 32, 24, 32)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      elevation: CustomThemeData.doubleElevation3,
      backgroundColor: Colors.white,
      child: Container(
        padding: padding,
        child: SizedBox(
          width: double.maxFinite,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  if (leading != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: leading,
                    ),
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: title,
                    ),
                  content,
                  if (trailing != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: trailing,
                    ),
                ],
              ),
              if (actions != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!.map((action) {
                    return TextButton(
                      onPressed: action['function'],
                      child: Text(action['text']),
                    );
                  }).toList(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
