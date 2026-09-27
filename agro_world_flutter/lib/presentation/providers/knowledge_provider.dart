import 'package:flutter/material.dart';
import '../../data/models/article_models.dart';
import '../../data/repositories/knowledge_repository.dart';

class KnowledgeProvider extends ChangeNotifier {
  final KnowledgeRepository _repository = KnowledgeRepository();

  List<CropModel> _crops = [];
  List<FruitModel> _fruits = [];
  List<FlowerModel> _flowers = [];
  List<ExpandTechniqueModel> _techniques = [];
  List<DiseaseModel> _diseases = [];
  List<InsectModel> _insects = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<CropModel> get crops => _crops;
  List<FruitModel> get fruits => _fruits;
  List<FlowerModel> get flowers => _flowers;
  List<ExpandTechniqueModel> get techniques => _techniques;
  List<DiseaseModel> get diseases => _diseases;
  List<InsectModel> get insects => _insects;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadAllKnowledge({bool isHindi = false}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.getCrops(isHindi: isHindi),
        _repository.getFruits(isHindi: isHindi),
        _repository.getFlowers(isHindi: isHindi),
        _repository.getTechniques(isHindi: isHindi),
        _repository.getDiseases(isHindi: isHindi),
        _repository.getInsects(isHindi: isHindi),
      ]);

      _crops = results[0] as List<CropModel>;
      _fruits = results[1] as List<FruitModel>;
      _flowers = results[2] as List<FlowerModel>;
      _techniques = results[3] as List<ExpandTechniqueModel>;
      _diseases = results[4] as List<DiseaseModel>;
      _insects = results[5] as List<InsectModel>;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
