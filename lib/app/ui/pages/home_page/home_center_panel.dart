import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../../controllers/home_controller.dart';
import '../../global_widgets/custom_snakbar.dart';
import '../../utils/constants.dart';

class HomeCenterPanel extends GetView<HomeController> {
  const HomeCenterPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (_) => Card(
              elevation: 10,
              child: SizedBox(
                height: Get.height - Get.height * 0.1,
                child: Obx(
                  () => SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // _search(_),
                      // _tab(_),
                      _view(_),
                    ],
                  )),
                ),
              ),
            ));
  }

  _view(HomeController _) {
    if (_.panelView.value is Text &&
        (_.panelView.value as Text).data == 'Proposal') {
      createProposal(_);
    }
    return _.panelView.value;
  }

  Future<void> createProposal(HomeController _) async {
    if (_.phoneController.value.text != '' &&
        int.tryParse(_.phoneController.value.text) == null) {
      Snack.show(
        content: 'The phone number have invalid format',
        snackType: SnackType.error,
        behavior: SnackBarBehavior.floating,
      );
    } else if (!_.validatingIntegerValue(_.seerController)) {
      Snack.show(
        content: 'The S.E.E.R have invalid format',
        snackType: SnackType.error,
        behavior: SnackBarBehavior.floating,
      );
    } else if (_.priceController.value.text != '' &&
        (!_.priceController.value.text.contains('.')
            ? int.tryParse(_.priceController.value.text) == null
            : double.tryParse(_.priceController.value.text) == null)) {
      Snack.show(
        content: 'The price have invalid format',
        snackType: SnackType.error,
        behavior: SnackBarBehavior.floating,
      );
    } else if (!_.validatingIntegerValue(_.hspfController)) {
      Snack.show(
        content: 'The H.S.P.F have invalid format',
        snackType: SnackType.error,
        behavior: SnackBarBehavior.floating,
      );
    } else if (!_.validatingIntegerValue(_.tonController)) {
      Snack.show(
        content: 'The tonnage have invalid format',
        snackType: SnackType.error,
        behavior: SnackBarBehavior.floating,
      );
    } else {
      _.panelView.value = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            height: Get.height,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: PdfPreview(
                build: (format) async =>
                    (await _.pdfController.generatePdf(format: format, data: {
                  'date': _.dateController.value,
                  MagicStrings.imgLogo.name: _.imgLogo.value,
                  MagicStrings.customer.name: _.customerSel.value,
                  MagicStrings.projectName.name:
                      _.projectNameController.value.text,
                  MagicStrings.modelPlan.name: _.modelPlanSel.value,
                  MagicStrings.city.name: _.citySel.value,
                  MagicStrings.jobAddress.name:
                      _.jobAddressController.value.text,
                  MagicStrings.bidPlan.name: _.bidPlanSel.value,
                  MagicStrings.phone.name: _.phoneController.value.text,
                  MagicStrings.attn.name: _.attnController.value.text,
                  MagicStrings.price.name: _.priceController.value.text,
                  MagicStrings.equipment.name: _.equipmentController,
                  MagicStrings.ton.name: _.tonController,
                  MagicStrings.seer.name: _.seerController,
                  MagicStrings.hspf.name: _.hspfController,
                  MagicStrings.elecHeat.name: _.elecHeatController,
                }))
                        .save(),
                useActions: true,
                initialPageFormat: PdfPageFormat.a4,
                allowPrinting: true,
                allowSharing: true,
                onError: (context, child) => const Center(
                  child: Text(
                    "Error",
                    style: TextStyle(fontFamily: Constants.fontFamilyApp),
                  ),
                ),
                pdfFileName: 'example.pdf',
                canChangePageFormat: true,
              ),
            ),
          ),
        ),
      );
    }
  }
}
