import 'package:flutter/material.dart';

const menuItems = <MenuItem>[
  MenuItem('Home', Icons.home),
  MenuItem('Library', Icons.menu_book),
  MenuItem('Search', Icons.search),
  MenuItem('History', Icons.history),
  MenuItem('Community', Icons.people),
];

class MenuItem {
  final String name;
  final IconData icon;
  const MenuItem(this.name, this.icon);
}
