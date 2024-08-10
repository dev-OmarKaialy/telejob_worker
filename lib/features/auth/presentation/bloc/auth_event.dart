part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String password;
  final String email;
  final String name;
  final String address;
  final String phone;
  final String description;
  final List<String> categories;
  const RegisterEvent({
    required this.password,
    required this.email,
    required this.name,
    required this.address,
    required this.phone,
    required this.description,
    required this.categories,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'password': password});
    result.addAll({'email': email});
    result.addAll({'name': name});
    result.addAll({'address': address});
    result.addAll({'phone': phone});
    result.addAll({'description': description});
    result.addAll({'JobCategories': categories});

    return result;
  }
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'password': password});

    return result;
  }
}
