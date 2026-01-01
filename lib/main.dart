
import 'package:core_project/Provider/ChairRequest/ChairRequestsProvider.dart';
import 'package:core_project/Provider/SuperAdminProviders/BottomNavBarProvider.dart';
import 'package:core_project/Provider/DeliveryProvider.dart';
import 'package:core_project/Provider/SuperAdminProviders/ComplaintProvider.dart';
import 'package:core_project/Provider/SuperAdminProviders/CutomerServiceProvider.dart';
import 'package:core_project/Provider/SuperAdminProviders/GetGateLogProvider.dart';
import 'package:core_project/Provider/SuperAdminProviders/HomeProviderForSuperAdminProvider.dart';
import 'package:core_project/Provider/SuperAdminProviders/NotificationForAdminProvider.dart';
import 'package:core_project/Provider/SuperAdminProviders/OwnersManagementProvider.dart';
import 'package:core_project/Provider/SuperAdminProviders/PaymentProvider.dart';
import 'package:core_project/Provider/SuperAdminProviders/RequestsNewUnitsProvider.dart';
import 'package:core_project/Provider/SuperAdminProviders/TransactionsProvider.dart';
import 'package:core_project/Provider/SuperAdminProviders/VisitAndRentProvider.dart';
import 'package:core_project/Provider/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import 'Provider/ConfigProvider.dart';
import 'Provider/HomeProvider.dart';
import 'Provider/LoginProvider.dart';
import 'Provider/NotifcationProvider.dart';
import 'Provider/QrCodeProvider.dart';
import 'Provider/RegisterProvider.dart';
import 'Provider/ServicesProvider.dart';
import 'Provider/UnitsProvider.dart';
import 'Provider/VisitorProvider.dart';
import 'Utill/Local_User_Data.dart';
import 'Utill/Notifications/notification.dart';
import 'app.dart';
import 'package:easy_localization/easy_localization.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Future<void> requestPermission() async {
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  //   print('User granted permission: ${settings.authorizationStatus}');
  // }
  // requestPermission();
  await globalAccountData.init();

  if (kDebugMode) {
    await Upgrader.clearSavedSettings();
  }
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  mainFunctionForNotification();

  //await Permission.notification.request();
  FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<RegisterProvider>(
            create: (_) => RegisterProvider()),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<ConfigProvider>(create: (_) => ConfigProvider()),
        ChangeNotifierProvider<QrcodeProvider>(create: (_) => QrcodeProvider()),
        ChangeNotifierProvider<ServicesProvider>(
            create: (_) => ServicesProvider()),
        ChangeNotifierProvider<VisitorProvider>(
            create: (_) => VisitorProvider()),
        ChangeNotifierProvider<UnitsProvider>(create: (_) => UnitsProvider()),
        ChangeNotifierProvider<NotificationProvider>(
            create: (_) => NotificationProvider()),
        ChangeNotifierProvider<DeliveryProvider>(
            create: (_) => DeliveryProvider()),

        ChangeNotifierProvider<BottomNavBarProvider>(
            create: (_) => BottomNavBarProvider()),
        ChangeNotifierProvider<HomeProviderForSuperAdminProvider>(
            create: (_) => HomeProviderForSuperAdminProvider()),
        ChangeNotifierProvider<OwnersManagementProvider>(
            create: (_) => OwnersManagementProvider()),
        ChangeNotifierProvider<RequestsNewUnitsProvider>(
            create: (_) => RequestsNewUnitsProvider()),
        ChangeNotifierProvider<GetGateLogProvider>(
            create: (_) => GetGateLogProvider()),

        ChangeNotifierProvider<VisitAndRentProviderProvider>(
            create: (_) => VisitAndRentProviderProvider()),
        ChangeNotifierProvider<CustomerServiceProvider>(
            create: (_) => CustomerServiceProvider()),
        ChangeNotifierProvider<NotificationForAdminProvider>(
            create: (_) => NotificationForAdminProvider()),
        ChangeNotifierProvider<PaymentProvider>(
            create: (_) => PaymentProvider()),
        ChangeNotifierProvider<ComplaintProvider>(create: (_) => ComplaintProvider()),
        ChangeNotifierProvider<TransactionsProvider>(create: (_) => TransactionsProvider()),
        ChangeNotifierProvider<ChairRequestsProvider>(create: (_) => ChairRequestsProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
        path: 'assets/trasnlation',
        saveLocale: true,
        fallbackLocale: const Locale('ar', 'EG'),
        child: const MyApp(),
      )));
}
