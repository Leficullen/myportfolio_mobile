/// Backend origin. Override with --dart-define=API_BASE_URL=https://example.com.
const apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:8000',
);
