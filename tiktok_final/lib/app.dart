import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/sizes.dart';

extension UiExtension on BuildContext {
  void showAlert(
      {required String title,
      required String message,
      required Function positiveCallback}) {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // 원하는 작업 수행
                Navigator.of(context).pop(); // AlertDialog 닫기
                positiveCallback();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void showConfirm(
      {required String title,
      required String message,
      required Function positiveCallback,
      required Function negativeCallback}) {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // AlertDialog 닫기
                negativeCallback();
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // 원하는 작업 수행
                Navigator.of(context).pop(); // AlertDialog 닫기
                positiveCallback();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}

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

  TextStyle get pincodeText => pageTitle!;
  TextStyle get cardText => pageSubtitle!.copyWith(fontWeight: FontWeight.w500);

  TextStyle get navText =>
      textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w300);

  TextStyle get postTitleText =>
      textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w800);

  TextStyle get linkText => textTheme.headlineSmall!
      .copyWith(color: Colors.blue, fontWeight: FontWeight.w600);
  // 일반
  TextStyle get normal => textTheme.displayMedium!;

  TextStyle get searchTitleText => textTheme.headlineMedium!.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      );
  TextStyle get searchSubTitleText => textTheme.headlineMedium!.copyWith(
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      );
  TextStyle get searchFollowersText => textTheme.headlineMedium!.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      );

  TextStyle get settingItemText => textTheme.headlineMedium!
      .copyWith(color: Colors.black, fontWeight: FontWeight.w500);

  Container divider(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      height: 1,
      color: Colors.grey.shade300);

  // bool get isDarkMode =>
  //     MediaQuery.of(this).platformBrightness == Brightness.dark;
}
