import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAnimatedIcon extends StatefulWidget {
  final Color color;
  final IconData icon;
  final bool isToggleable;
  final bool isActive;
  final void Function()? onTap;
  CustomAnimatedIcon(
      {Key? key,
      required this.color,
      required this.icon,
      this.isToggleable = true,
      required this.isActive,
      this.onTap})
      : super(key: key);

  @override
  _CustomAnimatedIconState createState() => _CustomAnimatedIconState();
}

class _CustomAnimatedIconState extends State<CustomAnimatedIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        alignment: Alignment.center,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isToggleable
                ? widget.isActive
                    ? widget.color
                    : Colors.transparent
                : widget.color,
            boxShadow: <BoxShadow>[
              if (widget.isActive)
                BoxShadow(
                  blurRadius: 5,
                  color: widget.color.withAlpha(100),
                  offset: Offset(-4, 4),
                  spreadRadius: 4,
                )
            ]),
        child: Icon(
          widget.icon,
          color: widget.isToggleable
              ? widget.isActive
                  ? Colors.white
                  : Colors.grey
              : Colors.white,
        ),
      ),
    );
  }
}
