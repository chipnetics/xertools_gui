// Copyright (c) 2022 jeffrey -at- ieee.org. All rights reserved.
// Use of this source code (/program) is governed by a GPLV3 license,
// that can be found in the LICENSE file. Do not remove this header.
import 'package:flutter/material.dart';
class AElevatedButton extends StatelessWidget
{
  final String buttonText;
  final String? buttonTooltip;
  final VoidCallback? onTap;

  const AElevatedButton({required this.buttonText, this.onTap, this.buttonTooltip});

  @override
  Widget build(BuildContext context) {

    void _showSnack() => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Button Tapped"),
      duration: Duration(milliseconds: 500),)
    
    );

    return Container( 
        margin: const EdgeInsets.all(5),
        child: Tooltip(
          message: buttonTooltip ?? "", // If null, just ""
          child:ElevatedButton(
            onPressed: onTap,
             //onPressed: _showSnack(),
            child: Text(buttonText)
        ),
    )
    );
  }
}