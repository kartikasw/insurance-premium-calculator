import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_challenge/core/domain/model/history.dart';
import 'package:insurance_challenge/presentation/bloc/result/result_bloc.dart';
import 'package:insurance_challenge/presentation/common_widgets/state.dart';
import 'package:insurance_challenge/resource/assets.gen.dart';
import 'package:insurance_challenge/resource/colors.gen.dart';
import 'package:insurance_challenge/utils/extensions.dart';
import 'package:insurance_challenge/utils/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen(this.history, {super.key});

  final History history;

  @override
  State<StatefulWidget> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generatePdf();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResultBloc, ResultState>(
      listener: _onResultBlocListener,
      child: WillPopScope(
        child: Scaffold(
          backgroundColor: ColorName.grey300,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () => Navigator.pop(context, true),
              child: const Icon(Icons.arrow_back_rounded),
            ),
          ),
          body: Center(
            child: BlocBuilder<ResultBloc, ResultState>(
              builder: (context, state) {
                if (state is ResultStateSuccess) {
                  return SfPdfViewer.memory(state.pdfData);
                } else {
                  return CircularProgressIndicator(
                    color: context.colorScheme.primary,
                  );
                }
              },
            ),
          ),
        ),
        onWillPop: () async => true,
      ),
    );
  }

  Future<void> _generatePdf() async {
    pw.Document document = pw.Document();
    String rawSvg = await _readFile(Assets.iconsKb.path);
    debugPrint('pattern : $rawSvg');
    pw.Widget logo = pw.SvgImage(svg: rawSvg, height: 35);

    String coverageType = '';
    String coverageRisk = '';
    List<pw.Widget> risks = [];

    String coverageFormat = currencyFormat.format(
      widget.history.coverage,
    );
    String coverageFormatWithoutSymbol = currencyWithoutSymbolFormat.format(
      widget.history.coverage,
    );

    if (mounted) {
      coverageType = context.tr(widget.history.coverageType.title);
      for (int i = 0; i < widget.history.coverageRisk.length; i++) {
        coverageRisk += widget.history.coverageRisk[i].defaultTitle;
        if (i != (widget.history.coverageRisk.length - 1)) {
          coverageRisk += ', ';
        }
        double premium =
            widget.history.coverage * widget.history.coverageRisk[i].rate;
        risks.add(
          _createRowData(
            widget.history.coverageRisk[i].defaultTitle,
            '${currencyFormat.format(premium)} ($coverageFormatWithoutSymbol x ${widget.history.coverageRisk[i].rate})',
          ),
        );
      }
    }

    DateTime startPeriod = DateTime.parse(widget.history.period);
    DateTime endPeriod = DateTime(
      startPeriod.year + 1,
      startPeriod.month,
      startPeriod.day,
    );
    String periodFormat =
        '${dateFormat.format(DateTime.parse(widget.history.period))} - ${dateFormat.format(endPeriod)}';

    document.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter,
        build: (pw.Context pwContext) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Row(
              children: <pw.Widget>[
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 12.0),
                  child: logo,
                ),
                pw.Text(
                  'KB Insurance Indonesia',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#ACA6A2'),
                  ),
                )
              ],
            ),
            pw.SizedBox(height: 40),
            pw.Text(
              'General Information',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            _createRowData('Nama Tertanggung', widget.history.customerName),
            _createRowData('Periode Pertanggungan', periodFormat),
            _createRowData(
                'Pertanggungan / Kendaraan', widget.history.vehicleType),
            _createRowData('Harga Pertanggungan', coverageFormat),
            pw.SizedBox(height: 40),
            pw.Text(
              'Coverage Information',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            _createRowData('Jenis Pertanggungan', coverageType),
            _createRowData('Risiko Pertanggungan', coverageRisk),
            pw.SizedBox(height: 40),
            pw.Text(
              'Premium Calculation',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            _createRowData('Periode Pertanggungan', periodFormat),
            _createRowData(
              'Premi Kendaraan',
              '${currencyFormat.format(widget.history.coverage * widget.history.coverageType.rate)} ($coverageFormatWithoutSymbol x ${widget.history.coverageType.rate})',
            ),
            for (pw.Widget widget in risks) widget,
            pw.SizedBox(height: 40),
            _createRowData(
              'Total Premi',
              currencyFormat.format(widget.history.premium),
            ),
          ],
        ),
      ),
    );

    Uint8List doc = await document.save();
    if (mounted) {
      BlocProvider.of<ResultBloc>(context).add(
        ResultEventGenerateResultPdf(doc, widget.history.customerName),
      );
    }
  }

  pw.Widget _createRowData(String title, String value) {
    return pw.Column(children: <pw.Widget>[
      pw.Row(
        children: <pw.Widget>[
          pw.SizedBox(
            width: 250,
            child: pw.Text(title, style: const pw.TextStyle(fontSize: 14)),
          ),
          pw.Text(': $value', style: const pw.TextStyle(fontSize: 14))
        ],
      ),
      pw.SizedBox(height: 8),
    ]);
  }

  Future<String> _readFile(String path) async {
    String content = await rootBundle.loadString(path);
    debugPrint(content);
    return content;
  }

  void _onResultBlocListener(BuildContext context, ResultState state) {
    if (state is ResultStateError) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) => ErrorState(state.errMessage),
      );
    }
  }
}
