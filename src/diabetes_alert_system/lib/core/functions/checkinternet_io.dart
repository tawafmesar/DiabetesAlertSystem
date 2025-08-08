import 'dart:io' show InternetAddress, SocketException;

/// Mobile / desktop implementation
Future<bool> checkInternet() async {
  try {
    print('[checkInternet] DNS lookup → google.com');
    final result = await InternetAddress.lookup('google.com');
    final ok = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    print('[checkInternet] Mobile OK? $ok');
    return ok;
  } on SocketException catch (e) {
    print('[checkInternet] Mobile SocketException: $e');
    return false;
  } catch (e) {
    print('[checkInternet] Mobile other exception: $e');
    return false;
  }
}
