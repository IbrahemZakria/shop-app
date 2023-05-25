import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/categoriesModel.dart';
import 'package:shop_app/model/getFavoritModel.dart';
import 'package:shop_app/model/homeModel.dart';
import 'package:shop_app/moduls/categories/categoriesScreen.dart';
import 'package:shop_app/moduls/favorits/favoritScreen.dart';
import 'package:shop_app/moduls/products/productsScreen.dart';
import 'package:shop_app/moduls/settings/settingsScreen.dart';
import 'package:shop_app/shared/network/local/cashhelper.dart';
import 'package:shop_app/shared/network/remote/Dio_helper.dart';
import 'package:shop_app/shared/network/remote/endpoints.dart';

import '../../model/addFavoritModel.dart';
import '../../model/searchProductModel.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    const productsScreen(),
    const categoriesScreen(),
    const favoritScreen(),
    const settingsScreen()
  ];
  void changebottomNavePar(int index) {
    currentIndex = index;
    emit(changeBottomNaveState());
  }

  homeModel? homemodel;
  List<String> images = [];
  Map<int, bool> favorit = {};
  void gethomedata() {
    emit(homeloadingState());
    diohelper
        .getdata(url: home, token: cashHelper.getString(key: 'token'))
        .then((value) {
      homemodel = homeModel.fromJson(value!.data);
      print(homemodel!.data!.products!.length);
      images = homemodel!.data!.banners!.map((e) => e.image).toList();
      for (var element in homemodel!.data!.products!) {
        favorit.addAll({element.id!.round(): element.inFavorites!});
      }
      emit(homesucessState());
    }).catchError((onError) {
      print(onError);
      emit(homeerrorState());
    });
  }

  categoriesModel? categoriesmodel;
  void getcategorydata() {
    emit(categoryloadingState());
    diohelper
        .getdata(url: category, token: cashHelper.getString(key: 'token'))
        .then((value) {
      categoriesmodel = categoriesModel.fromJson(value!.data);
      print(categoriesmodel!.data!.categorydata![0].image);
      emit(categorysucessState());
    }).catchError((onError) {
      print(onError);
      emit(categoryerrorState());
    });
  }

  addfavoritModel? favoritModel;

  Icon icon = const Icon(Icons.favorite_border);
  void cangefavorit({required int id}) {
    emit(cangefavoritloadingState());
    diohelper
        .postdata(
            url: favorites,
            data: {'product_id': id},
            token: cashHelper.getString(key: 'token'))
        .then((value) {
      favorit[id] = !favorit[id]!;
      getFavorit();
      emit(cangefavoritsucessState());
    }).catchError((onError) {
      emit(cangefavoriterrorState());
    });
  }

  favoritmodel? getfavoritModel;
  void getFavorit() {
    emit(getfavoritloadingState());

    diohelper
        .getdata(url: 'favorites', token: cashHelper.getString(key: 'token'))
        .then((value) {
      getfavoritModel = favoritmodel.fromJson(value!.data);
      print('${getfavoritModel!.data!.favoritdata![0].product!.image}');
      emit(getfavoritsucessState());
    }).catchError((onError) {
      emit(getfavoriterrorState());
      print(onError);
    });
  } searchProductModel? searchmodel;
    Map<int, bool> searchfavorit = {};

  void searchProduct({required String value}) {
    emit(SearchloadingState());
    diohelper.postdata(url: search, data: {'text': value}).then((value) {
      searchmodel = searchProductModel.fromJson(value!.data);
      print('${searchmodel!.data!.searchdata![0].id}');
        for (var element in homemodel!.data!.products!) {
        searchfavorit.addAll({element.id!.round(): element.inFavorites!});
      }
     
      emit(SearchSuccesState());
    }).catchError((onError) {
      print(onError);
      emit(SearcherrorState());
    });
  }

  
}
  