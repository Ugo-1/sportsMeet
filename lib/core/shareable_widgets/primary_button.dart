import 'package:flutter/material.dart';
import 'package:sports_meet/core/utils/color_palette.dart';
import 'package:sports_meet/core/utils/size_manager.dart';

class PrimaryButton extends StatelessWidget {
  final ButtonConfig buttonConfig;
  final double height;
  final EdgeInsets? margin;
  final double width;
  final Color color, textColor;

  const PrimaryButton(
      {Key? key,
        required this.buttonConfig,
        this.height = 54.0,
        this.margin,
        this.width = double.infinity,
        this.textColor = Colors.white,
        this.color = Palette.primaryRed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Container(
      height: height,
      width: width,
      margin: margin ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: buttonConfig.disabled ? Palette.staleWhite : color,
        borderRadius: BorderRadius.circular(
          SizeMg.radius(10),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: buttonConfig.disabled ? null : buttonConfig.action,
          highlightColor: Palette.primaryRed.withOpacity(0.3),
          child: Center(
            child: Text(
              buttonConfig.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: buttonConfig.disabled ? Palette.inactiveGray : textColor,
                fontSize: SizeMg.text(18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OutlinePrimaryButton extends StatelessWidget {
  final ButtonConfig buttonConfig;
  final double height;
  final EdgeInsets? margin;
  final double width;
  final Color color, textColor;

  const OutlinePrimaryButton(
      {Key? key,
        required this.buttonConfig,
        this.height = 54.0,
        this.margin,
        this.width = double.infinity,
        this.textColor = Palette.primaryRed,
        this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Container(
      height: height,
      width: width,
      margin: margin ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          SizeMg.radius(10),
        ),
        border: Border.all(color: Palette.primaryRed,),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: buttonConfig.action,
          highlightColor: Colors.white.withOpacity(0.3),
          child: Center(
            child: Text(
              buttonConfig.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: textColor,
                fontSize: SizeMg.text(18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonConfig {
  final String text;
  final VoidCallback action;
  final bool disabled;

  ButtonConfig({
    required this.text,
    required this.action,
    this.disabled = false,
  });
}
