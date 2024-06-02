


 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realstate/Core/widgets/Custom_Text.dart';
import 'package:realstate/core/resources/app_colors.dart';
import 'package:realstate/core/widgets/custom_app_bar.dart';
import 'package:realstate/models/building_model.dart';

class AllBuildingsCatView extends StatelessWidget {
  RxList<Building>data;
   AllBuildingsCatView({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar('جميع العقارات', context, false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          const SizedBox(height: 11,),
          allBuildingsWidget()
        ],),
      ),
    );
  }
  Widget allBuildingsWidget(){
    return ListView.builder(
      
      shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context,index){
      return Container(
        height: 176,
        margin:const EdgeInsets.only(bottom: 20),
        clipBehavior: Clip.antiAlias ,
        decoration: BoxDecoration(
          color:Colors.grey[200],
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Image.network(data[index].image.toString(),fit: BoxFit.cover,),
          ),
          const SizedBox(height: 10,),
          Custom_Text(text: data[index].name.toString()),
          const SizedBox(height: 10,),
          Custom_Text(text: '${data[index].price!} د.ك ',color: AppColors.greenColor,),
          const SizedBox(height: 10,),
        ],),
      );
    });
  }
}
