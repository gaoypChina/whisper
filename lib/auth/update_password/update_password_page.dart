// material
import 'package:flutter/material.dart';
// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:whisper/constants/colors.dart';
import 'package:whisper/constants/doubles.dart';
// components
import 'package:whisper/details/rounded_button.dart';
import 'package:whisper/details/rounded_password_field.dart';
// model
import 'update_password_model.dart';

class UpdatePasswordPage extends ConsumerWidget {

  const UpdatePasswordPage({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  final User? currentUser;

  @override 
  Widget build(BuildContext context, WidgetRef ref) {

    final updatePasswordModel = ref.watch(updatePasswordProvider);
    final newPasswordInputController = TextEditingController(text: updatePasswordModel.newPassword);
    final confirmPasswordInputController = TextEditingController(text: updatePasswordModel.confirmPassword);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('update password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RoundedPasswordField(
              hintText: '新しいパスワード', 
              controller: newPasswordInputController, 
              onChanged:  (text) {
                updatePasswordModel.newPassword = text;
              },
              paste: (value) {
                updatePasswordModel.newPassword = value;
              },
            ),
          ),
          Center(
            child: RoundedPasswordField(
              hintText: 'パスワード(確認)', 
              controller: confirmPasswordInputController, 
              onChanged:  (text) {
                updatePasswordModel.confirmPassword = text;
              },
              paste: (value) {
                updatePasswordModel.confirmPassword = value;
              },
            ),
          ),
          Center(
            child: RoundedButton(
              text: 'パスワードを更新', 
              widthRate: 0.95,
              fontSize: defaultHeaderTextSize(context: context),
              press:  () async {
                await updatePasswordModel.onUpdateButtonPressed(context: context);
              }, 
              textColor: Colors.white, 
              buttonColor: kSecondaryColor
            ),
          )
        ],
      ),
    );
  }
}
