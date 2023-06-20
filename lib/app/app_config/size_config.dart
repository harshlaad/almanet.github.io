import 'package:flutter/material.dart';

class SizeConfig {
  static late double _screenWidth;
  static double _screenHeight = 0;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double textMultiplier = 0;
  static double imageSizeMultiplier = 0;
  static double heightMultiplier = 0;
  static double widthMultiplier = 0;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  double setWidth(num value) => value * _screenWidth;
  double setHeight(num value) => value * _screenHeight;
  double setBlockHeigth(num value) => value * _blockHeight;
  double setBlockWidth(num value) => value * _blockWidth;
  double setTextMultiplier(num value) => value * textMultiplier;
  double setImageSizeMultiplier(num value) => value * imageSizeMultiplier;
  double setHeightMultiplier(num value) => value * heightMultiplier;
  double setWidthMultiplier(num value) => value * widthMultiplier;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (_screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;
  }
}

extension SizeConfigExtension on num {
  double get fullWidth => SizeConfig().setWidth(this);
  double get fullHeight => SizeConfig().setHeight(this);
  double get sp => SizeConfig().setTextMultiplier(this);
  double get iM => SizeConfig().setImageSizeMultiplier(this);
  double get h => SizeConfig().setHeightMultiplier(this);
  double get r => SizeConfig().setHeightMultiplier(this);
  double get w => SizeConfig().setWidthMultiplier(this);
}
