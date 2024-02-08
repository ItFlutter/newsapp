import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_api/core/class/stautscode.dart';
import 'package:news_api/core/constant/appimageasset.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  final double height;
  final Future<void> Function() onRefresh;
  const HandlingDataView(
      {Key? key,
      required this.statusRequest,
      required this.widget,
      required this.height,
      required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? SizedBox(
            height: height,
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView(children: [
                SizedBox(
                  height: height / 2,
                ),
                const Center(
                  child: CircularProgressIndicator(),
                )
              ]),
            ))
        // : statusRequest == StatusRequest.offlineFailure
        //     ? SizedBox(
        //         height: height,
        //         child: RefreshIndicator(
        //           onRefresh: onRefresh,
        //           child: ListView(children: [
        //             SizedBox(
        //               height: height / 4,
        //             ),
        //             LottieBuilder.asset(
        //               AppImageAsset.offline,
        //               height: height / 2,
        //             )
        //           ]),
        //         ))
        : statusRequest == StatusRequest.serverFailure
            ? SizedBox(
                height: height,
                child: RefreshIndicator(
                  onRefresh: onRefresh,
                  child: ListView(children: [
                    SizedBox(
                      height: height / 4,
                    ),
                    LottieBuilder.asset(
                      AppImageAsset.server,
                      height: height / 2,
                    )
                  ]),
                ))
            : statusRequest == StatusRequest.failure
                ? SizedBox(
                    height: height,
                    child: RefreshIndicator(
                      onRefresh: onRefresh,
                      child: ListView(children: [
                        SizedBox(
                          height: height / 4,
                        ),
                        LottieBuilder.asset(
                          AppImageAsset.nodata,
                          height: height / 2,
                        )
                      ]),
                    ))
                : widget;
  }
}
