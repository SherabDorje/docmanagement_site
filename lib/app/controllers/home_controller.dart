import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/pages/home_page/home_center_panel.dart';
import '../ui/utils/Constants.dart';
import 'pdf_controller.dart';
// import 'pdf_controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find<HomeController>();
  PdfController pdfController = PdfController.to;

  var imgLogo = File('').obs;

  //Form
  var projectNameController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var attnController = TextEditingController().obs;
  var jobAddressController = TextEditingController().obs;
  var priceController = TextEditingController().obs;
  var equipmentController =
      <TextEditingController>[TextEditingController()].obs;
  var tonController = <TextEditingController>[TextEditingController()].obs;
  var seerController = <TextEditingController>[TextEditingController()].obs;
  var hspfController = <TextEditingController>[TextEditingController()].obs;
  var elecHeatController = <TextEditingController>[TextEditingController()].obs;
  Rx<DateTime> dateController = DateTime.now().obs;

  var textEditingControllerCount = 1;

  var searchController = TextEditingController().obs;
  //customer
  var customerTypes = <Map<String, dynamic>>[
    {'name': 'Customer example'}
  ].obs;
  var customerSel = ''.obs;
  //modelPlan
  var modelPlanTypes = <Map<String, dynamic>>[
    {'name': 'Model example'},
    {'name': 'Plan example'}
  ].obs;
  var modelPlanSel = ''.obs;
  //modelPlan
  var bidPlanTypes = <Map<String, dynamic>>[
    {'name': 'Bid Plan example 1'},
    {'name': 'Bid Plan example 2'},
  ].obs;
  var bidPlanSel = ''.obs;
  //modelPlan
  var cityTypes = <Map<String, dynamic>>[
    {'name': 'Tokio'},
    {'name': 'New York'}
  ].obs;
  var citySel = ''.obs;

  var tableRows = <TableRow>[].obs;

  Rx<Widget> panelView = Rx<Widget>(const Text(
    'Proposal',
    style: TextStyle(fontFamily: Constants.fontFamilyApp),
  ));
  var homeCenterPanel = const HomeCenterPanel();

  var validated = false.obs;

  @override
  void onInit() {
    //init drops
    customerSel.value = customerTypes[0]['name'];
    modelPlanSel.value = modelPlanTypes[0]['name'];
    bidPlanSel.value = bidPlanTypes[0]['name'];
    citySel.value = cityTypes[0]['name'];

    intitTableEquipments();

    super.onInit();
  }

  void setFile(File imageFile) {
    imgLogo.value = imageFile;
  }

  void intitTableEquipments() {
    tableRows.value = [
      TableRow(children: [
        headerableEquipment('Equipments'),
        headerableEquipment('Tonnage'),
        headerableEquipment('S.E.E.R.'),
        headerableEquipment('H.S.P.F.'),
        headerableEquipment('Elec. Heat'),
      ]),
      TableRow(children: [
        itemTableEquipment(TextField(controller: equipmentController[0])),
        itemTableEquipment(TextField(controller: tonController[0])),
        itemTableEquipment(TextField(controller: seerController[0])),
        itemTableEquipment(TextField(controller: hspfController[0])),
        itemTableEquipment(TextField(controller: elecHeatController[0])),
      ]),
    ];
  }

  Widget headerableEquipment(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget itemTableEquipment(Widget w) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: w,
    );
  }

  void addRowEquipment() {
    equipmentController.add(TextEditingController());
    tonController.add(TextEditingController());
    seerController.add(TextEditingController());
    hspfController.add(TextEditingController());
    elecHeatController.add(TextEditingController());
    tableRows.add(
      TableRow(children: [
        itemTableEquipment(TextField(
            controller: equipmentController[textEditingControllerCount])),
        itemTableEquipment(
            TextField(controller: tonController[textEditingControllerCount])),
        itemTableEquipment(
            TextField(controller: seerController[textEditingControllerCount])),
        itemTableEquipment(
            TextField(controller: hspfController[textEditingControllerCount])),
        itemTableEquipment(TextField(
            controller: elecHeatController[textEditingControllerCount])),
      ]),
    );
    textEditingControllerCount++;
  }

  bool validatingIntegerValue(List<TextEditingController> data) {
    var result = true;
    data.map((e) {
      if (e.text != '' &&
          (e.text.contains('.')
              ? double.tryParse(e.text) == null
              : int.tryParse(e.text) == null)) {
        result = false;
      }
    }).toList();
    return result;
  }
}
