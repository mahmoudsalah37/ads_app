import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repositories/ads_repository.dart';
import '../datasources/ads_datasource.dart';

class AdsRepositoryImp implements AdsRepository {
  AdsRepositoryImp({required this.adsDatasource});
  final AdsDatasource adsDatasource;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAds() {
    final ads = adsDatasource.getAds();

    return ads.snapshots();
  }
}
