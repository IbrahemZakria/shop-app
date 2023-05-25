part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class changeBottomNaveState extends ShopState {}

class homeloadingState extends ShopState {}

class homesucessState extends ShopState {}

class homeerrorState extends ShopState {}

class categoryloadingState extends ShopState {}

class categorysucessState extends ShopState {}

class categoryerrorState extends ShopState {}

class cangefavoritloadingState extends ShopState {}

class cangefavoritsucessState extends ShopState {}

class cangefavoriterrorState extends ShopState {}

class getfavoritloadingState extends ShopState {}

class getfavoritsucessState extends ShopState {}

class getfavoriterrorState extends ShopState {}
class SearchloadingState extends ShopState {}

class SearchSuccesState extends ShopState {}

class SearcherrorState extends ShopState {}

