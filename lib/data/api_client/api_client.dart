import '../../models/card.dart';

abstract class ApiClient {

  Future<List<LCard>> all();
}