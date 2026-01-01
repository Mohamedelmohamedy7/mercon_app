import 'package:core_project/Provider/UnitsProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../helper/ImagesConstant.dart';
import '../../Widget/comman/CustomAppBar.dart';
import '../../Widget/comman/comman_Image.dart';
import '../add_new_unit.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  UnitsProvider ? unitsProvider;
  @override
  void initState() {
    super.initState();
    unitsProvider = Provider.of<UnitsProvider>(context, listen: false);
    unitsProvider!.getMyUnitNumber(context);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'personAccount'.tr(),
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Container(
          //color: BACKGROUNDCOLOR,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                10.height,
                globalAccountData.getProfilePic() == null || globalAccountData.getProfilePic() == ""
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Image.asset(
                          "assets/images/person.png",
                          width: 150,
                          height: 100,
                          color: Colors.black.withOpacity(0.4),
                        ))
                    : Container(
                        width: 110,
                        height: 110,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: cachedImage(
                            "${  globalAccountData.getProfilePic()}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                Align(alignment: Alignment.center,child: Text("${globalAccountData.getUsername()}",style: CustomTextStyle.bold14black,)),
                Align(alignment: Alignment.center,child:
                Text("${globalAccountData.getEmail()}",style: CustomTextStyle.medium14Gray,)),
                Align(alignment: Alignment.center,child:
                Text("${globalAccountData.getPhoneNumber()}",style: CustomTextStyle.medium14Gray,)),
                20.height,
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("your_units".tr().toString() +" :",style: CustomTextStyle.bold14black
                      .copyWith(fontSize: 13,fontWeight: FontWeight.w600),),
                  ),
                ),
                Provider.of<UnitsProvider>(context).modelUnitServiceListAndContainPending.length == 0 ?
                    Padding(padding: EdgeInsets.only(top: 60),child: emptyList()):
                Provider.of<UnitsProvider>(context).modelUnitServiceListAndContainPending.length == 1 ?
                 Container(
                   padding: EdgeInsets.symmetric(horizontal: 11,vertical: 20),
                   margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                   width: MediaQuery.of(context).size.height * 0.8,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child:Column(
                     children: [
                       Row(
                         children: [
                           Icon(Icons.account_balance,color: Theme.of(context).primaryColor,size: 20,),
                           SizedBox(width:5,),
                           Text("model".tr(),style: CustomTextStyle.bold14black.copyWith(fontSize: 10),),
                           Text(" : "),
                           Text("${Provider.of<UnitsProvider>(context).modelUnitServiceListAndContainPending[0].modelName}",style: CustomTextStyle.bold14black.copyWith(fontSize: 10),),
                           Spacer(),
                           Icon(Icons.home_outlined,color: Theme.of(context).primaryColor,size: 20,),
                           SizedBox(width:5,),
                           Text("builds".tr(),style: CustomTextStyle.bold14black.copyWith(fontSize: 10),),
                           Text(" : "),
                           Text("${Provider.of<UnitsProvider>(context).modelUnitServiceListAndContainPending[0].buildingName}",style: CustomTextStyle.bold14black.copyWith(fontSize: 10),),
                           SizedBox(width:50,),
                         ],
                       ),
                       SizedBox(height: 20,),
                       Row(
                         children: [
                           Icon(Icons.add_business_outlined,color: Theme.of(context).primaryColor,size: 20,),
                           SizedBox(width:5,),
                           Text("levels".tr(),style: CustomTextStyle.bold14black.copyWith(fontSize: 10),),
                           Text(" : "),
                           Text("${Provider.of<UnitsProvider>(context).modelUnitServiceListAndContainPending[0].levelName}",style: CustomTextStyle.bold14black.copyWith(fontSize: 10),),
            
                           Spacer(),
                           Icon(Icons.ad_units,color: Theme.of(context).primaryColor,size: 20,),
                           Text("units".tr(),style: CustomTextStyle.bold14black.copyWith(fontSize: 10),),
                           Text(" : "),
                           Text("${Provider.of<UnitsProvider>(context).modelUnitServiceListAndContainPending[0].unitNumber}",style: CustomTextStyle.bold14black.copyWith(fontSize: 10),),
                           SizedBox(width:20,),
                         ]
                       )
                     ]
                   ) ,
                 )
                :
                DataTable(
                  showCheckboxColumn: true,
                  showBottomBorder: true,
                  headingRowHeight: 40,
                  columnSpacing: 30,
                  border: TableBorder.all(color: grey.withOpacity(0.4), width: 0.5, style: BorderStyle.solid),
                  headingRowColor: MaterialStateColor.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.white; // Color when selected
                    }
                    return Theme.of(context).primaryColor ; // Default color
                  }),
                  dividerThickness: 1,
                  dataTextStyle: CustomTextStyle.regular14Black,
                  headingTextStyle: CustomTextStyle.bold14black.copyWith(
                    color: Colors.white,fontWeight: FontWeight.w500,
                  ),
                  columns: [
                    DataColumn(label: Expanded(child: Center(child: Text('model'.tr())))),
                    DataColumn(label: Expanded(child: Center(child: Text('builds'.tr())))),
                    DataColumn(label: Expanded(child: Center(child: Text('levels'.tr())))),
                    DataColumn(label: Expanded(child: Center(child: Text('units'.tr())))),
                    DataColumn(label: Expanded(child: Center(child: Text('case'.tr())))),
                  ],
                   rows:Provider.of<UnitsProvider>(context).modelUnitServiceListAndContainPending.map((e) => DataRow(cells: [
                    DataCell(Center(child: Text('${e.modelName}'))),
                    DataCell(Center(child: Text('${e.buildingName}'))),
                    DataCell(Center(child: Text('${e.levelName}'))),
                    DataCell(Center(child: Text('${e.unitNumber}',style: CustomTextStyle.medium10Black.copyWith(fontSize: 12),))),
                    DataCell(Center(child: Text('${e.statusName=="Active"?'✅':'❌'}',style: CustomTextStyle.bold18black,))),
                  ])).toList()
            
                ),
                20.height,

              ],
            ),
          ),
        ),
      bottomNavigationBar:     Container(
        height: 70, //color: BACKGROUNDCOLOR,
        padding: EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          onTap: (){
            pushRoute(context: context, route: AddNewUnit());
          },
          child: Align(
            alignment: AlignmentDirectional.topEnd,
            child: Container(
              height: 55,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add,size: 18,color: Colors.white,),
                    5.width,
                    Text("add_new_unit".tr(),style: CustomTextStyle.bold14White.copyWith(
                        fontWeight: FontWeight.w600,fontSize: 12
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}
