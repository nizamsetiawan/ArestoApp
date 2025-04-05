import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:arestro/features/favorite/presentation/providers/favorite_provider.dart';
import 'package:arestro/features/restaurant/domain/entities/restaurant.dart';

import '../../../../core/enums/result_state.dart';

class FavoriteButton extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteButton({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FavoriteProvider>();
    final isFavorite = provider.favorites.any((r) => r.id == restaurant.id);

    return IconButton(
      icon: provider.state == ResultState.loading && isFavorite == provider.favorites.any((r) => r.id == restaurant.id)
          ? const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      )
          : Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () => provider.toggleFavorite(restaurant),
    );
  }
}