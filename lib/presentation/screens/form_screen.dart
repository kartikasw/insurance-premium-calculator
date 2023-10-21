import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_challenge/presentation/bloc/form/form_bloc.dart';
import 'package:insurance_challenge/presentation/common_widgets/check_box.dart';
import 'package:insurance_challenge/presentation/common_widgets/dropdown.dart';
import 'package:insurance_challenge/presentation/common_widgets/state.dart';
import 'package:insurance_challenge/presentation/common_widgets/text_filed.dart';
import 'package:insurance_challenge/resource/string_resource.dart';
import 'package:insurance_challenge/utils/enum/coverage_risk.dart';
import 'package:insurance_challenge/utils/enum/coverage_type.dart';
import 'package:insurance_challenge/utils/extensions.dart';
import 'package:insurance_challenge/utils/utils.dart';
import 'package:flutter/src/widgets/form.dart' as form;

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _coverageController = TextEditingController();
  final TextEditingController _vehicleController = TextEditingController();
  final _formKey = GlobalKey<form.FormState>();

  late final TextEditingController _periodController;

  CoverageType _selectedType = CoverageType.comprehensive;
  List<CoverageRisk> _selectedRisk = [];

  LoadingState? _loading;

  @override
  void initState() {
    _periodController = TextEditingController(
      text: dateFormat.format(
        DateTime.now(),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _coverageController.dispose();
    _vehicleController.dispose();
    _loading?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FormBloc, KbFormState>(
      listener: _onFormBlocListener,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.tr(StringRes.addCalculation.name)),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              KbTextFormField(
                formTitle: StringRes.customerName.name,
                controller: _nameController,
                keyboardType: TextInputType.text,
              ),
              GestureDetector(
                onTap: _onShowDatePicker,
                child: KbTextFormField(
                  enabled: false,
                  formTitle: StringRes.coveragePeriod.name,
                  controller: _periodController,
                  keyboardType: TextInputType.text,
                ),
              ),
              KbTextFormField(
                formTitle: StringRes.vehicleType.name,
                controller: _vehicleController,
                keyboardType: TextInputType.text,
              ),
              KbTextFormField(
                formTitle: StringRes.coverage.name,
                controller: _coverageController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'\d'))
                ],
              ),
              _getCoverageTypeDropdown(),
              _getRiskCheckbox(),
              ElevatedButton(
                onPressed: _onAddClick,
                child: Text(context.tr(StringRes.add.name)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getCoverageTypeDropdown() {
    return KbDropdown(
      selectedItem: _selectedType,
      title: StringRes.coverageType.name,
      items: CoverageType.values
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                context.tr(e.title),
                style: context.textTheme.bodyMedium,
              ),
            ),
          )
          .toList(),
      onChanged: (value) => _onTypeChange,
    );
  }

  Widget _getRiskCheckbox() {
    return KbCheckBox(
      title: StringRes.coverageRisk.name,
      items: CoverageRisk.values,
      item: (item) => Text(context.tr((item as CoverageRisk).title)),
      selectedItems: (items) {
        _selectedRisk = items.map((e) => e as CoverageRisk).toList();
      },
    );
  }

  void _onShowDatePicker() async {
    DateTime? result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2070),
    );

    if (result != null) {
      _periodController.text = dateFormat.format(result);
    }
  }

  void _onTypeChange(CoverageType type) {
    _selectedType = type;
  }

  void _onAddClick() {
    if (_formKey.currentState!.validate()) {
      debugPrint('_onAddClick');
      BlocProvider.of<FormBloc>(context).add(
        FormEventSubmitPremiumForm(
          customerName: _nameController.text,
          vehicle: _vehicleController.text,
          period: dateFormat.parse(_periodController.text),
          coverage: double.parse(_coverageController.text),
          coverageType: _selectedType,
          coverageRisk: _selectedRisk,
        ),
      );
    }
  }

  void _onFormBlocListener(BuildContext context, KbFormState state) {
    if (state is KbFormStateLoading) {
      _loading ??= LoadingState(context);
      _loading?.show();
    } else if (state is KbFormStateSuccess) {
      _loading?.dismiss();
      Navigator.pop(context, state.history);
    } else if (state is KbFormStateError) {
      _loading?.dismiss();
    }
  }
}
