part of 'newroom_bloc.dart';

abstract class NewroomState extends Equatable {
  const NewroomState();
  
  @override
  List<Object> get props => [];
}

class NewroomInitial extends NewroomState {}
