import 'dart:async';

import 'package:flutter/material.dart';
import 'package:happiness_club/modules/newsletter/Controller/newsletter_controller.dart';
import 'package:happiness_club/modules/newsletter/Model/newsletter_model.dart';
import 'package:happiness_club/modules/newsletter/widgets/newsCard.dart';
import 'package:happiness_club/modules/newsletter/widgets/newsletter_shimmer.dart';
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
              CustomAppBar(title: "Newsletters"),
              Expanded(
                  child:StreamBuilder<NewsletterModel?>(
                    stream: newsStream!.stream,
                    builder: (context,snapshot){
                       if(!snapshot.hasData || snapshot.hasError || snapshot.connectionState == ConnectionState.waiting){
                         return ListView(
                           children: [
                             NewsletterShimmer(),
                             SizedBox(height: 12,),
                             NewsletterShimmer(),
                             SizedBox(height: 12,),
                             NewsletterShimmer(),
                             SizedBox(height: 12,),
                             NewsletterShimmer(),
                           ],
                         );
                       }
                       if(snapshot.data == null){
                         return Center(
                           child: Text("No Newsletters are found"),
                         );
                       }
                      return  ListView.separated(
                          itemBuilder: (context, i) {
                            return NewsCard(modelData: snapshot.data!.data![i]!);
                          },
                          separatorBuilder: (context, i) => SizedBox(
                            height: 12,
                          ),
                          itemCount: snapshot.data!.data!.length);
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
