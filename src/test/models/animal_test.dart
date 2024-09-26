
// test/models/animal_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:animalswitcher/models/animal.dart';

void main() {
	group('Animal Model:', () {
		test('Animal constructor should correctly initialize name and icon', () {
			final animal = Animal(name: 'Cat', icon: Icons.pets);
			expect(animal.name, 'Cat');
			expect(animal.icon, Icons.pets);
		});

		test('Animal should serialize to JSON correctly', () {
			final animal = Animal(name: 'Cat', icon: Icons.pets);
			final json = animal.toJson();
			expect(json['name'], 'Cat');
			expect(json['icon'], Icons.pets.codePoint);
		});

		test('Animal should deserialize from JSON correctly', () {
			final json = {'name': 'Cat', 'icon': Icons.pets.codePoint};
			final animal = Animal.fromJson(json);
			expect(animal.name, 'Cat');
			expect(animal.icon, Icons.pets);
		});
	});
}
