import 'package:caption_craft/app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/text_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: const Center(
            child: GradientText(
              'CaptionCraft',
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.purple,
                  Colors.red,
                ],
              ),
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Obx(
              () => Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 700, // Set your desired max width here
                  ),
                  child: ListView(
                    padding:  const EdgeInsets.all(16.0),
                    children: [
                      const Center(
                        child: Text(
                          'Capture, Caption, Copy',
                          style: TextStyle(fontSize: 18,color: Colors.grey ,fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: const BorderSide(color: Colors.grey, width: 2),
                        ),
                        leading: const Icon(Icons.upload_file),
                        title: const Text('Upload Image'),
                        subtitle: const Text('png, jpeg, gif'),
                        trailing: ElevatedButton(
                          onPressed: () => controller.pickImage(ImageSource.gallery),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                          child: const Text(
                            "Select",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      controller.imageFile.value != null
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.blue, // Border color
                                  width: 2.0,
                                  // Border width
                                ),
                              ),
                              child: Image.memory(
                                controller.pickedImage.value!,
                                width: 300,
                                height: 300,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                      SizedBox(
                        height: controller.imageFile.value != null ? 10 : 0,
                      ),
                      const Text("Select Social Media"),
                      DropdownButtonFormField<String>(
                        
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        value: controller.selectedItem.value,
                        items: const [
                          DropdownMenuItem(
                            value: 'Instagram',
                            child: Text('Instagram'),
                          ),
                          DropdownMenuItem(
                            value: 'FaceBook',
                            child: Text('FaceBook'),
                          ),

                          DropdownMenuItem(
                            value: 'Twitter',
                            child: Text('Twitter (X)'),
                          ),DropdownMenuItem(
                            value: 'Youtube',
                            child: Text('Youtube'),
                          ),
                          DropdownMenuItem(
                            value: 'LinkedIn',
                            child: Text('LinkedIn'),
                          ),
                        ],
                        onChanged: (item) => controller.onSelectItem(item!),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Select a role"),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        value: controller.selectedMood.value,
                        items: const [
                          DropdownMenuItem(
                            value: 'Normal',
                            child: Text('Normal'),
                          ),
                          DropdownMenuItem(
                            value: 'Doctor',
                            child: Text('Doctor'),
                          ), DropdownMenuItem(
                            value: 'Engineer',
                            child: Text('Engineer'),
                          ), DropdownMenuItem(
                            value: 'Teacher',
                            child: Text('Teacher'),
                          ), DropdownMenuItem(
                            value: 'Scientist',
                            child: Text('Scientist'),
                          ), DropdownMenuItem(
                            value: 'Artist',
                            child: Text('Artist'),
                          ), DropdownMenuItem(
                            value: 'Lawyer',
                            child: Text('Lawyer'),
                          ), DropdownMenuItem(
                            value: 'Entrepreneur',
                            child: Text('Entrepreneur'),
                          ), DropdownMenuItem(
                            value: 'Software Developer',
                            child: Text('Software Developer'),
                          ), DropdownMenuItem(
                            value: 'Architect',
                            child: Text('Architect'),
                          ), DropdownMenuItem(
                            value: 'Chef',
                            child: Text('Chef'),
                          ),
                        ],
                        onChanged: (item) => controller.onSelectMood(item!),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Additional prompt (optional)"),
                      TextFormField(
                        controller: controller.extra,
                        decoration: const InputDecoration(
                          hintText: "Ex.caption in Hindi language and minimum 20 words ",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () => controller.imageFile.value != null ? controller.geminiCall() : () {},
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue,),
                          child: Text(
                            "Generate Caption".toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          )).toProgressIndicator(isLoading: controller.loader),
                      const SizedBox(height: 10,),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.captionList.length,
                        itemBuilder: (context, index) {
                          return Card(
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            "Caption",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        TextButton.icon(
                                          icon: const Icon(Icons.copy),
                                          label: const Text(''),
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(text: '${controller.captionList[index].title!}.\n${controller.captionList[index].caption}'));
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Text copied to clipboard'),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text('${controller.captionList[index].title!}.\n${controller.captionList[index].caption}'),
                                    const Divider(
                                      thickness: 1,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Relevant tags",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextButton.icon(
                                          icon: const Icon(Icons.copy),
                                          label: const Text(''),
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                              text: controller.captionList[index].hashtags!.join(' '),
                                            ));
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Text copied to clipboard'),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      controller.captionList[index].hashtags!.join(' ').trim(),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                      const SizedBox(height: 10,),
                      Visibility(
                        visible: controller.captionList.isNotEmpty,
                        child: ElevatedButton(
                            onPressed: () => controller.imageFile.value != null ? controller.reGenCaption() : () {},
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            child: Text(
                              "load more caption".toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            )).toProgressIndicator(isLoading: controller.otherLoader),
                      ),
                      const SizedBox(height: 40,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
