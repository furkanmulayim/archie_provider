part of '../view/home_view.dart';

class _BuildLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _BuildError extends StatelessWidget {
  final String err;
  const _BuildError({super.key, required this.err});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(err));
  }
}
