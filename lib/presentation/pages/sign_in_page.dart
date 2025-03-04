import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.push('/start'),
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '로그인',
                style: AppTextStyle.authTitle,
              ),
              const SizedBox(height: 40),
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
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                      value: false,
                      onChanged: (value) {
                        // Todo: 자동 로그인 기능 추가
                      }),
                  Text(
                    '자동 로그인',
                    style: AppTextStyle.authAutoLogin,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String hintText,
    required bool obscureText,
  }) {
    return TextField(
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
        contentPadding: EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: 260,
      height: 49,
      child: ElevatedButton(
        onPressed: () {
          // 로그인 버튼 클릭 시 동작 추가
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text(
          '로그인',
          style: AppTextStyle.authTextButton,
        ),
      ),
    );
  }
}
