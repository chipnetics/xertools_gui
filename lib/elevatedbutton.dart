import 'package:flutter/material.dart';

// StatelessWidget does not need createState
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