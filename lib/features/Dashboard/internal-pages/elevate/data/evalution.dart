import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/evalution-line.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/level-expecation.dart';

class Evalution {
  late String? evaluationType;
  late String? evaluationState;
  late List<LevelExpectaion>? expectations;
  late List<EvaluationLine>? studentEvaluation;

  Evalution({
    this.evaluationType,
    this.evaluationState,
    this.expectations,
    this.studentEvaluation,
  });
}
