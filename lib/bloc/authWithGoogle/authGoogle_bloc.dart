import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_flutter/bloc/authWithGoogle/authGoogle_event.dart';
import 'package:stock_flutter/bloc/authWithGoogle/authGoogle_state.dart';
import 'package:stock_flutter/repositories/authGoogle_repository.dart';

class AuthGoogleBloc extends Bloc<AuthGoogleEvent, AuthGoogleState> {
  final AuthGoogleRepository authGoogleRepository;

  AuthGoogleBloc({required this.authGoogleRepository})
      : super(AuthGoogleInitial()) {
    on<GoogleSignInRequested>(onSignInGoogleRequested);
    on<GoogleSignOutRequested>(onSignOutGoogleRequested);
  }

  Future<void> onSignInGoogleRequested(
      GoogleSignInRequested event, Emitter<AuthGoogleState> emit) async {
    emit(AuthGoogleLoading());

    try {
      final user = await authGoogleRepository.signInWithGoogle();

      if (user != null) {
        print('user name login with google: ${user.id}');
        print('user name login with google: ${user.userName}');
        print('user name login with google: ${user.email}');
        print('user token login with google: ${user.token}');
        emit(AuthGoogleAuthenticated(user: user));
      } else {
        emit(AuthGoogleError(message: 'Đăng nhập không thành công'));
      }
    } catch (e) {
      emit(AuthGoogleError(message: e.toString()));
    }
  }

  Future<void> onSignOutGoogleRequested(
      GoogleSignOutRequested event, Emitter<AuthGoogleState> emit) async {
    await authGoogleRepository.signOut();
    emit(UnAuthGoogleAuthenticated());
  }
}
