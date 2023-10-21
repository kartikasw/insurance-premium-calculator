import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_challenge/core/domain/model/history.dart';
import 'package:insurance_challenge/presentation/bloc/form/form_bloc.dart';
import 'package:insurance_challenge/presentation/bloc/history/history_bloc.dart';
import 'package:insurance_challenge/presentation/common_widgets/button.dart';
import 'package:insurance_challenge/presentation/common_widgets/history_list.dart';
import 'package:insurance_challenge/presentation/common_widgets/icon.dart';
import 'package:insurance_challenge/resource/colors.gen.dart';
import 'package:insurance_challenge/resource/string_resource.dart';
import 'package:insurance_challenge/utils/app_router.dart';
import 'package:insurance_challenge/utils/extensions.dart';
import 'package:insurance_challenge/utils/navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => BlocProvider.of<HistoryBloc>(context)
          .add(HistoryEventGetHistoryList()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryBloc, HistoryState>(
      listener: _onHistoryBlocListener,
      child: Scaffold(
        body: Column(
          children: [
            _getHeader(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              child: Divider(color: ColorName.yellow700, thickness: 1.5),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      context.tr(StringRes.history.name),
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorName.yellow700,
                      ),
                    ),
                  ),
                  KbTextButton(StringRes.seeMore.name, onTap: _onSeeMoreClick)
                ],
              ),
            ),
            const Expanded(
              child: HistoryList(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getHeader() {
    return SizedBox(
      width: context.mediaQuery.size.width,
      height: context.mediaQuery.size.height * 0.25,
      child: OverflowBox(
        maxWidth: context.mediaQuery.size.width,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: context.mediaQuery.size.height * 0.08,
              ),
              decoration: const BoxDecoration(
                color: ColorName.yellow400,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const WrappedIcon(
                      icon: Icons.person_rounded,
                      size: 28,
                      margin: EdgeInsets.only(right: 12),
                    ),
                    Expanded(
                      child: Text(
                        'Hi, nama orang',
                        style: context.textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    WrappedIcon(
                      icon: Icons.logout_rounded,
                      size: 28,
                      margin: const EdgeInsets.only(left: 12),
                      onTap: _onLogoutClick,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AddCard(onAddClick: _onAddClick),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onAddClick() async {
    dynamic result = await Navigation.slideToLeft(context, AppRouter.form());

    if (result != null && mounted) {
      dynamic refresh = await Navigation.slideToLeft(
        context,
        AppRouter.result(result as History),
      );

      if (refresh != null && refresh as bool && mounted) {
        BlocProvider.of<HistoryBloc>(context).add(HistoryEventGetHistoryList());
      }
    }
  }

  void _onSeeMoreClick() {
    Navigation.slideToLeft(context, AppRouter.history());
  }

  void _onLogoutClick() {
    BlocProvider.of<FormBloc>(context).add(FormEventLogout());
  }

  void _onHistoryBlocListener(BuildContext context, HistoryState state) {
    if (state is HistoryStateLoading) {
    } else if (state is HistoryStateSuccess) {
    } else if (state is HistoryStateError) {}
  }
}

class AddCard extends StatelessWidget {
  const AddCard({this.onAddClick, super.key});

  final Function()? onAddClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAddClick,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(15),
                  ),
                  color: context.colorScheme.onSurface,
                ),
                child: Text(
                  context.tr(StringRes.addPremium.name),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.surface,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.tr(StringRes.addPremiumCalculation.name),
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    WrappedIcon(
                      margin: const EdgeInsets.only(left: 25),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.colorScheme.primary,
                      ),
                      icon: Icons.add,
                      size: 28,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
