import 'package:core_project/Provider/SuperAdminProviders/ComplaintProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/ActionsScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/ComplaintScreens/ComplaintDetailsScreen.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Model/complaint_list_model.dart';
import '../../../Widget/SuperAdminWidgets/build_row.dart';

class ComplaintListScreen extends StatefulWidget {
  ComplaintListScreen({super.key, required this.needBack});
  final bool needBack;

  @override
  State<ComplaintListScreen> createState() => _ComplaintListScreenState();
}

class _ComplaintListScreenState extends State<ComplaintListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ComplaintProvider>(context, listen: false).notify = false;
    catchError(
        p_Listeneress<ComplaintProvider>(context).getComplaintList(context),
        'ComplaintProvider');
    Provider.of<ComplaintProvider>(context, listen: false).notify = true;
    Provider.of<ComplaintProvider>(context, listen: false).first = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "complaint".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Provider.of<ComplaintProvider>(context, listen: false).notify =
                true;
            Provider.of<ComplaintProvider>(context, listen: false)
                .getComplaintList(context);
          },
          child: Consumer<ComplaintProvider>(builder: (context, model, _) {
            return Column(
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                model.status == LoadingStatus.LOADING
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 200.0),
                            child: Center(
                              child: Loading(),
                            ),
                          ),
                        ),
                      )
                    : model.complaintList.isEmpty && model.first
                        ? Expanded(
                            child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 100.0),
                                  child: Center(child: emptyList()),
                                )))
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                //   shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    buildCompliantCard(
                                  model.complaintList[index],
                                  model: model,
                                ),
                                itemCount: model.complaintList.length,
                              ),
                            ),
                          ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget buildCompliantCard(ComplaintModel user,
      {required ComplaintProvider model}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.grey),
                  onPressed: () {
                    pushRoute(
                      context: context,
                      route: ComplaintDetailsScreen(
                        needBack: true,
                        id: user.id,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (dialogContext) => CustomDialogWidgetWithActions(
                        context: dialogContext,
                        title: "confirm".tr(),
                        onYesTap: () {
                          model.deleteComplaint(context, id: user.id);
                          Navigator.pop(context);
                        },
                        subtitle: "delete_confirmation".tr()),
                  ),
                ),
              ],
            ),
            buildRow(
              "complaint_user_name".tr(),
              user.name ?? "",
            ),
            buildRow(
              "complaint_date".tr(),
              DateFormat('dd/MM/yyyy').format((DateTime.tryParse(
                      user.createdDate ?? (DateTime.now().toString())) ??
                  (DateTime.now()))),
            ),
            user?.unitName == null ? Container() : buildRow(
              "unitNumber".tr(),
              user?.unitName ?? "",
            ),
          ],
        ),
      ),
    );
  }
}
