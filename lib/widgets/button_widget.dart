import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ButtonWidget extends StatelessWidget {
  // passing in a color, text color, and a string
  final Color backgroundcolor;
  final String text;
  final Color textColor;

  const ButtonWidget({Key? key, 
    required this.backgroundcolor, 
    required this.text, 
    required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      // dynamic height based on the size of the device, divided by 14
      height: MediaQuery.of(context).size.height/14,
      decoration: BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: Text(
          text, 
          style: TextStyle(
            fontSize: 24,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
