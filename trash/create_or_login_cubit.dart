import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrLoginCubit extends Cubit<CreateOrLoginState> {
  CreateOrLoginCubit() : super(CreateOrLoginInitial());
  bool login = true;

  void changescreen() {
    login = !(login);
    emit(ChangeScreen(loginState: login));
  }
}

abstract class CreateOrLoginState {}

class CreateOrLoginInitial extends CreateOrLoginState {}

class ChangeScreen extends CreateOrLoginState {
  final bool loginState;

  ChangeScreen({required this.loginState});
}
