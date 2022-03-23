import 'package:flutter/material.dart';
import 'package:parking/values/app_texts.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        fixedSize: const Size(81, 48),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () async {
        onPressed.call();
      },
      child: const Text(
        AppTexts.save,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
