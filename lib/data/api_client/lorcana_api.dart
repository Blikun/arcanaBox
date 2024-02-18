import 'package:arcana_box/data/api_client/api_client.dart';
import 'package:arcana_box/models/card.dart';
import 'package:dio/dio.dart';

abstract class LorcanaApi implements ApiClient {
  String cardsAll = "/cards/all";
  final dio = Dio(BaseOptions(baseUrl: "https://api.lorcana-api.com"));

  @override
  Future<List<LCard>> all();
}
