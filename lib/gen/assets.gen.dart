/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class $AssetsIconscGen {
  const $AssetsIconscGen();

  /// File path: assets/iconsc/about_us.svg
  SvgGenImage get aboutUs => const SvgGenImage('assets/iconsc/about_us.svg');

  /// File path: assets/iconsc/back.svg
  SvgGenImage get back => const SvgGenImage('assets/iconsc/back.svg');

  /// File path: assets/iconsc/contact_us.svg
  SvgGenImage get contactUs =>
      const SvgGenImage('assets/iconsc/contact_us.svg');

  /// File path: assets/iconsc/email.svg
  SvgGenImage get email => const SvgGenImage('assets/iconsc/email.svg');

  /// File path: assets/iconsc/eye.svg
  SvgGenImage get eye => const SvgGenImage('assets/iconsc/eye.svg');

  /// File path: assets/iconsc/eye_off.svg
  SvgGenImage get eyeOff => const SvgGenImage('assets/iconsc/eye_off.svg');

  /// File path: assets/iconsc/get_help.svg
  SvgGenImage get getHelp => const SvgGenImage('assets/iconsc/get_help.svg');

  /// File path: assets/iconsc/key.svg
  SvgGenImage get key => const SvgGenImage('assets/iconsc/key.svg');

  /// File path: assets/iconsc/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/iconsc/logo.png');

  /// File path: assets/iconsc/my_rides.svg
  SvgGenImage get myRides => const SvgGenImage('assets/iconsc/my_rides.svg');

  /// File path: assets/iconsc/no_data_found.svg
  SvgGenImage get noDataFound =>
      const SvgGenImage('assets/iconsc/no_data_found.svg');

  /// File path: assets/iconsc/phone.svg
  SvgGenImage get phone => const SvgGenImage('assets/iconsc/phone.svg');

  /// File path: assets/iconsc/profile.svg
  SvgGenImage get profile => const SvgGenImage('assets/iconsc/profile.svg');

  /// File path: assets/iconsc/short_logo.svg
  SvgGenImage get shortLogo =>
      const SvgGenImage('assets/iconsc/short_logo.svg');

  /// File path: assets/iconsc/sign_out.svg
  SvgGenImage get signOut => const SvgGenImage('assets/iconsc/sign_out.svg');

  /// File path: assets/iconsc/term_conditions.svg
  SvgGenImage get termConditions =>
      const SvgGenImage('assets/iconsc/term_conditions.svg');

  /// File path: assets/iconsc/today_rides.svg
  SvgGenImage get todayRides =>
      const SvgGenImage('assets/iconsc/today_rides.svg');

  /// List of all assets
  List<dynamic> get values => [
        aboutUs,
        back,
        contactUs,
        email,
        eye,
        eyeOff,
        getHelp,
        key,
        logo,
        myRides,
        noDataFound,
        phone,
        profile,
        shortLogo,
        signOut,
        termConditions,
        todayRides
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/bubble.png
  AssetGenImage get bubble => const AssetGenImage('assets/images/bubble.png');

  /// File path: assets/images/login_bg.png
  AssetGenImage get loginBg =>
      const AssetGenImage('assets/images/login_bg.png');

  /// File path: assets/images/profile.png
  AssetGenImage get profile => const AssetGenImage('assets/images/profile.png');

  /// List of all assets
  List<AssetGenImage> get values => [bubble, loginBg, profile];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/loading.json
  LottieGenImage get loading =>
      const LottieGenImage('assets/lottie/loading.json');

  /// File path: assets/lottie/upload.json
  LottieGenImage get upload =>
      const LottieGenImage('assets/lottie/upload.json');

  /// List of all assets
  List<LottieGenImage> get values => [loading, upload];
}

class Assets {
  Assets._();

  static const $AssetsIconscGen iconsc = $AssetsIconscGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(this._assetName);

  final String _assetName;

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
