// Firebase Authentication과 직접 상호작용하는 데이터 소스 클래스 파일입니다. signUp과 logIn 메서드를 통해 Firebase와 통신하여 사용자 인증을 처리합니다.

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:health_routine/domain/entities/user.dart';
import 'package:health_routine/domain/repository/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource(this._firebaseAuth);

  // ⭐️ 회원가입 함수
  Future<User> signUp(User user) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      // Firestore에 사용자 데이터 저장
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(result.user!.uid);

      await userDocRef.set({
        'userID': user.userID,
        'email': user.email,
        'phone': user.phone,
        'name': user.name,
        'level': user.level,
        'createAt': user.createAt?.toIso8601String(),
        'updateAt': user.updateAt?.toIso8601String(),
        'goal': user.goal,
      });

      // Firestore에서 저장한 데이터 가져오기
      final userDoc = await userDocRef.get();

      return User(
        userKey: BigInt.parse(result.user!.uid),
        userID: userDoc['userID'] ?? '', // Firestore에서 가져옴
        email: user.email,
        phone: user.phone,
        password: user.password,
        name: user.name,
        level: user.level,
        createAt: user.createAt,
        updateAt: user.updateAt,
        goal: user.goal,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      // Firebase에서 발생하는 오류 처리
      if (e.code == 'email-already-in-use') {
        throw Exception('이미 사용 중인 이메일입니다.');
      } else if (e.code == 'weak-password') {
        throw Exception('비밀번호가 너무 약합니다.');
      } else if (e.code == 'invalid-email') {
        throw Exception('유효하지 않은 이메일 형식입니다.');
      } else {
        throw Exception('회원가입에 실패했습니다. 다시 시도해 주세요.');
      }
    } catch (e) {
      throw Exception('알 수 없는 오류가 발생했습니다.');
    }
  }

  // ⭐️ 로그인 함수
  Future<User> logIn(String email, String password) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Firebase User 객체를 도메인 User 객체로 변환하여 반환
    return User(
      userKey: BigInt.parse(result.user!.uid),
      userID: '', // 필요에 따라 설정
      email: email,
      phone: '', // 필요에 따라 설정
      password: password,
      createAt: DateTime.now(),
    );
  }
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<User> signUp(User user) {
    return _dataSource.signUp(user);
  }

  @override
  Future<User> logIn(String email, String password) {
    return _dataSource.logIn(email, password);
  }
}
