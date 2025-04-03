import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/enums/result_state.dart';
import '../../../../core/navigation/app_routes.dart';
import '../../../../core/widgets/empty_message.dart';
import '../../../../core/widgets/error_message.dart';
import '../../../../core/widgets/loading_progress.dart';
import '../providers/restaurant_list_provider.dart';
import '../widgets/restaurant_card.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Restoran'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor, // Or any color you prefer
        child: const Icon(Icons.search, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.restaurantSearch);
        },
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, provider, _) {
          switch (provider.state) {
            case ResultState.loading:
              return const LoadingProgress();
            case ResultState.hasData:
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: provider.restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = provider.restaurants[index];
                  return RestaurantCard(restaurant: restaurant);
                },
              );
            case ResultState.noData:
              return const EmptyMessage(message: "Tidak ada restoran");
            case ResultState.error:
              return ErrorMessage(
                message: provider.message,
                onRetry: () => provider.fetchRestaurantList(),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}