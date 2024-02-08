import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_api/core/class/sqldb.dart';
import 'package:news_api/core/class/stautscode.dart';
import 'package:news_api/core/constant/appcolor.dart';
import 'package:news_api/core/functions/handlingdatacontroller.dart';
import 'package:news_api/data/datasource/remote/home_data.dart';
import 'package:news_api/data/model/article_model.dart';

import 'sharedscroll_controller.dart';

class NewsCategoriesController extends SharedScrollController {
  late String categoryValue;
  late String categoryName;
  SqlDb sqlDb = Get.find();
  int page = 1;
  bool isLoadMore = false;

  StatusRequest statusRequest = StatusRequest.none;
  HomeData homeData = HomeData();
  List<ArticleModel> listDataByCategoryAndCountry = [];

  Future<void> getDataByCategory() async {
    page = 1;
    listDataByCategoryAndCountry.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await homeData.getDataByCategoryAndCountry(
        categoryValue, "us", 10, page);
    print(
        "=================================Home_Controller=================================$response");
    statusRequest = handlingData(response);
    update();
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "ok") {
        List data = response['articles'];
        data.removeWhere((element) => element['title'] == "[Removed]");

        print(
            "=================================Home_Controller_Data=================================$data");
        listDataByCategoryAndCountry
            .addAll(data.map((e) => ArticleModel.fromJson(e)));
        sqlDb.deleteData('delete from news where type="${categoryValue}"');
        listDataByCategoryAndCountry.forEach((e) {
          sqlDb.insertData(
              'insert into news(title,description,url,urlToImage,type) values ("${e.title}","${e.description}","${e.articelUrl}","${e.imageUrl}","${categoryValue}")');
        });
        print(
            "=================================Home_Controller_Model_Data=================================$listDataByCategoryAndCountry");
      } else {
        statusRequest = StatusRequest.failure;
      }
    } else if (statusRequest == StatusRequest.offlineFailure) {
      List data = await sqlDb
          .readData('select * from news where type="${categoryValue}"');
      //empty data
      print(
          "=================================Home_Controller_Data_SqlLite=================================$data");
      listDataByCategoryAndCountry
          .addAll(data.map((e) => ArticleModel.fromJson(e)));

      print(
          "=================================Home_Controller_Model_Data_SqlLite=================================$listDataByCategoryAndCountry");
    }
    update();
  }

  Future<void> getMoreDataByCategory() async {
    var response = await homeData.getDataByCategoryAndCountry(
        categoryValue, "us", 10, page);
    print(
        "=================================Home_Controller=================================$response");
    statusRequest = handlingData(response);
    update();
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "ok") {
        List data = response['articles'];
        data.removeWhere((element) => element['title'] == "[Removed]");

        // if (data.isEmpty) {
        // isLast = true;
        // update();
        // Get.rawSnackbar(
        //     message: "You seen the latest news. ",
        //     backgroundColor: AppColor.grey2,
        //     margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
        //     borderRadius: 5);
        // }
        print(
            "=================================Home_Controller_Data=================================$data");
        listDataByCategoryAndCountry
            .addAll(data.map((e) => ArticleModel.fromJson(e)));
        print(
            "=================================Home_Controller_Model_Data=================================$listDataByCategoryAndCountry");
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  showMore() async {
    // isLast = false;
    // print(
    //     "=================================show_More=================================");
    // print(
    //     "=================================ScrollController_Position_Pixels=================================${scrollController.position.pixels}");
    if (isLoadMore == true) {
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (statusRequest == StatusRequest.offlineFailure) {
        Get.rawSnackbar(
            message: "You are currently offline.",
            messageText: Row(
              children: [
                Icon(
                  Icons.wifi_off,
                  color: AppColor.grey3,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "You are currently offline.",
                  style: TextStyle(color: AppColor.grey3),
                ),
              ],
            ),
            backgroundColor: AppColor.grey2,
            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
            borderRadius: 5);
      }
      isLoadMore = true;
      update();
      page = page + 1;
      await getMoreDataByCategory();
      isLoadMore = false;
      update();
    }
    // else {
    //   isLast = false;
    // }
  }

  @override
  void onInit() {
    categoryValue = Get.arguments['categoryValue'];
    categoryName = Get.arguments['categoryName'];
    getDataByCategory();
    scrollController.addListener(showMore);
    // TODO: implement onInit
    super.onInit();
  }
}
