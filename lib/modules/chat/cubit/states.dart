abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class ChatLoadingMessageState extends ChatStates {}

class ChatSuccessMessageState extends ChatStates {}

class ChatSendingMessageState extends ChatStates {}

class ChatSendSuccessState extends ChatStates {}

class ChatGettingMessageState extends ChatStates {}

class ChatGetSuccessState extends ChatStates {}

class ChatGettingImagesState extends ChatStates {}

class ChatGetImagesSuccessState extends ChatStates {}

class ChatCreateState extends ChatStates {}

class ChatSuccessCreateState extends ChatStates {}

class ChatLoadingFriendState extends ChatStates {}

class ChatSuccessFriendState extends ChatStates {}

class ChatTypingState extends ChatStates {}

class ChatStopTypingState extends ChatStates {}

class ChatCurrentDateState extends ChatStates {}

class ChatEndOfListState extends ChatStates {}

class ChatErrorState extends ChatStates {}
