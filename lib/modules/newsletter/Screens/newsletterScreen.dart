import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/modules/companies/Widget/companies_card_shimmer.dart';
import 'package:happiness_club/modules/newsletter/Controller/newsletter_controller.dart';
import 'package:happiness_club/modules/newsletter/Model/newsletter_model.dart';
import 'package:happiness_club/modules/newsletter/widgets/newsCard.dart';
import 'package:happiness_club/modules/newsletter/widgets/newsletter_shimmer.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/customAppBar.dart';

class NewsletterScreen extends StatefulWidget {
  const NewsletterScreen({Key? key}) : super(key: key);

  @override
  _NewsletterScreenState createState() => _NewsletterScreenState();
}

class _NewsletterScreenState extends State<NewsletterScreen> {

  StreamController<NewsletterModel?>? newsStream;
  loadData(){
    getNewsLetters(context).then((value) {
      if(value!=null){
        newsStream!.add(value);
        return value;
      }
      else{
        newsStream!.add(null);
        return null;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsStream = StreamController<NewsletterModel?>();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              CustomAppBar(title: LocaleKeys.newsletter.tr()),
              Expanded(
                  child:StreamBuilder<NewsletterModel?>(
                    stream: newsStream!.stream,
                    builder: (context,snapshot){
                       if(!snapshot.hasData || snapshot.hasError || snapshot.connectionState == ConnectionState.waiting){
                         return GridView.count(
                             shrinkWrap: true,
                             childAspectRatio: 1.2,
                             crossAxisCount: 2,
                             crossAxisSpacing: 15,
                             mainAxisSpacing: 15,
                             children:List.generate(4, (index) =>CompaniesCardShimmer())
                         );
                       }
                       if(snapshot.data == null){
                         return Center(
                           child: Text(LocaleKeys.no_newsletter_found.tr()),
                         );
                       }
                      return
                        GridView.count(
                          padding: EdgeInsets.symmetric(vertical: 10),
                            crossAxisCount: 2,
                          childAspectRatio: 1.2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          children: List.generate(snapshot.data!.data!.length, (i) => NewsCard(modelData: snapshot.data!.data![i]!)),
                        );
                        // ListView.separated(
                        //   itemBuilder: (context, i) {
                        //     return NewsCard(modelData: snapshot.data!.data![i]!);
                        //   },
                        //   separatorBuilder: (context, i) => SizedBox(
                        //     height: 12,
                        //   ),
                        //   itemCount: snapshot.data!.data!.length);
                    },
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
