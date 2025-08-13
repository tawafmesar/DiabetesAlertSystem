import 'dart:html' show window;

/// Web implementation
Future<bool> checkInternet() async {
  final online = window.navigator.onLine ?? false;
  print('[checkInternet] Web navigator.onLine = $online');
  return online;
}
