import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:module_9/views/home_view.dart';
import 'package:module_9/views/hotel_view.dart';

class FluroRoutes {
  static FluroRouter router = FluroRouter();

  static Handler _homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return HomeView();
    },
  );

  static Handler _hotelhandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      print(params);
      if (params.containsKey('uuid')) {
        return HotelView(uuid: params['uuid'][0]);
      }
      return HotelView();
    },
  );

  static void setupRouter() {
    router.define(
      HomeView.routeName,
      handler: _homeHandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      HotelView.routeName,
      handler: _hotelhandler,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      '${HotelView.routeName}/:uuid',
      handler: _hotelhandler,
      transitionType: TransitionType.cupertino,
    );
  }
}
