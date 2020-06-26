import 'dart:async';
import 'package:app/features/authentication/domain/usecases/authenticate_with_credentials.dart';
import 'package:app/features/authentication/presentation/view/sign_up/validator.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'sign_in.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthenticateWithCredentials _signInWithCredentials;

  LoginBloc({
    @required AuthenticateWithCredentials signInWithCredentials,
  })  : assert(signInWithCredentials != null),
        _signInWithCredentials = signInWithCredentials;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.updateEmail(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.updatePassword(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
//    try {
//      await _userRepository.signInWithGoogle();
//      yield LoginState.success();
//    } catch (_) {
//      yield LoginState.failure();
//    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      await _signInWithCredentials.call(Params(email, password));
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
