import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String location;

  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? location,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [name, email, phone, location];
}
