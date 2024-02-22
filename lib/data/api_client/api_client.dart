
import '../models/card.dart';

abstract class ApiClient {
  Future<List<LCard>> all();
  Future<List<LCard>> fetch(int page);
}