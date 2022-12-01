import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sports_meet/core/shareable_widgets/primary_button.dart';
import 'package:sports_meet/core/utils/color_palette.dart';
import 'package:sports_meet/core/utils/size_manager.dart';
import 'package:sports_meet/core/utils/validator_utils.dart';
import 'package:sports_meet/features/authentication_features/view_models/forgot_password_view_model.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final FocusManager focusManager = FocusManager.instance;
  late TextEditingController email;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return GestureDetector(
      onTap: () => focusManager.primaryFocus?.unfocus(),
      child: ViewModelBuilder<ForgotPasswordViewModel>.reactive(
        viewModelBuilder: () => ForgotPasswordViewModel(),
        builder: (_, model, __) => ModalProgressHUD(
          inAsyncCall: model.isBusy,
          progressIndicator: const CircularProgressIndicator(
            color: Palette.primaryRed,
          ),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: SizeMg.text(18),
                ),
              ),
              titleSpacing: 0,
            ),
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: Center(
                  child: ListView(
                    padding: EdgeInsets.only(
                      left: SizeMg.width(26.0),
                      right: SizeMg.width(26.0),
                    ),
                    shrinkWrap: true,
                    children: [
                      Text(
                        'Provide your email and we will send you a link to reset your password',
                        style: TextStyle(
                          fontSize: SizeMg.text(20),
                          color: Palette.mainBlack,
                        ),
                      ),

                      ///Email field
                      SizedBox(
                        height: SizeMg.height(32),
                      ),
                      TextFormField(
                        controller: email,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontSize: SizeMg.text(16),
                          fontWeight: FontWeight.w400,
                          color: Palette.mainBlack,
                          letterSpacing: 0.3,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Palette.inactiveTextField,
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (ValidatorUtils.isEmpty(value)) {
                            return 'Email cannot be left blank';
                          }
                          if (ValidatorUtils.isNotEmail(value)) {
                            return 'Email must contain @';
                          }
                          return null;
                        },
                      ),


                      ///Reset password
                      PrimaryButton(
                        margin: EdgeInsets.symmetric(
                          vertical: SizeMg.height(40),
                        ),
                        buttonConfig: ButtonConfig(
                          text: 'Reset Password',
                          action: () {
                            if (_formKey.currentState!.validate()) {
                              model.resetPassword(email: email.text.trim());
                            }
                            focusManager.primaryFocus?.unfocus();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    focusManager.dispose();
    super.dispose();
  }
}