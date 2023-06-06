import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthAppbar extends PreferredSize {
  final void Function() logout;

  AuthAppbar({
    Key? key,
    required this.logout,
    String? title,
    String theme = 'light',
    String? avatar,
    bool showAvatar = false,
    void Function()? onTap,
  }) : super(
          key: key,
          child: DashboardAppBarContent(
            title: title,
            theme: theme,
            logout: logout,
            avatar: avatar,
            showAvatar: showAvatar,
            onTap: onTap,
          ),
          preferredSize: const Size.fromHeight(72.0),
        );
}

class DashboardAppBarContent extends StatelessWidget {
  final void Function() logout;
  final String? title;
  final String? theme;
  final String? avatar;
  final bool showAvatar;
  final Function()? onTap;

  const DashboardAppBarContent({
    Key? key,
    required this.logout,
    this.title,
    this.theme,
    this.avatar,
    required this.showAvatar,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme == "light"
            ? Theme.of(context).colorScheme.tertiary
            : Theme.of(context).colorScheme.primary,
        gradient: theme == "light"
            ? null
            : LinearGradient(colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary
              ]),
      ),
      child: SafeArea(
        child: Container(
            constraints: const BoxConstraints(maxHeight: 72, minHeight: 72),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                      alignment: Alignment.centerLeft,
                      onPressed: () => Navigator.canPop(context)
                          ? Navigator.of(context).pop()
                          : null,
                      icon: Icon(
                        Icons.chevron_left,
                        color: theme == "light"
                            ? Navigator.canPop(context)
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.transparent
                            : Navigator.canPop(context)
                                ? Colors.white
                                : Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SvgPicture.asset(
                    '${!kIsWeb ? 'assets/' : ''}images/${theme == "light" ? "Logo.svg" : "Logo-white.svg"}',
                    height: 24,
                    width: 106.37,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: showAvatar
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 45,
                                width: 45,
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    )),
                                child: GestureDetector(
                                  onTap: onTap,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: avatar != null
                                        ? NetworkImage(avatar!)
                                        : const AssetImage(
                                                '${!kIsWeb ? 'assets/' : ''}images/default-avatar.png')
                                            as ImageProvider,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
