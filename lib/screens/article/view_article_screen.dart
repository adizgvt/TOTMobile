import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/getwidget.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:training/helper_functions.dart';
import 'package:training/models/article.dart';
import 'package:training/providers/article_provider.dart';

import '../../constants.dart';

class ViewArticleScreen extends StatefulWidget {
  const ViewArticleScreen({super.key, required this.title, required  this.articleId});
  final String title;
  final int articleId;

  @override
  State<ViewArticleScreen> createState() => _ViewArticleScreenState();
}

class _ViewArticleScreenState extends State<ViewArticleScreen> {
  QuillEditorController controller = QuillEditorController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GFColors.WHITE,
        appBar: appBarTemplate(title: widget.title),
        //backgroundColor: Colors.yellow,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: FutureBuilder(
                future: Provider.of<ArticleProvider>(context, listen: false).getArticle(articleId: widget.articleId), // a previously-obtained Future<String> or null
                builder: (BuildContext context, AsyncSnapshot snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return apiCallLoadingTemplate(context: context);
                  }

                  else if (snapshot.hasError) {
                    return apiCallErrorTemplate(context: context, errorMessage: snapshot.error.toString(), onRefresh: () => setState(() {}));
                  }

                  Article? article = snapshot.data;

                  if (article == null) {
                    return apiCallNoDataTemplate(context: context, onRefresh: () => setState(() {}));
                  }

                  else {}
                    return ListView(
                      children: [
                        //Image.network(baseDomain + (article.thumbnail ?? ''), fit: BoxFit.fitWidth, height: 150,),
                        SizedBox(
                            //color: Colors.yellow,
                            width: MediaQuery.of(context).size.width,
                            child: Text(article.about, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500), textAlign: TextAlign.center,)
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person, size: 18,),
                                Text(': ${article.penulis}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w200),),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.date_range, size: 18,),
                                Text(': ${article.tarikhPublish.toString().substring(0,10)}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200),),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        const Wrap(
                          spacing: 10,
                          children: [
                            Icon(FontAwesomeIcons.facebook, color: GFColors.PRIMARY),
                            Icon(FontAwesomeIcons.instagram, color: GFColors.DANGER),
                            Icon(FontAwesomeIcons.twitter, color: GFColors.PRIMARY)
                          ],
                        ),
                        const SizedBox(height: 10,),
                        QuillHtmlEditor(
                          padding: const EdgeInsets.all(10),
                          //backgroundColor: Colors.black12,
                          isEnabled: false,
                          textStyle: const TextStyle(fontSize: 12),
                          text: HtmlUnescape().convert(article.content),
                          controller: controller,
                          minHeight: 50,
                        )
                      ],
                    );
                  },
              )),
        ));
  }
}
