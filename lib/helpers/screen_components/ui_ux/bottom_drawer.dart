import 'package:flutter/material.dart';

class BottomDrawer extends StatelessWidget {
  final void Function()? onButtonPress;
  final Widget buttonText;
  const BottomDrawer({
    Key? key,
    required this.onButtonPress,
    required this.buttonText,
  }) : super(key: key);

  // @override
  // State<BottomDrawer> createState() => _BottomDrawerState();
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: _heightAnim.value.height,
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.14),
              blurRadius: 12,
              offset: Offset(0, 9)),
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.12),
              blurRadius: 16,
              offset: Offset(0, 3))
        ],
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 22, 32, 22),
        child: ElevatedButton(
          onPressed: onButtonPress != null
              ? () => {
                    onButtonPress!(),
                    // triggerAnimation(),
                  }
              : null,
          child: buttonText,
        ),
      ),
    );
    // );
  }
}
