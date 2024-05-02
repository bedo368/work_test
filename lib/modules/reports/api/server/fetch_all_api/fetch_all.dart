import 'package:flutter_application_1/core/common/error_model.dart';
import 'package:flutter_application_1/modules/reports/api/server/question_api/question_api_repo.dart';
import 'package:flutter_application_1/modules/reports/api/server/satage_api/repo/stage_repo.dart';
import 'package:flutter_application_1/modules/reports/api/server/sections_api/section_repo/section_api_repo.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/checkbox_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/project_stage_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/answer_models/radio_question_answer_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_data_model.dart';
import 'package:flutter_application_1/modules/reports/models/question_options_model.dart';
import 'package:flutter_application_1/modules/reports/models/section_model.dart';
import 'package:flutter_application_1/modules/reports/models/stage_models.dart';
import 'package:hive_flutter/hive_flutter.dart';

const hiveStageBox = 'stage_box';
const String hiveSectionBox = 'section_box';
const String hiveQuestionBox = 'question_box';
const String hiveQuestionOptionBox = 'question_option_box';
const String hiveQuestionOptionDataBox = 'question_option_data_box';

class FetchAllAndStoreInLocalStorage {
  FetchAllAndStoreInLocalStorage._privateConstructor();

  static FetchAllAndStoreInLocalStorage? _instance;
  static final StageApiRepo _stageApiRepo = StageApiRepo();
  static final SectionApiRepo _sectionApiRepo = SectionApiRepo();
  static final QuestionApiRepo _questApiRepo = QuestionApiRepo();
  static final _hive = Hive;

  static Future<FetchAllAndStoreInLocalStorage> init() async {
    if (_instance == null) {
      await _initializeAdapotors();
      _instance = FetchAllAndStoreInLocalStorage._privateConstructor();
      await _fetchAll();
    }
    return _instance!;
  }

  static Future<void> _initializeAdapotors() async {
    await _hive.initFlutter();

    if (!_hive.isAdapterRegistered(StageModelHiveAdaptor().typeId)) {
      _hive.registerAdapter(StageModelHiveAdaptor());
    }
    if (!Hive.isAdapterRegistered(SectionModelHiveAdapter().typeId)) {
      _hive.registerAdapter(SectionModelHiveAdapter());
    }
    if (!_hive.isAdapterRegistered(QuestionHiveAdaptor().typeId)) {
      _hive.registerAdapter(QuestionHiveAdaptor());
    }
    if (!_hive.isAdapterRegistered(QuestionsOptionsDataAdapter().typeId)) {
      _hive.registerAdapter(QuestionsOptionsDataAdapter());
    }
    if (!_hive.isAdapterRegistered(QuestionOptionAdaptor().typeId)) {
      _hive.registerAdapter(QuestionOptionAdaptor());
    }
    if (!_hive
        .isAdapterRegistered(CheckboxQuestionAnswerModelAdapter().typeId)) {
      _hive.registerAdapter(CheckboxQuestionAnswerModelAdapter());
    }
    if (!_hive.isAdapterRegistered(ProjectStageAnserModelAdapter().typeId)) {
      _hive.registerAdapter(ProjectStageAnserModelAdapter());
    }
    if (!_hive.isAdapterRegistered(RadioQuestionAnswerModelAdapter().typeId)) {
      _hive.registerAdapter(RadioQuestionAnswerModelAdapter());
    }
  }

  static Future<void> _fetchAll() async {
    try {
      final res = await Future.wait([
        _stageApiRepo.getAllStages(),
        _sectionApiRepo.getAllSections(),
        _questApiRepo.getAllQuestion(),
        _questApiRepo.getAllQuestionOptions(),
        _questApiRepo.getAllQuestionOptionsData(),
      ]);

      if (res[0] is StagesDataModel) {
        _storeSatgeInHive((res[0] as StagesDataModel).stages.values.toList());
      } else if (res[0] is ErrorModel) {
        final getStagesAgin = await _stageApiRepo.getAllStages();
        if (getStagesAgin is StagesDataModel) {
          _storeSatgeInHive(getStagesAgin.stages.values.toList());
        }
      }

      if (res[1] is SectionsDataModel) {
        _storeSectionInHive(
            (res[1] as SectionsDataModel).sections.values.toList());
      } else if (res[1] is ErrorModel) {
        final getSectionAgain = await _stageApiRepo.getAllStages();
        if (getSectionAgain is SectionsDataModel) {
          _storeSectionInHive(getSectionAgain.sections.values.toList());
        }
      }

      if (res[2] is QuestionsDataModel) {
        _storeQuestionInHive(
            (res[2] as QuestionsDataModel).questions.values.toList());
      } else if (res[2] is ErrorModel) {
        final getQuestionAgain = await _stageApiRepo.getAllStages();
        if (getQuestionAgain is QuestionsDataModel) {
          _storeQuestionInHive(getQuestionAgain.questions.values.toList());
        }
      }

      if (res[3] is QuestionsOptionsDataModel) {
        _storeQuestionOptionInHive((res[3] as QuestionsOptionsDataModel)
            .questionsOptions
            .values
            .toList());
      } else if (res[3] is ErrorModel) {
        final getQuestionAgain = await _stageApiRepo.getAllStages();
        if (getQuestionAgain is QuestionsOptionsDataModel) {
          _storeQuestionOptionInHive((res[3] as QuestionsOptionsDataModel)
              .questionsOptions
              .values
              .toList());
        }
      }

      if (res[4] is QuestionOptionDDataModel) {
        _storeQuestionOptionDataInHive((res[4] as QuestionOptionDDataModel)
            .questionOptionsData
            .values
            .toList());
      } else if (res[4] is ErrorModel) {
        final getQuestionAgain = await _stageApiRepo.getAllStages();
        if (getQuestionAgain is QuestionsOptionsDataModel) {
          _storeQuestionOptionDataInHive((res[4] as QuestionOptionDDataModel)
              .questionOptionsData
              .values
              .toList());
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> _storeSatgeInHive(List<StageModel> stages) async {
    if (_hive.isBoxOpen(hiveStageBox)) {
      final stagesBox = _hive.box<StageModel>(hiveStageBox);
      await stagesBox.clear();
      await stagesBox.addAll(stages);
    } else {
      final stagesBox = await _hive.openBox<StageModel>(hiveStageBox);
      await stagesBox.clear();
      await stagesBox.addAll(stages);
    }
  }

  static Future<void> _storeSectionInHive(List<SectionModel> s) async {
    if (_hive.isBoxOpen(hiveSectionBox)) {
      final sectionBox = _hive.box<SectionModel>(hiveSectionBox);

      await sectionBox.clear();
      await sectionBox.addAll(s);
    } else {
      final sectionBox = await _hive.openBox<SectionModel>(hiveSectionBox);

      await sectionBox.clear();
      await sectionBox.addAll(s);
    }
  }

  static Future<void> _storeQuestionInHive(List<QuestionModel> q) async {
    if (_hive.isBoxOpen(hiveQuestionBox)) {
      final sectionBox = _hive.box<QuestionModel>(hiveQuestionBox);
      await sectionBox.clear();
      await sectionBox.addAll(q);
    } else {
      final sectionBox = await _hive.openBox<QuestionModel>(hiveQuestionBox);
      await sectionBox.clear();
      await sectionBox.addAll(q);
    }
  }

  static Future<void> _storeQuestionOptionInHive(
      List<QuestionOptionsModel> q) async {
    if (_hive.isBoxOpen(hiveQuestionOptionBox)) {
      final sectionBox = _hive.box<QuestionOptionsModel>(hiveQuestionOptionBox);
      await sectionBox.clear();
      await sectionBox.addAll(q);
    } else {
      final sectionBox =
          await _hive.openBox<QuestionOptionsModel>(hiveQuestionOptionBox);
      await sectionBox.clear();
      await sectionBox.addAll(q);
    }
  }

  static Future<void> _storeQuestionOptionDataInHive(
      List<QuestionsOptionDModel> qo) async {
    if (_hive.isBoxOpen(hiveQuestionOptionDataBox)) {
      final sectionBox =
          _hive.box<QuestionsOptionDModel>(hiveQuestionOptionDataBox);
      await sectionBox.clear();
      await sectionBox.addAll(qo);
    } else {
      final sectionBox =
          await _hive.openBox<QuestionsOptionDModel>(hiveQuestionOptionDataBox);
      await sectionBox.clear();
      await sectionBox.addAll(qo);
    }
  }
}
