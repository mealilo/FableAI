import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'openAIApiKey', obfuscate: true)
  static final openAIApiKey = _Env.openAIApiKey;
}
