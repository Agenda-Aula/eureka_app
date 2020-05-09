import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final double width;
  final VoidCallback onPressed;

  CustomRaisedButton({
    this.child,
    this.color,
    this.borderRadius: 4.0,
    this.height: 60.0,
    this.width: 220.0,
    this.onPressed,
  }) : assert(borderRadius != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xfffbb448),
            Color(0xfff7892b),
          ],
        ),
      ),
      child: SizedBox(
        child: RaisedButton(
          child: child,
          color: color,
          disabledColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
          onPressed: this.onPressed,
        ),
      ),
    );
  }
}
