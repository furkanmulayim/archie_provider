import 'package:archie_provider/common/data/models/user_model.dart';
import 'package:archie_provider/common/data/services/user_api_service.dart';

class UserRepository {
  UserRepository({required this.apiService});
  final UserApiService apiService;

  Future<List<UserModel>> getUsers() async {
    try {
      final userJson = await apiService.fetchUsers();
      return userJson.map((userJson) => UserModel.fromJson(userJson)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
