import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/moduls/login/mainLogin.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/cubit/login_cubit.dart';

class onpoardingScreen extends StatelessWidget {
  onpoardingScreen({super.key});
  static const String id = 'fd';
  List<String> imageslist = [
    'assets/images/starting1.png',
    'assets/images/starting2.png',
    'assets/images/starting3.png',
  ];
  var controler = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, mainlogin.id);
                      cubit.checkpoardingMode();
                    },
                    child: const Text("skip"))
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controler,
                    itemCount: imageslist.length,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    itemBuilder: (context, index) {
                      return onpoardingbuilder(imageslist[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      SmoothPageIndicator(
                          controller: controler,
                          count: imageslist.length,
                          effect: const ExpandingDotsEffect(
                              dotColor: Colors.grey,
                              activeDotColor: Colors.green)),
                      const Spacer(),
                      FloatingActionButton(
                        onPressed: () {
                          controler.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.decelerate);
                          if (imageslist.length == 3) {
                            Navigator.pushReplacementNamed(
                                context, mainlogin.id);
                          }
                        },
                        child: const Icon(Icons.arrow_forward),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget onpoardingbuilder(String image) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          Expanded(
              child: Image.asset(
            image,
            width: double.infinity,
            fit: BoxFit.cover,
          )),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
