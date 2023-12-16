import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';

import '../../../controllers/home_controller.dart';
import '../../global_widgets/custom_button.dart';
import '../../utils/constants.dart';

class HomeLeftPanel extends GetView<HomeController> {
  const HomeLeftPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (_) => Card(
              elevation: 10,
              child: SizedBox(
                height: Get.height - Get.height * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _owner(_)),
                    Expanded(flex: 10, child: _form(_)),
                  ],
                ),
              ),
            ));
  }

  _owner(HomeController _) {
    return Column(
      children: [
        // Row(
        //   children: [
        //     Icon(
        //       Icons.account_circle_outlined,
        //       color: Colors.black,
        //       size: Get.height * 0.1,
        //     ),
        //     const SizedBox(
        //       width: 10,
        //     ),
        //     const Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           'John Doe',
        //           style: TextStyle(
        //               color: Color.fromRGBO(8, 82, 147, 1),
        //               fontSize: 24,
        //               fontFamily: Constants.fontFamilyApp),
        //         ),
        //         Text(
        //           'FROZZEN AIR',
        //           style: TextStyle(
        //               color: Colors.grey, fontFamily: Constants.fontFamilyApp),
        //         ),
        //         Text(
        //           'johndoe@abc.com',
        //           style: TextStyle(
        //               color: Colors.black, fontFamily: Constants.fontFamilyApp),
        //         ),
        //       ],
        //     )
        //   ],
        // ),
        Padding(
          padding: EdgeInsets.only(
            left: Get.width * 0.01,
            right: Get.width * 0.01,
            top: Get.height * 0.01,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Proposal Form',
                style: TextStyle(
                    fontFamily: Constants.fontFamilyApp,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              CustomButton(
                width: Get.width * 0.06,
                height: Get.height * 0.05,
                gradient: const LinearGradient(colors: [
                  Constants.primaryColor,
                  Constants.secondaryColor,
                  Constants.primaryColor,
                ]),
                borderRadius: 5,
                onPressed: () => _.homeCenterPanel.createProposal(_),
                child: const Text(
                  "Create PDF",
                  style: TextStyle(
                      color: Colors.white, fontFamily: Constants.fontFamilyApp),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _form(HomeController _) {
    return Obx(() => Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                _itemForm(
                  _,
                  name: MagicStrings.projectName.name,
                  'Project Name',
                  isDrop: false,
                  tecontroller: _.projectNameController.value,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                _itemForm(
                  _,
                  name: MagicStrings.customer.name,
                  'Customer',
                  onChanged: (value) {
                    _.customerSel.value = value!;
                    // _.homeCenterPanel.createProposal(_);
                  },
                  dropValue: _.customerSel.value,
                  dropList: _.customerTypes,
                ),
                _itemForm(
                  _,
                  name: MagicStrings.phone.name,
                  'Phone',
                  isDrop: false,
                  tecontroller: _.phoneController.value,
                  keyboardType: TextInputType.number,
                ),
                _itemForm(
                  _,
                  name: MagicStrings.attn.name,
                  'Attn.',
                  isDrop: false,
                  tecontroller: _.attnController.value,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                _itemForm(
                  _,
                  name: MagicStrings.modelPlan.name,
                  'Model/Plan',
                  onChanged: (value) {
                    _.modelPlanSel.value = value!;
                    // _.homeCenterPanel.createProposal(_);
                  },
                  dropValue: _.modelPlanSel.value,
                  dropList: _.modelPlanTypes,
                ),
                _itemForm(
                  _,
                  name: MagicStrings.bidPlan.name,
                  'Bid Plan',
                  onChanged: (value) {
                    _.bidPlanSel.value = value!;
                    // _.homeCenterPanel.createProposal(_);
                  },
                  dropValue: _.bidPlanSel.value,
                  dropList: _.bidPlanTypes,
                ),
                _itemForm(
                  _,
                  name: MagicStrings.city.name,
                  'City',
                  onChanged: (value) {
                    _.citySel.value = value!;
                    // _.homeCenterPanel.createProposal(_);
                  },
                  dropValue: _.citySel.value,
                  dropList: _.cityTypes,
                ),
                _itemForm(
                  _,
                  name: MagicStrings.jobAddress.name,
                  'Job Address',
                  isDrop: false,
                  tecontroller: _.jobAddressController.value,
                  suffixIcon: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.01),
                        child: const Icon(Icons.map_outlined),
                      ),
                      const Icon(
                        Icons.room,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                _itemForm(
                  _,
                  name: MagicStrings.price.name,
                  'Value',
                  isDrop: false,
                  tecontroller: _.priceController.value,
                  prefixIcon: const Icon(Icons.attach_money),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Obx(() => Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: Get.height * 0.02),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 10,
                            child: Table(
                              border: TableBorder.all(color: Colors.black),
                              children: _.tableRows,
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: _.addRowEquipment,
                              child: const Icon(Icons.add_box_outlined),
                            ),
                          )
                        ],
                      ),
                    )),
                // _itemForm(
                //   _,
                //   name: MagicStrings.equipment.name,
                //   'Equipments',
                //   isDrop: false,
                //   tecontroller: _.equipmentController.value,
                //   keyboardType: TextInputType.multiline,
                //   maxLines: 10,
                //   maxLength: null,
                //   showBox: true,
                // ),
                // _itemForm(
                //   _,
                //   name: MagicStrings.ton.name,
                //   'Tonnage',
                //   isDrop: false,
                //   tecontroller: _.tonController.value,
                //   keyboardType: TextInputType.number,
                // ),
                // _itemForm(
                //   _,
                //   name: MagicStrings.seer.name,
                //   'S.E.E.R.',
                //   isDrop: false,
                //   tecontroller: _.seerController.value,
                //   keyboardType: TextInputType.number,
                // ),
                // _itemForm(
                //   _,
                //   name: MagicStrings.hspf.name,
                //   'H.S.P.F.',
                //   isDrop: false,
                //   tecontroller: _.hspfController.value,
                //   keyboardType: TextInputType.number,
                // ),
                // _itemForm(
                //   _,
                //   name: MagicStrings.elecHeat.name,
                //   'Elec. Heat',
                //   isDrop: false,
                //   tecontroller: _.elecHeatController.value,
                //   keyboardType: TextInputType.number,
                // ),
                _itemForm(
                  _,
                  name: 'date',
                  readOnly: true,
                  DateFormat.yMd().format(_.dateController.value),
                  withoutLabel: true,
                  maxLength: null,
                  isDrop: false,
                  suffixIcon: InkWell(
                    onTap: () => _callShowDatePicker(_),
                    child: const Icon(Icons.calendar_month),
                  ),
                  prefixIcon: const Text(
                    'Date: ',
                    style: TextStyle(fontFamily: Constants.fontFamilyApp),
                  ),
                  onTap: () => _callShowDatePicker(_),
                ),
              ],
            ),
          ),
        ));
  }

  _itemForm(
    HomeController _,
    String label, {
    String? name,
    bool isDrop = true,
    Function(String?)? onChanged,
    dropValue,
    List? dropList,
    TextEditingController? tecontroller,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool withoutLabel = false,
    int? maxLength = 40,
    int? maxLines,
    bool showBox = false,
    TextInputType keyboardType = TextInputType.name,
    Function()? onTap,
    bool readOnly = false,
  }) {
    return isDrop
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontFamily: Constants.fontFamilyApp),
                ),
                DropdownButton<String>(
                  hint: const Text('',
                      style: TextStyle(fontFamily: Constants.fontFamilyApp)),
                  onChanged: onChanged,
                  value: dropValue,
                  isDense: true,
                  items: dropList!.map((value) {
                    return DropdownMenuItem<String>(
                      value: value['name'],
                      child: Text(
                        value['name']!,
                        style: const TextStyle(
                            color: Colors.black45,
                            fontFamily: Constants.fontFamilyApp),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.only(right: Get.width * 0.02),
            child: Row(
              children: [
                SizedBox(
                  width: Get.width * 0.14,
                  child: TextFormField(
                    readOnly: readOnly,
                    keyboardType: keyboardType,
                    maxLines: maxLines,
                    controller: !withoutLabel ? tecontroller : null,
                    initialValue: !withoutLabel ? null : label,
                    decoration: InputDecoration(
                      prefixIcon: prefixIcon,
                      hintText: !withoutLabel ? null : label,
                      alignLabelWithHint: true,
                      label: !withoutLabel
                          ? Text(
                              label,
                              style: const TextStyle(
                                  fontFamily: Constants.fontFamilyApp),
                            )
                          : null,
                      border: showBox
                          ? const OutlineInputBorder()
                          : const UnderlineInputBorder(),
                    ),
                    maxLength: maxLength,
                    onTap: onTap,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                suffixIcon ?? const SizedBox.shrink()
              ],
            ),
          );
  }

  _callShowDatePicker(HomeController _) async {
    await showDatePicker(
      context: Get.context!,
      firstDate: DateTime.now(),
      initialDate: _.dateController.value,
      lastDate: DateTime(3000),
    ).then((DateTime? date) async {
      if (date != null) {
        _.dateController.value = date;
      }
    });
  }
}
