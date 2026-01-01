import 'package:core_project/Provider/SuperAdminProviders/ComplaintProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/SuperAdminWidgets/buildImageCard.dart';
import 'package:core_project/View/Widget/SuperAdminWidgets/build_row.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:core_project/helper/date_converter.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class ComplaintDetailsScreen extends StatefulWidget {
  const ComplaintDetailsScreen(
      {super.key, required this.needBack, required this.id});
  final bool needBack;

  final int? id;
  @override
  State<ComplaintDetailsScreen> createState() => _ComplaintDetailsScreenState();
}

class _ComplaintDetailsScreenState extends State<ComplaintDetailsScreen> {
  bool openReason = false;

  final TextEditingController reasonController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ComplaintProvider>(context, listen: false).notify = false;
    p_Listeneress<ComplaintProvider>(context)
        .getComplaintDetails(context, id: widget.id);
    Provider.of<ComplaintProvider>(context, listen: false).notify = true;
  }

  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "complaint_details".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<ComplaintProvider>(builder: (context, model, _) {
            if (model.status == LoadingStatus.LOADING) {
              return Center(
                child: Loading(),
              );
            } else if (model.complaintModel == null && model.first) {
              return Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(child: emptyList()),
              );
            } else {
              return SingleChildScrollView(
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildRow(
                          "complaint_user_name".tr(),
                          model.complaintModel?.name ?? "",
                        ),
                        model.complaintModel?.unitName == null
                            ? Container()
                            : buildRow(
                                "unitNumber".tr(),
                                model.complaintModel?.unitName ?? "",
                              ),
                        buildRow(
                          "complaint_date".tr(),
                          DateConverter.formatDateTimeBasedOnLocale(
                              model.complaintModel?.createdDate, context),
                          // DateFormat('dd/MM/yyyy').format((DateTime.tryParse(
                          //         model.complaintModel?.createdDate ??
                          //             (DateTime.now().toString())) ??
                          //     (DateTime.now()))),
                        ),
                        buildRow(
                          "complaint_details".tr(),
                          model.complaintModel?.descriptionComplaint ?? "",
                        ),
                        buildRow(
                          "ReplyToComplaint".tr(),
                          model.complaintModel?.replyText ?? "",
                        ),
                        if (model.complaintModel?.imageUrl != null &&
                            model.complaintModel?.imageUrl
                                    .toString()
                                    .trim()
                                    .toLowerCase() !=
                                "string" &&
                            model.complaintModel?.imageUrl != null &&
                            model.complaintModel?.imageUrl
                                    .toString()
                                    .trim()
                                    .toLowerCase() !=
                                "no files were uploaded.") ...[
                          SizedBox(
                            height: 10,
                          ),
                          buildImageCard(model.complaintModel?.imageUrl,
                              context: context),
                        ],
                        SizedBox(height: 16),
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              labelText: 'Complaint_Description'.tr(),
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a complaint description'
                                    .tr();
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        model.status == LoadingStatus.LOADING
                            ? Container(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(child: const LoaderWidget()),
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    model
                                        .sendReplay(
                                      context,
                                      replyText: _descriptionController.text,
                                      complaintID: widget.id,
                                    )
                                        .then((value) {
                                      if (value == true) {
                                        _descriptionController.clear();
                                        model.getComplaintDetails(context,
                                            id: widget.id);
                                      }
                                    });
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  width: w(context),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Theme.of(context).primaryColor,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: lightGray,
                                        offset: Offset(0.0, 2.0),
                                        blurRadius:
                                            4.0, // Specify the blur radius
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                      child: Text(
                                    "sendReplay".tr(),
                                    style: CustomTextStyle.semiBold12Black
                                        .copyWith(color: white),
                                  )),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
