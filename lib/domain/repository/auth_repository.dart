// 인증 관련 기능을 추상화한 리포지토리 인터페이스를 정의하는 파일입니다. signUp과 logIn 메서드를 선언하여, 구현체에서 해당 메서드를 구현하도록 합니다

import 'package:health_routine/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> signUp(User user);
  Future<User> logIn(String email, String password);
}
