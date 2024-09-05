import 'dart:typed_data';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../models/caption_model.dart';
import '../../../services/gemini_services.dart';

class HomeController extends GetxController {
  final selectedItem = 'Instagram'.obs; // Observable string to store the selected item
  final selectedMood = 'Normal'.obs; // Observable string to store the selected mood
  final imageFile = Rx<XFile?>(null);
  var pickedImage = Rxn<Uint8List>();
  final TextEditingController extra = TextEditingController();
  final RxList<Caption> captionList = <Caption>[].obs;
  final RxBool loader = true.obs;
  final RxBool otherLoader = true.obs;

  final generativeModelService = Get.find<GenerativeModelService>();

  void onSelectItem(String item) => selectedItem.value = item;

  void onSelectMood(String mood) => selectedMood.value = mood;

  Future<void> pickImage(ImageSource source) async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      await requestPermissions();
    }

    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      pickedImage.value = await pickedFile.readAsBytes();
      imageFile.value = pickedFile;
      extra.clear();
      captionList.clear();
    } else {
      print('No image selected.');
    }
  }

  @override
  void onReady() async {
    await requestPermissions();
  }

  Future<void> geminiCall() async {
    captionList.clear();
    await _generateCaption(
          () => generativeModelService.genTextWithImg(
        selectedItem.value,
        selectedMood.value,
        extra.text,
        imageFile.value,
      ),
      loader,
    );
  }

  Future<void> reGenCaption() async {
    String prompt = "give me answer unique and creative way as content writer. here i have given you a caption, caption is: ${captionList.last.caption}, you read this caption in detail and analyze it, and give me a new caption and tags";
    await _generateCaption(() => generativeModelService.generateText(prompt), otherLoader);
  }

  Future<void> _generateCaption(Future<String?> Function() generateText, RxBool loadingIndicator) async {
    try {
      loadingIndicator.value = false;
      String data = (await generateText())!;
      final caption = captionFromJson(data);
      List<String> tags = caption.hashtags!
          .map((item) => item.startsWith('#') ? item : '#$item')
          .toSet()
          .toList();

      captionList.add(caption.copyWith(tags: tags,title: caption.title ?? " "));
    } catch (e) {
      _showErrorSnackbar();
      throw Exception(e);
    } finally {
      loadingIndicator.value = true;
    }
  }

  void _showErrorSnackbar() {
    Get.snackbar(
      "Something wrong",
      "Check Internet or try again.",
      backgroundColor: Colors.red.shade100,
      icon: const Icon(Icons.warning),
    );
  }

  Future<void> requestPermissions() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      // await _requestPermission(Permission.camera);
      await _requestPermission(Permission.photos);
    }
  }

  Future<void> _requestPermission(Permission permission) async {
    var status = await permission.status;
    if (!status.isGranted) {
      status = await permission.request();
    }
    if (status.isDenied) {
      print('Permission denied for $permission');
      // Get.snackbar("Give Permission", "you give me the photo or gallery premise");
    }
  }
}