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
import 'package:training/models/user_model.dart';
import 'package:training/providers/article_provider.dart';
import 'package:training/screens/home_screen.dart';
import 'package:training/services/gallery_services.dart';

import '../providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  QuillEditorController controller = QuillEditorController();
  final _formKey = GlobalKey<FormBuilderState>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          children: [
            //frostedBackground(),
            SafeArea(
              bottom: false,
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: FormBuilder(
                    key: _formKey,
                    child: ListView(
                      controller: scrollController,
                      children: [
                        const SizedBox(height: 100,),
                        Image.network('https://cdn-icons-png.flaticon.com/512/2944/2944349.png', height: 150,),
                        const SizedBox(height: 20,),
                        const Text('Emel', style: TextStyle(fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        FormBuilderTextField(
                          onChanged: (val) => _formKey.currentState!.fields['emel']!.validate(),
                          name: 'emel',
                          decoration: inputDecorationTemplate(hintText: 'Sila isikan emel'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                        ),
                        const SizedBox(height: 10,),
                        const Text('Kata laluan', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10,),
                        FormBuilderTextField(
                          obscureText: true,
                          onChanged: (val) => _formKey.currentState!.fields['password']!.validate(),
                          name: 'password',
                          decoration: inputDecorationTemplate(hintText: 'Sila isikan kata laluan'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                        ),
                        const SizedBox(height: 50,),
                        GFButton(
                          text: 'LOG MASUK',
                          onPressed: () async {

                            if(!_formKey.currentState!.saveAndValidate(autoScrollWhenFocusOnInvalid: true)){
                              print(_formKey.currentState?.value);
                              return;
                            }

                            print(_formKey.currentState?.value);


                            Map<String,dynamic> formData = Map.from(_formKey.currentState!.value);

                            if(mounted){
                              print('asd');
                              Provider.of<UserProvider>(context, listen: false).login(
                                  context: context,
                                  formData: formData,
                              ).
                              then((value) {
                                if(value == true) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen(title: 'Senarai artikel')), (route) => false);
                                }
                              );
                            }

                          },
                        ),
                        const SizedBox(height: 50,),
                      ],
                    ),
                  )
              ),
            ),
          ],
        ));
  }
}
