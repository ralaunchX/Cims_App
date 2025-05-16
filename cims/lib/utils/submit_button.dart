import 'package:flutter/material.dart';

class CommonSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CommonSubmitButton({
    super.key,
    required this.onPressed,
    this.text = 'Submit',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text),
        ),
      ),
    );
  }
}
