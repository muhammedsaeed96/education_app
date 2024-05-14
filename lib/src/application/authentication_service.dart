import 'package:education_app/src/data/authentication_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/authentication_model.dart';

class AuthenticationService {
  AuthenticationService(this.authenticationRepository);

  final AuthenticationRepository authenticationRepository;

  Future<void> requestOtpForSignIn(
      {required String phone, required String accountType}) async {
    await authenticationRepository.requestOtpForSignIn(
      phone: phone,
      accountType: accountType,
    );
  }

  Future<void> requestOtpForSignup({
    required String phone,
    required String accountType,
  }) async {
    await authenticationRepository.requestOtpForSignup(
      phone: phone,
      accountType: accountType,
    );
  }

  Future<void> verifyOtp({
    required String phone,
    required String otp,
    required String accountType,
  }) async {
    await authenticationRepository.verifyOtp(
      phone: phone,
      otp: otp,
      accountType: accountType,
    );
  }

  Future<void> createUserAccount(AuthenticationModel authentication) async {
    await authenticationRepository.createUserAccount(authentication);
  }
}

final authenticationServiceProvider =
    Provider.autoDispose<AuthenticationService>(
  (ref) => AuthenticationService(ref.read(authenticationRepositoryProvider)),
);
