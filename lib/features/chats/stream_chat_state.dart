import 'package:basetime/features/chats/chat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stream_chat_state.g.dart';

@riverpod
Stream<Chat> streamChatState(Ref ref, String matchID) {
  return Chat.stream(matchID);
}
