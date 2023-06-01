import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/moduls/login/cubit/login_cubit.dart';
import 'package:shop_app/moduls/search/searchScreen.dart';

class shopLayout extends StatefulWidget {
  const shopLayout({super.key});
  static const String id = 'fd,f';

  @override
  State<shopLayout> createState() => _shopLayoutState();
}

class _shopLayoutState extends State<shopLayout> {
  bool showavatar = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        var shopcubit = ShopCubit.get(context);
        return 
        Scaffold(
          drawer: Drawer(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        showavatar = !showavatar;
                        setState(() {});
                      },
                      child: showavatar
                          ? CircleAvatar(
                              child: Image.network(
                                  cubit.getprofilemodel?.data?.image ?? ''),
                            )
                          : const Placeholder(),
                    ),
                    Text(
                      'HI ${cubit.getprofilemodel?.data?.name?.split(' ')[0]}',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.text_fields),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      cubit.getprofilemodel?.data?.name ?? '',
                      style: const TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.email),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      cubit.getprofilemodel?.data?.email ?? '',
                      style: const TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.phone),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      cubit.getprofilemodel?.data?.phone ?? '',
                      style: const TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.credit_card),
                    const SizedBox(
                      width: 20,
                    ),
                    Text("${cubit.getprofilemodel?.data?.credit}",
                        style: const TextStyle(fontSize: 20))
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.point_of_sale_rounded),
                    const SizedBox(
                      width: 20,
                    ),
                    Text("${cubit.getprofilemodel?.data?.points ?? ''}",
                        style: const TextStyle(fontSize: 20))
                  ],
                )
              ],
            ),
          )),
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, searchScreen.id);
                  },
                  icon: const Icon(Icons.search))
            ],
            title: const Text('Sala'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'products'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined), label: 'catigories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'favorit'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'setting'),
            ],
            onTap: (value) {
              shopcubit.changebottomNavePar(value);
            },
            currentIndex: shopcubit.currentIndex,
          ),
          body: shopcubit.screens[shopcubit.currentIndex],
          floatingActionButton: FloatingActionButton(onPressed: () {
            
          }),
        );
      },
    );
  }
}
