import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:arestro/core/error/failures.dart';
import 'package:arestro/core/enums/result_state.dart';
import 'package:arestro/features/restaurant/domain/entities/restaurant.dart';
import 'package:arestro/features/restaurant/domain/usecases/get_restaurant_list.dart';
import 'package:arestro/features/restaurant/presentation/providers/restaurant_list_provider.dart';

import 'restaurant_list_provider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetRestaurantList>()])
void main() {
  late MockGetRestaurantList mockGetRestaurantList;
  late RestaurantListProvider provider;

  setUp(() {
    mockGetRestaurantList = MockGetRestaurantList();
    // Stub the execute method before creating the provider
    when(mockGetRestaurantList.execute())
        .thenAnswer((_) async => Right([]));
    provider = RestaurantListProvider(getRestaurantList: mockGetRestaurantList);
  });

  final tRestaurants = [
    Restaurant(
      id: '1',
      name: 'Test Restaurant 1',
      description: 'Test Description 1',
      pictureId: '1',
      city: 'Test City 1',
      rating: 4.5,
    ),
    Restaurant(
      id: '2',
      name: 'Test Restaurant 2',
      description: 'Test Description 2',
      pictureId: '2',
      city: 'Test City 2',
      rating: 4.0,
    ),
  ];

  group('RestaurantListProvider', () {
    test('initial state should be loading', () {
      // Arrange - Create a new provider with a fresh mock
      final newMock = MockGetRestaurantList();
      when(newMock.execute()).thenAnswer((_) async => Right([]));
      final newProvider = RestaurantListProvider(getRestaurantList: newMock);

      // Assert
      expect(newProvider.state, ResultState.loading);
      expect(newProvider.restaurants, isEmpty);
      expect(newProvider.message, isEmpty);
    });

    test('should return list of restaurants when data fetching is successful',
          () async {
        // Arrange - Override the stub for this specific test
        when(mockGetRestaurantList.execute())
            .thenAnswer((_) async => Right(tRestaurants));

        // Act
        await provider.fetchRestaurantList();

        // Assert
        verify(mockGetRestaurantList.execute());
        expect(provider.state, ResultState.hasData);
        expect(provider.restaurants, tRestaurants);
        expect(provider.message, isEmpty);
      },
    );

    test('should return error when data fetching is failed', () async {
      // Arrange - Override the stub for this specific test
      when(mockGetRestaurantList.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // Act
      await provider.fetchRestaurantList();

      // Assert
      verify(mockGetRestaurantList.execute());
      expect(provider.state, ResultState.error);
      expect(provider.restaurants, isEmpty);
      expect(provider.message, 'Server Failure');
    });

    test('should return noData state when list is empty', () async {
      // Arrange - Already stubbed to return empty list in setUp

      // Act
      await provider.fetchRestaurantList();

      // Assert
      verify(mockGetRestaurantList.execute());
      expect(provider.state, ResultState.noData);
      expect(provider.restaurants, isEmpty);
      expect(provider.message, isEmpty);
    });
  });
}