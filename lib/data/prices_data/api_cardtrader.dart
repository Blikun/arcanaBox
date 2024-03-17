import 'package:dio/dio.dart';
import '../../secret.dart';
import 'prices_api_interface.dart';

class CardTraderApi implements PricesAPI {
  final dio = Dio(BaseOptions(
      baseUrl: "https://api.cardtrader.com/api/v2",
      headers: {"Authorization": cardTraderToken}));
  String blueprintsEp = "/blueprints/export";
  String productsEp = "marketplace/products";
}
