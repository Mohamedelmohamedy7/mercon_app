import 'package:core_project/Model/UnitModel.dart';

import 'ALLModelModel.dart';
import 'BuildingModel.dart';
import 'LevelModel.dart';

class SharedTypeSelected {
  ALLModelModel? selectedModel;
  BuildingModel? buildingModel;
  LevelModel? levelModel;
  UnitModel? unitModel;

  SharedTypeSelected(
      {this.selectedModel,
      this.buildingModel,
      this.levelModel,
      this.unitModel});
}
