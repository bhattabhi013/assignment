class SpacesModel {
  List<Track>? track;

  SpacesModel({required this.track});

  SpacesModel.fromJson(Map<String, dynamic> json) {
    if (json['track'] != null) {
      // ignore: deprecated_member_use
      track = new List<Track>.empty();
      json['track'].forEach((v) {
        track!.add(new Track.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['track'] = this.track!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Track {
  late String title;
  late String id;
  late String cover;
  late String status;
  late String disabledMsg;
  late TrackRegistrationsAggregate trackRegistrationsAggregate;

  Track(
      {required this.title,
      required this.id,
      required this.cover,
      required this.status,
      required this.disabledMsg,
      required this.trackRegistrationsAggregate});

  Track.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    cover = json['cover'];
    status = json['status'];
    disabledMsg = json['disabled_msg'];
    trackRegistrationsAggregate = (json['track_registrations_aggregate'] != null
        ? new TrackRegistrationsAggregate.fromJson(
            json['track_registrations_aggregate'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['cover'] = this.cover;
    data['status'] = this.status;
    data['disabled_msg'] = this.disabledMsg;
    // if (this.trackRegistrationsAggregate != null) {
      data['track_registrations_aggregate'] =
          this.trackRegistrationsAggregate.toJson();
    // }
    return data;
  }
}

class TrackRegistrationsAggregate {
  Aggregate? aggregate;

  TrackRegistrationsAggregate({required this.aggregate});

  TrackRegistrationsAggregate.fromJson(Map<String, dynamic> json) {
    aggregate = (json['aggregate'] != null
        ? new Aggregate.fromJson(json['aggregate'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aggregate != null) {
      data['aggregate'] = this.aggregate!.toJson();
    }
    return data;
  }
}

class Aggregate {
  int? count;

  Aggregate({required this.count});

  Aggregate.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}
