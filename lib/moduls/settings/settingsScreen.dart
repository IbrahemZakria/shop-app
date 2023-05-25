import 'package:flutter/material.dart';
import 'package:shop_app/moduls/login/mainLogin.dart';
import 'package:shop_app/moduls/profileEditing/profileEditing.dart';
import 'package:shop_app/shared/network/local/cashhelper.dart';

class settingsScreen extends StatelessWidget {
  const settingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const Icon(Icons.edit),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, profileEditing.id);
                  },
                  child: const Text("profile editing?")),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.logout),
              TextButton(
                  onPressed: () { cashHelper.removedata(Key: 'token');
                    cashHelper.removedata(Key: 'profilename'  );
                    cashHelper.removedata(Key: 'profileemail' );
                    cashHelper.removedata(Key: 'profilephone' );
                    cashHelper.removedata(Key: 'profilewalet' );
                    cashHelper.removedata(Key: 'profilepoints');
                    cashHelper.removedata(Key: 'profileimage' );
                    Navigator.pushReplacementNamed(context, mainlogin.id);
                   
                  },
                  child: const Text(
                    "log out?",
                  )),
            ],
          )
        ],
      ),
    );
  }
}
