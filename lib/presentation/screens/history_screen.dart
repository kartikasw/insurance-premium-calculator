import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insurance_challenge/presentation/common_widgets/history_list.dart';
import 'package:insurance_challenge/resource/string_resource.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(StringRes.history.name)),
      ),
      body: const HistoryList(padding: EdgeInsets.all(20)),
    );
  }
}
