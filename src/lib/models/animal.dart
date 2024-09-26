
import 'package:flutter/material.dart';

class Animal {
	final String name;
	final IconData icon;

	Animal({required this.name, required this.icon});

	Map<String, dynamic> toJson() {
		return {
			'name': name,
			'icon': icon.codePoint,
		};
	}

	factory Animal.fromJson(Map<String, dynamic> json) {
		return Animal(
			name: json['name'] as String,
			icon: IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
		);
	}
}
