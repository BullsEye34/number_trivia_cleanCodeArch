import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInformation {
  Future<bool>? get isConnected;
}

class NetworkInformationImpl implements NetworkInformation {
  late final InternetConnectionChecker internetConnectionChecker;
  NetworkInformationImpl(this.internetConnectionChecker);
  @override
  Future<bool>? get isConnected => internetConnectionChecker.hasConnection;
}
