import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/firebase_collections.dart';

abstract class AdsDatasource {
  CollectionReference<Map<String, dynamic>> getAds();
}

class AdsDatasourceImp implements AdsDatasource {
  @override
  CollectionReference<Map<String, dynamic>> getAds() {
    final firestore = FirebaseFirestore.instance;
    final ads = firestore.collection(FirebaseCollections.ads.name);
    return ads;
  }
}
