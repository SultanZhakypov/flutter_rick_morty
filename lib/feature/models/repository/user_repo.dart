import 'package:dio/dio.dart';
import 'package:rick_and_morty_project/feature/models/detail_model.dart';
import 'package:rick_and_morty_project/feature/models/user_model.dart';

class UserRepo {
  UserRepo({
    required this.dio,
  });
  final Dio dio;

  Future<UserModel> getUsers(
      {required String name, required int pageNumber}) async {
    final result = await dio.get('character', queryParameters: {
      'name': name,
      'page': pageNumber,
    });

    return UserModel.fromJson(result.data);
  }

  Future<DetailModel> getDetailUsers({required int id}) async {
    final result = await dio.get('character/$id');

    return DetailModel.fromJson(result.data);
  }
}
