// ignore_for_file: prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';

import 'detail_page.dart';

class Item {
  late final String? itemId;

  Item({this.itemId});

  StreamController<Item> _controller = StreamController<Item>.broadcast();
  Stream<Item> get onChanged => _controller.stream;

  String? _matchteam;
  String? get matchteam => _matchteam;
  set setMatchteam(String? value) {
    _matchteam = value;
    _controller.add(this);
  }

  String? _score;
  String? get score => _score;
  set setScore(String? value) {
    _score = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    final String routeName = '/detail/$itemId';
    return routes.putIfAbsent(
      routeName,
      () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => DetailPage(itemId!),
      ),
    );
  }
}
