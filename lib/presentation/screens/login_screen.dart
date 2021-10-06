import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/application/auth_provider.dart';
import 'package:shopify/presentation/core/app_images.dart';
import 'package:shopify/presentation/screens/bottom_navigation_screen.dart';
import 'package:shopify/presentation/widgets/loading_button.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ChangeNotifierProvider(
        lazy: false,
        create: (context) => AuthProvider()
          ..checkLoginUser(() {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavigationScreen(),
                ));
          }),
        builder: (context, child) {
          final provider = context.watch<AuthProvider>();
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              height: size.height,
              alignment: Alignment.center,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          AppImages.logo,
                          width: size.width / 2,
                        ),
                        Text(
                          'Shopify',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black54,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        TextFormField(
                          validator: (val) {
                            if (val == null) {
                              return 'email should not be empty';
                            } else if (val.isEmpty) {
                              return 'email should not be empty';
                            }
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                          cursorColor: Colors.green,
                          onChanged: provider.onUserNameChanged,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val == null) {
                              return 'password should not be empty';
                            } else if (val.isEmpty) {
                              return 'password should not be empty';
                            }
                          },
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          onChanged: provider.onPasswordChanged,
                        ),
                      ],
                    ),
                    LoadingButton(
                      text: 'Login',
                      isLoading: provider.isloading,
                      width: size.width,
                      onTap: () async {
                        await provider.login();
                        if (formKey.currentState!.validate()) {
                          if (provider.l.error.hasData()) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(provider.l.error.status),
                                content: Text(provider.l.error.message),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('ok'))
                                ],
                              ),
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavigationScreen(),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
