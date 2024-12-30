import 'package:archie_provider/common/data/models/user_model.dart';
import 'package:archie_provider/common/data/repository/user_repository.dart';
import 'package:archie_provider/common/data/services/user_api_service.dart';
import 'package:archie_provider/core/constants/colores.dart';
import 'package:archie_provider/core/constants/dimens.dart';
import 'package:archie_provider/core/constants/texts.dart';
import 'package:archie_provider/ui/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

part '../widget/flat_app_bar.dart';
part '../widget/user_card.dart';
part '../widget/load_err.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel _homeViewModel;

  @override
  void initState() {
    super.initState();
    _homeViewModel =
        HomeViewModel(userRepo: UserRepository(apiService: UserApiService()));
    _homeViewModel.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => _homeViewModel,
      child: Scaffold(
        appBar: _FlatAppBar(),
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return _BuildLoading();
            }
            if (viewModel.errorMessage != null) {
              return _BuildError(err: viewModel.errorMessage!);
            }
            if (viewModel.users.isEmpty) {
              return const Center(
                child: Text(Texts.noData),
              );
            }
            return _LazyList(items: viewModel.users);
          },
        ),
      ),
    );
  }
}
