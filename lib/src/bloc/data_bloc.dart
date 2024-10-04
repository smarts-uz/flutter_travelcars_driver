import 'dart:convert';

import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/data_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/profile_model.dart';
import 'package:rxdart/rxdart.dart';

class DataBloc {
  Repository repository = Repository();
  final _dataFetch = BehaviorSubject<DataModel>();

  Stream<DataModel> get dataFeedback => _dataFetch.stream;

  final _profileFetch = BehaviorSubject<ProfileModel>();

  Stream<ProfileModel> get profileFeedback => _profileFetch.stream;

  getAllData() async {
    try {
      HttpResult response = await repository.getData();
      DataModel data = dataModelFromJson(
        json.encode(response.result),
      );
      List<Datum> data1 = <Datum>[];
      List<Datum> data2 = <Datum>[];
      DateTime _now = DateTime.now();
      for (int i = 0; i < data.data.length; i++) {
        String day = data.data[i].date[0] + data.data[i].date[1];
        String month = data.data[i].date[3] + data.data[i].date[4];
        String year = data.data[i].date[6] +
            data.data[i].date[7] +
            data.data[i].date[8] +
            data.data[i].date[9];
        if (int.parse(day) == _now.day &&
            int.parse(month) == _now.month &&
            int.parse(year) == _now.year) {
          data1.add(data.data[i]);
        }
      }
      for (int i = data.data.length - 1; i >= 0; i--) {
        data2.add(data.data[i]);
      }
      DataModel data3 = DataModel(
        data: data1,
        data1: data2,
      );
      _dataFetch.sink.add(data3);
    } catch (_) {}
  }

  getProfileData() async {
    try {
      HttpResult response = await repository.getProfile();
      ProfileModel data = profileModelFromJson(
        json.encode(response.result),
      );
      _profileFetch.sink.add(data);
    } catch (_) {}
  }

  dispose() {
    _profileFetch.close();
    _dataFetch.close();
  }
}

final dataBloc = DataBloc();
