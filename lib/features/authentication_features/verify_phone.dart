import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';
import 'package:sports_meet/core/shareable_widgets/primary_button.dart';
import 'package:sports_meet/core/utils/color_palette.dart';
import 'package:sports_meet/core/utils/constants.dart';
import 'package:sports_meet/core/utils/size_manager.dart';
import 'package:sports_meet/features/authentication_features/view_models/verify_phone_view_model.dart';
import 'package:stacked/stacked.dart';

class VerifyPhoneView extends StatefulWidget {
  final String number;
  final String routeName;

  const VerifyPhoneView({
    Key? key,
    required this.number,
    required this.routeName,
  }) : super(key: key);

  @override
  State<VerifyPhoneView> createState() => _VerifyPhoneViewState();
}

class _VerifyPhoneViewState extends State<VerifyPhoneView> {
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  late String number;
  late String routeName;
  late bool disableResendToken;
  late TextEditingController pinController;

  @override
  void initState() {
    super.initState();
    number = widget.number;
    routeName = widget.routeName;
    pinController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return ViewModelBuilder<VerifyPhoneViewModel>.reactive(
      viewModelBuilder: () => VerifyPhoneViewModel(),
      onModelReady: (model) => model.verifyNumber(number, routeName),
      fireOnModelReadyOnce: true,
      builder: (_, model, __) => ModalProgressHUD(
        inAsyncCall: model.isBusy,
        progressIndicator: const CircularProgressIndicator(
          color: Palette.primaryRed,
        ),
        child: Scaffold(
          appBar: AppBar(
          title: Text(
            'Verify Account By Phone Number',
            style: TextStyle(
              fontSize: SizeMg.text(18),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
          body: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              SizedBox(
                height: SizeMg.height(55),
              ),
              Text(
                'Verification',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeMg.text(20),
                  fontWeight: FontWeight.w600,
                  color: Palette.mainBlack,
                ),
              ),

              ///Verification text
              SizedBox(
                height: SizeMg.height(20),
              ),
              Text(
                'Enter the code sent to the number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeMg.text(18),
                  color: Palette.inactiveTextField,
                ),
              ),
              SizedBox(
                height: SizeMg.height(20),
              ),
              Text(
                number,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeMg.text(18),
                  color: Palette.secondaryBlack,
                ),
              ),

              ///Pin Input
              SizedBox(
                height: SizeMg.height(50),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeMg.width(20),
                ),
                child: Pinput(
                  length: 6,
                  defaultPinTheme: kPinInputTheme,
                  focusNode: focusNode,
                  controller: pinController,
                  focusedPinTheme: kPinInputTheme.copyWith(
                    height: SizeMg.height(68),
                    width: SizeMg.width(64),
                    decoration: kPinInputTheme.decoration!.copyWith(
                      border: Border.all(color: Palette.mainBlack),
                    ),
                  ),
                  showCursor: true,
                  onCompleted: (pin) => model.moveToLandingView(pin, routeName),
                ),
              ),

              ///Resend OTP Button
              PrimaryButton(
                margin: EdgeInsets.only(
                  top: SizeMg.height(50),
                  left: SizeMg.width(50),
                  right: SizeMg.width(50),
                ),
                buttonConfig: ButtonConfig(
                  text: 'Resend OTP',
                  action: (){
                    model.verifyNumber(number, routeName);
                  },
                  disabled: model.disableResendToken,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
