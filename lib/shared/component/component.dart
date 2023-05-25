import 'package:flutter/material.dart';

import '../../layout/cubit/shop_cubit.dart';
import '../../model/homeModel.dart';

Widget gridViewItem(Products model, context) => Container(
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image.network(model.image!,
                    width: double.infinity, height: 200),
                Container(
                  color: Colors.red,
                  child: Text(
                    'DISCOUND ${model.discount}%',
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            Text('${model.name}', maxLines: 2),
            const Spacer(),
            Row(
              children: [
                Text('${model.price}'),
                const SizedBox(
                  width: 10,
                ),
                if (model.price != model.oldPrice)
                  Text(
                    '${model.oldPrice}',
                    style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.lineThrough),
                  ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      print(model.id!.round());
                      ShopCubit.get(context)
                          .cangefavorit(id: model.id!.round());
                    },
                    icon: ShopCubit.get(context).favorit[model.id]!
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
        ),
      );