import 'package:archie_provider/common/data/models/detail_model.dart';
import 'package:archie_provider/common/data/repository/detail_repository.dart';
import 'package:archie_provider/core/constants/texts.dart';
import 'package:flutter/material.dart';

class DetailViewModel extends ChangeNotifier {
  final DetailRepository detailRepo;

  List<DetailModel> _details = [];
  List<DetailModel> get details => _details;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  DetailViewModel({required this.detailRepo});

  Future<void> fetchDetails(id) async {
    _setLoading(true);
    _clearError();

    try {
      _details = await detailRepo.getDetail(id);
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
