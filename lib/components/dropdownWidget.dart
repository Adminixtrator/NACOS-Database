import 'package:centraldb/helpers/fonts.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  DropdownWidget({
    this.store,
    this.title,
    this.altColor,
    this.altDropdownColor,
    this.altTextColor,
    this.callback,
    this.borderRadius,
    this.altArrowColor,
    this.arrowSize,
    this.padding,
    this.iconPadding,
    this.textSize,
    this.width,
  });
  final List store;
  final String title;
  final Color altColor, altArrowColor, altDropdownColor, altTextColor;
  final ValueChanged<String> callback;
  final BorderRadius borderRadius;
  final double arrowSize;
  final double textSize;
  final double width;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry iconPadding;

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String _title;

  @override
  void initState() {
    super.initState();
    setState(() => _title = widget.title);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: widget.padding,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        color: widget.altColor ?? Color(0xffF3F4F8),
      ),
      child: DropdownButton<String>(
          hint: Container(
            width: widget.width,
            child: Text(
              _title,
              style: TextStyle(
                color: widget.altTextColor ?? Color(0xff2254D3),
                fontSize: widget.textSize ?? 12,
                fontWeight: semiBold,
                fontFamily: 'MontSerrat',
              ),
              overflow: TextOverflow.ellipsis,
              // softWrap: false,
            ),
          ),
          items: widget.store
              .map(
                (value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                  onTap: () => setState(() => _title = value),
                ),
              )
              .toList(),
          onChanged: widget.callback,
          // isExpanded: true,
          style: TextStyle(
            color: widget.altTextColor ?? Color(0xff828A95),
            fontSize: 12,
          ),
          underline: SizedBox(),
          dropdownColor: widget.altDropdownColor ?? Colors.white,
          iconDisabledColor: Color(0xff2254D3),
          icon: Container(
            padding: widget.iconPadding,
            child: Icon(
              Icons.keyboard_arrow_down,
              size: widget.arrowSize ?? 20,
              color: widget.altArrowColor ?? Color(0xff2254D3),
            ),
          )),
    );
  }
}
