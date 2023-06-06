import 'package:flutter/material.dart';

class ExpandedText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final IconData expandLessIcon;
  final IconData expandMoreIcon;
  const ExpandedText({
    Key? key,
    required this.text,
    this.textStyle,
    this.expandLessIcon = Icons.expand_less,
    this.expandMoreIcon = Icons.expand_more,
  }) : super(key: key);
  @override
  ExpandedTextState createState() => ExpandedTextState();
}

class ExpandedTextState extends State<ExpandedText> {
  bool _isExpanded = false;
  final bool _basicInformationIsExpanded = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final TextSpan span = TextSpan(
        text: widget.text,
        style: widget.textStyle,
      );
      final TextPainter textPainter = TextPainter(
        text: span,
        maxLines: 1,
        ellipsis: '...',
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(maxWidth: constraints.maxWidth);

      if (textPainter.didExceedMaxLines) {
        return Row(
          crossAxisAlignment: _basicInformationIsExpanded
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                widget.text,
                style: widget.textStyle,
                maxLines: _isExpanded ? null : 1,
                overflow: _isExpanded ? null : TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              child: _isExpanded
                  ? Icon(widget.expandLessIcon)
                  : Icon(widget.expandMoreIcon),
              onTap: () {
                setState(() => _isExpanded = !_isExpanded);
              },
            ),
          ],
        );
      } else {
        return Text(
          widget.text,
          style: widget.textStyle,
        );
      }
    });
  }
}
