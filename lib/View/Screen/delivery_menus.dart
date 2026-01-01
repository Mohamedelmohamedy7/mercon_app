import 'package:core_project/Model/HomeComponantModel/DeliveryModel.dart';
import 'package:core_project/Provider/DeliveryProvider.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_zoom/widget_zoom.dart';
import '../../../helper/ImagesConstant.dart';

class DeliveryMenusScreen extends StatefulWidget {
  DeliveryMenusScreen({Key? key, required this.deliveryData}) : super(key: key);

  final DeliveryData deliveryData;
  @override
  State<DeliveryMenusScreen> createState() => _DeliveryMenusScreenState();
}

class _DeliveryMenusScreenState extends State<DeliveryMenusScreen> {
  @override
  initState() {
    Provider.of<DeliveryProvider>(context, listen: false)
        .getDeliveryMenusDataFunction(context, id: widget.deliveryData.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'deliveryServices'.tr(),
          needBack: true,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Container(
          //color: BACKGROUNDCOLOR,
          height: MediaQuery.of(context).size.height,
          child: Consumer<DeliveryProvider>(
            builder: (context, model, _) {
              if (model.status == LoadingStatus.LOADING) {
                return shimmerList();
                ;
              } else {
                return Container(
                  //color: BACKGROUNDCOLOR,
                  height: MediaQuery.of(context).size.height,
                  width:  MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [

                        if(model.deliveryMenuData.isEmpty)
                          Container(
                            height: MediaQuery.of(context).size.height,
                            width:  MediaQuery.of(context).size.width,
                            child: Center(child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                emptyList(),
                              ],
                            )),
                          )
                    else    ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => WidgetZoom(
                                  heroAnimationTag: index.toString(),
                                  zoomWidget: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: cachedImage(
                                          "${model.deliveryMenuData[index].menuIamge}"),
                                    ),
                                  ),
                                ),
                            separatorBuilder: (context, index) => SizedBox(),
                            itemCount: model.deliveryMenuData.length),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
