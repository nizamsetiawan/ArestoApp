import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/enums/result_state.dart';
import '../../../../core/widgets/empty_message.dart';
import '../../../../core/widgets/error_message.dart';
import '../../../../core/widgets/loading_progress.dart';
import '../../domain/entities/restaurant.dart';
import '../providers/restaurant_search_provider.dart';
import '../widgets/restaurant_card.dart';

class RestaurantSearchPage extends StatelessWidget {
  const RestaurantSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencarian Restoran'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar with improved decoration
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Cari restoran...',
                  hintStyle: TextStyle(
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorScheme.primary,
                  ),
                  filled: true,
                  fillColor: colorScheme.surface,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 16,
                ),
                onChanged: (query) {
                  context.read<RestaurantSearchProvider>().search(query);
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Search results
          Expanded(
            child: Consumer<RestaurantSearchProvider>(
              builder: (context, provider, _) {
                switch (provider.state) {
                  case ResultState.loading:
                    return provider.restaurants.isEmpty
                        ? const LoadingProgress()
                        : _buildSearchResults(provider.restaurants);
                  case ResultState.hasData:
                    return _buildSearchResults(provider.restaurants);
                  case ResultState.noData:
                    return const EmptyMessage(
                      message: "Tidak ada restoran yang ditemukan",
                    );
                  case ResultState.error:
                    return ErrorMessage(
                      message: provider.message,
                      onRetry: () => provider.search(''),
                    );
                  default:
                    return const EmptyMessage(
                      message: "Mulai ketik untuk mencari restoran",
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<Restaurant> restaurants) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: RestaurantCard(restaurant: restaurant),
        );
      },
    );
  }
}