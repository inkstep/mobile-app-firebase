class Journey {
  Journey(this.artistName, this.studioName);

  Journey.fromJson(Map<String, dynamic> json)
      : artistName = json['artist'],
        studioName = json['studio'];

  final String artistName;
  final String studioName;
}
