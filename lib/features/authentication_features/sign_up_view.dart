import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sports_meet/core/models/interest.dart';
import 'package:sports_meet/core/models/user.dart';
import 'package:sports_meet/core/shareable_widgets/primary_button.dart';
import 'package:sports_meet/core/utils/color_palette.dart';
import 'package:sports_meet/core/utils/constants.dart';
import 'package:sports_meet/core/utils/image_utils.dart';
import 'package:sports_meet/core/utils/size_manager.dart';
import 'package:sports_meet/core/utils/validator_utils.dart';
import 'package:sports_meet/features/authentication_features/view_models/sign_up_view_model.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formSignUpKey = GlobalKey<FormState>();
  final _chipKey = GlobalKey<ChipsInputState>();
  final FocusManager focusManager = FocusManager.instance;
  bool _submitted = false;

  List<String> submitInterest = <String>[];

  late TextEditingController email;
  late TextEditingController username;
  late TextEditingController password;
  late TextEditingController number;
  late TextEditingController confirmPassword;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    username = TextEditingController();
    password = TextEditingController();
    number = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (_, model, __) => GestureDetector(
        onTap: () => focusManager.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ModalProgressHUD(
            inAsyncCall: model.isBusy,
            progressIndicator: const CircularProgressIndicator(
              color: Palette.primaryRed,
            ),
            child: SafeArea(
              child: Form(
                key: _formSignUpKey,
                child: ListView(
                  padding: EdgeInsets.only(
                    left: SizeMg.width(30.0),
                    right: SizeMg.width(30.0),
                    top: SizeMg.height(30.0),
                  ),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Image.asset(
                      ImageUtils.splashIcon,
                      height: SizeMg.height(100),
                    ),
                    Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: SizeMg.text(30.0),
                      ),
                    ),

                    ///EmailField
                    SizedBox(
                      height: SizeMg.height(50.0),
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

                    ///UsernameField
                    SizedBox(
                      height: SizeMg.height(20.0),
                    ),
                    TextFormField(
                      controller: username,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        fontSize: SizeMg.text(16),
                        fontWeight: FontWeight.w400,
                        color: Palette.mainBlack,
                        letterSpacing: 0.3,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(
                          Icons.person_outline_rounded,
                          color: Palette.inactiveTextField,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (ValidatorUtils.isEmpty(value)) {
                          return 'Username cannot be left blank';
                        }
                        return null;
                      },
                    ),

                    ///PhoneNumber
                    SizedBox(
                      height: SizeMg.height(20.0),
                    ),
                    IntlPhoneField(
                      initialCountryCode: 'NG',
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        fontSize: SizeMg.text(16),
                        fontWeight: FontWeight.w400,
                        color: Palette.mainBlack,
                        letterSpacing: 0.3,
                      ),
                      pickerDialogStyle: PickerDialogStyle(
                        searchFieldInputDecoration: kIntlPhoneDecoration,
                      ),
                      dropdownIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Palette.mainBlack,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Phone number',
                      ),
                      onChanged: (phoneNumber) {
                        setState(() {
                          number.text = phoneNumber.completeNumber;
                        });
                      },
                    ),

                    ///Interest
                    SizedBox(
                      height: SizeMg.height(10.0),
                    ),
                    ChipsInput(
                      key: _chipKey,
                      decoration: InputDecoration(
                        hintText: 'Select Interests',
                        contentPadding: EdgeInsets.symmetric(
                          vertical: SizeMg.height(10),
                          horizontal: SizeMg.width(15),
                        ),
                        errorText: _submitted ? _errorText : null,
                      ),
                      chipBuilder: (ctx, state, Interest interest) => InputChip(
                        key: ObjectKey(interest),
                        backgroundColor: Colors.white,
                        label: Text(
                          interest.name,
                          style: TextStyle(
                            fontSize: SizeMg.text(16),
                            fontWeight: FontWeight.w400,
                            color: Palette.mainBlack,
                            letterSpacing: 0.3,
                          ),
                        ),
                        avatar: Icon(
                          interest.iconData,
                          color: interest.color,
                        ),
                        onDeleted: () => state.deleteChip(interest),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      suggestionBuilder: (ctx, state, Interest interest) =>
                          ListTile(
                        key: ObjectKey(interest),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            interest.iconData,
                            color: interest.color,
                          ),
                        ),
                        title: Text(interest.name),
                        onTap: () => state.selectSuggestion(interest),
                      ),
                      findSuggestions: (String query) {
                        if (query.isNotEmpty) {
                          String lowercaseQuery = query.toLowerCase();
                          return model.interestList.where((interest) {
                            return interest.name
                                .toLowerCase()
                                .contains(query.toLowerCase());
                          }).toList(growable: false)
                            ..sort((a, b) => a.name
                                .toLowerCase()
                                .indexOf(lowercaseQuery)
                                .compareTo(b.name
                                    .toLowerCase()
                                    .indexOf(lowercaseQuery)));
                        }
                        return model.interestList;
                      },
                      onChanged: (data) {
                        submitInterest =
                            data.map((interest) => interest.name).toList();
                      },
                    ),

                    ///Password
                    SizedBox(
                      height: SizeMg.height(20.0),
                    ),
                    TextFormField(
                      controller: password,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: model.passwordHide,
                      style: TextStyle(
                        fontSize: SizeMg.text(16),
                        fontWeight: FontWeight.w400,
                        color: Palette.mainBlack,
                        letterSpacing: 0.3,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: Palette.inactiveTextField,
                        ),
                        suffixIcon: IconButton(
                          onPressed: model.togglePasswordVisibility,
                          icon: Icon(
                            model.passwordHide
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

                    ///ConfirmPassword
                    SizedBox(
                      height: SizeMg.height(20.0),
                    ),
                    TextFormField(
                      controller: confirmPassword,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: model.confirmPasswordHide,
                      style: TextStyle(
                          fontSize: SizeMg.text(16),
                          fontWeight: FontWeight.w400,
                          color: Palette.mainBlack,
                          letterSpacing: 0.3),
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
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
                        if (value != password.text) {
                          return "Password doesn't match";
                        }
                        return null;
                      },
                    ),

                    /// Sign Up Button
                    SizedBox(
                      height: SizeMg.height(50.0),
                    ),
                    PrimaryButton(
                      buttonConfig: ButtonConfig(
                        text: 'Sign Up',
                        action: () {
                          setState(() {
                            _submitted = true;
                          });
                          if (_formSignUpKey.currentState!.validate()) {
                            if (_errorText == null) {
                              model.signUp(
                                email: email.text.trim(),
                                password: password.text.trim(),
                                userModel: UserModel(
                                  number: number.text.trim(),
                                  username: username.text.trim(),
                                  interests: submitInterest,
                                ),
                              );
                            }
                          }
                          focusManager.primaryFocus?.unfocus();
                        },
                      ),
                    ),

                    ///Login text
                    SizedBox(
                      height: SizeMg.height(30.0),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Already have an account?  ',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: SizeMg.text(16),
                        ),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: const TextStyle(
                              color: Palette.primaryRed,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = model.moveToLoginView,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeMg.height(30.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? get _errorText {
    if (submitInterest.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  @override
  void dispose() {
    email.dispose();
    username.dispose();
    password.dispose();
    number.dispose();
    confirmPassword.dispose();
    super.dispose();
  }
}
