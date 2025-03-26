import 'package:health_routine/domain/entities/user.dart';
import 'package:health_routine/domain/repository/auth_repository.dart';
import 'package:health_routine/data/data_sources/firebase_auth_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<User> signUp(User user) async {
    return await _dataSource.signUp(user);
  }

  @override
  Future<User> logIn(String email, String password) async {
    final firebaseUser = await _dataSource.logIn(email, password);

    // Firestore에서 사용자 데이터 가져오기
    final userDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.userKey.toString());
    final userDoc = await userDocRef.get();

    if (userDoc.exists) {
      return User(
        userKey: firebaseUser.userKey,
        userID: userDoc['userID'] ?? '',
        email: firebaseUser.email,
        phone: userDoc['phone'] ?? '',
        password: firebaseUser.password,
        name: userDoc['name'] ?? '',
        level: userDoc['level'],
        createAt: DateTime.parse(
            userDoc['createAt'] ?? DateTime.now().toIso8601String()),
        updateAt: userDoc['updateAt'] != null
            ? DateTime.parse(userDoc['updateAt'])
            : null,
        goal: userDoc['goal'] ?? '',
      );
    } else {
      throw Exception("Firestore에 사용자 정보가 없습니다.");
    }
  }
}
