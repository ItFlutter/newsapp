import 'package:get/get.dart';
import 'package:news_api/core/class/crud.dart';
import 'package:news_api/core/class/sqldb.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    print(
        "=================================Initial_Bindings=================================");
    Get.put(Crud());
    Get.put(SqlDb());

    // TODO: implement dependencies
  }
}
