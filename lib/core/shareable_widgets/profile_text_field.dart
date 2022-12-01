import 'package:flutter/material.dart';
import 'package:sports_meet/core/utils/color_palette.dart';
import 'package:sports_meet/core/utils/size_manager.dart';

class ProfileTextField extends StatelessWidget {

  final String text;

  const ProfileTextField({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Container(
      margin: EdgeInsets.only(
        top: SizeMg.height(5),
        bottom: SizeMg.height(25),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeMg.width(10),
        vertical: SizeMg.height(15),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeMg.radius(10),
        ),
        border: Border.all(
          color: Palette.inactiveTextField,
        ),
        color: Palette.inactiveGray,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Palette.secondaryBlack,
          fontSize: SizeMg.text(16),
        ),
      ),
    );
  }
}
