part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

enum MessageType { text, image, emoji }

class SendMessageEvent extends MessageEvent {
  final ChatUser user;
  final String message;
  final Type type;

  SendMessageEvent({
    required this.user,
    required this.message,
    required this.type,
  });

  String? get text => null;
}

class LoadMessagesEvent extends MessageEvent {
  ChatUser? get user => null;
}

class ToggleEmojiVisibilityEvent extends MessageEvent {}

class PickImageFromGalleryEvent extends MessageEvent {}

class PickImageFromCameraEvent extends MessageEvent {}

class MessageErrorEvent extends MessageEvent {
  final String message;

  MessageErrorEvent(this.message);

  @override
  List<Object?> get props => [message];
}
