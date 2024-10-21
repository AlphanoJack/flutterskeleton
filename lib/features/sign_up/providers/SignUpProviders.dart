import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailProvider = StateProvider<String>((ref) => '');

final nameProvider = StateProvider<String>((ref) => '');

final nicknameProvider = StateProvider<String>((ref) => '');

final passwordProvider = StateProvider((ref) => '');
final passwordConfirmProvider = StateProvider((ref) => '');

final phoneNumberProvider = StateProvider((ref) => '');
