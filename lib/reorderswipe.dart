// Copyright (c) 2022 jeffrey -at- ieee.org. All rights reserved.
// Use of this source code (/program) is governed by a GPLV3 license,
// that can be found in the LICENSE file. Do not remove this header.
import 'package:flutter/material.dart';

class XER {
  String name;
  String modified;
  String fullpath;

  XER({this.name = "", this.modified ="", this.fullpath =""});
}

class XERList extends StatefulWidget {

  XERList({Key? key}) : super(key:key);

  List<XER> items = []; // For our list of XER structs (Classes)

  List<String> currentPaths() {
    List<String> retList = [];
    items.forEach((element) { retList.add(element.fullpath);});
    return retList;
  }

  @override
  State<XERList> createState() => _XERListState();
}

class _XERListState extends State<XERList> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: ReorderableListView(
        onReorder: onReorder,
        children: _getListItems(),
      ),
    );
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    setState(() {
      XER song = widget.items[oldIndex];

      widget.items.removeAt(oldIndex);
      widget.items.insert(newIndex, song);
    });
  }

  List<Widget> _getListItems() => widget.items
      .asMap()
      .map((i, item) => MapEntry(i, _buildTenableListTile(item, i)))
      .values
      .toList();

  Widget _buildTenableListTile(XER item, int index) {
    return Dismissible(
      key: Key(item.name),
      onDismissed: (direction) {
        setState(() {
          widget.items.removeAt(index);
        });
      },
      background: Container(color: Colors.red),
      child: ListTile(
        key: ValueKey(item.name),
        title: Text(
          item.name,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Modified: ${item.modified}',
          style: const TextStyle(
            color: Colors.blueAccent,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}