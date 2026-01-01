import 'dart:io';

import 'package:core_project/Model/SuperAdminModels/Transactions/Transaction_request.dart';
import 'package:core_project/Model/SuperAdminModels/Transactions/get_all_transaction_types.dart';
import 'package:core_project/Model/SuperAdminModels/Transactions/get_all_transactions.dart';
import 'package:core_project/Provider/SuperAdminProviders/TransactionsProvider.dart';
import 'package:core_project/Services/RestApi.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/validator.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/SnackBarScreen.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:core_project/helper/ButtonAction.dart';
import 'package:core_project/Utill/Local_User_Data.dart';

class UpdateTransactionScreen extends StatefulWidget {
  const UpdateTransactionScreen({super.key, required this.transaction});
  final Transaction transaction;
  @override
  State<UpdateTransactionScreen> createState() =>
      _UpdateTransactionScreenState();
}

class _UpdateTransactionScreenState extends State<UpdateTransactionScreen> {
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  TransactionsProvider? transactionsProvider;
  TransactionType? transactionType;
  Future pickImageCFront() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      attachment = File(image.path);

      setState(() {});
      FocusScope.of(context).unfocus();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
    FocusScope.of(context).unfocus();
  }

  Future pickImageFront() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      attachment = File(image.path);

      //setState(() => imageFront = imageTemp);
      setState(() {
        //  imageFront.add(imageTemp);
      });
      FocusScope.of(context).unfocus();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  File? attachment;
  String? attachmentUrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      transactionsProvider =
          Provider.of<TransactionsProvider>(context, listen: false);
      transactionsProvider?.getTransactionTypeList(
        context,
      ).then((value) {
        try {
        transactionType = Provider.of<TransactionsProvider>(context,
            listen: false)
            .transactionTypesList
            .firstWhere(
                (element) => element.id == widget.transaction.transactionTypeID);
        } catch (e) {

          print("widget.transaction.transactionTypeID ${widget.transaction.transactionTypeID} ${Provider.of<TransactionsProvider>(context,
              listen: false)
              .transactionTypesList.length}");
          print('Failed to set Data: $e');
        }
      });
      descriptionController.text = widget.transaction?.description ?? "";
      attachmentUrl = widget.transaction.attachmentUrl;


  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  bool isChecked = false;
  // TransactionType? selectedTransactionType;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "UpdateTransaction".tr(),
          needBack: true,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Consumer<TransactionsProvider>(builder: (context, model, _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: DropdownButtonFormField<TransactionType>(
                        value: transactionType,
                        decoration: InputDecoration(
                          border: InputBorder.none, // Remove underline
                        ),
                        hint: Text('TransactionType'.tr(),
                            style: CustomTextStyle.semiBold12Black),
                        items:
                            model.transactionTypesList.map((transactionModel) {
                          return DropdownMenuItem<TransactionType>(
                            value: transactionModel,
                            child: Text(transactionModel.name ?? "",
                                style: CustomTextStyle.semiBold12Black),
                          );
                        }).toList(),
                        onChanged: (value) {
                          transactionType = value;
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    textFormField(
                      "description".tr(),
                      descriptionController,
                      null,
                      validation: (value) => Validator.defaultValidator(value),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    GestureDetector(
                      onTap: () => showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                        ),
                        context: context,
                        builder: (context) => Container(
                          margin: const EdgeInsets.all(40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () async {
                                  Navigator.pop(context);
                                  await pickImageCFront(); // من الكاميرا
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.camera),
                                    const SizedBox(width: 10),
                                    Text("Select From Camera",
                                        style: CustomTextStyle.semiBold12Black),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(),
                              ),
                              InkWell(
                                onTap: () async {
                                  Navigator.pop(context);
                                  await pickImageFront(); // من المعرض
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.photo),
                                    const SizedBox(width: 10),
                                    Text("Select From Gallery",
                                        style: CustomTextStyle.semiBold12Black),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: attachment == null
                              ? Border.all(color: Colors.grey)
                              : null,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: attachment == null
                            ?widget.transaction.attachmentUrl!=null?    Container(width:double.infinity,child: Container(
                          //  elevation: 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: cachedImage(
                              widget.transaction.attachmentUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                        )): const Icon(Icons.add, size: 40)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  attachment!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    30.height,
                    widgetWithAction.buttonAction<TransactionsProvider>(
                        action: (model) {
                          if (_formKey.currentState!.validate()) {
                            Future.delayed(const Duration(seconds: 0),
                                () async {
                              if (transactionType == null) {
                                showAwesomeSnackbar(
                                  context,
                                  'Error!',
                                  '${"please_selectedTransactionType".tr()}',
                                  contentType: ContentType.failure,
                                );
                              } else if (attachment == null &&
                                  attachmentUrl == null) {
                                showAwesomeSnackbar(
                                  context,
                                  'Error!',
                                  '${"please_attachment".tr()}',
                                  contentType: ContentType.failure,
                                );
                              } else {
                                if (attachment != null) {
                                  List<String> images =
                                      await uploadImagePostFunction(
                                          [attachment],
                                          "Common/UploadImage",
                                          context);
                                  attachmentUrl =
                                      "${images.isEmpty ? "" : images.first}";
                                }

                                model.UpdateTransaction(
                                  context,
                                  transactionRequest: TransactionRequest(
                                      description: descriptionController.text,
                                      attachmentUrl: attachmentUrl,
                                      transactionTypeID: transactionType?.id,
                                      compID: int.tryParse(globalAccountData
                                          .getCompoundId()
                                          .toString())),
                                  transactionId: widget.transaction.id,
                                ).then((value) {
                                  if (value == true) {
                                    popRoute(context: context);
                                    //  popRoute(context: context);
                                    showAwesomeSnackbar(
                                      context,
                                      'Success!',
                                      '${value}',
                                      contentType: ContentType.success,
                                    );
                                  }
                                });
                              }
                            });
                          }
                        },
                        context: context,
                        text: "UpdateTransaction".tr()),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
