import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurance_challenge/core/domain/model/history.dart';
import 'package:insurance_challenge/presentation/bloc/history/history_bloc.dart';
import 'package:insurance_challenge/resource/assets.gen.dart';
import 'package:insurance_challenge/resource/colors.gen.dart';
import 'package:insurance_challenge/resource/string_resource.dart';
import 'package:insurance_challenge/utils/extensions.dart';
import 'package:insurance_challenge/utils/utils.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({this.padding, super.key});

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state.list.isNotEmpty) {
          return ListView.builder(
            padding: padding,
            itemBuilder: (context, index) => HistoryItem(state.list[index]),
          );
        } else {
          return Center(
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
          );
        }
      },
    );
  }
}

class HistoryItem extends StatelessWidget {
  const HistoryItem(this.history, {super.key});

  final History history;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                  ),
                ),
                Text(
                  dateFormat.format(DateTime.now()),
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
