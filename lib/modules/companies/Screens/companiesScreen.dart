import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/modules/companies/Controller/companies_controller.dart';
import 'package:happiness_club/modules/companies/Model/companies_model.dart';
import 'package:happiness_club/modules/companies/Widget/companies_card_shimmer.dart';
import 'package:happiness_club/modules/companies/Widget/companyCard.dart';
import 'package:happiness_club/translations/locale_keys.g.dart';
import 'package:happiness_club/widgets/customAppBar.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({ Key? key }) : super(key: key);

  @override
  _CompaniesScreenState createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {

  StreamController<CompaniesModel?>? companiesController;
  loadData()async{
    getAllCompanies(context).then((value) {
      if(value!=null){
        companiesController!.add(value);
        return value;
      }
      else{
        companiesController!.add(null);
        return null;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companiesController = StreamController<CompaniesModel?>();
    loadData();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    companiesController!.close();
  }
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
          title: LocaleKeys.hc_portfolio.tr(),
        ),
        SizedBox(height: 20,),
              Expanded(
                child: StreamBuilder<CompaniesModel?>(
                  stream: companiesController!.stream,
                  builder: (context,snapshot){
                    if(snapshot.hasError || !snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
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
                      return Text(LocaleKeys.no_companies_found.tr());
                    }
                    CompaniesModel model = snapshot.data!;
                    return GridView.count(
                        shrinkWrap: true,
                        childAspectRatio: 1.2,
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        children:List.generate(model.data!.length, (index) =>CompanyCard(modelData: model.data![index]!,))
                    );
                  },
                )


              ),
            ],
          ),
        ),
      ),
    );
  }
}