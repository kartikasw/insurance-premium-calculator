import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurance_challenge/core/domain/model/history.dart';
import 'package:insurance_challenge/presentation/bloc/history/history_bloc.dart';
import 'package:insurance_challenge/presentation/common_widgets/state.dart';
import 'package:insurance_challenge/resource/assets.gen.dart';
import 'package:insurance_challenge/resource/colors.gen.dart';
import 'package:insurance_challenge/resource/string_resource.dart';
import 'package:insurance_challenge/utils/app_router.dart';
import 'package:insurance_challenge/utils/extensions.dart';
import 'package:insurance_challenge/utils/navigation.dart';
import 'package:insurance_challenge/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({this.padding, super.key});

  final EdgeInsets? padding;

  @override
  State<StatefulWidget> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: false);
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryBloc, HistoryState>(
      listener: _onHistoryBlocListener,
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryStateInitial || state is HistoryStateLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: context.colorScheme.primary,
              ),
            );
          } else {
            return SmartRefresher(
              onRefresh: () => BlocProvider.of<HistoryBloc>(context).add(
                HistoryEventGetHistoryList(refresh: true),
              ),
              header: WaterDropHeader(
                waterDropColor: context.colorScheme.primary,
              ),
              controller: _refreshController,
              child: state.list.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: widget.padding ?? const EdgeInsets.all(20.0),
                      itemCount: state.list.length,
                      itemBuilder: (context, index) =>
                          HistoryItem(state.list[index]),
                    )
                  : Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            Assets.iconsEmpty.path,
                            width: context.mediaQuery.size.width * 0.8,
                          ),
                          Text(
                            context.tr(StringRes.emptyHistory.name),
                            style: context.textTheme.titleMedium,
                          )
                        ],
                      ),
                    ),
            );
          }
        },
      ),
    );
  }

  void _onHistoryBlocListener(BuildContext context, HistoryState state) {
    if (state is HistoryStateRefreshing) {
    } else if (state is HistoryStateLoading) {
    } else if (state is HistoryStateSuccess) {
      _refreshController.refreshCompleted();
    } else if (state is HistoryStateError) {
      _refreshController.refreshCompleted();
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) => ErrorState(state.errMessage),
      );
    }
  }
}

class HistoryItem extends StatelessWidget {
  const HistoryItem(this.history, {super.key});

  final History history;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigation.push(context, AppRouter.result(history)),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    history.customerName,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  dateTimeFormat.format(DateTime.parse(history.timestamp)),
                  style: context.textTheme.bodySmall,
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0),
              child: Divider(color: ColorName.grey400),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                history.vehicleType,
                style: context.textTheme.bodyMedium,
              ),
            ),
            Text(
              currencyFormat.format(history.premium),
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
