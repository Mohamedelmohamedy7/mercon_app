import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/date_converter.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../Provider/UnitsProvider.dart';
import '../../helper/ImagesConstant.dart';
import '../../helper/color_resources.dart';
import '../Widget/MyOrdersWidget/ListOrders.dart';
import '../Widget/comman/CustomAppBar.dart';
import 'Services/ServicesCategories.dart';



class UnitsOwner extends StatefulWidget {
  const UnitsOwner({Key? key}) : super(key: key);

  @override
  _UnitsOwnerState createState() => _UnitsOwnerState();
}

class _UnitsOwnerState extends State<UnitsOwner> {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UnitsProvider>(context,listen:false).getAllUnitsPayment(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Ownedunits'.tr(),
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          //color: BACKGROUNDCOLOR,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            child: Consumer<UnitsProvider>(
              builder:(context,model,_) {
                if(model.status==LoadingStatus.LOADING){
                  return ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 40),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: lightGrey.withOpacity(0.2)
                          ),
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              10.height,
                              buildShimmer1(context),
                              10.height,
                              Table(
                                border: TableBorder.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                children: [
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: buildShimmer1(context),
                                      ),
                                      TableCell(
                                        child:  buildShimmer1(context),
                                      ),
                                      TableCell(
                                        child:  buildShimmer1(context),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Center(
                                          child:  buildShimmer1(context),
                                        ),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child:  buildShimmer1(context),
                                        ),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child:  buildShimmer1(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Center(
                                          child:  buildShimmer1(context),
                                        ),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child:  buildShimmer1(context),
                                        ),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child:  buildShimmer1(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Center(
                                          child:  buildShimmer1(context),
                                        ),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child:  buildShimmer1(context),
                                        ),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: buildShimmer1(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => 0.height,
                      itemCount: 10);
                }else {
                  return model.ownersPayment==null||model.ownersPayment.isEmpty? emptyList() :
                  model.ownersPayment.first.ownerPayments.isEmpty ? emptyList() :
                  ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 0),
                      itemBuilder: (context, index) {
                        return  model.ownersPayment[index].ownerPayments.isEmpty? SizedBox.shrink(): Container(
                          decoration: BoxDecoration(
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              10.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color:Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${(model.ownersPayment[index].unitName)?.replaceAll("-", " : ")}',
                                          style: CustomTextStyle.bold14black.copyWith(
                                            color:Theme.of(context).primaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              5.height,
                              Table(
                                border: TableBorder.all(
                                  color: Colors.black,
                                  width: 1,
                                ),

                                children: [
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "السنة",
                                              style: CustomTextStyle.regular14Black.copyWith(
                                                  color: Colors.white,fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "حالة الدفع",
                                              style: CustomTextStyle.regular14Black.copyWith(
                                                  color: Colors.white,fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              'القيمة',
                                              style: CustomTextStyle.regular14Black.copyWith(
                                                  color: Colors.white,fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  for (var payment in model.ownersPayment[index].ownerPayments)...[
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5),
                                              child: Text(
                                                DateConverter.isoStringToLocalDateOnly(payment.createdDate.toString()),
                                                style: CustomTextStyle.medium14LightBlack,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5),
                                              child: Text(
                                                payment.isPaid.toString()=="true"?"paid".tr():"unpaid".tr(),
                                                style: CustomTextStyle.regular14Black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5),
                                              child: Text(
                                                payment.value.toString() + "EGP".tr(),
                                                style: CustomTextStyle.regular14Black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  ]

                                ],
                              ),
                              10.height,
                              Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("totalPaid".tr(),style: CustomTextStyle.regular14Black.copyWith(
                                          fontSize: 12,
                                        ),),
                                        Text(" : ",style: CustomTextStyle.regular14Black.copyWith(fontSize: 12,)),
                                        SizedBox(width: 30,),
                                        Text(model.ownersPayment[index].paidDone.toString() + " " + "EGP".tr(),
                                          style: CustomTextStyle.regular14Black,textAlign: TextAlign.start,),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Text("totalUnpaid".tr(),style: CustomTextStyle.regular14Black.copyWith(
                                          fontSize: 12,
                                        ),),
                                        Text(" : ",style: CustomTextStyle.regular14Black.copyWith(fontSize: 12,)),
                                        SizedBox(width: 17,),
                                        Text(model.ownersPayment[index].notPaid.toString() + " " + "EGP".tr(),style: CustomTextStyle.regular14Black,
                                          textAlign: TextAlign.start,),
                                      ],
                                    ),

                                  ]
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => 0.height,
                      itemCount: model.ownersPayment.length);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

