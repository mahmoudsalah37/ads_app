import 'dart:async';

import 'package:ads_app/core/injection_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../controllers/home_controller.dart';
import 'package:badges/badges.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = InjectionContainer.sl<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ads App'),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.red,
        child: StreamBuilder<QuerySnapshot>(
            stream: homeController.getAds(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Loading"));
              }
              final ads = snapshot.data!.docs
                  .map((e) => e.data() as Map<String, dynamic>)
                  .toList();
              return AdsWidget(
                ads: ads,
              );
            }),
      ),
    );
  }
}

class AdsWidget extends StatefulWidget {
  const AdsWidget({
    Key? key,
    required this.ads,
  }) : super(key: key);
  final List<Map<String, dynamic>> ads;

  @override
  State<AdsWidget> createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<AdsWidget> {
  static var startTime = 5;
  var counter = startTime, indexAds = 0;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _createTimer();
  }

  void _createTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        setState(() {
          if (counter == 0) {
            counter = startTime;
            _changeAds();
          } else {
            counter--;
          }
        });
      },
    );
  }

  void _changeAds() {
    if (indexAds < widget.ads.length - 1) {
      indexAds++;
    } else {
      indexAds = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: Text(
        '$counter',
        style: const TextStyle(color: Colors.white),
      ),
      child: CachedNetworkImage(
        width: double.infinity,
        alignment: Alignment.center,
        imageUrl: widget.ads.elementAt(indexAds)['path'],
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
