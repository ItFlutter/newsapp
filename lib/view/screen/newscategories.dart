import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_api/controller/newscategories_controller.dart';
import 'package:news_api/core/class/handlingdataview.dart';
import 'package:news_api/core/constant/appcolor.dart';
import 'package:news_api/core/constant/dimensions_screen.dart';
import 'package:news_api/core/shared/customappbar.dart';
import 'package:news_api/core/shared/customcachednetworkimage.dart';
import 'package:news_api/core/shared/customtitleandsubtitletext.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/shared/customcachednetworkimage.dart';
import '../../core/shared/customtitleandsubtitletext.dart';

class NewsCategories extends StatelessWidget {
  const NewsCategories({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    NewsCategoriesController controller = Get.put(NewsCategoriesController());
    return Scaffold(
        appBar: customAppBar("${controller.categoryName} News"),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.moveToTop();
            },
            child: const Icon(
              Icons.expand_less,
              size: 35,
            )),
        body: RefreshIndicator(
            onRefresh: () async {
              controller.getDataByCategory();
            },
            child: ListView(controller: controller.scrollController, children: [
              GetBuilder<NewsCategoriesController>(
                builder: (controller) => HandlingDataView(
                    onRefresh: () async {
                      await controller.getDataByCategory();
                    },
                    height: heightScreen - statusBarHeight - appBarHeight,
                    statusRequest: controller.statusRequest,
                    widget: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.isLoadMore == true
                          ? controller.listDataByCategoryAndCountry.length + 1
                          : controller.listDataByCategoryAndCountry.length,
                      itemBuilder: (context, index) {
                        return index >=
                                controller.listDataByCategoryAndCountry.length
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
                                                .listDataByCategoryAndCountry[
                                                    index]
                                                .imageUrl ??
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbW6yFH3_Hl_YRWvKrOeJAFrfPx7V8V6awslRDzlGVyyKMbsjjwSA5IOA_QFEfOnSaonc&usqp=CAU"),
                                    CustomTitleAndSubtitleText(
                                      text: controller
                                          .listDataByCategoryAndCountry[index]
                                          .title,
                                      fontSize: 17,
                                      isBold: true,
                                      isUrl: true,
                                      onTapLink: () async {
                                        await launchUrl(
                                            Uri.parse(controller
                                                .listDataByCategoryAndCountry[
                                                    index]
                                                .articelUrl),
                                            mode:
                                                LaunchMode.externalApplication);
                                      },
                                    ),
                                    CustomTitleAndSubtitleText(
                                      text: controller
                                              .listDataByCategoryAndCountry[
                                                  index]
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
            ])));
  }
}
