import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arestro/core/enums/result_state.dart';
import 'package:arestro/core/widgets/empty_message.dart';
import 'package:arestro/core/widgets/error_message.dart';
import 'package:arestro/core/widgets/loading_progress.dart';
import 'package:arestro/features/favorite/presentation/providers/favorite_provider.dart';
import 'package:arestro/features/restaurant/presentation/widgets/restaurant_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorit Restoran'),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, _) {
          switch (provider.state) {
            case ResultState.loading:
              return const LoadingProgress();
            case ResultState.hasData:
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: provider.favorites.length,
                itemBuilder: (context, index) {
                  final restaurant = provider.favorites[index];
                  return RestaurantCard(restaurant: restaurant);
                },
              );
            case ResultState.noData:
              return const EmptyMessage(message: ' Belum ada restoran favorit');
            case ResultState.error:
              return ErrorMessage(
                message: provider.message,
                onRetry: () => provider.loadFavorites(),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}