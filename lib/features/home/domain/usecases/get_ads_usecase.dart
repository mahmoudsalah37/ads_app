import 'package:ads_app/features/home/domain/repositories/ads_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetAdsUsecase {
  GetAdsUsecase({required this.adsRepository});
  final AdsRepository adsRepository;
  Stream<QuerySnapshot<Map<String, dynamic>>> call() {
    return adsRepository.getAds();
  }
}
