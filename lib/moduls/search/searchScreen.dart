import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';

class searchScreen extends StatelessWidget {
  searchScreen({super.key});
  static const String id = 'poiuy';
  TextEditingController searchcontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var model = cubit.searchmodel?.data?.searchdata;
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size(double.infinity, 65),
              child: SafeArea(
                  child: Container(
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: Offset(0, 5))
                ]),
                alignment: Alignment.center,
                child: AnimationSearchBar(
                    backIconColor: Colors.black,
                    centerTitle: 'tap to search',
                    onChanged: (text) {
                      cubit.searchProduct(value: text);
                    },
                    horizontalPadding: 5,
                    searchTextEditingController: searchcontroler),
              ))),
          body: ConditionalBuilder(
            builder: (context) {
              return GridView.count(
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
                          Image.network(model[index].image!,
                              width: double.infinity, height: 200),
                          Container(
                            color: Colors.red,
                            // child: Text(
                            //   'DISCOUND ${model[index].discount}%',
                            //   style: const TextStyle(color: Colors.white),
                            // ),
                          )
                        ],
                      ),
                      Text('${model[index].name}', maxLines: 2),
                      const Spacer(),
                      Row(
                        children: [
                          Text('${model[index].price}'),
                          const SizedBox(
                            width: 10,
                          ),
                          // if (model[index].price !=
                          //     model[index].oldPrice)
                          //   // Text(
                          //   '${model[index].oldPrice}',
                          //   style: const TextStyle(
                          //       color: Colors.blue,
                          //       decoration: TextDecoration.lineThrough),
                          // ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                print(model[index].id!.round());
                                ShopCubit.get(context)
                                    .cangefavorit(id: model[index].id!.round());
                              },
                              icon: (ShopCubit.get(context)
                                              .favorit[model[index].id] ==
                                          null ||
                                      ShopCubit.get(context)
                                              .favorit[model[index].id] ==
                                          true)
                                  // icon: cubit.searchfavorit[model[index].id]!
                                  // icon: true
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
              );
            },
            condition: cubit.searchmodel != null,
            fallback: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
    );
  }
}
