import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sports_meet/core/utils/color_palette.dart';
import 'package:sports_meet/core/utils/size_manager.dart';
import 'package:sports_meet/features/profile_features/view_models/profile_view_model.dart';
import 'package:sports_meet/features/profile_features/widgets/profile_content.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    final double coverHeight = SizeMg.height(280);
    final double profileHeight = SizeMg.height(144);
    final double profilePicRadius = profileHeight / 2;

    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (ctx, model, __) => ModalProgressHUD(
        inAsyncCall: model.isBusy,
        progressIndicator: const CircularProgressIndicator(
          color: Palette.primaryRed,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: SizeMg.text(18),
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(
            shrinkWrap: true,
            children: [

              ///Image
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
                        child: CircularProgressIndicator(),
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
                ],
              ),

              ///Profile body
              ProfileContent(
                userModel: model.userModel,
                user: user,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

