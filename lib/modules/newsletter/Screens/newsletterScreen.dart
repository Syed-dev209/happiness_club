import 'package:flutter/material.dart';
import 'package:happiness_club/modules/newsletter/widgets/newsCard.dart';
import 'package:happiness_club/widgets/customAppBar.dart';

class NewsletterScreen extends StatefulWidget {
  const NewsletterScreen({Key? key}) : super(key: key);

  @override
  _NewsletterScreenState createState() => _NewsletterScreenState();
}

class _NewsletterScreenState extends State<NewsletterScreen> {
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
                  child: ListView.separated(
                      itemBuilder: (context, i) {
                        return NewsCard();
                      },
                      separatorBuilder: (context, i) => SizedBox(
                            height: 12,
                          ),
                      itemCount: 10))
            ],
          ),
        ),
      ),
    );
  }
}
