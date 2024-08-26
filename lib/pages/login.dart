import 'package:flutter/material.dart';
import '../controller/login.dart'; // Make sure this path is correct
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _focusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8BA9F8),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Image.asset(
                    'assets/logo.png',
                    height: 100,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "ระบบควบคุมคุณภาพ",
                    style: TextStyle(
                      fontFamily: 'K2D',
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "ส่วนงานรับผิดชอบโดยฝ่ายควบคุมคุณภาพ",
                    style: TextStyle(
                      fontFamily: 'K2D',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 400,
                    height: 250,
                    padding: EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'รหัสพนักงาน',
                          focusNode: _focusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                        ),
                        SizedBox(height: 35),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'เลข 5 ตัวสุดท้ายของบัตรประชาชน',
                          obscureText: true,
                          onFieldSubmitted: (_) {
                            validateAndSubmit(context, _formKey, _emailController, _passwordController);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  GradientButton(
                    text: 'เข้าสู่ระบบเพื่อใช้งาน',
                    onPressed: () => validateAndSubmit(context, _formKey, _emailController, _passwordController),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
