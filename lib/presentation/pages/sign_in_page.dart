import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _autoLogin = false; // 자동 로그인 체크 상태

  @override
  void initState() {
    super.initState();
    _checkAutoLogin(); // 앱 실행 시 자동 로그인 확인
  }

  Future<void> _checkAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? savedAutoLogin = prefs.getBool('auto_login');
    if (savedAutoLogin == true) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          if (mounted) {
            context.go('/');
          } // 로그인된 경우 홈 화면으로 이동
        }
      });
    }
  }

  Future<void> _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // 입력값 유효성 검사
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("이메일과 비밀번호를 입력하세요.")),
      );
      return;
    }

    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("올바른 이메일 형식을 입력하세요.")),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("비밀번호는 6자 이상이어야 합니다.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (_autoLogin) {
        await prefs.setBool('auto_login', true);
        await prefs.setString('logged_in_email', email);
      } else {
        await prefs.remove('auto_login');
        await prefs.remove('logged_in_email');
      }

      if (mounted) {
        context.go('/'); // 로그인 성공 시 홈 화면으로 이동
      }
    } on FirebaseAuthException catch (e) {
      String message = '로그인 실패';
      if (e.code == 'user-not-found') {
        message = '사용자를 찾을 수 없습니다.';
      } else if (e.code == 'wrong-password') {
        message = '비밀번호가 틀렸습니다.';
      } else if (e.code == 'too-many-requests') {
        message = '로그인 시도가 너무 많습니다. 잠시 후 다시 시도하세요.';
      } else if (e.code == 'invalid-email') {
        message = '잘못된 이메일 형식입니다.';
      }
      {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.replace('/start');
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('로그인', style: AppTextStyle.authTitle),
              const SizedBox(height: 40),
              _buildInputField(
                  controller: _emailController,
                  icon: Icons.person,
                  hintText: '이메일'),
              const SizedBox(height: 16),
              _buildInputField(
                  controller: _passwordController,
                  icon: Icons.lock,
                  hintText: '비밀번호',
                  obscureText: true),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _autoLogin,
                    onChanged: (value) {
                      setState(() {
                        _autoLogin = value ?? false;
                      });
                    },
                  ),
                  Text('자동 로그인', style: AppTextStyle.authAutoLogin),
                ],
              ),
              const SizedBox(height: 30),
              _buildLoginButton(),
              if (_isLoading)
                const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      {required TextEditingController controller,
      required IconData icon,
      required String hintText,
      bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.black),
        hintText: hintText,
        hintStyle: AppTextStyle.authTextField,
        filled: true,
        fillColor: AppColors.middleGray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: 260,
      height: 49,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _signIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text('로그인', style: AppTextStyle.authTextButton),
      ),
    );
  }
}
