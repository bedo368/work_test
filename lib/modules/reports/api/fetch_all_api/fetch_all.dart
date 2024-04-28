import 'package:flutter_application_1/modules/reports/api/satage_api/repo/stage_repo.dart';
import 'package:flutter_application_1/modules/reports/api/sections_api/section_repo/section_api_repo.dart';
import 'package:flutter_application_1/modules/reports/models/section_model.dart';
import 'package:flutter_application_1/modules/reports/models/stage_models.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FetchAll {
  FetchAll._privateConstructor();

  static FetchAll? _instance;
  static final StageApiRepo _stageApiRepo = StageApiRepo();
  static final SectionApiRepo _sectionApiRepo = SectionApiRepo();

  // Factory constructor to return the singleton instance
  static Future<FetchAll> init() async {
    if (_instance == null) {
      await _initializeAdapotors();
      _instance = FetchAll._privateConstructor();
      await _fetchAll();
    }
    return _instance!;
  }

  static Future<void> _initializeAdapotors() async {
    await Hive.initFlutter();
    Hive.registerAdapter(StageModelHiveAdaptor());
    Hive.registerAdapter(SectionModelHiveAdapter());
  }

  static Future<void> _fetchAll() async {
    try {
      final res = await Future.wait([
        _stageApiRepo.getAllStages(),
        _sectionApiRepo.getAllSections(),
      ]);

      print(res);
    } catch (e) {
      rethrow;
    }
  }

  // Add your methods and properties here
}
