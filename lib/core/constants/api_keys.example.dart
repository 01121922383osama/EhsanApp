/// Copy this file to `api_keys.dart` and add your keys.
/// `api_keys.dart` is gitignored and will not be committed.
abstract final class ApiKeys {
  static const youtubeApiKey = String.fromEnvironment(
    'YOUTUBE_API_KEY',
    defaultValue: 'YOUR_YOUTUBE_API_KEY_HERE',
  );
}
