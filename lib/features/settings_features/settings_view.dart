import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sports_meet/core/shareable_widgets/primary_button.dart';
import 'package:sports_meet/core/utils/color_palette.dart';
import 'package:sports_meet/core/utils/size_manager.dart';
import 'package:sports_meet/features/settings_features/view_models/settings_view_model.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Scaffold(
      backgroundColor: Palette.inactiveGray,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: SizeMg.text(18),
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: ViewModelBuilder<SettingsViewModel>.reactive(
        viewModelBuilder: () => SettingsViewModel(),
        onModelReady: (model) => model.fetchProfile(),
        builder: (ctx, model, __) => ListView(
          padding: EdgeInsets.symmetric(
            vertical: SizeMg.height(30),
          ),
          shrinkWrap: true,
          children: [
            ///Account container
            GestureDetector(
              onTap: model.moveToEditProfileView,
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.only(
                  bottom: SizeMg.height(20),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeMg.width(15),
                  vertical: SizeMg.height(10),
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: CachedNetworkImage(
                        imageUrl: '${model.userModel?.profileImage}',
                        imageBuilder: (ctx, image) => CircleAvatar(
                          backgroundImage: image,
                          radius: SizeMg.radius(40),
                        ),
                        placeholder: (ctx, url) => CircleAvatar(
                          backgroundColor: Palette.primaryRed,
                          radius: SizeMg.radius(40),
                          child: const Center(
                            child: CircularProgressIndicator(color: Colors.white,),
                          ),
                        ),
                        errorWidget: (ctx, url, dyn) => CircleAvatar(
                          backgroundColor: Palette.primaryRed,
                          radius: SizeMg.radius(40),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: SizeMg.width(10),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            '${model.userModel?.username}',
                            style: TextStyle(
                              fontSize: SizeMg.text(18),
                              fontWeight: FontWeight.w500,
                              color: Palette.mainBlack,
                            ),
                          ),
                          SizedBox(
                            height: SizeMg.height(7),
                          ),
                          Builder(
                            builder: (ctx) {
                              if (model.user != null &&
                                  model.user!.emailVerified) {
                                return Text(
                                  '${model.user!.email}',
                                  style: TextStyle(
                                    fontSize: SizeMg.text(16),
                                    color: Palette.inactiveTextField,
                                  ),
                                );
                              }
                              return Text(
                                'Email not verified',
                                style: TextStyle(
                                  fontSize: SizeMg.text(16),
                                  color: Colors.red,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const Flexible(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Palette.inactiveTextField,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///First settings group
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) => ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeMg.width(15),
                ),
                tileColor: Colors.white,
                onTap: model.firstSettingsList[index].onTap,
                title: Text(
                  model.firstSettingsList[index].name,
                  style: TextStyle(
                    fontSize: SizeMg.text(18),
                    color: Palette.mainBlack,
                  ),
                ),
                trailing: (model.firstSettingsList[index].onTap != null)
                    ? const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Palette.inactiveTextField,
                      )
                    : null,
              ),
              separatorBuilder: (ctx, index) => const ColoredBox(
                color: Colors.white,
                child: Divider(),
              ),
              itemCount: model.firstSettingsList.length,
            ),
            SizedBox(
              height: SizeMg.height(20),
            ),

            ///Second settings group
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) => ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeMg.width(15),
                ),
                tileColor: Colors.white,
                onTap: model.secondSettingsList[index].onTap,
                title: Text(
                  model.secondSettingsList[index].name,
                  style: TextStyle(
                    fontSize: SizeMg.text(18),
                    color: Palette.mainBlack,
                  ),
                ),
                trailing: (model.secondSettingsList[index].onTap != null)
                    ? const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Palette.inactiveTextField,
                )
                    : null,
              ),
              separatorBuilder: (ctx, index) => const ColoredBox(
                color: Colors.white,
                child: Divider(),
              ),
              itemCount: model.secondSettingsList.length,
            ),
            SizedBox(
              height: SizeMg.height(30),
            ),

            ///Logout button
            OutlinePrimaryButton(
              margin: EdgeInsets.symmetric(
                horizontal: SizeMg.width(50),
              ),
              buttonConfig: ButtonConfig(
                text: 'Log Out',
                action: model.logOut,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
