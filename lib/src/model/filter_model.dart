import 'package:json_annotation/json_annotation.dart';

part 'filter_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FilterModel {
  final List<String> cities;
  final Map<String, List<String>> countries;
  final List<String> levels;
  final List<String> subjects;

  FilterModel({
    this.cities = const [],
    this.countries = const {},
    this.levels = const [],
    this.subjects = const [],
  });

  factory FilterModel.fromJson(Map<String, dynamic> data) => _$FilterModelFromJson(data);

  Map<String, dynamic> toJson() => _$FilterModelToJson(this);

  List<String> getCityByCountryName(String? cityName) {
    print(cityName);
    return dummyFilters.countries[cityName] ?? [];
  }
}

final dummyFilters = FilterModel(
  cities: ['بغداد', 'ميسان', 'البصرة', 'بابل'],
  countries: {
    'بغداد': ['الغزالية', 'الكاظمية'],
    'البصرة': ['ام قصر', 'الدهلة'],
  },
  levels: ['ابتدائية','متوسطة','اعدادية'],
  subjects: ['الرياضيات','الكيمياء','الفيزياء'],
);
