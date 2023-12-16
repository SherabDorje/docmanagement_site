import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../controllers/home_controller.dart';

class HomeRightPanel extends GetView<HomeController> {
  const HomeRightPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (_) => Card(
              elevation: 10,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: Get.height - Get.height * 0.1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.05),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const Text('SAVE'),
                            InkWell(
                              onTap: () {},
                              // onTap: _.pdfController.savePDF,
                              child: const Icon(
                                Icons.drive_folder_upload_outlined,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: Get.height * 0.03),
                          child: Column(
                            children: [
                              const Text('SEND'),
                              InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.send_outlined,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            const Text('NEXT'),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.next_plan_outlined,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
