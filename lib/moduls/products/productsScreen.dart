import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';

import '../../shared/component/component.dart';

class productsScreen extends StatelessWidget {
  const productsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var model = cubit.homemodel?.data!.products;
        var categorymodel = cubit.categoriesmodel?.data!.categorydata;

        return ConditionalBuilder(
            condition: cubit.images.isEmpty,
            builder: (context) => const Scaffold(),
            fallback: (context) {
              return Scaffold(
                body: ConditionalBuilder(
                    condition: cubit.images.isNotEmpty &&
                        categorymodel != null,
                    fallback: (context) => const Center(
                            child: CircularProgressIndicator(
                          color: Colors.amber,
                        )),
                    builder: (context) => SingleChildScrollView(
                          child: Column(
                            children: [
                              FanCarouselImageSlider(
                                imagesLink: cubit.images,
                                isAssets: false,
                                initalPageIndex: 0,
                                showIndicator: false,
                                sliderHeight: 250,
                              ),
                              Container(
                                  color: Colors.grey[100],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Categories',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              color: Colors.white,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 120,
                                              child: 
                                              ListView.separated(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return
                                                     Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .bottomStart,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .3,
                                                          child: Image.network(
                                                              categorymodel[
                                                                      index]
                                                                  .image!,
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                        Container(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    .4),
                                                            child: Text(
                                                              categorymodel[
                                                                      index]
                                                                  .name!,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ))
                                                      ],
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const SizedBox(
                                                      width: 10,
                                                    );
                                                  },
                                                  itemCount:
                                                      categorymodel!.length,
                                                  scrollDirection:
                                                      Axis.horizontal),
                                            ),
                                            const Text(
                                              'News Product',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GridView.count(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        crossAxisCount: 2,
                                        childAspectRatio: 1 / 1.6,
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 2,
                                        children: List.generate(model!.length,
                                            (index) {
                                          return gridViewItem(
                                              model[index], context);
                                        }),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        )),
              );
            });
      },
    );
  }

  
}
