import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_api/core/class/sqldb.dart';
import 'package:news_api/core/class/stautscode.dart';
import 'package:news_api/core/constant/appcolor.dart';
import 'package:news_api/core/constant/appimageasset.dart';
import 'package:news_api/core/functions/handlingdatacontroller.dart';
import 'package:news_api/data/datasource/remote/home_data.dart';
import 'package:news_api/data/model/article_model.dart';

import 'sharedscroll_controller.dart';

class HomeController extends SharedScrollController {
  SqlDb sqlDb = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  int page = 1;
  bool isLast = false;
  bool isLoadMore = false;
  HomeData homeData = HomeData();
  List<ArticleModel> listDataByCountry = [];
  List categoriesImages = [
    {"name": "General", "value": "general", "image": AppImageAsset.general},
    {
      "name": "Entertainment",
      "value": "entertainment",
      "image": AppImageAsset.entertainment
    },
    {"name": "Business", "value": "business", "image": AppImageAsset.business},
    {"name": "Health", "value": "health", "image": AppImageAsset.health},
    {"name": "Science", "value": "science", "image": AppImageAsset.science},
    {"name": "Sports", "value": "sports", "image": AppImageAsset.sports},
    {
      "name": "Technology",
      "value": "technology",
      "image": AppImageAsset.technology
    },
  ];
  Future<void> getDataByCountry() async {
    page = 1;
    listDataByCountry.clear();
    statusRequest = StatusRequest.loading;
    update();
    var response = await homeData.getDataByCountry("us", 10, page);
    print(
        "=================================Home_Controller=================================$response");
    statusRequest = handlingData(response);
    update();
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "ok") {
        List data = response['articles'];
        if (data.isEmpty) {
          print(
              "=================================data_isEmpty=================================");
          isLast = true;
          update();
          //   // Get.rawSnackbar(
          //   //     message: "You seen the latest news. ",
          //   //     backgroundColor: AppColor.grey2,
          //   //     margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
          //   //     borderRadius: 5);
        } else {
          isLast = false;
          update();
          print(
              "=================================data_isNotEmpty=================================");
        }
        data.removeWhere((element) => element['title'] == "[Removed]");
        print(
            "=================================Home_Controller_Data=================================$data");
        listDataByCountry.addAll(data.map((e) => ArticleModel.fromJson(e)));
        sqlDb.deleteData('delete from news where type="country"');
        listDataByCountry.forEach((e) {
          sqlDb.insertData(
              'insert into news(title,description,url,urlToImage,type) values ("${e.title}","${e.description}","${e.articelUrl}","${e.imageUrl}","country")');
        });

        print(
            "=================================Home_Controller_Model_Data=================================$listDataByCountry");
      } else {
        statusRequest = StatusRequest.failure;
      }
    } else if (statusRequest == StatusRequest.offlineFailure) {
      List data =
          await sqlDb.readData('select * from news where type="country"');
      print(
          "=================================Home_Controller_Data_SqlLite=================================$data");
      listDataByCountry.addAll(data.map((e) => ArticleModel.fromJson(e)));
      print(
          "=================================Home_Controller_Model_Data_SqlLite=================================$listDataByCountry");
    }
    update();
  }

  Future<void> getMoreDataByCountry() async {
    var response = await homeData.getDataByCountry("us", 10, page);
    print(
        "=================================Home_Controller=================================$response");
    statusRequest = handlingData(response);
    update();
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == "ok") {
        List data = response['articles'];
        data.removeWhere((element) => element['title'] == "[Removed]");

        if (data.isEmpty) {
          print(
              "=================================data_isEmpty=================================");
          isLast = true;
          // update();
          //   // Get.rawSnackbar(
          //   //     message: "You seen the latest news. ",
          //   //     backgroundColor: AppColor.grey2,
          //   //     margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
          //   //     borderRadius: 5);
        } else {
          isLast = false;
          // update();
          print(
              "=================================data_isNotEmpty=================================");
        }
        print(
            "=================================Home_Controller_Data=================================$data");
        listDataByCountry.addAll(data.map((e) => ArticleModel.fromJson(e)));
        print(
            "=================================Home_Controller_Model_Data=================================$listDataByCountry");
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  showMore() async {
    // isLast = false;
    print(
        "=================================show_More=================================");
    // print(
    //     "=================================ScrollController_Position_Pixels=================================${scrollController.position.pixels}");
    if (isLoadMore == true) {
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print(
          "=================================maxScrollExtent=================================");
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
      // isLast = false;
      await getMoreDataByCountry();
      isLoadMore = false;
      update();
    }
    // else {
    //   isLast = false;
    // }
  }

  @override
  void onInit() {
    getDataByCountry();
    scrollController.addListener(showMore);
    // TODO: implement onInit
    super.onInit();
  }
}
