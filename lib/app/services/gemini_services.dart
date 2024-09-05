import 'dart:io';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class GenerativeModelService extends GetxService {
  final GenerativeModel model;

  GenerativeModelService({required String model, required String apiKey})
      : model = GenerativeModel(
            model: model,
            apiKey: apiKey,
            generationConfig: GenerationConfig(responseMimeType: 'application/json', responseSchema: Schema.object(properties: {'title': Schema.string(description: "img title"), 'caption': Schema.string(description: "img caption data"), 'hashtags': Schema.array(items: Schema.string(description: "all item"))})));

  Future<String?> genTextWithImg(String sApp, String role,String? extra ,XFile? image) async {
    try {
      if (image == null) {
        throw Exception('Image is null');
      }

      final bytes = await image.readAsBytes();
      final pathSegments = image.path.split('.');
      String? imageExtension = 'image/${pathSegments.last.toLowerCase()}';
      if(GetPlatform.isWeb){
        imageExtension = image.mimeType;
      }
      // String extraPrompt = extra == ""?"":"and addition information for about image or user requirement is $extra";
      List<Content> prompt = extra == ""? [
        Content.text('''
        As a master in social media influencer, marketing and SEO expert,
        your task is to optimize a social media post for maximum engagement on "$sApp App".
        the user has provided the Role for this post as "$role" and would like to see more likes, comments, and indirections.
        please generate the following:
        - A catchy title for the $sApp post.
        - A caption that is engaging and resonates with the user's "$role Role".
        - read all detail from the image create a Hashtags.
        - A extra relevant hashtags for the post. 
        Please ensure the title is catchy, the caption and Hashtags are appropriate for the $role Role, and the extra hashtags are relevant and optimized for engagement.
        your response like json {title: "image related title" , caption: "caption detail and top 5 hashtags", hashtags:[extra tag1, extra tag2..]}
   
        '''),
        Content.data(imageExtension!, bytes)
      ]: [
        Content.text('''
        Here user give you extra detail bout prompt, this detail is '$extra', so focused on the detail then write a answer.
        As a master in social media influencer as $role, you are expert in this $role ,
        your task is to optimize a social media post for maximum engagement on "$sApp App".
        the user has provided the Role for this post as "$role" and would like to see more likes, comments, and indirections.
        please generate the following:
        - Make sure check this detail '$extra' and analysis around this detail after that give below points response.
        - A catchy title for the $sApp post.
        - A caption that is engaging and resonates with the user's "$role Role".
        - read all detail from the image create a Hashtags.
        - A extra relevant hashtags for the post. 
        Please ensure the title is catchy, the caption and Hashtags are appropriate for the $role Role, and the extra hashtags are relevant and optimized for engagement.
        your response like json {title: "image related title" , caption: "caption detail and top 5 hashtags", hashtags:[extra tag1, extra tag2..]}
        '''),
        Content.data(imageExtension!, bytes)
      ];
      final response = await model.generateContent(prompt);
      return response.text;
    } on FileSystemException catch (e) {
      throw Exception('Error reading file: $e');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String?> generateText(String prompt) async {
    try {
      final content1 = [Content.text(prompt)];
      final GenerateContentResponse response = await model.generateContent(content1);
      return response.text!;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
