import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app.dart';

import '../../../common/sizes.dart';

class FormButton extends ConsumerWidget {
  final bool disabled;
  late final String? text;

  FormButton({
    super.key,
    required this.disabled,
    this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size5),
          color: disabled
              ? context.isDarkMode(ref)
                  ? Colors.grey.shade800
                  : Colors.grey.shade300
              : Theme.of(context).primaryColor,
        ),
        duration: const Duration(milliseconds: 500),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 500),
          style: TextStyle(
            color: disabled ? Colors.grey.shade400 : Colors.white,
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w600,
          ),
          child: Text(
            text ?? 'Next',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
