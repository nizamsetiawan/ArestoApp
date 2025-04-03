class AppConstants {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';

  // API endpoints
  static const String restaurantList = '$baseUrl/list';
  static const String restaurantDetail = '$baseUrl/detail';
  static const String restaurantSearch = '$baseUrl/search';
  static const String postReview = '$baseUrl/review';

  // Assets paths
  static const String noDataImage = 'assets/images/no-data.png';
  static const String noInternetImage = 'assets/images/no-internet.png';
  static const String notFoundImage = 'assets/images/not-found.png';
  static const String searchImage = 'assets/images/search-restaurant.png';
  static const String foodImage = 'assets/images/food.png';
  static const String drinkImage = 'assets/images/drink.png';

  // Animation paths
  static const String loadingAnimation = 'assets/lottie/loading.json';

  // App constants
  static const String appName = 'ARestro';
}