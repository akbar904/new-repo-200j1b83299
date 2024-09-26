
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/animal_cubit.dart';
import '../models/animal.dart';

class AnimalTextWidget extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocBuilder<AnimalCubit, Animal>(
			builder: (context, animal) {
				return GestureDetector(
					onTap: () => context.read<AnimalCubit>().toggleAnimal(),
					child: Row(
						children: [
							Text(animal.name),
							Icon(animal.icon),
						],
					),
				);
			},
		);
	}
}
