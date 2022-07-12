import 'package:flutter/material.dart';

class ADropDown extends StatefulWidget
{
  ADropDown({Key? key}) : super(key:key);

  String dropDownText = "";

  @override
  State<ADropDown> createState() => DropDownState();
}

class DropDownState extends State<ADropDown>
{
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context)
  {
    return
      Row(
      children:
      <Widget>[
        Container(
            margin: const EdgeInsets.all(5),
        child:Text(
            widget.dropDownText
        )),
        DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      //style: const TextStyle(color: Colors.green),
      underline: Container(
        height: 2,
        color: Colors.white70,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['One', 'Two', 'Three', 'Four','Five','Six','Seven','All']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    )]
      );
  }
}