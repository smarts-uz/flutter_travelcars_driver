import 'dart:convert';

import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/CourseModel.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:rxdart/rxdart.dart';

class CourseBloc {
  Repository repository = Repository();

  final _courseFetch = PublishSubject<List<CourseModel>>();

  Stream<List<CourseModel>> get courseFeedback => _courseFetch.stream;

  getAllCourse(DateTime time) async {
    try {
      HttpResult response = await repository.getCourses(time);
      if (response.isSuccess) {
        List<CourseModel> data = courseModelFromJson(
          json.encode(response.result),
        );
        _courseFetch.sink.add(data);
      }
    } catch (_) {}
  }
}
