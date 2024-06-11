import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:training/helper_functions.dart';
import 'package:training/models/image_data.dart';
import 'package:training/providers/article_provider.dart';
import 'package:training/services/gallery_services.dart';

class CreateArticleScreen extends StatefulWidget {
  const CreateArticleScreen({super.key});

  @override
  State<CreateArticleScreen> createState() => _CreateArticleScreenState();
}

class _CreateArticleScreenState extends State<CreateArticleScreen> {
  QuillEditorController controller = QuillEditorController();
  final _formKey = GlobalKey<FormBuilderState>();
  bool loadingCreateArticleScreen = true;
  bool hasError = false;
  String error = '';
  List<dynamic> categories = [];
  PickedImage? thumbnail;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    try{
      loadingCreateArticleScreen = true;
      hasError = false;
      setState(() {});
      categories = await Provider.of<ArticleProvider>(context,listen: false).createArticle();
    }
    catch(e){
      print('e is $e');
      error = e.toString();
      hasError = true;
    }
    finally{
      loadingCreateArticleScreen = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    GlobalKey thumbnailKey = GlobalKey();

    return Scaffold(
        appBar: appBarTemplate(title: 'New Article'),
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          bottom: false,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: loadingCreateArticleScreen ? apiCallLoadingTemplate(context: context) :
                     hasError ? apiCallErrorTemplate(context: context, errorMessage: error, onRefresh: () => loadData()) :
              FormBuilder(
                key: _formKey,
                child: ListView(
                  controller: scrollController,
                  children: [
                    const SizedBox(height: 10,),
                    const Text('Thumbnail', style: TextStyle(fontWeight: FontWeight.bold),),
                    thumbnail == null ?
                    Container(
                      key: thumbnailKey,
                      child: Column(
                        children: [
                          InkWell(
                              child: const Icon(FontAwesomeIcons.image, size: 100,),
                              onTap: () async {
                                thumbnail = await GalleryService.getPicture() ?? thumbnail;
                                setState(() {});
                              },
                          ),
                          const Text('No Thumbnail picture selected', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),)
                        ],
                      ),
                    )
                    : InkWell(
                      onTap: () async {
                        thumbnail = await GalleryService.getPicture() ?? thumbnail;
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          GFCard(
                              elevation: 0,
                              content: Image.memory(
                                base64Decode(thumbnail!.base64EncodedString),
                                height: 200,
                                gaplessPlayback: true,
                              )
                          ),
                          const Text('Click to change picture', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text('Tajuk', style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    FormBuilderTextField(
                      onChanged: (val) => _formKey.currentState!.fields['tajuk']!.validate(),
                      name: 'tajuk',
                      decoration: inputDecorationTemplate(),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 10,),
                    const Text('Tarikh Publish', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10,),
                    FormBuilderDateTimePicker(
                      //enableInteractiveSelection: false,
                      //onEditingComplete: () => _formKey.currentState!.fields['tarikh_publish']?.validate(),
                      onChanged: (val) {
                        if (val == null) return;
                        _formKey.currentState!.fields['tarikh_publish']?.validate();
                      },
                      name: 'tarikh_publish',
                      inputType: InputType.date,
                      decoration: inputDecorationTemplate(),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 10,),
                    const Text('Penulis', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10,),
                    FormBuilderTextField(
                      onChanged: (val) => _formKey.currentState!.fields['penulis']!.validate(),
                      name: 'penulis',
                      decoration: inputDecorationTemplate(),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 10,),
                    const Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10,),
                    FormBuilderDropdown(
                      name: 'kategori',
                      onChanged: (val) => _formKey.currentState!.fields['kategori']!.validate(),
                      decoration: inputDecorationTemplate(),
                      items: categories.map((e) => DropdownMenuItem(value: e,child: Text(e, style: const TextStyle(fontSize: 16),),)).toList(),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required()
                      ]),
                    ),
                    const SizedBox(height: 10,),
                    const Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10,),
                    FormBuilderTextField(
                      minLines: 2,
                      maxLines: 3,
                      onChanged: (val) => _formKey.currentState!.fields['about']!.validate(),
                      name: 'about',
                      keyboardType: TextInputType.text,
                      decoration: inputDecorationTemplate(),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(10, errorText: CustomErrorText.minLength(10)),
                        FormBuilderValidators.maxLength(20, errorText: CustomErrorText.maxLength(20))
                      ]),
                    ),
                    const SizedBox(height: 10,),
                    const Text('Content', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10,),

                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: Column(
                        children: [
                          ToolBar(controller: controller, toolBarColor: Colors.black54, iconColor: Colors.white70),
                          QuillHtmlEditor(
                              padding: const EdgeInsets.all(5),
                              hintText: '',
                              textStyle: const TextStyle(fontSize: 16),
                              controller: controller,
                              minHeight: 200
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),
                    GFButton(
                      text: 'SUBMIT',
                      onPressed: () async {

                        if(thumbnail == null && mounted){
                          ScaffoldMessenger.of(context).
                          showSnackBar(SnackBar(content: Text(CustomErrorText.requiredThumbnail()),));
                          scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                          return;
                        }

                        if(!_formKey.currentState!.saveAndValidate(autoScrollWhenFocusOnInvalid: true, focusOnInvalid: true)){
                          print(_formKey.currentState?.value);
                          return;
                        }

                        print(_formKey.currentState?.value);
                        String content = await controller.getText();
                        print(content);

                        if(content == '' && mounted){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(CustomErrorText.requiredContent()),));
                          return;
                        }

                        Map<String,dynamic> formData = Map.from(_formKey.currentState!.value);
                        print('content is + $content');
                        formData['content'] = content;
                        formData['thumbnail'] = thumbnail!.base64EncodedString;
                        formData['tarikh_publish'] = _formKey.currentState!.fields['tarikh_publish']?.value.toString();

                        if(mounted){
                          print('asd');
                          Provider.of<ArticleProvider>(context, listen: false).storeArticle(
                              context: context,
                              formData: formData,
                              formKey: _formKey,
                              scrollController: scrollController
                          ).
                          then((value) {/*if(value == true) Navigator.pop(context);*/});
                        }

                      },
                    ),
                    const SizedBox(height: 50,),
                  ],
                ),
              )
          ),
        ));
  }
}
