import 'dart:html';
import 'dart:js';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../api/apis.dart';
import '../../../models/chat_user.dart';
import '../../../models/message.dart';
import 'package:flutter/src/widgets/framework.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitial());

  get messages => null;

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is SendMessageEvent) {
      yield* _mapSendMessageEventToState(event);
    } else if (event is LoadMessagesEvent) {
      yield* _mapLoadMessagesEventToState(event);
    } else if (event is ToggleEmojiVisibilityEvent) {
      yield* _mapToggleEmojiVisibilityEventToState(event);
    } else if (event is PickImageFromGalleryEvent) {
      yield* _mapPickImageFromGalleryEventToState(event);
    } else if (event is PickImageFromCameraEvent) {
      yield* _mapPickImageFromCameraEventToState(event);
    }
    on((MessageErrorEvent, emit) => emit(MessageErrorState("Error")));
  }

  Stream<MessageState> _mapSendMessageEventToState(
      SendMessageEvent event) async* {
    APIs.sendMessage(event.user, event.message!, event.type);

    yield MessageSentState();
  }

  final _textController = TextEditingController();

  Stream<MessageState> _mapLoadMessagesEventToState(
      LoadMessagesEvent event) async* {
    final user = event.user;
    if (_textController.text.isNotEmpty) {
      APIs.sendMessage(user!, _textController.text, Type.Text);
      _textController.text = '';
    }
    if (user != null) {
      final messages = await APIs.getAllMessages(user);
      yield MessagesLoadedState(messages as List<Message>);
    } else {
      print("User is null");
    }

    yield MessagesLoadedState(messages as List<Message>);
  }

  Stream<MessageState> _mapToggleEmojiVisibilityEventToState(
      ToggleEmojiVisibilityEvent event) async* {
    // final bool isVisible = !state.isEmojiVisible;
    // yield state.copyWith(isEmojiVisible: isVisible);
  }

  Stream<MessageState> _mapPickImageFromGalleryEventToState(
      PickImageFromGalleryEvent event) async* {
    // Call the ImagePicker.pickImage() method here to pick an image from the gallery

    // final image = await ImagePicker.pickImage(source: ImageSource.gallery);

    // Update the state accordingly, if needed
    // For example, you can yield a new state with the picked image

    // yield ImagePickedState(image);
  }

  Stream<MessageState> _mapPickImageFromCameraEventToState(
      PickImageFromCameraEvent event) async* {
    // Call the ImagePicker.pickImage() method here to pick an image from the camera

    // Example code:
    // final image = await ImagePicker.pickImage(source: ImageSource.camera);

    // Update the state accordingly, if needed
    // For example, you can yield a new state with the picked image

    // Example code:
    // yield ImagePickedState(image);
  }
}
