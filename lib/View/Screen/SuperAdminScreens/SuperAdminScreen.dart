import 'package:core_project/Provider/SuperAdminProviders/BottomNavBarProvider.dart';
import 'package:core_project/Provider/SuperAdminProviders/HomeProviderForSuperAdminProvider.dart';
import 'package:core_project/Utill/AnimationWidget.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Screen/DashBoard/HomeScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/SuperAdminDrawer.dart';
import 'package:core_project/View/Widget/SuperAdminWidgets/dashboard_card.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:provider/provider.dart';

import '../RentRequestsScreen.dart';
import '../RequestPage.dart';
import '../UnitOwnersScreen.dart';
import '../VisitorsNotApprovedScreen.dart';
import '../VisitorsNotExitScreen.dart';

class SuperAdminScreen extends StatefulWidget {
  SuperAdminScreen({super.key});

  @override
  State<SuperAdminScreen> createState() => _SuperAdminScreenState();
}

class _SuperAdminScreenState extends State<SuperAdminScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeProviderForSuperAdminProvider>(context, listen: false)
        .notify = false;
    Future.wait([
      Provider.of<HomeProviderForSuperAdminProvider>(context, listen: false)
          .loadData(context),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    HomeProviderForSuperAdminProvider homeProviderForSuperAdminProvider =   Provider.of<HomeProviderForSuperAdminProvider>(context, listen: false);
    return SafeArea(
      child: Consumer<BottomNavBarProvider>(
        builder: (context, model, _) {
          return Scaffold(
            key: model.scaffoldKey,
            drawer: SuperAdminDrawer(),
            onDrawerChanged: (isOpen) {
              model.onDrawerStateChanged();
            },
            extendBody: true,
            appBar: CustomAppBar(
              needBack: false,
              title: 'AppNameOnHome'.tr(
                namedArgs: {
                  'comName': globalAccountData.getCompoundName() ?? ""
                },
              ),
              backgroundImage: AssetImage(ImagesConstants.backgroundImage),
              leading: IconButton(

                icon: Icon(Icons.menu,size: 30,), // Custom icon to open the drawer
                onPressed: () {
                  model.scaffoldKey.currentState?.openDrawer();
                  //  model.onDrawerStateChanged();
                },
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                homeProviderForSuperAdminProvider.notify = true;
                homeProviderForSuperAdminProvider.loadData(context);
              },
              child: Consumer<HomeProviderForSuperAdminProvider>(
                  builder: (context, model, _) {
                return model.status == LoadingStatus.LOADING
                    ? Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoaderWidget(),
                          ],
                        ),
                      )
                    : Container(
                        //color: BACKGROUNDCOLOR,
                        child: ListView(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    model.status == LoadingStatus.LOADING?
                                        Center(
                                          child:CircularProgressIndicator(),):
                                    GridView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 0,
                                        childAspectRatio: 3 / 3.5,
                                      ),
                                      children: [
                                        DashboardCard(
                                          title: "new_customer_requests".tr(),
                                          value: model.getNewRequestsCountModel
                                                  ?.data ??
                                              "",
                                          color: Color(0xffE53E3E),
                                          icon: Icons.work_outline,
                                          onTap: () {
                                            homeProviderForSuperAdminProvider.getNewRequests(context).then((value){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>RequestPageScreen(
                                                  requestPage: homeProviderForSuperAdminProvider.requestResponse!
                                                )));
                                            });
                                          }
                                        ),
                                        DashboardCard(
                                          title: "rental_requests_pending".tr(),
                                          value: model
                                                  .getVisitorsNotApprovedCountModel
                                                  ?.data ??
                                              "",
                                          color: Color(0xff48BB78),
                                          icon: Icons.event_note,
                                            onTap: () {
                                              homeProviderForSuperAdminProvider.getVisitsNotApproved(context).then((value){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => VisitorsNotApprovedScreen(response: homeProviderForSuperAdminProvider
                                                        .visitorsNotApprovedResponse!),
                                                  ),
                                                );
                                              });
                                            }
                                        ),
                                        DashboardCard(
                                          title: "rental_requests_in_progress"
                                              .tr(),
                                          value: model
                                                  .getRentsNotApprovedCountModel
                                                  ?.data ??
                                              "",
                                          color: Color(0xffA1CCF0),
                                          icon: Icons.event_available,
                                            onTap: () {
                                              homeProviderForSuperAdminProvider.getRentsNotApproved(context).then((value){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => RentRequestsScreen(rentData:homeProviderForSuperAdminProvider.rentNotApprovedResponse!),
                                                  ),
                                                );
                                              });
                                            }
                                        ),
                                        DashboardCard(
                                          title:
                                              "owners_pending_activation".tr(),
                                          value: model.getNewOwnersCountModel
                                                  ?.data ??
                                              "",
                                          color: Color(0xffF6AD55),
                                          icon: Icons.person_add,
                                            onTap: () {
                                              homeProviderForSuperAdminProvider.getUnitOwnersNotApproved(context).then((value){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => UnitOwnersScreen(data:homeProviderForSuperAdminProvider.notApprovedUnitOwnersResponse!),
                                                  ),
                                                );
                                              });
                                            }
                                        ),
                                        DashboardCard(
                                          title: "visitors_not_left".tr(),
                                          value: model
                                                  .getVisitorsNotExitCountModel
                                                  ?.data ??
                                              "",
                                          color: Color(0xff5A67D8),
                                          icon: Icons.person_off,
                                            onTap: () {
                                              homeProviderForSuperAdminProvider.getVisitorsNotExitResponse(context).then((value){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => VisitorsNotExitScreen(response:
                                                    homeProviderForSuperAdminProvider.visitorsNotExitResponse!),
                                                  ),
                                                );
                                              });
                                            }
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text("occupancy_rate".tr()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Circular progress card
                                      Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  model
                                                          .getUnitsForDashboardModel[
                                                              index]
                                                          .modelName ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Icon(Icons.help_outline,
                                                    color: Colors.grey),
                                              ],
                                            ),
                                            SizedBox(height: 16),
                                            Column(
                                              //  alignment: Alignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 120,
                                                  height: 120,
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: ((model
                                                                .getUnitsForDashboardModel[
                                                                    index]
                                                                .emptyUnitsCount ??
                                                            0) /
                                                        (model
                                                                .getUnitsForDashboardModel[
                                                                    index]
                                                                .totalUnitsCount ??
                                                            1)), // Adjust this value dynamically (0.0 to 1.0)
                                                    strokeWidth: 8,
                                                    backgroundColor:
                                                        Colors.grey[300],

                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.green
                                                                .withOpacity(
                                                                    0.7)),
                                                  ),
                                                ),
                                                SizedBox(height: 16),
                                                Text(
                                                  "${model.getUnitsForDashboardModel[index].busyUnitsPercentage ?? ""}%",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      'busy'.tr(),
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text(
                                                      "${model.getUnitsForDashboardModel[index].busyUnitsCount ?? ""}",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'vacant'.tr(),
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text(
                                                      "${model.getUnitsForDashboardModel[index].emptyUnitsCount ?? ""}",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              itemCount: model.getUnitsForDashboardModel.length,
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      );
              }),
            ),
          );
        },
      ),
    );
  }
}
