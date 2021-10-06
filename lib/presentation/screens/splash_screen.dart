import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopify/presentation/core/app_animations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          height: size.height,
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                AppAnimations.loadingBag,
              ),
              Text(
                'Shopify...',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontStyle: FontStyle.italic),
              ),
            ],
          )),
    );
  }
}
