import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sports_meet/core/shareable_widgets/primary_button.dart';
import 'package:sports_meet/core/utils/color_palette.dart';
import 'package:sports_meet/core/utils/size_manager.dart';
import 'package:sports_meet/core/utils/validator_utils.dart';
import 'package:sports_meet/features/settings_features/view_models/update_password_view_model.dart';
import 'package:stacked/stacked.dart';

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordView> createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {

  final _formKey = GlobalKey<FormState>();
  final FocusManager focusManager = FocusManager.instance;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return ViewModelBuilder<UpdatePasswordViewModel>.reactive(
      viewModelBuilder: () => UpdatePasswordViewModel(),
      onModelReady: (model) => model.fetchPassword(),
      fireOnModelReadyOnce: true,
      builder: (_, model, __) => ModalProgressHUD(
        inAsyncCall: model.isBusy,
        progressIndicator: const CircularProgressIndicator(
          color: Palette.primaryRed,
        ),
        child: GestureDetector(
          onTap: () => focusManager.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Update Password',
                style: TextStyle(
                  fontSize: SizeMg.text(18),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  vertical: SizeMg.height(20),
                  horizontal: SizeMg.width(15),
                ),
                children: [
                  ///New Password Field
                  Text(
                    'New Password',
                    style: TextStyle(
                      fontSize: SizeMg.text(18),
                      color: Palette.primaryRed,
                    ),
                  ),
                  SizedBox(
                    height: SizeMg.height(5),
                  ),
                  TextFormField(
                    controller: _newPasswordController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: model.newPasswordHide,
                    style: TextStyle(
                      fontSize: SizeMg.text(16),
                      fontWeight: FontWeight.w400,
                      color: Palette.mainBlack,
                      letterSpacing: 0.3,
                    ),
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        color: Palette.inactiveTextField,
                      ),
                      suffixIcon: IconButton(
                        onPressed: model.toggleNewPasswordVisibility,
                        icon: Icon(
                          model.newPasswordHide
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Palette.inactiveTextField,
                        ),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (ValidatorUtils.isEmpty(value)) {
                        return 'Password cannot be left blank';
                      }
                      if (ValidatorUtils.shortPassword(value)) {
                        return 'Password min of 6 characters';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: SizeMg.height(25),
                  ),

                  ///Confirm Password Field
                  Text(
                    'Confirm Password',
                    style: TextStyle(
                      fontSize: SizeMg.text(18),
                      color: Palette.primaryRed,
                    ),
                  ),
                  SizedBox(
                    height: SizeMg.height(5),
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: model.confirmPasswordHide,
                    style: TextStyle(
                      fontSize: SizeMg.text(16),
                      fontWeight: FontWeight.w400,
                      color: Palette.mainBlack,
                      letterSpacing: 0.3,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Confirm new password',
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        color: Palette.inactiveTextField,
                      ),
                      suffixIcon: IconButton(
                        onPressed: model.toggleConfirmPasswordVisibility,
                        icon: Icon(
                          model.confirmPasswordHide
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Palette.inactiveTextField,
                        ),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (ValidatorUtils.isEmpty(value)) {
                        return 'Password cannot be left blank';
                      }
                      if (ValidatorUtils.shortPassword(value)) {
                        return 'Password min of 6 characters';
                      }
                      if (value != _newPasswordController.text) {
                        return "Password doesn't match";
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: SizeMg.height(30),
                  ),

                  ///Save changes button
                  PrimaryButton(
                    margin: EdgeInsets.symmetric(
                      vertical: SizeMg.height(20),
                    ),
                    buttonConfig: ButtonConfig(
                      text: 'Update Password',
                      action: (){
                        if (_formKey.currentState!.validate()) {
                          model.updatePassword(
                            newPassword: _newPasswordController.text.trim(),
                            confirmPassword: _confirmPasswordController.text.trim(),
                          );
                        }
                        focusManager.primaryFocus?.unfocus();
                      },
                    ),
                  ),

                  ///Cancel text button
                  GestureDetector(
                    onTap: model.cancel,
                    child: Text(
                      'Cancel',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: SizeMg.text(16),
                        color: Palette.primaryRed,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
