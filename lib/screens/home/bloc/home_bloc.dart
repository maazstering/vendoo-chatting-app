import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomepageLoginButtonNavigateEvent>(
        (event, emit) { 
          emit(HomeLoginPageNavigateActionState());});
    on<HomepageSignUpButtonNavigateEvent>(
        (event, emit) => emit(HomeSignPageUpNavigateActionState()));
    on<HomepageChatButtonNavigateEvent>(
        (event, emit) => emit(HomeChatPageNavigateActionState()));


    // Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // if (event is HomepageLoginButtonNavigateEvent) {
    //   yield HomeLoginPageNavigateActionState();

    // }
    // if (event is HomepageSignUpButtonNavigateEvent) {
    //   yield HomeSignPageUpNavigateActionState();

    // }
    // if (event is HomepageChatButtonNavigateEvent) {
    //   yield HomeChatPageNavigateActionState();

    // }
  }
}
