import 'package:archie_provider/common/data/models/detail_model.dart';
import 'package:archie_provider/common/data/repository/detail_repository.dart';
import 'package:archie_provider/common/data/services/detail_api_service.dart';
import 'package:archie_provider/core/constants/colores.dart';
import 'package:archie_provider/core/constants/dimens.dart';
import 'package:archie_provider/core/constants/texts.dart';
import 'package:archie_provider/ui/detail/view_model/detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
part '../widget/app_bar.dart';
part '../widget/detail_card.dart';
part '../widget/load_err.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key, required this.userId, required this.name});

  final String name;
  final int userId;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late DetailViewModel _detailViewModel;

  @override
  void initState() {
    super.initState();
    _detailViewModel = DetailViewModel(
        detailRepo: DetailRepository(apiService: DetailApiService()));
    _detailViewModel.fetchDetails(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailViewModel>(
      create: (context) => _detailViewModel,
      child: Scaffold(
        appBar: _CustomBackAppBar(title: widget.name),
        body: Consumer<DetailViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return _BuildLoading();
            }
            if (viewModel.errorMessage != null) {
              return _BuildError(err: viewModel.errorMessage!);
            }
            if (viewModel.details.isEmpty) {
              return const Center(
                child: Text(Texts.noData),
              );
            }
            return _LazyList(items: viewModel.details);
          },
        ),
      ),
    );
  }
}
