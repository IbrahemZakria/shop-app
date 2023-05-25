import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/shop_cubit.dart';

class favoritScreen extends StatelessWidget {
  const favoritScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var model = cubit.getfavoritModel!.data!.favoritdata;
        return Scaffold(
          body: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.6,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            children: List.generate(model!.length, (index) {
              return Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image.network(model[index].product!.image!,
                          width: double.infinity, height: 200),
                      Container(
                        color: Colors.red,
                        child: Text(
                          'DISCOUND ${model[index].product!.discount}%',
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Text('${model[index].product!.name}', maxLines: 2),
                  const Spacer(),
                  Row(
                    children: [
                      Text('${model[index].product!.price}'),
                      const SizedBox(
                        width: 10,
                      ),
                      if (model[index].product!.price !=
                          model[index].product!.oldPrice)
                        Text(
                          '${model[index].product!.oldPrice}',
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            print(model[index].product!.id!.round());
                            ShopCubit.get(context).cangefavorit(
                                id: model[index].product!.id!.round());
                          },
                          icon: ShopCubit.get(context)
                                  .favorit[model[index].product!.id]!
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(Icons.favorite_border))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
