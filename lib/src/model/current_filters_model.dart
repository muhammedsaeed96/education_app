class CurrentFiltersModel {
  final String? city;
  final String? country;
  final String? level;
  final String? subject;

  CurrentFiltersModel({
    this.city,
    this.country,
    this.level,
    this.subject,
  });

  CurrentFiltersModel copyWith({
    String? city,
    String? country,
    String? level,
    String? subject,
  }) {
    return CurrentFiltersModel(
      city: city ?? this.city,
      country: country ?? this.country,
      level: level ?? this.level,
      subject: subject ?? this.subject,
    );
  }
}
