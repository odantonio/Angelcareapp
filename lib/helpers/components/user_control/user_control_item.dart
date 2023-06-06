import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../screen_components/theme/angel-care_theme.dart';

class UserControlItem extends StatefulWidget {
  //final Monitored monitored;
  final void Function(bool, int) onSwitch;
  final List<Map<String, dynamic>> controls;
  const UserControlItem({
    super.key,
    //required this.monitored,
    required this.onSwitch,
    required this.controls,
  });

  @override
  State<UserControlItem> createState() => _UserControlItemState();
}

class _UserControlItemState extends State<UserControlItem>
    with TickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late Animation<double> animation = CurvedAnimation(
    parent: animationController,
    curve: Curves.fastOutSlowIn,
  );

  late AnimationController animationControllerRotate = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  @override
  void initState() {
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    animationControllerRotate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: CustomThemeData.doubleElevation2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (animationController.isCompleted) {
                    animationController.reverse();
                  } else {
                    animationController.forward();
                  }
                  if (animationControllerRotate.isCompleted) {
                    animationControllerRotate.reverse();
                  } else {
                    animationControllerRotate.forward();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: CircleAvatar(
                          // radius: 24,
                          backgroundImage: AssetImage(
                            '${!kIsWeb ? 'assets/' : ''}images/default-avatar.png',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'widget.monitored.name',
                              style:
                                  Theme.of(context).textTheme.bodyMedium!.merge(
                                        const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text('número do telefone',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ),
                          ],
                        ),
                      ),
                      RotationTransition(
                        turns: Tween(begin: 0.0, end: 0.5)
                            .animate(animationControllerRotate),
                        child: Icon(Icons.expand_less,
                            color: Theme.of(context).colorScheme.grey5),
                      ),
                    ],
                  ),
                ),
              ),
              SizeTransition(
                axisAlignment: 1.0,
                sizeFactor: animation,
                child: Column(
                  children: [
                    Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.grey4,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.controls
                            .map(
                              (control) => Row(
                                children: [
                                  Switch(
                                    value: control['value'],
                                    onChanged: (value) => widget.onSwitch(
                                      value,
                                      widget.controls.indexOf(control),
                                    ),
                                  ),
                                  Text(
                                    control['name'],
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
