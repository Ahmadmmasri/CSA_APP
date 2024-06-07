import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/creteria.dart';

class EvaluationLine {
  final String name;
  final String stage;
  final String value;
  final String pointValue;
  final String race;
  final String distance;
  final String lastUpdateDate;

  final Criteria criteria;

  EvaluationLine({
    required this.race,
    required this.distance,
    required this.lastUpdateDate,
    required this.name,
    required this.stage,
    required this.value,
    required this.pointValue,
    required this.criteria,
  });
}
