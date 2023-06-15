/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsPrgLangGen {
  const $AssetsPrgLangGen();

  /// File path: assets/prg_lang/flutter.json
  String get flutter => 'assets/prg_lang/flutter.json';

  /// List of all assets
  List<String> get values => [flutter];
}

class $AssetsProgrammingLangPngGen {
  const $AssetsProgrammingLangPngGen();

  /// File path: assets/programming_lang_png/flutter.png
  AssetGenImage get flutter =>
      const AssetGenImage('assets/programming_lang_png/flutter.png');

  /// File path: assets/programming_lang_png/go.png
  AssetGenImage get go =>
      const AssetGenImage('assets/programming_lang_png/go.png');

  /// File path: assets/programming_lang_png/java.png
  AssetGenImage get java =>
      const AssetGenImage('assets/programming_lang_png/java.png');

  /// File path: assets/programming_lang_png/js.png
  AssetGenImage get js =>
      const AssetGenImage('assets/programming_lang_png/js.png');

  /// File path: assets/programming_lang_png/python.png
  AssetGenImage get python =>
      const AssetGenImage('assets/programming_lang_png/python.png');

  /// File path: assets/programming_lang_png/react.png
  AssetGenImage get react =>
      const AssetGenImage('assets/programming_lang_png/react.png');

  /// File path: assets/programming_lang_png/ruby.png
  AssetGenImage get ruby =>
      const AssetGenImage('assets/programming_lang_png/ruby.png');

  /// File path: assets/programming_lang_png/rust.png
  AssetGenImage get rust =>
      const AssetGenImage('assets/programming_lang_png/rust.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [flutter, go, java, js, python, react, ruby, rust];
}

class Assets {
  Assets._();

  static const $AssetsPrgLangGen prgLang = $AssetsPrgLangGen();
  static const $AssetsProgrammingLangPngGen programmingLangPng =
      $AssetsProgrammingLangPngGen();
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
