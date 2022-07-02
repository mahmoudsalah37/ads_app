import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AdsRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAds();
}
