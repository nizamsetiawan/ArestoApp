import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/result_state.dart';
import '../../../../core/widgets/error_message.dart';
import '../../../../core/widgets/loading_progress.dart';
import '../providers/restaurant_detail_provider.dart';
import '../widgets/restaurant_detail_content.dart';
import '../../domain/entities/restaurant.dart';


class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      Provider.of<RestaurantDetailProvider>(context, listen: false)
          .fetchRestaurantDetail(widget.restaurant.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, provider, _) {
          if (provider.state == ResultState.loading) {
            return const LoadingProgress();
          } else if (provider.state == ResultState.error) {
            return ErrorMessage(
              message: provider.message,
              onRetry: () => provider.fetchRestaurantDetail(widget.restaurant.id),
            );
          } else if (provider.state == ResultState.hasData) {
            return RestaurantDetailContent(
              restaurantDetail: provider.restaurantDetail!,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}