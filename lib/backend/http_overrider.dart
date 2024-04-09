import 'dart:io';

class MyHttpOverrides extends HttpOverrides{
  /// I have Created this overrider because of Socket Integration
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}