import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/moduls/login/cubit/login_cubit.dart';
import 'package:shop_app/shared/component/default_button.dart';
import 'package:shop_app/shared/component/textFormField.dart';

import '../../layout/cubit/shop_cubit.dart';

class profileEditing extends StatelessWidget {
  profileEditing({super.key});

  static const String id = 'kfc';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        TextEditingController? namecontroler =
            TextEditingController(text: cubit.getprofilemodel!.data!.name);
        TextEditingController? emailcontroler =
            TextEditingController(text: cubit.getprofilemodel!.data!.email);
        TextEditingController? phonecontroler =
            TextEditingController(text: cubit.getprofilemodel!.data!.phone);
        TextEditingController? imagecontroler =
            TextEditingController(text: cubit.getprofilemodel!.data!.image);

        return Scaffold(
          appBar: AppBar(
            title: const Text('profile editing'),
          ),
          body: Container(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  defaultTextFormField(
                    hintText: 'name',
                    sufixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.title),
                    ),
                    onsubmited: (p0) {
                      namecontroler!.text = p0;
                    },
                    textControler: namecontroler,
                  ),
                  defaultTextFormField(
                    hintText: 'email',
                    sufixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.email),
                    ),
                    onsubmited: (p0) {
                      emailcontroler?.text = p0;
                    },
                    textControler: emailcontroler,
                    textinputType: TextInputType.emailAddress,
                  ),
                  defaultTextFormField(
                    hintText: 'phone',
                    sufixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.phone),
                    ),
                    onsubmited: (p0) {
                      phonecontroler?.text = p0;
                    },
                    textControler: phonecontroler,
                    textinputType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .15,
                  ),
                  default_button(
                      ontap: () {
                        cubit.ubdateProfile(
                            name: namecontroler?.text,
                            email: emailcontroler?.text,
                            image: imagecontroler?.text,
                            phone: phonecontroler?.text);
                        cubit.GetProfile();
                      },
                      text: 'submit')
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
