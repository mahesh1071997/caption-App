import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/services/gemini_services.dart';

void main()async {

  final generativeModelService = GenerativeModelService(
    model: 'gemini-1.5-flash',
    apiKey: 'AIzaSyBrtPiP9yDHpBX9Dfhztlqd-glFXE1U2ak',
  );
  Get.put(generativeModelService);
  runApp(GetMaterialApp(
    title: "Application",
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
    key: UniqueKey(),
    debugShowCheckedModeBanner: false,
  ));
  // runApp(const MyApp());
}
