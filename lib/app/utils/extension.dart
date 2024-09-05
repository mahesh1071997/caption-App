import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

extension CustomExtension on Widget {
  Widget toProgressIndicator({required RxBool isLoading}) {
    if (isLoading.value) {
      return ObxValue<RxBool>((isSearching) => isSearching() ? this : Center(
                  child: SizedBox(
                  height: Get.height / 7.5,
                  child: Lottie.asset('assets/lottie/loader.json', alignment: Alignment.center, repeat: true, reverse: true, animate: true),
                ).paddingAll(8.0)),
          isLoading);
    } else {
      return ObxValue<RxBool>(
          (isSearching) => isSearching()
              ? this
              : Center(
                  child: SizedBox(
                  height: Get.height / 7.5,
                  child: Lottie.asset('assets/lottie/loader.json', alignment: Alignment.center, repeat: true, reverse: true, animate: true),
                ).paddingAll(8.0)),
          isLoading);
    }
  }

  Widget toOfflineProgressIndicator({required RxBool isLoading}) {
    if (isLoading.value) {
      return ObxValue<RxBool>(
              (isSearching) => isSearching()
              ? this
              : Center(
              child: SizedBox(
                height:100,
                width:  Get.width * 1.5,
                child: Lottie.asset('assets/lottie/load_upload_image.json', alignment: Alignment.center, repeat: true, reverse: true, animate: true),
              ).paddingAll(8.0)),
          isLoading);
    } else {
      return ObxValue<RxBool>(
              (isSearching) => isSearching()
              ? this
              : Center(
              child: SizedBox(
                height: 500, width:  Get.width * 1.5,
                child: Lottie.asset('assets/lottie/load_upload_image.json', alignment: Alignment.center, repeat: true, reverse: true, animate: true),
              ).paddingAll(8.0)),
          isLoading);
    }
  }

  Widget toOfflineSyncProgressIndicator({required RxBool isLoading}) {
    if (isLoading.value) {
      return ObxValue<RxBool>(
              (isSearching) => isSearching()
              ? this
              : Center(
              child: CircularProgressIndicator(color: Get.theme.primaryColor,).paddingAll(8.0)),
          isLoading);
    } else {
      return ObxValue<RxBool>(
              (isSearching) => isSearching()
              ? this
              : Center(
                  child: CircularProgressIndicator(color: Get.theme.primaryColor,).paddingAll(8.0)),
          isLoading);
    }
  }
}

extension CustomExtensions on String {
  bool checkNull() {
    if ([null, "", " ", "null"].contains(this)) {
      return true;
    } else {
      return false;
    }
  }

  bool checkNotNull() {
    if (![null, "", " ", "null"].contains(this)) {
      return true;
    } else {
      return false;
    }
  }

  String toCamelCase() {
    List<String> words = this.split(' ');
    String camelCase = "";
    for (int i = 0; i < words.length; i++) {
      String word = words[i] + " ";
      camelCase += word[0].toUpperCase() + word.substring(1);
    }
    return camelCase;
  }
}
