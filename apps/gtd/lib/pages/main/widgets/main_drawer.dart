
import 'package:flutter/material.dart';
import 'package:theming/main.dart';

class MainDrawer extends CustomThemeSwitchingStatelessMixin {
  const MainDrawer({super.key});

  @override
  Widget buildWithTheme(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const <Widget>[
          DrawerHeader(
            child: Text(
              'Drawer Header',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: CustomThemeSwitcher(),
          ),
          ListTile(
            title: Text('Item 1'),
          ),
          ListTile(
            title: Text('Item 2'),
          ),
        ],
      ),
    );
  }


}