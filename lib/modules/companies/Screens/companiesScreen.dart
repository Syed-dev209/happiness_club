import 'package:flutter/material.dart';
import 'package:happiness_club/modules/companies/Widget/companyCard.dart';
import 'package:happiness_club/widgets/customAppBar.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({ Key? key }) : super(key: key);

  @override
  _CompaniesScreenState createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height*0.98,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
          child: Column(
            children: [
              CustomAppBar(
          title: "HC Portfolio",
        ),
        SizedBox(height: 20,),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  childAspectRatio: 1.2,
                  crossAxisCount: 2,
                   crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children:List.generate(20, (index) =>CompanyCard())
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}