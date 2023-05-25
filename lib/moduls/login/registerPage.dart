import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/moduls/login/cubit/login_cubit.dart';
import 'package:shop_app/moduls/login/mainLogin.dart';

import '../../shared/component/default_button.dart';
import '../../shared/component/textFormField.dart';
class registerPage extends StatelessWidget {
   registerPage({super.key});
    static const String id = 'fds,';
 var emailControler = TextEditingController();
 var nameControler = TextEditingController();
 var phoneControler = TextEditingController();
  var passwordControler = TextEditingController();
  var formkey = GlobalKey<FormState>();
  
  get cashHelper => null;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
if (state is registersucessState) {
            if (state.registermodel.status!) {
              Fluttertoast.showToast(
                msg: "${state.registermodel.message}",
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb:
                    5, // set timeInSecForIosWeb to a value greater than 0
              );
              Navigator.pushNamed(context, mainlogin.id);
              cashHelper.putdata(
                  key: 'token', value: state.registermodel.data!.token);

              print(state.registermodel.message);
            } else {
              Fluttertoast.showToast(
                  msg: "${state.registermodel.message}",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);

              print('${state.registermodel.status}');
            }
          }      },
      builder: (context, state) {          var cubit = LoginCubit.get(context);

        return Scaffold(
          body: Form(
                key: formkey,
                child: Scaffold(
                  body: Center(
                      child: SingleChildScrollView(
                          child: Column(
                    children: [
                      Text(
                        'create an account',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextFormField(
                        hintText: 'name',
                        sufixIcon:
                            IconButton(onPressed: () {}, icon: const Icon(Icons.text_fields_outlined)),
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'please enter the name';
                          }
                          return null;
                        },
                        textControler: nameControler,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextFormField(
                        hintText: 'phone',
                        sufixIcon:
                            IconButton(onPressed: () {}, icon: const Icon(Icons.phone)),
                        textinputType: TextInputType.phone,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return 'please enter the phone';
                          }
                          return null;
                        },
                        textControler: phoneControler,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultTextFormField(
                        hintText: 'email',
                        sufixIcon:
                            IconButton(onPressed: () {}, icon: const Icon(Icons.email)),
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
                                    cubit.registerLogin(name:nameControler.text ,phone:phoneControler.text ,
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
              )
          ,
        );
      },
    );
  }
}