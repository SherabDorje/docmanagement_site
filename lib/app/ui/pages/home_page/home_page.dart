import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../controllers/home_controller.dart';
import '../../utils/Constants.dart';
import 'home_left_panel.dart';
import 'home_center_panel.dart';
import 'home_right_panel.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => AdminScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Constants.primaryColor,
            title: const Text(
              'Form Generator',
              style: TextStyle(fontFamily: Constants.fontFamilyApp),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                child: Image.asset('assets/images/icon.png', scale: 10),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: Get.width * 0.05),
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  onTap: () {},
                  child: Icon(Icons.account_circle_outlined,
                      size: Get.height * 0.05),
                ),
              ),
            ]),
        body: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 5, child: HomeLeftPanel()),
            Expanded(flex: 9, child: HomeCenterPanel()),
            Expanded(child: HomeRightPanel()),
          ],
        ),
      ),
    );
  }
}
