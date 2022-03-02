
import '../model/api_model/http_result.dart';
import 'api_provider.dart';

class Repository {
  final apiProvider = ApiProver();

  Future<HttpResult> loginApi(String id, String password) =>
      apiProvider.setLogin(id, password);
  Future<HttpResult> getTask() =>
      apiProvider.getAllTasks();
}