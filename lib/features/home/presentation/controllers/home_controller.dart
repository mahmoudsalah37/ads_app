import 'package:ads_app/features/home/domain/usecases/get_ads_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController {
  final GetAdsUsecase getAdsUsecase;
  HomeController({required this.getAdsUsecase});
  Stream<QuerySnapshot<Map<String, dynamic>>> getAds() => getAdsUsecase();
}
