import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sports_meet/core/shareable_widgets/primary_button.dart';
import 'package:sports_meet/core/utils/color_palette.dart';
import 'package:sports_meet/core/utils/size_manager.dart';
import 'package:sports_meet/core/utils/validator_utils.dart';
import 'package:sports_meet/core/shareable_widgets/profile_text_field.dart';
import 'package:sports_meet/features/settings_features/view_models/edit_profile_view_model.dart';
import 'package:stacked/stacked.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final FocusManager focusManager = FocusManager.instance;
  String email = '';
  String userName = '';


  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    final double coverHeight = SizeMg.height(280);
    final double profileHeight = SizeMg.height(144);
    final double profilePicRadius = profileHeight / 2;

    return ViewModelBuilder<EditProfileViewModel>.reactive(
      viewModelBuilder: () => EditProfileViewModel(),
      onModelReady: (model) => model.updateProfilePic(),
      fireOnModelReadyOnce: true,
      builder: (ctx, model, __) {
        return ModalProgressHUD(
          inAsyncCall: model.isBusy,
          progressIndicator: const CircularProgressIndicator(
            color: Palette.primaryRed,
          ),
          child: GestureDetector(
            onTap: () => focusManager.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Edit Profile',
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
                  padding: EdgeInsets.only(
                    bottom: SizeMg.height(30),
                  ),
                  children: [
                    ///Images (Profile and cover image)
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        ///Cover Image
                        ColoredBox(
                          color: Colors.grey,
                          child: CachedNetworkImage(
                            width: double.infinity,
                            height: coverHeight,
                            imageUrl: '${model.userModel?.coverImage}',
                            placeholder: (ctx, url) => const Center(
                              child: CircularProgressIndicator(color: Colors.white,),
                            ),
                            errorWidget: (ctx, url, dyn) => const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 50,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),

                        ///Profile Image
                        Positioned(
                          top: coverHeight - profilePicRadius,
                          child: CachedNetworkImage(
                            imageUrl: '${model.userModel?.profileImage}',
                            imageBuilder: (ctx, image) => CircleAvatar(
                              backgroundImage: image,
                              radius: SizeMg.radius(profilePicRadius),
                            ),
                            placeholder: (ctx, url) => CircleAvatar(
                              backgroundColor: Palette.primaryRed,
                              radius: SizeMg.radius(profilePicRadius),
                              child: const Center(
                                child: CircularProgressIndicator(color: Colors.white,),
                              ),
                            ),
                            errorWidget: (ctx, url, dyn) => CircleAvatar(
                              backgroundColor: Palette.primaryRed,
                              radius: SizeMg.radius(profilePicRadius),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),

                        ///Edit Profile Image
                        Positioned(
                          bottom: 0,
                          right: profilePicRadius / 0.8,
                          child: FloatingActionButton(
                            onPressed: () {
                              _showSelectDialog(
                                context: ctx,
                                model: model,
                                profilePic: true,
                              );
                            },
                            elevation: 1.0,
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.edit_rounded,
                              color: Palette.primaryRed,
                            ),
                          ),
                        ),
                        ///Edit Cover Image
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              _showSelectDialog(
                                context: ctx,
                                model: model,
                                profilePic: false,
                              );
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.edit_rounded,
                                color: Palette.primaryRed,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeMg.height(80.0),
                    ),

                    ///Form field
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeMg.width(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ///Email Field
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: SizeMg.text(18),
                              color: Palette.primaryRed,
                            ),
                          ),
                          SizedBox(
                            height: SizeMg.height(5),
                          ),
                          TextFormField(
                            initialValue: '${model.user?.email}',
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value){
                              setState(() {
                                email = value;
                              });
                            },
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

                          ///Verify email only shows if the user email is not verified
                          Visibility(
                            visible: (!model.user!.emailVerified),
                            child:  Padding(
                              padding: EdgeInsets.only(
                                top: SizeMg.height(5),
                              ),
                              child: GestureDetector(
                                onTap: model.verifyEmail,
                                child: Text(
                                  'Click to verify your email address',
                                  style: TextStyle(
                                    fontSize: SizeMg.text(14),
                                    color: Colors.green.shade400,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          ///Username Field
                          SizedBox(
                            height: SizeMg.height(20),
                          ),
                          Text(
                            'Username',
                            style: TextStyle(
                              fontSize: SizeMg.text(18),
                              color: Palette.primaryRed,
                            ),
                          ),
                          SizedBox(
                            height: SizeMg.height(5),
                          ),
                          TextFormField(
                            initialValue: '${model.userModel?.username}',
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
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
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onChanged: (value){
                              setState(() {
                                userName = value;
                              });
                            },
                            validator: (value) {
                              if (ValidatorUtils.isEmpty(value)) {
                                return 'Username cannot be left blank';
                              }
                              return null;
                            },
                          ),

                          ///Phone Number Field not editable
                          SizedBox(
                            height: SizeMg.height(20),
                          ),
                          Text(
                            'Phone Number',
                            style: TextStyle(
                              fontSize: SizeMg.text(18),
                              color: Palette.primaryRed,
                            ),
                          ),
                          SizedBox(
                            height: SizeMg.height(5),
                          ),
                          ProfileTextField(
                            text: '${model.userModel?.number}',
                          ),

                          ///Interest Field not editable
                          Text(
                            'Interests',
                            style: TextStyle(
                              fontSize: SizeMg.text(18),
                              color: Palette.primaryRed,
                            ),
                          ),
                          SizedBox(
                            height: SizeMg.height(5),
                          ),
                          ProfileTextField(
                            text: '${model.userModel?.interests.join(', ')}',
                          ),

                          ///Save changes button
                          PrimaryButton(
                            margin: EdgeInsets.symmetric(
                              vertical: SizeMg.height(20),
                            ),
                            buttonConfig: ButtonConfig(
                              text: 'Save Changes',
                              action: (){
                                if (_formKey.currentState!.validate()) {
                                  model.saveChanges(email: email.trim(), username: userName.trim());
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  void _showSelectDialog({
    required BuildContext context,
    required EditProfileViewModel model,
    required bool profilePic,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.camera_outlined,
              color: Palette.primaryRed,
            ),
            Text(
              'Please choose an option',
              style: TextStyle(
                fontSize: SizeMg.text(18),
                fontWeight: FontWeight.w500,
                color: Palette.mainBlack,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                model.uploadImage(
                  fromPhotos: false,
                  profilePic: profilePic,
                );
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.camera_alt,
                      color: Palette.primaryRed,
                    ),
                  ),
                  Text(
                    'Take photo',
                    style: TextStyle(
                      fontSize: SizeMg.text(16),
                      color: Palette.secondaryBlack,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeMg.height(10),
            ),
            GestureDetector(
              onTap: () {
                model.uploadImage(
                  fromPhotos: true,
                  profilePic: profilePic,
                );
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.image,
                      color: Palette.primaryRed,
                    ),
                  ),
                  Text(
                    'Pick from Gallery',
                    style: TextStyle(
                      fontSize: SizeMg.text(16),
                      color: Palette.secondaryBlack,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
