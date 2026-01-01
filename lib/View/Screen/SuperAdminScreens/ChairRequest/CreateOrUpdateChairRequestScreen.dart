import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:core_project/Model/ChairRequest/GetAllChairRequestsModel.dart';
import 'package:core_project/Provider/ChairRequest/ChairRequestsProvider.dart';
import 'package:core_project/helper/EnumLoading.dart';
import "package:core_project/helper/ButtonAction.dart";

class CreateChairRequestScreen extends StatefulWidget {
  final ChairRequest? existingRequest;
  const CreateChairRequestScreen({super.key, this.existingRequest});

  @override
  State<CreateChairRequestScreen> createState() =>
      _CreateChairRequestScreenState();
}

class _CreateChairRequestScreenState extends State<CreateChairRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingRequest != null) {
      _isUpdating = true;
      _countController.text = widget.existingRequest?.count?.toString() ?? '';
      _descriptionController.text = widget.existingRequest?.description ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ChairRequestsProvider>(context);

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(_isUpdating ? 'update_chair_request'.tr() : 'new_chair_request'.tr()),
        // ),

        appBar: CustomAppBar(
          title: _isUpdating
              ? 'update_chair_request'.tr()
              : 'new_chair_request'.tr(),
          needBack: true,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body:
            // model.status == LoadingStatus.LOADING
            //     ? const Center(child: CircularProgressIndicator())
            //     :
            Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _countController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'chair_count'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter_chair_count'.tr();
                    }
                    if (int.tryParse(value) == null) {
                      return 'enter_valid_number'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'description'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                widgetWithAction.buttonAction<ChairRequestsProvider>(
                    action: (model) {
                      if (!_formKey.currentState!.validate()) return;

                      final chairRequest = ChairRequest(
                        id: widget.existingRequest?.id,
                        count: int.parse(_countController.text),
                        description: _descriptionController.text,
                        statusID: widget.existingRequest?.statusID,
                      );

                      if (_isUpdating) {
                        // chairRequest.statusID = 4; // 🔥 منتهي
                        model.UpdateChairRequest(
                          context,
                          chairRequest: chairRequest,
                          chairRequestId: chairRequest.id,
                        ).then((value) {
                          Navigator.of(context).pop();
                          successSnak(context, 'request_sent'.tr());
                        });
                      } else {
                        model.CreateChairRequest(
                          context,
                          chairRequest: chairRequest,
                        ).then((value) {
                          print("hereee");
                          Navigator.of(context).pop();
                          successSnak(context, 'request_sent'.tr());
                        });
                      }
                    },
                    context: context,
                    text: _isUpdating ? 'update_request' : 'send_request')

                // ElevatedButton.icon(
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(vertical: 16),
                //   ),
                //   icon: const Icon(Icons.save),
                //   label: Text(_isUpdating ? 'update_request'.tr() : 'send_request'.tr()),
                //   onPressed: () async {
                //     if (!_formKey.currentState!.validate()) return;
                //
                //     final chairRequest = ChairRequest(
                //       id: widget.existingRequest?.id,
                //       count: int.parse(_countController.text),
                //       description: _descriptionController.text,
                //       statusID: widget.existingRequest?.statusID,
                //     );
                //
                //     bool success = false;
                //     if (_isUpdating) {
                //      // chairRequest.statusID = 4; // 🔥 منتهي
                //       success = await model.UpdateChairRequest(
                //         context,
                //         chairRequest: chairRequest,
                //         chairRequestId: chairRequest.id,
                //       );
                //     } else {
                //       success = await model.CreateChairRequest(
                //         context,
                //         chairRequest: chairRequest,
                //       );
                //     }
                //
                //     if (success && mounted) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text(
                //             _isUpdating ? 'request_updated'.tr() : 'request_sent'.tr(),
                //           ),
                //           backgroundColor: Colors.green,
                //         ),
                //       );
                //       Navigator.pop(context);
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
