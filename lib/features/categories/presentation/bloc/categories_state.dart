part of 'categories_bloc.dart';

enum CubitStatus { loading, initial, success, failed }

class CategoriesState {
  final CubitStatus status;
  final List<JobCategory> model;
  CategoriesState({
    this.status = CubitStatus.initial,
    this.model = const [],
  });

  CategoriesState copyWith({
    CubitStatus? status,
    List<JobCategory>? model,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }
}
