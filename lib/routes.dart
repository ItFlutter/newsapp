import 'package:get/get.dart';
import 'package:news_api/core/constant/approutes.dart';
import 'package:news_api/view/screen/newscategories.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoute.newscategories, page: () => const NewsCategories()),
];
