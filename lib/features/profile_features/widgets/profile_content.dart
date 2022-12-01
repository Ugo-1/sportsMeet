import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports_meet/core/models/user.dart';
import 'package:sports_meet/core/utils/color_palette.dart';
import 'package:sports_meet/core/utils/size_manager.dart';
import 'package:sports_meet/core/shareable_widgets/profile_text_field.dart';

class ProfileContent extends StatelessWidget {

  final UserModel? userModel;
  final User? user;

  const ProfileContent({Key? key, this.userModel, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeMg.width(15),
        vertical: SizeMg.height(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ///Username
          SizedBox(
            height: SizeMg.height(50),
          ),
          Text(
            'Username',
            style: TextStyle(
              fontSize: SizeMg.text(18),
              color: Palette.primaryRed,
            ),
          ),
          ProfileTextField(
            text: '${userModel?.username}',
          ),

          ///Email
          Text(
            'Email',
            style: TextStyle(
              fontSize: SizeMg.text(18),
              color: Palette.primaryRed,
            ),
          ),
          ProfileTextField(
            text: '${user?.email}',
          ),

          ///PhoneNumber
          Text(
            'Phone Number',
            style: TextStyle(
              fontSize: SizeMg.text(18),
              color: Palette.primaryRed,
            ),
          ),
          ProfileTextField(
            text: '${user?.phoneNumber}',
          ),

          ///Interest
          Text(
            'Interests',
            style: TextStyle(
              fontSize: SizeMg.text(18),
              color: Palette.primaryRed,
            ),
          ),
          ProfileTextField(
            text: '${userModel?.interests.join(', ')}',
          ),
        ],
      ),
    );
  }
}
