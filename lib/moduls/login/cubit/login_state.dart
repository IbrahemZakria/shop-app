part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitialstate extends LoginState {}

class changethemsstate extends LoginState {}

class checkpoardingstate extends LoginState {}

class Loginloadinstate extends LoginState {}

class Loginsucssesstate extends LoginState {
  final loginModel loginmodel;
  Loginsucssesstate(this.loginmodel);
}

class passwordvisibilitystate extends LoginState {}

class Loginerrorstate extends LoginState {
  final String error;
  Loginerrorstate(this.error);
}

class GetProfileloadingState extends LoginState {}

class GetProfilesucessState extends LoginState {}

class GetProfileerrorState extends LoginState {}

class registerloadingState extends LoginState {}

class registersucessState extends LoginState {
  final loginModel registermodel;
  registersucessState(this.registermodel);
}

class registererrorState extends LoginState {}

class ubdateProfileloadingState extends LoginState {}

class ubdateProfilesucessState extends LoginState {}

class ubdateProfileerrorState extends LoginState {}
