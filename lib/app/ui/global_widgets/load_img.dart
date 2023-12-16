import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';

import '../utils/Constants.dart';

loadImgGet({
  required Function() onTapGaleries,
  required Function() onTapCamera,
}) {
  Get.bottomSheet(
    GlassContainer(
      height: Get.height * 0.2,
      width: Get.width,
      color: Colors.transparent,
      borderWidth: 2,
      borderColor: Constants.primaryColor,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(45), topRight: Radius.circular(45)),
      child: Padding(
        padding: EdgeInsets.only(left: Get.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: onTapGaleries,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.image_search_sharp,
                    size: Get.height * 0.08,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: Get.width * 0.65,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Desde la galería',
                        style: TextStyle(
                          fontSize: Get.height * 0.03,
                          color: Colors.white,
                          fontFamily: Constants.fontFamilyApp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: onTapCamera,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.camera,
                    size: Get.height * 0.08,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: Get.width * 0.65,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Desde la cámara',
                        style: TextStyle(
                          fontSize: Get.height * 0.03,
                          color: Colors.white,
                          fontFamily: Constants.fontFamilyApp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
