import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final double width;
  final void Function()? onTap;
  const LoadingButton({
    Key? key,
    required this.text,
    required this.isLoading,
    required this.width,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(10),
          // shape: isLoading ? BoxShape.circle : BoxShape.rectangle,
        ),
        width: isLoading ? 60 : width,
        duration: Duration(milliseconds: 250),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isLoading
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Flexible(
                    child: Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ))
          ],
        ),
      ),
    );
  }
}
