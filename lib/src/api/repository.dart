import '../model/api_model/http_result.dart';
import 'api_provider.dart';

class Repository {
  final apiProvider = ApiProver();

  ///API
  Future<HttpResult> loginApi(String id, String password) =>
      apiProvider.setLogin(id, password);

  Future<HttpResult> getTask() => apiProvider.getAllTasks();

  Future<HttpResult> getData() => apiProvider.getAllData();

  Future<HttpResult> getWeather() => apiProvider.getWeather();

  Future<HttpResult> getCourses() => apiProvider.getCourse();

  Future<HttpResult> getProfile() => apiProvider.getProfile();

  Future<HttpResult> getHistory(String type, int page) =>
      apiProvider.getHistory(type, page);

  Future<HttpResult> changeStatus(int id) => apiProvider.changeStatus(id);

  Future<HttpResult> getShow(String id) => apiProvider.getShow(id);

  Future<HttpResult> setProfileEdit(
          String currentPassword, String newPass, String confirmNewPass) =>
      apiProvider.setEdit(currentPassword, newPass, confirmNewPass);

  Future<HttpResult> getCalendarList(DateTime date) =>
      apiProvider.getListCalendar(date);
}
