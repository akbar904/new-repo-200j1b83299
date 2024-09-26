
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animalswitcher/main.dart';

// Mock classes
class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('AnimalCubit tests', () {
		late MockAnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		blocTest<AnimalCubit, Animal>(
			'Initial state is Cat',
			build: () => animalCubit,
			verify: (_) {
				expect(animalCubit.state.name, equals('Cat'));
				expect(animalCubit.state.icon, equals(Icons.pets));
			},
		);

		blocTest<AnimalCubit, Animal>(
			'toggleAnimal changes state from Cat to Dog',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [
				Animal(name: 'Dog', icon: Icons.person),
			],
		);

		blocTest<AnimalCubit, Animal>(
			'toggleAnimal changes state from Dog to Cat',
			build: () => animalCubit,
			setUp: () {
				whenListen(animalCubit, Stream.fromIterable([Animal(name: 'Dog', icon: Icons.person)]));
			},
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [
				Animal(name: 'Cat', icon: Icons.pets),
			],
		);
	});

	group('Main widget tests', () {
		testWidgets('App starts with Cat text and pets icon', (WidgetTester tester) async {
			await tester.pumpWidget(const MyApp());

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.pets), findsOneWidget);
		});

		testWidgets('Tapping on text changes it to Dog with person icon', (WidgetTester tester) async {
			await tester.pumpWidget(const MyApp());

			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
