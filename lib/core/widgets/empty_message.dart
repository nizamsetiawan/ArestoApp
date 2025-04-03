import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

class EmptyMessage extends StatelessWidget {
  final String message;

  const EmptyMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppConstants.noDataImage,
            height: 150,
            width: 150,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}