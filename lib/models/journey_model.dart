class JourneyModel {
  JourneyModel(this.artistName, this.studioName);

  JourneyModel.fromJson(Map<String, dynamic> json)
      : artistName = json['artist'],
        studioName = json['studio'];

  final String artistName;
  final String studioName;
}
