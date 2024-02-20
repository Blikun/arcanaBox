import 'package:arcana_box/data/api_client/api_client.dart';
import 'package:dio/dio.dart';

abstract class LorcanaApi implements ApiClient {
  String cardsAll = "/cards/all";
  String cardsFetch = "/cards/fetch";
  int pageSize = 21;

  final dio = Dio(BaseOptions(baseUrl: "https://api.lorcana-api.com"));
}
