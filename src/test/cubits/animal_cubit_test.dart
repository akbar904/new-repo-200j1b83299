
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animalswitcher/cubits/animal_cubit.dart';
import 'package:animalswitcher/models/animal.dart';

class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});

		test('initial state is Cat', () {
			expect(animalCubit.state.name, 'Cat');
		});

		blocTest<AnimalCubit, Animal>(
			'emits Dog when toggleAnimal is called and initial state is Cat',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [
				Animal(name: 'Dog', icon: Icons.person),
			],
		);

		blocTest<AnimalCubit, Animal>(
			'emits Cat when toggleAnimal is called and initial state is Dog',
			build: () {
				animalCubit.emit(Animal(name: 'Dog', icon: Icons.person));
				return animalCubit;
			},
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [
				Animal(name: 'Cat', icon: Icons.access_time),
			],
		);
	});
}
