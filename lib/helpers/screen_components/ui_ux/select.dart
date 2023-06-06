import 'package:flutter/material.dart';

class Select<T> extends StatefulWidget {
  final T? value;
  final List<dynamic> options;
  final String? optionLabel;
  final IconData? icon;
  final String? label;
  final IconData? selectedIcon;
  final void Function(T?)? onChange;
  final bool disabled;
  const Select({
    Key? key,
    required this.value,
    required this.options,
    this.optionLabel,
    this.icon,
    this.label,
    this.selectedIcon,
    required this.onChange,
    this.disabled = false,
  }) : super(key: key);

  @override
  State<Select<T>> createState() => _SelectState<T>();
}

class _SelectState<T> extends State<Select<T>> {
  T? value;
  Color color = Colors.transparent;

  @override
  void initState() {
    setState(() {
      value = widget.value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        label: widget.label != null ? Text(widget.label!) : null,
      ),
      value: value,
      icon: widget.icon != null ? Icon(widget.icon) : null,
      // elevation: CustomThemeData.doubleElevation1.toInt(),
      // style: Theme.of(context).inputDecorationTheme.labelStyle,
      onChanged: widget.disabled
          ? null
          : (T? newValue) {
              if (widget.onChange != null) widget.onChange!(newValue);
              setState(() {
                value = newValue;
              });
            },
      selectedItemBuilder: (BuildContext context) {
        return widget.options.map<Widget>((itemValue) {
          return Text(
            widget.optionLabel == null
                ? itemValue
                : itemValue[widget.optionLabel],
          );
        }).toList();
      },
      items: widget.options.map<DropdownMenuItem<T>>(
        (itemValue) {
          return DropdownMenuItem<T>(
            value: itemValue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.optionLabel == null
                      ? itemValue
                      : itemValue[widget.optionLabel],
                ),
                widget.selectedIcon != null
                    ? value == itemValue
                        ? itemValue = Icon(
                            widget.selectedIcon,
                          )
                        : const SizedBox.shrink()
                    : const SizedBox.shrink(),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
