import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:core_project/Provider/LoginProvider.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/View/Widget/HomeWidgets/internal_regulations.dart';
import 'package:core_project/View/Widget/HomeWidgets/one_unit_widget.dart';
import 'package:core_project/View/Widget/HomeWidgets/units_widget.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../../Provider/HomeProvider.dart';
import '../../../Provider/UnitsProvider.dart';
import '../../../Utill/AnimationWidget.dart';
import '../../../Utill/Comman.dart';
import '../../../WeatherService.dart';
import '../../../helper/EnumLoading.dart';
import '../../../helper/ImagesConstant.dart';
import '../../Widget/HomeWidgets/CarousalWidget.dart';
import '../../Widget/HomeWidgets/NewsWidget.dart';
import '../../Widget/HomeWidgets/delivery_card.dart';
import '../../Widget/comman/comman_Image.dart';
import '../ProjectDetailPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider? home_provider;

   @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: CustomAnimatedWidget(
          child: Container(
            // //color: BACKGROUNDCOLOR,
            child: ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 330,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        20.height,
                        textAnimation(),
                        5.height,
                        CarouselSliderExample(),
                        10.height,
                        ProjectsListView(projects:EasyLocalization.of(context)?.currentLocale?.languageCode == 'ar' ?
                        projectsArabic:projects,),

                        10.height,
                        Provider.of<UnitsProvider>(context)
                            .modelUnitServiceList
                            .length >
                            0
                            ? Provider.of<UnitsProvider>(context)
                            .modelUnitServiceList
                            .length >
                            1
                            ? UnitsWidget()
                            : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: OneUnitWidget(
                              myUnit: Provider.of<UnitsProvider>(context)
                                  .modelUnitServiceList),
                        )
                            : SizedBox(),
                        10.height,
                      ],
                    ),
                  ],
                ),
                // DeliveryCard(
                //   home_provider: home_provider!,
                // ),
                // 10.height,
                // InternalRegulations(
                //   home_provider: home_provider!,
                // ),
                10.height,
                NewsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {

    Future.delayed(const Duration(seconds: 0), () async {
      await Provider.of<LoginProvider>(context, listen: false)
          .checkUserValidation(context);
    });
    home_provider = Provider.of<HomeProvider>(context, listen: false);
    super.initState();
    getMyName();
  }

  void getMyName() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await globalAccountData.init();
      if (home_provider?.mobileSliders == null ||
          home_provider!.mobileSliders.isEmpty) {
        home_provider?.loadData(context);
      } else {
        catchError(
            Provider.of<UnitsProvider>(context, listen: false)
                .getMyUnitNumber(context),
            'getMyUnitNumber');
      }
    });
  }

  Row textAnimation() {
    return Row(
      children: [
        10.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                textAlign: TextAlign.left,
                style: CustomTextStyle.semiBold14grey.copyWith(fontSize: 14,color: Colors.white),
                child: AnimatedTextKit(
                  repeatForever: false,
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText("  "),
                    TypewriterAnimatedText(
                        " ${"Welcome".tr()},${globalAccountData.getUsername()} "),
                  ],
                ),
              ),
              WeatherScreen(),
            ],
          ),
        ),

        cachedImage(ImagesConstants.logo, width: 110, height: 60),
        // cachedImage(globalAccountData.getCompoundLogo(), width: 40, height: 40),
        10.width,
      ],
    );
  }
}


List<Map<String, dynamic>> data = [
  {
    "title": "Riverton New Cairo",
    "imageUrl": "https://newcairo-developments.com/wp-content/uploads/2025/08/Riverton-New-Cairo-Compound.jpg",
    "desc": "A luxurious residential project in the heart of Fifth Settlement, covering approximately 25 acres with a variety of housing units, full services, and extensive green spaces.",
    "details": {
      "location": "Fifth Settlement – New Cairo",
      "type": "Residential / Investment",
      "size": "Approximately 25 acres",
      "greenSpaces": "80% of the area",
      "partners": ["Al Tamayoz Kuwait", "Giwan Hotels"],
      "amenities": ["Restaurants", "Spa", "Swimming Pool", "Gym"]
    },
    "video_id":"2uJ1_yurwOk"
  },
  {
    "title": "Nurai Golden Square",
    "imageUrl": "https://newcairo-developments.com/wp-content/uploads/2024/05/Nurai-Fifth-Settlement-Compound.jpg",
    "desc": "A fully integrated residential and commercial community in the Golden Square area of New Cairo, spanning around 70,000 m², combining residential and commercial services.",
    "details": {
      "location": "Golden Square – Fifth Settlement",
      "type": "Residential + Commercial",
      "area": "70,000 m²",
      "units": "Over 400 units",
      "investment": "Approx. 14 billion EGP"
    },
    "video_id":"O7djMUUXKxw"
  },
  {
    "title": "VX Golden Square",
    "imageUrl": "https://blureg.com/wp-content/uploads/2025/12/0-04-scaled-1.webp",
    "desc": "A modern residential project in Golden Square, offering an innovative living experience with a mix of modern amenities and open spaces.",
    "details": {
      "location": "Golden Square – New Cairo",
      "type": "Residential",
      "features": ["Jogging Tracks", "Entertainment Areas", "Green Spaces"]
    },
    "video_id":"QDM8rMw1fH8"
  },
  {
    "title": "VX N90",
    "imageUrl": "https://mercondevelopments.com/wp-content/uploads/2025/12/0-01-scaled-e1764683407441-1-e1766331327461.webp",
    "desc": "A commercial and business project providing flexible spaces designed specifically for startups and offices, located strategically in Fifth Settlement.",
    "details": {
      "location": "Fifth Settlement – New Cairo",
      "type": "Commercial / Administrative",
      "features": ["Office Spaces", "Shops", "Business Support Services"]
    },
    "video_id":"tq8ziC2WxoM"
  },
  {
    "title": "Pavo Tower",
    "imageUrl": "https://ipgegypt.com/storage/613/0f9/37a/6130f937ae233322716847.jpg",
    "desc": "A commercial and administrative tower in the New Administrative Capital offering high-end units with modern design in the Central Business District (CBD).",
    "details": {
      "location": "New Administrative Capital – CBD",
      "type": "Commercial / Administrative",
      "amenities": ["Parking", "24/7 Security", "Office Support Services"]
    },
    "video_id":"ui10jaabvoc"
  }
];

List<Map<String, dynamic>> dataArabic = [
  {
    "title": "ريڤرتون – القاهرة الجديدة",
    "imageUrl": "https://newcairo-developments.com/wp-content/uploads/2025/08/Riverton-New-Cairo-Compound.jpg",
    "desc":
    "مشروع سكني فاخر في قلب التجمع الخامس، يمتد على مساحة تقارب 25 فدان، ويضم وحدات سكنية متنوعة مع خدمات متكاملة ومساحات خضراء واسعة.",
    "details": {
      "location": "التجمع الخامس – القاهرة الجديدة",
      "type": "سكني / استثماري",
      "size": "حوالي 25 فدان",
      "greenSpaces": "80% من مساحة المشروع",
      "partners": ["التميز الكويت", "فنادق جيوان"],
      "amenities": ["مطاعم", "سبا", "حمامات سباحة", "جيم"]
    },
    "video_id": "2uJ1_yurwOk"
  },
  {
    "title": "نوراي جولدن سكوير",
    "imageUrl":
    "https://newcairo-developments.com/wp-content/uploads/2024/05/Nurai-Fifth-Settlement-Compound.jpg",
    "desc":
    "مجتمع سكني وتجاري متكامل في منطقة جولدن سكوير بالقاهرة الجديدة، على مساحة تقارب 70,000 متر مربع، يجمع بين الوحدات السكنية والخدمات التجارية.",
    "details": {
      "location": "جولدن سكوير – التجمع الخامس",
      "type": "سكني + تجاري",
      "area": "70,000 متر مربع",
      "units": "أكثر من 400 وحدة",
      "investment": "حوالي 14 مليار جنيه مصري"
    },
    "video_id": "O7djMUUXKxw"
  },
  {
    "title": "VX جولدن سكوير",
    "imageUrl": "https://blureg.com/wp-content/uploads/2025/12/0-04-scaled-1.webp",
    "desc":
    "مشروع سكني عصري في جولدن سكوير، يوفر تجربة معيشة حديثة تجمع بين المرافق المتطورة والمساحات المفتوحة.",
    "details": {
      "location": "جولدن سكوير – القاهرة الجديدة",
      "type": "سكني",
      "features": ["مسارات للجري", "مناطق ترفيهية", "مساحات خضراء"]
    },
    "video_id": "QDM8rMw1fH8"
  },
  {
    "title": "VX N90",
    "imageUrl":
    "https://mercondevelopments.com/wp-content/uploads/2025/12/0-01-scaled-e1764683407441-1-e1766331327461.webp",
    "desc":
    "مشروع تجاري وإداري يوفر مساحات مرنة مصممة خصيصًا للشركات الناشئة والمكاتب، ويقع في موقع استراتيجي بالتجمع الخامس.",
    "details": {
      "location": "التجمع الخامس – القاهرة الجديدة",
      "type": "تجاري / إداري",
      "features": ["مكاتب إدارية", "محلات", "خدمات دعم الأعمال"]
    },
    "video_id": "tq8ziC2WxoM"
  },
  {
    "title": "برج بافو",
    "imageUrl":
    "https://ipgegypt.com/storage/613/0f9/37a/6130f937ae233322716847.jpg",
    "desc":
    "برج تجاري وإداري في العاصمة الإدارية الجديدة، يضم وحدات عالية المستوى بتصميم عصري داخل منطقة الأعمال المركزية (CBD).",
    "details": {
      "location": "العاصمة الإدارية الجديدة – منطقة الأعمال المركزية",
      "type": "تجاري / إداري",
      "amenities": ["جراجات", "أمن 24/7", "خدمات دعم المكاتب"]
    },
    "video_id": "ui10jaabvoc"
  }
];

// project_model.dart

class Project {
  String title;
  String imageUrl;
  String desc;
  Details details;
  String video_id;

  Project({
    required this.title,
    required this.imageUrl,
    required this.desc,
    required this.details,
    required this.video_id,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      desc: json['desc'] ?? '',
      video_id: json['video_id'] ?? '',
      details: Details.fromJson(json['details'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'video_id': video_id,
      'desc': desc,
      'details': details.toJson(),
    };
  }
}

class Details {
  String? location;
  String? type;
  String? size;           // optional, some projects have 'area' instead
  String? area;
  String? units;
  String? investment;
  List<String>? features;
  List<String>? amenities;
  List<String>? partners;
  String? greenSpaces;
  String? notes;

  Details({
    this.location,
    this.type,
    this.size,
    this.area,
    this.units,
    this.investment,
    this.features,
    this.amenities,
    this.partners,
    this.greenSpaces,
    this.notes,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      location: json['location'],
      type: json['type'],
      size: json['size'],
      area: json['area'],
      units: json['units'],
      investment: json['investment'],
      features: json['features'] != null ? List<String>.from(json['features']) : null,
      amenities: json['amenities'] != null ? List<String>.from(json['amenities']) : null,
      partners: json['partners'] != null ? List<String>.from(json['partners']) : null,
      greenSpaces: json['greenSpaces'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'type': type,
      'size': size,
      'area': area,
      'units': units,
      'investment': investment,
      'features': features,
      'amenities': amenities,
      'partners': partners,
      'greenSpaces': greenSpaces,
      'notes': notes,
    };
  }
}
List<Project> projects = data.map((e) => Project.fromJson(e)).toList();
List<Project> projectsArabic = dataArabic.map((e) => Project.fromJson(e)).toList();

class ProjectsListView extends StatelessWidget {
  final List<Project> projects;

  const ProjectsListView({Key? key, required this.projects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,height:  MediaQuery.of(context).size.height*0.35,

      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal:4,vertical: 1),
        itemCount: projects.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final project = projects[index];
          return Container(
              margin: EdgeInsets.symmetric(horizontal: 4),

              width:  MediaQuery.of(context).size.width*0.55,height: 220,
              child: InkWell(
                  onTap: (){
                    pushRoute(context: context, route: ProjectDetailPage(
                      project: project,
                      videoId: project.video_id,
                    ));
                  }
                  ,child: Container(
                  decoration: BoxDecoration(
                      color: lightBrown.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.all(5),
                  child: _ProjectCard(project: project))));
        },
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;

  const _ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.teal.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15),bottom:
        Radius.circular(10)
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: cachedImage(
                  project.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Gradient Overlay من الأسفل
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.7),
                      ],
                      stops: const [0.1, 1.0, 1.0, 1.0],
                    ),
                  ),
                ),
              ),
              // العنوان والموقع فوق الـ Overlay
              PositionedDirectional(
                bottom: 16,
                end: 20,
                start:8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            project.details.location ?? '',
                            style: const TextStyle(fontSize: 13, color: Colors.white70),
                            maxLines: 2,
                          ),
                        ),
                        const Icon(Icons.location_on, size: 16, color: Colors.white70),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.05),

            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الوصف
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          project.desc,
                          style: TextStyle(fontSize: 13, color: Colors.black),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.open_in_new)
                    ],
                  ),

                  // يمكن إضافة سعر أو زر "عرض التفاصيل" هنا لو موجود
                  // مثال:
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: const Text("عرض التفاصيل", style: TextStyle(color: Colors.teal)),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
Color lightBrown = const Color(0xFFDEDAD5);
