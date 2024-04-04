import 'package:flutter/material.dart';

class ButtonAddWidget extends StatefulWidget {
  final String buttonName;

  const ButtonAddWidget({Key? key, required this.buttonName}) : super(key: key);

  @override
  State<ButtonAddWidget> createState() => _ButtonAddWidgetState();
}

class _ButtonAddWidgetState extends State<ButtonAddWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
    onPressed: () {},
        child: Text(widget.buttonName),
      ),
    );
  }
}
