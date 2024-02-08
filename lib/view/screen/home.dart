import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_api/controller/home_controller.dart';
import 'package:news_api/core/class/handlingdataview.dart';
import 'package:news_api/core/constant/appcolor.dart';
import 'package:news_api/core/constant/approutes.dart';
import 'package:news_api/core/constant/dimensions_screen.dart';
import 'package:news_api/core/shared/customappbar.dart';
import 'package:news_api/core/shared/customcachednetworkimage.dart';
import 'package:news_api/view/widget/home/customcategoryimage.dart';
import 'package:news_api/view/widget/home/customthelastofnews.dart';
import 'package:news_api/core/shared/customtitleandsubtitletext.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.moveToTop();
            },
            child: const Icon(
              Icons.expand_less,
              size: 35,
            )),
        appBar: customAppBar("News"),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.getDataByCountry();
          },
          child: ListView(
            controller: controller.scrollController,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      ...List.generate(
                          controller.categoriesImages.length,
                          (index) => InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoute.newscategories,
                                      arguments: {
                                        'categoryValue': controller
                                            .categoriesImages[index]['value'],
                                        "categoryName": controller
                                            .categoriesImages[index]['name'],
                                      });
                                },
                                child: CustomCategoryImage(
                                    image: controller.categoriesImages[index]
                                        ['image'],
                                    title: controller.categoriesImages[index]
                                        ['name']),
                              ))
                    ],
                  ),
                ),
              ),
              //    print(
              // "=================================Constraints=================================${constraints.minWidth}");
              GetBuilder<HomeController>(
                builder: (controller) => HandlingDataView(
                    onRefresh: () async {
                      await controller.getDataByCountry();
                    },
                    height: heightScreen -
                        appBarHeight -
                        statusBarHeight -
                        heightScreen / 6,
                    statusRequest: controller.statusRequest,
                    widget: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.isLoadMore == true
                          ? controller.listDataByCountry.length + 1
                          : controller.listDataByCountry.length,
                      itemBuilder: (context, index) {
                        return index >= controller.listDataByCountry.length &&
                                controller.isLast == true
                            ? CustomTheLastOfNews()
                            : index >= controller.listDataByCountry.length
                                ? Center(
                                    child: Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: const CircularProgressIndicator(),
                                  ))
                                : Container(
                                    height: heightScreen / 2.5,
                                    padding: EdgeInsets.only(
                                        right: 10.sp, left: 10.sp, top: 20.sp),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomCachedNetworkImage(
                                            heightImage: heightScreen / 4,
                                            image: controller
                                                    .listDataByCountry[index]
                                                    .imageUrl ??
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbW6yFH3_Hl_YRWvKrOeJAFrfPx7V8V6awslRDzlGVyyKMbsjjwSA5IOA_QFEfOnSaonc&usqp=CAU"),
                                        CustomTitleAndSubtitleText(
                                          onTapLink: () async {
                                            await launchUrl(
                                                Uri.parse(controller
                                                    .listDataByCountry[index]
                                                    .articelUrl),
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          text: controller
                                              .listDataByCountry[index].title,
                                          fontSize: 17,
                                          isBold: true,
                                          isUrl: true,
                                        ),
                                        CustomTitleAndSubtitleText(
                                          text: controller
                                                  .listDataByCountry[index]
                                                  .description ??
                                              "",
                                          fontSize: 14,
                                          colorText: AppColor.grey,
                                        ),
                                      ],
                                    ),
                                  );
                      },
                    )),
              )
            ],
          ),
        ));
  }
}
