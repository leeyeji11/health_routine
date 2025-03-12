import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:health_routine/core/show_snack_bars.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) {
        Showsnackbars.showSnackBar(context, "회원가입 성공!");
      }
      if (mounted) {
        Navigator.pop(context);
      }
      // 회원가입 후 로그인 화면으로 이동
    } catch (e) {
      if (mounted) {
        Showsnackbars.showSnackBar(context, "회원가입 실패 : $e");
      }
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '회원가입',
                  style: AppTextStyle.authTitle,
                ),
                const SizedBox(height: 40),
                _buildInputField(
                  controller: _emailController,
                  icon: Icons.email,
                  hintText: '이메일 주소',
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _phoneController,
                  icon: Icons.phone,
                  hintText: '휴대폰 번호',
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _idController,
                  icon: Icons.person,
                  hintText: 'ID',
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _passwordController,
                  icon: Icons.lock,
                  hintText: '비밀번호',
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                _buildSignupButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    required bool obscureText,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        hintText: hintText,
        hintStyle: AppTextStyle.authTextField,
        filled: true,
        fillColor: AppColors.middleGray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }

  Widget _buildSignupButton() {
    return SizedBox(
      width: 260,
      height: 49,
      child: ElevatedButton(
        onPressed: _signUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text(
          '회원가입',
          style: AppTextStyle.authTextButton,
        ),
      ),
    );
  }
}
