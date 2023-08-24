import 'package:flutter/material.dart';
import 'package:twitter_clone/common/sizes.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;

  TextStyle get ultraTitle =>
      textTheme.titleLarge!.copyWith(fontSize: Sizes.size36);
  // 페이지 상단 타이틀
  TextStyle get pageTitle => textTheme.titleLarge!;
  // 페이지 타이틀 설명 문구
  TextStyle get pageSubtitle => textTheme.headlineMedium!;
  // 버튼 타이틀
  TextStyle get buttonTitle =>
      textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w600);
  // 입력필드 힌트
  TextStyle get hintText => textTheme.headlineMedium!;
  // 일반
  TextStyle get normal => textTheme.displayMedium!;
}
