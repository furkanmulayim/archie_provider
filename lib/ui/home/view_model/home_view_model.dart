import 'package:archie_provider/common/data/models/user_model.dart';
import 'package:archie_provider/common/data/repository/user_repository.dart';
import 'package:archie_provider/core/constants/texts.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final UserRepository userRepo;

  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  HomeViewModel({required this.userRepo});

  Future<void> fetchUsers() async {
    _setLoading(true);
    _clearError();

    try {
      _users = await userRepo.getUsers();
      _setLoading(false);
    } catch (e) {
      _setError(Texts.errData);
      _setLoading(false);
    }
  }

  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
