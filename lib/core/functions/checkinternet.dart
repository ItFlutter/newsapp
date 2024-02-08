import 'dart:io';

Future<bool> checkInternet() async {
  try {
    List<InternetAddress> results = await InternetAddress.lookup("google.com");
    print(
        "=================================Check_Internet_Result=================================$results");
    return results.isEmpty ? false : true;
  } on SocketException catch (_) {
    return false;
  }
}
