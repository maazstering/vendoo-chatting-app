part of 'message_bloc.dart';

@immutable
abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageSentState extends MessageState {
  // Add any necessary properties or data related to the message being sent
}

class MessagesLoadedState extends MessageState {
  final List<Message> messages;

  MessagesLoadedState(this.messages);
  // Add any necessary properties or data related to the loaded messages
}

class EmojiVisibilityState extends MessageState {
  final bool isEmojiVisible;

  EmojiVisibilityState(this.isEmojiVisible);
  // Add any necessary properties or data related to the emoji visibility
}

class ImagePickedState extends MessageState {
  final File image;

  ImagePickedState(this.image);
  // Add any necessary properties or data related to the picked image
}

class MessageErrorState extends MessageState {
  final String message;

  MessageErrorState(this.message) {
    if (message == null) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(
          content: Text("Message is null"),
        ),
      );
    } else {
      print("Message is not null");
    }
  }
}

// Add more state classes if needed for other states of the messaging feature
