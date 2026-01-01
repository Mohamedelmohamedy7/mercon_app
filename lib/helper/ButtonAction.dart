import 'package:core_project/View/Screen/DropDownWidgets.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Utill/Comman.dart';
import '../Utill/LoaderWidget/loader_widget.dart';
import 'EnumLoading.dart';

class widgetWithAction {


  static Consumer buttonAction<T>({required Function? action(T model),required BuildContext context,required String text,double? fontSize}) => Consumer<T>(
      builder: (context, T model, _) => GestureDetector(
        onTap: ()async {
         await action(model);
        },
        child: p_Listener<T>(context)!.status == LoadingStatus.LOADING
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: const LoaderWidget()),
                ],
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: w(context),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).primaryColor,
                  boxShadow: const [
                    BoxShadow(
                      color: lightGray,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 4.0, // Specify the blur radius
                    ),
                  ],
                ),
                child: Center(
                    child: Text(
                  "$text".tr(),
                  style: CustomTextStyle.semiBold12Black.copyWith(    color: Color(0xffCCB6A1),fontSize: fontSize),
                )),
              ),
      ),
    );
}
