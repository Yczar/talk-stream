// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'all_users_cubit.dart';

abstract class AllUsersState extends Equatable {
  const AllUsersState();

  @override
  List<Object> get props => [];
}

class AllUsersInitial extends AllUsersState {}

class AllUsersLoading extends AllUsersState {}

class AllUsersLoaded extends AllUsersState {
  const AllUsersLoaded({
    required this.users,
  });
  final List<User> users;
}

class AllUsersError extends AllUsersState {
  const AllUsersError({
    required this.errorMessage,
  });
  final String errorMessage;
}
