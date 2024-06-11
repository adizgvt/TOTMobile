import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:training/helper_functions.dart';
import 'package:training/models/article.dart';
import 'package:training/providers/article_provider.dart';
import 'package:training/screens/article/create_article_screen.dart';
import 'package:training/screens/article/view_article_screen.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  QuillEditorController controller = QuillEditorController();

  late var x;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //x = Provider.of<ArticleProvider>(context, listen: false).getArticleList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
          appBar: GFAppBar(
            backgroundColor: GFColors.DARK,
            brightness: Brightness.dark,
            title: const Text('Senarai artikel'),
            centerTitle: true,
            actions: [
              InkWell(
                  child: const Icon(Icons.add),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateArticleScreen())).then((value) => setState((){})),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          //backgroundColor: Colors.yellow,
          body: RefreshIndicator(
            onRefresh: () async{
              setState(() {});
            },
            child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: FutureBuilder(
                    future: Provider.of<ArticleProvider>(context, listen: false).getArticleList(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {

                      print('connection state is ${snapshot.connectionState}');

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return apiCallLoadingTemplate(context: context);
                      }

                      else if (snapshot.hasError) {
                        return apiCallErrorTemplate(context: context, errorMessage: snapshot.error.toString(), onRefresh: () => setState(() {}));
                      }

                      List<Article> articles = snapshot.data;

                      if (articles.isEmpty) {
                        return apiCallNoDataTemplate(context: context, onRefresh: () => setState(() {}));
                      }

                      else {
                        return ListView.builder(
                            itemCount: articles.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GFCard(
                                showImage: articles[index].thumbnail==null ? false : true,
                                image: Image.network(baseDomain + (articles[index].thumbnail ?? ''), fit: BoxFit.fitWidth,),
                                elevation: 0,
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        articles[index].tajuk.toUpperCase(),
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        /*Row(
                                            children: [
                                              const Icon(Icons.person, size: 18,),
                                              Text(': ${articles[index].penulis}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w200),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.date_range, size: 18,),
                                              Text(': ${articles[index].tarikhPublish.toString().substring(0,10)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w200),),
                                            ],
                                          )*/
                                        Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.person, size: 18,),
                                                Flexible(child: Text(': ${articles[index].penulis}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w200), overflow: TextOverflow.ellipsis,)),
                                              ],
                                            )
                                        ),
                                        Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                const Icon(Icons.date_range, size: 18,),
                                                Flexible(child: Text(': ${articles[index].tarikhPublish.toString().substring(0,10)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w200),)),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        articles[index].about,
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300, color: Colors.black87),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          child: const Icon(Icons.delete, color: GFColors.DANGER,),
                                          onTap: () async {

                                            bool action = await showWarningDialogTemplate(
                                                context: context,
                                                message: 'Adakah anda pasti untuk padam artikel ini?'
                                            );

                                            if(action == false) return;

                                            if(mounted){
                                              context.loaderOverlay.show();
                                              bool result = await Provider.of<ArticleProvider>(context, listen: false).deleteArticle(context: context, articleId: articles[index].id);
                                              context.loaderOverlay.hide();
                                              setState(() {});
                                            }


                                          },
                                        ),
                                        const SizedBox(width: 20,),
                                        InkWell(
                                          child: const Icon(Icons.edit, color: GFColors.WARNING,),
                                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ViewArticleScreen(
                                              title: articles[index].tajuk, articleId: articles[index].id))
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                        InkWell(
                                          child: const Icon(Icons.info, color: GFColors.PRIMARY,),
                                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ViewArticleScreen(
                                              title: articles[index].tajuk, articleId: articles[index].id))
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                //showAccordion: true,
                              );
                            });
                      }
                    },
                  )),
            ),
          )),
    );
  }
}
