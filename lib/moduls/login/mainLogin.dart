import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shopLayout.dart';
import 'package:shop_app/moduls/login/cubit/login_cubit.dart';
import 'package:shop_app/moduls/login/registerPage.dart';
import 'package:shop_app/shared/component/default_button.dart';
import 'package:shop_app/shared/component/textFormField.dart';
import 'package:shop_app/shared/network/local/cashhelper.dart';

class mainlogin extends StatelessWidget {
  mainlogin({super.key});
  static const String id = 'fd,';
  var emailControler = TextEditingController();
  var passwordControler = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is Loginsucssesstate) {
            if (state.loginmodel.status!) {
              Fluttertoast.showToast(
                msg: "${state.loginmodel.message}",
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb:
                    5, // set timeInSecForIosWeb to a value greater than 0
              );
              
              cashHelper.putdata(
                  key: 'token', value: state.loginmodel.data!.token);

              ShopCubit.get(context).getFavorit();
              Navigator.pushReplacementNamed(context, shopLayout.id);
            } else {
              Fluttertoast.showToast(
                  msg: "${state.loginmodel.message}",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);

              print('${state.loginmodel.status}');
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Form(
            key: formkey,
            child: Scaffold(
              body: Center(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultTextFormField(
                    hintText: 'email',
                    sufixIcon: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.email)),
                    textinputType: TextInputType.emailAddress,
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'please enter the Email';
                      }
                      return null;
                    },
                    textControler: emailControler,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultTextFormField(
                    hintText: 'password',
                    obsecuretext: cubit.passwordvisibility,
                    sufixIcon: IconButton(
                        onPressed: () {
                          cubit.changepasswordvisibility();
                        },
                        icon: Icon(cubit.paswordIcon)),
                    textinputType: TextInputType.visiblePassword,
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'please enter the password';
                      }
                      return null;
                    },
                    textControler: passwordControler,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ConditionalBuilder(
                      condition: state == Loginloadinstate,
                      builder: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                      fallback: (context) {
                        return default_button(
                            ontap: () {
                              if (formkey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: emailControler.text,
                                    password: passwordControler.text);
                              }
                            },
                            text: 'Login');
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, registerPage.id);
                          },
                          child: const Text(' register'))
                    ],
                  )
                ],
              ))),
            ),
          );
        },
      ),
    );
  }
}
