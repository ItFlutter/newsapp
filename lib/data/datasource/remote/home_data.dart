import 'package:get/get.dart';
import 'package:news_api/core/class/crud.dart';
import 'package:news_api/linkapi.dart';

class HomeData {
  Crud crud = Get.find();
  // Future<Either<StatusRequest,Map>>
  getDataByCountry(String country, int pageSize, int page) async {
    var response = await crud.getData(
        AppLink.server + "?sources=$country&pageSize=$pageSize&page=$page");
    print(
        "=================================Home_Data=================================$response");
    return response.fold((l) => l, (r) => r);
    // return response;
  }

  getDataByCategoryAndCountry(
      String category, String? country, int pageSize, int page) async {
    var response = await crud
        .getData(AppLink.server + "?q=$category&pageSize=$pageSize&page=$page");
    print(
        "=================================Home_Data=================================$response");
    return response.fold((l) => l, (r) => r);
    // return response;
  }
}
