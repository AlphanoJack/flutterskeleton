import 'package:talker/talker.dart';

// Talker Log guideline for MyApp

final Talker talker = Talker();

void talkerLog(String screenName, String message) {
  talker.log('ScreenName: $screenName, Message: $message');
}

void talkerInfo(String functionState, String message) {
  talker.info('FunctionState: $functionState, Message: $message');
}

void talkerError(String functionState, String message, Object error) {
  talker
      .error('FunctionState: $functionState, Message: $message, Error: $error');
}
