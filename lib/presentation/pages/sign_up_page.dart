import 'package:flutter/material.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
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
                icon: Icons.email,
                hintText: '이메일 주소',
                obscureText: false,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                icon: Icons.phone,
                hintText: '휴대폰 번호',
                obscureText: false,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                icon: Icons.person,
                hintText: 'ID',
                obscureText: false,
              ),
              const SizedBox(height: 16),
              _buildInputField(
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
    );
  }

  /// 입력 필드 공통 위젯
  Widget _buildInputField({
    required IconData icon,
    required String hintText,
    required bool obscureText,
  }) {
    return TextField(
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

  /// 회원가입 버튼
  Widget _buildSignupButton() {
    return SizedBox(
      width: 260,
      height: 49,
      child: ElevatedButton(
        onPressed: () {
          // 회원가입 버튼 클릭 시 동작 추가
        },
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
