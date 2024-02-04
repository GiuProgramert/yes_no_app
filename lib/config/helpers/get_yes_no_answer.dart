import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/infraestructure/models/yes_no_model.dart';

/// Used to make an HTTP request to the yes no api
class GetYesNoAnswer {
  final _dio = Dio();

  Future<Message> getAnswer() async {
    /// In this case we use the Dio library to make the request
    final response = await _dio.get('https://yesno.wtf/api');

    final yesNoModel = YesNoModel.fromJsonMap(response.data);

    return yesNoModel.toMessageEntity();
  }
}
