import 'package:core_project/Model/ChairRequest/GetAllChairRequestsModel.dart';
import 'package:core_project/Provider/ChairRequest/ChairRequestsProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/ChairRequest/CreateOrUpdateChairRequestScreen.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../../Widget/SuperAdminWidgets/build_row.dart';

class ChairRequestsListScreen extends StatefulWidget {
  ChairRequestsListScreen(
      {super.key, required this.needBack, this.admin = true});
  final bool needBack;
  final bool admin;
  @override
  State<ChairRequestsListScreen> createState() =>
      _ChairRequestsListScreenState();
}

class _ChairRequestsListScreenState extends State<ChairRequestsListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ChairRequestsProvider>(context, listen: false).notify = false;

    if (widget.admin) {
      catchError(
          p_Listeneress<ChairRequestsProvider>(context)
              .getChairRequestsList(context),
          'ChairRequestsProvider');
      catchError(
              p_Listeneress<ChairRequestsProvider>(context)
                  .getChairsCount(context),
              'getChairsCount');
      //     .then((value) {
      //   _controller = TextEditingController(
      //       text: int.tryParse(
      //               Provider.of<ChairRequestsProvider>(context, listen: false)
      //                       .getChairCountModel
      //                       ?.data
      //                       ?.chairsCount
      //                       ?.toString() ??
      //                   "")
      //           .toString());
      // });
    } else {
      catchError(
          p_Listeneress<ChairRequestsProvider>(context)
              .getChairRequestsListByUserId(context),
          'getChairRequestsListByUserId');
    }

    catchError(
        p_Listeneress<ChairRequestsProvider>(context)
            .getChairRequestStatusList(context),
        'getChairRequestStatusList');

    Provider.of<ChairRequestsProvider>(context, listen: false).notify = true;
    Provider.of<ChairRequestsProvider>(context, listen: false).first = true;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "chairRequest".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Provider.of<ChairRequestsProvider>(context, listen: false).notify =
                true;

            if (widget.admin) {
              Provider.of<ChairRequestsProvider>(context, listen: false)
                  .getChairRequestsList(context);
              Provider.of<ChairRequestsProvider>(context, listen: false)
                  .getChairsCount(context).then((value) {

              });
            } else {
              Provider.of<ChairRequestsProvider>(context, listen: false)
                  .getChairRequestsListByUserId(context);
            }
          },
          child: Consumer<ChairRequestsProvider>(builder: (context, model, _) {
            return Column(
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (model.getChairCountModel?.data?.chairsCount != null &&
                    widget.admin)
                  Row(
                    children: [
                      Text("${'chairCount'.tr()}:"),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 80,
                        child: TextField(
                          controller: model.controller,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                            border: OutlineInputBorder(),
                          ),
                          // 🔥 السماح فقط بالأرقام
                          onChanged: (value) {
                           model.controller.text = value;
                            if (int.tryParse(value) == null &&
                                value.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("الرجاء إدخال رقم صحيح"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                            setState(() {}); // تحديث زر الحفظ
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.black26),
                        ),
                        onPressed: (model.controller.text.isEmpty ?? true) ||
                                int.tryParse(model.controller.text ?? "") == null
                            ? null // 🔥 تعطيل الزر لو مفيش رقم صحيح
                            : () async {
                                final count =
                                    int.tryParse(model.controller.text ?? "");
                                if (count == null) return;

                                bool success = await model
                                    .setChairCount(context, chairCount: count);
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("تم تحديث عدد الكراسي")),
                                  );
                                }
                              },
                        child: const Text(
                          "حفظ",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                if (!widget.admin)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            pushRoute(
                              context: context,
                              route: const CreateChairRequestScreen(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 24.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'new_chair_request'.tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                    : model.chairRequestList.isEmpty ||
                            model.chairRequestStatusModelList.isEmpty &&
                                model.first
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
                                    //     buildCompliantCard(
                                    //   model.complaintList[index],
                                    //   model: model,
                                    // ),
                                    widget.admin
                                        ? buildChairRequestCardAdmin(
                                            model.chairRequestList[index],
                                            model: model,
                                          )
                                        : buildChairRequestCard(
                                            model.chairRequestList[index],
                                            model: model,
                                          ),
                                itemCount: model.chairRequestList.length,
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

  Widget buildChairRequestCardAdmin(ChairRequest chairRequest,
      {required ChairRequestsProvider model}) {
    final selectedStatus = model.chairRequestStatusModelList
        .firstWhere((status) => status.id == chairRequest.statusID);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // ⚙️ العمليات (Edit/Delete)
            Row(
              children: [
                Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text("Confirm"),
                      content: const Text("Are you sure you want to delete?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            model.deleteChairRequest(context,
                                id: chairRequest.id, admin: true);
                            Navigator.pop(dialogContext);
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                // 🪪 مالك الوحدة
                buildRow(
                  "unit_owner".tr(),
                  chairRequest.ownerName ?? '',
                ),
                buildRow(
                  "chairCount".tr(),
                  chairRequest.count?.toString() ?? '',
                ),

                buildRow(
                  "description".tr(),
                  chairRequest.description ?? '',
                ),
                buildRow(
                  "status".tr(),
                  selectedStatus.status.toString() ?? '',
                  color:
                      getChairStatueColor(chairStatesId: chairRequest.statusID),
                ),

                if (chairRequest.statusID != 4)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "status".tr() + ":",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 2,
                          child: DropdownButton<int>(
                            value: chairRequest.statusID,
                            isExpanded: true,
                            items: model.chairRequestStatusModelList
                                .where((statusModel) =>
                                    statusModel.forAdmin == true)
                                .map((statusModel) {
                              final isDisabled = ((chairRequest.statusID == 2 &&
                                          statusModel.id ==
                                              3) //close not available when chairRequest is available
                                      ||
                                      statusModel.id ==
                                          1 //close received option
                                  // ||
                                  //     (statusModel.id==chairRequest.statusID) //m5tar4 el option ally wa2fa 3leh already
                                  );

                              return DropdownMenuItem<int>(
                                value: statusModel.id,
                                enabled: !isDisabled, // 🔥 يخلي الخيار غير نشط
                                child: Text(
                                  statusModel.status ?? '',
                                  style: TextStyle(
                                    color: isDisabled
                                        ? Colors.grey
                                        : Colors.black, // لون باهت
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (selectedId) async {
                              if (selectedId != null) {
                                final selectedStatus = model
                                    .chairRequestStatusModelList
                                    .firstWhere(
                                        (status) => status.id == selectedId);

                                // 🔥 عرض دياalog التأكيد
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) => AlertDialog(
                                    title: const Text("تأكيد"),
                                    content: Text(
                                        "هل أنت متأكد أنك تريد تغيير الحالة إلى ${selectedStatus.status}?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(dialogContext),
                                        child: const Text("إلغاء"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(
                                              dialogContext); // قفل الديالوج

                                          // تحديث البيانات
                                          chairRequest.statusID = selectedId;
                                          chairRequest.statusName =
                                              selectedStatus.status;

                                          bool success =
                                              await model.UpdateChairRequest(
                                            context,
                                            chairRequest: chairRequest,
                                            chairRequestId: chairRequest.id,
                                            admin: true,
                                          );

                                          if (success) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'تم تحديث الحالة بنجاح')),
                                            );
                                          }
                                        },
                                        child: const Text("نعم"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )

                // buildRow(
                //   "order_date".tr(),
                //   DateFormat('dd/MM/yyyy').format((DateTime.tryParse(
                //       chairRequest. ?? (DateTime.now().toString())) ??
                //       (DateTime.now()))),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getChairStatueColor({required int? chairStatesId}) {
    return chairStatesId == 3
        ? Color(0xffe6575e)
        : chairStatesId == 2
            ? Color(0xff62b051)
            : chairStatesId == 1
                ? Color(0xffef960f)
                : Color(0xff2f96f3);
  }

  Widget buildChairRequestCard(ChairRequest chairRequest,
      {required ChairRequestsProvider model})
  {
    final selectedStatus = model.chairRequestStatusModelList
        .firstWhere((status) => status.id == chairRequest.statusID);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // ⚙️ العمليات (Edit/Delete)
            Row(
              children: [
                Spacer(),
                if (chairRequest.statusID == 1)
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.grey),
                    onPressed: () {
                      if (!widget.admin)
                        pushRoute(
                            context: context,
                            route: CreateChairRequestScreen(
                                existingRequest: chairRequest));
                    },
                  ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text("Confirm"),
                      content: const Text("Are you sure you want to delete?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            model.deleteChairRequest(
                              context,
                              id: chairRequest.id,
                            );
                            Navigator.pop(dialogContext);
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                // 🪪 مالك الوحدة
                // buildRow(
                //   "unit_owner".tr(),
                //   chairRequest.ownerName ?? '',
                // ),
                buildRow(
                  "chairCount".tr(),
                  chairRequest.count?.toString() ?? '',
                ),

                buildRow(
                  "description".tr(),
                  chairRequest.description ?? '',
                ),

                buildRow(
                  "status".tr(),
                  selectedStatus.status ?? '',
                  color:
                      getChairStatueColor(chairStatesId: chairRequest.statusID),
                ),

                if (chairRequest.statusID == 2)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "status".tr() + ":",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 2,
                          child: DropdownButton<int>(
                            value: chairRequest.statusID,
                            isExpanded: true,
                            items: model.chairRequestStatusModelList
                                .where((statusModel) =>
                                    statusModel.id == 2 || statusModel.id == 4)
                                .map((statusModel) {
                              final isDisabled = !(chairRequest.statusID == 2 &&
                                  (statusModel.id == 4));

                              return DropdownMenuItem<int>(
                                value: statusModel.id,
                                enabled: !isDisabled, // 🔥 يخلي الخيار غير نشط
                                child: Text(
                                  statusModel.status ?? '',
                                  style: TextStyle(
                                    color: isDisabled
                                        ? Colors.grey
                                        : Colors.black, // لون باهت
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (selectedId) async {
                              if (selectedId != null) {
                                final selectedStatus = model
                                    .chairRequestStatusModelList
                                    .firstWhere(
                                        (status) => status.id == selectedId);

                                // 🔥 عرض دياalog التأكيد
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) => AlertDialog(
                                    title: const Text("تأكيد"),
                                    content: Text(
                                        "هل أنت متأكد أنك تريد تغيير الحالة إلى ${selectedStatus.status}?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(dialogContext),
                                        child: const Text("إلغاء"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(
                                              dialogContext); // قفل الديالوج

                                          // تحديث البيانات
                                          chairRequest.statusID = selectedId;
                                          chairRequest.statusName =
                                              selectedStatus.status;

                                          bool success =
                                              await model.UpdateChairRequest(
                                            context,
                                            chairRequest: chairRequest,
                                            chairRequestId: chairRequest.id,
                                          );

                                          if (success) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'تم تحديث الحالة بنجاح')),
                                            );
                                          }
                                        },
                                        child: const Text("نعم"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )

                // buildRow(
                //   "order_date".tr(),
                //   DateFormat('dd/MM/yyyy').format((DateTime.tryParse(
                //       chairRequest. ?? (DateTime.now().toString())) ??
                //       (DateTime.now()))),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
