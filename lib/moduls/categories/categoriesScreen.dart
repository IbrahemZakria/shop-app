import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';

class categoriesScreen extends StatelessWidget {
  const categoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        var categorymodel = cubit.categoriesmodel?.data!.categorydata;

        return Scaffold(
          body: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Image.network(categorymodel[index].image!,
                        fit: BoxFit.cover),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(categorymodel[index].name!,
                      style: Theme.of(context).textTheme.displayLarge),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.keyboard_arrow_right_sharp,
                        size: 50,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 10,
              );
            },
            itemCount: categorymodel!.length,
          ),
        );
      },
    );
  }
}
