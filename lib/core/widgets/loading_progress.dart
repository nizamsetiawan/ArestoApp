// loading_progress.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/constants/app_constants.dart';

class LoadingProgress extends StatelessWidget {
  const LoadingProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        AppConstants.loadingAnimation,
        width: 150,
        height: 150,
      ),
    );
  }
}
