import 'package:arestro/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../favorite/presentation/widgets/favorite_button.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/entities/restaurant_detail.dart';
import 'bottom_sheet_review.dart';

class RestaurantDetailContent extends StatelessWidget {
  final RestaurantDetail restaurantDetail;

  const RestaurantDetailContent({super.key, required this.restaurantDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(restaurantDetail.name),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: FavoriteButton(
              restaurant: Restaurant(
                id: restaurantDetail.id,
                name: restaurantDetail.name,
                description: restaurantDetail.description,
                pictureId: restaurantDetail.pictureId,
                city: restaurantDetail.city,
                rating: restaurantDetail.rating,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => BottomSheetReview(restaurant: restaurantDetail),
          );
        },
        child: const Icon(Icons.reviews),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: restaurantDetail.pictureId,
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/large/${restaurantDetail.pictureId}',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurantDetail.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 4),
                      Text("${restaurantDetail.address}, ${restaurantDetail.city}"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  RatingBarIndicator(
                    rating: restaurantDetail.rating,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Kategori:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Wrap(
                    spacing: 8,
                    children: restaurantDetail.categories
                        .map((category) => Chip(label: Text(category.name)))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Deskripsi Restoran:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(restaurantDetail.description,
                      textAlign: TextAlign.justify),
                  const SizedBox(height: 16),
                  Text(
                    'Makanan:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurantDetail.menus.foods.length,
                      itemBuilder: (context, index) {
                        final food = restaurantDetail.menus.foods[index];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Image.asset(
                                AppConstants.foodImage,
                                height: 50,
                                width: 50,
                              ),
                              Text(food.name),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Minuman:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurantDetail.menus.drinks.length,
                      itemBuilder: (context, index) {
                        final drink = restaurantDetail.menus.drinks[index];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Image.asset(
                                AppConstants.drinkImage,
                                height: 50,
                                width: 50,
                              ),
                              Text(drink.name),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
