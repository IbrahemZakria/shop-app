import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/loginModel.dart';
import 'package:shop_app/shared/network/local/cashhelper.dart';
import 'package:shop_app/shared/network/remote/Dio_helper.dart';
import 'package:shop_app/shared/network/remote/endpoints.dart';

import '../../../model/getProfileModel.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialstate());
  static LoginCubit get(context) => BlocProvider.of(context);
  loginModel loginmodel = loginModel();
  void registerLogin(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    diohelper.postdata(url: register, data: {
      "email": email,
      "password": password,
      "name": name,
      "phone": phone,
      "image":
          "https://student.valuxapps.com/storage/uploads/users/gt8NF13Jwt_1685005973.jpeg"
    }).then((value) {
      emit(registerloadingState());
      registermodel = loginModel.fromJson(value!.data);
      print(registermodel.message);
      GetProfile();
      emit(registersucessState(registermodel));
    }).catchError((onError) {
      print(onError);
      emit(registererrorState());
    });
  }

  loginModel registermodel = loginModel();
  void userLogin({required String email, required String password}) {
    emit(Loginloadinstate());

    diohelper.postdata(
        url: login, data: {"email": email, "password": password}).then((value) {
      loginmodel = loginModel.fromJson(value!.data);

      emit(Loginsucssesstate(loginmodel));
      GetProfile();
    }).catchError((onError) {
      emit(Loginerrorstate(onError));
    });
  }

  IconData paswordIcon = Icons.visibility_sharp;
  bool passwordvisibility = false;
  void changepasswordvisibility() {
    paswordIcon = passwordvisibility
        ? Icons.visibility_sharp
        : Icons.visibility_off_sharp;
    passwordvisibility = !passwordvisibility;

    emit(passwordvisibilitystate());
  }

  bool isdark = cashHelper.getbolean(key: 'isdark') ?? false;
  void changeThemeMode() {
    isdark = !isdark;
    cashHelper
        .putdata(key: 'isdark', value: isdark)
        .then((value) => emit(changethemsstate()));
  }

  bool isboarding = cashHelper.getbolean(key: 'isboarding') ?? false;
  void checkpoardingMode() {
    isboarding = !isboarding;
    cashHelper
        .putdata(key: 'isboarding', value: isboarding)
        .then((value) => emit(checkpoardingstate()));
  }

  getProfileModel? getprofilemodel;
  var profilename;
  var profileemail;
  var profilephone;
  var profilewalet;
  var profilepoints;
  var profileimage;
  void GetProfile() {
    emit(GetProfileloadingState());
    diohelper
        .getdata(url: 'profile', token: cashHelper.getString(key: 'token'))
        .then((value) {
      getprofilemodel = getProfileModel.fromJson(value!.data);

     
      emit(GetProfilesucessState());
    }).catchError((onError) {
      print(onError);
    });
  }

  getProfileModel? ubdateprofilemodel;
  void ubdateProfile(
      {String? name, String? email, String? image, String? phone}) {
    emit(ubdateProfileloadingState());
    diohelper.putdata(
        url: 'profile',
        token: cashHelper.getString(key: 'token'),
        data: {
          "name": name,
          "phone": phone,
          "email": email,
          "image": image
        }).then((value) {
      ubdateprofilemodel = getProfileModel.fromJson(value!.data);

      emit(ubdateProfilesucessState());
    }).catchError((onError) {
      print(onError);
      emit(ubdateProfileerrorState());
    });
  }
}
