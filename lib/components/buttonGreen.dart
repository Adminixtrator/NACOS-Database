import 'package:centraldb/helpers/colors.dart';
import 'package:flutter/material.dart';

class ButtonGreen extends StatelessWidget {
  ButtonGreen({
    @required this.title,
    @required this.onPressed,
    this.borderRadius,
    this.altWidget,
    this.color,
    this.textStyle,
    this.padding,
    this.enabled,
  });
  final String title;
  final GestureTapCallback onPressed;
  final BorderRadiusGeometry borderRadius;
  final Color color;
  final Widget altWidget;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        colorBrightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        color: color ?? Theme.of(context).buttonColor,
        padding: EdgeInsets.symmetric(horizontal: 0),
        onPressed: onPressed,
        child: altWidget ??
            Container(
              alignment: Alignment.center,
              padding: padding ?? EdgeInsets.symmetric(vertical: 18),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: borderRadius ?? BorderRadius.circular(12),
                  color: enabled != false
                      ? transparent
                      : white.withOpacity(0.5)),
              child: Text(title,
                  style: textStyle ?? Theme.of(context).textTheme.button),
            ),
      ),
    );
  }
}
