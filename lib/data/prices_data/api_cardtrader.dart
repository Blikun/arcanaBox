import 'dart:developer';

import 'package:dio/dio.dart';

import '../../models/card.dart';
import '../../models/filters.dart';
import 'prices_api_interface.dart';

class CardTraderApi implements PricesAPI {

  final dio = Dio(BaseOptions(baseUrl: "https://api.cardtrader.com/api/v2"));
  String blueprintsEp = "/blueprints/export";
  String productsEp = "marketplace/products";



}
