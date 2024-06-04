import '../model/api_model/http_result.dart';
import 'api_provider.dart';

class Repository {
  final apiProvider = ApiProvider();
  Future<HttpResult> setLogin(String username, String password) async {
    final response = await apiProvider.setLogin(username, password);
    return HttpResult(
      statusCode: response.statusCode,
      isSuccess: response.isSuccess,
      result: response.result,
    );
  }
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

  Future<HttpResult> logout() => apiProvider.logout();




}
