import '../../models/card.dart';

abstract class ApiClient {

  Future<List<LCard>> all();
  Future<List<LCard>> fetchPage(int page);

}