import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../helper/ImagesConstant.dart';
import '../../Widget/comman/CustomAppBar.dart';

class RegulationScreen extends StatefulWidget {
  final String internalRegulationsText;
  const RegulationScreen({super.key,required this.internalRegulationsText});

  @override
  State<RegulationScreen> createState() => _RegulationScreenState();
}

class _RegulationScreenState extends State<RegulationScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'internalRegulation'.tr(),
          needBack: true,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: HtmlWidget(widget.internalRegulationsText,
            textStyle: TextStyle(fontSize: 15),
              enableCaching: true,
            ),
          ),
        ),
      ),
    );
  }
}
