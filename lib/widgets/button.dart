import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;

  const CustomButton({
    Key? key,
    required this.onPress,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 12,
              splashFactory: NoSplash.splashFactory  ,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              )),
          onPressed: onPress,

          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          )),
    );
  }
}