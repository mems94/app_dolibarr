import 'package:data_connection_checker/data_connection_checker.dart';

Future<bool> checkConnectivity() async {
  bool result = await DataConnectionChecker().hasConnection;
  if (result == true) {
    print('Connexion ok');
    return true;
  } else {
    print('No internet :( Reason:');
    print(DataConnectionChecker().lastTryResults);
    return false;
  }
}
