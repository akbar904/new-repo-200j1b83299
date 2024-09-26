
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animalswitcher/widgets/animal_text_widget.dart';
import 'package:animalswitcher/cubits/animal_cubit.dart';
import 'package:animalswitcher/models/animal.dart';

class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('AnimalTextWidget', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('displays Cat with clock icon initially', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(Animal(name: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: animalCubit,
					child: MaterialApp(
						home: Scaffold(
							body: AnimalTextWidget(),
						),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog with person icon after tap', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(Animal(name: 'Cat', icon: Icons.access_time));
			whenListen(animalCubit, Stream.fromIterable([Animal(name: 'Dog', icon: Icons.person)]));

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: animalCubit,
					child: MaterialApp(
						home: Scaffold(
							body: AnimalTextWidget(),
						),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
