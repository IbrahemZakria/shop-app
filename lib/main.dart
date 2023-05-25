import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shopLayout.dart';
import 'package:shop_app/moduls/login/mainLogin.dart';
import 'package:shop_app/moduls/login/registerPage.dart';
import 'package:shop_app/moduls/onbaording/onboarding.dart';
import 'package:shop_app/moduls/profileEditing/profileEditing.dart';
import 'package:shop_app/moduls/search/searchScreen.dart';
import 'package:shop_app/shared/component/BlocObserver%20.dart';
import 'package:shop_app/shared/network/local/cashhelper.dart';
import 'package:shop_app/shared/style/My_Theme_Data.dart';

import 'moduls/login/cubit/login_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await cashHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String? homepage;
  String? token = cashHelper.getString(key: 'token');

  bool? isboarding = cashHelper.getbolean(key: 'isboarding') ?? false;
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (isboarding!) {
      if (token == null || token!.isEmpty) {
        homepage = mainlogin.id;
      } else {
        homepage = shopLayout.id;
      }
    } else {
      homepage = onpoardingScreen.id;
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit()..GetProfile(),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..gethomedata()
            ..getcategorydata()
            ..getFavorit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: {
          onpoardingScreen.id: (context) => onpoardingScreen(),
          mainlogin.id: (context) => mainlogin(),
          registerPage.id: (context) => registerPage(),
          shopLayout.id: (context) => const shopLayout(),
          searchScreen.id: (context) =>  searchScreen(),
          profileEditing.id: (context) => profileEditing()
        },
        theme: themes.lightmode,
        initialRoute: homepage,
      ),
    );
  }
}
