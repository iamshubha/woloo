class HostDashboardData {
  bool? success;
  Results? results;

  HostDashboardData({this.success, this.results});

  HostDashboardData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    results =
        json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }
}

class Results {
  String? wahScore;
  String? wahScoreImage;
  String? wahScoreColour;
  WalkInsLast1Hr? walkInsLast1Hr;
  WalkInsLast1Hr? walkInsLast3Hr;
  WalkInsLast1Hr? walkInsLast6Hr;

  Results(
      {this.wahScore,
      this.wahScoreImage,
      this.wahScoreColour,
      this.walkInsLast1Hr,
      this.walkInsLast3Hr,
      this.walkInsLast6Hr});

  Results.fromJson(Map<String, dynamic> json) {
    wahScore = json['wah_score'];
    wahScoreImage = json['wah_score_image'];
    wahScoreColour = json['wah_score_colour'];
    walkInsLast1Hr = json['walk_ins_last_1Hr'] != null
        ? new WalkInsLast1Hr.fromJson(json['walk_ins_last_1Hr'])
        : null;
    walkInsLast3Hr = json['walk_ins_last_3Hr'] != null
        ? new WalkInsLast1Hr.fromJson(json['walk_ins_last_3Hr'])
        : null;
    walkInsLast6Hr = json['walk_ins_last_6Hr'] != null
        ? new WalkInsLast1Hr.fromJson(json['walk_ins_last_6Hr'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wah_score'] = this.wahScore;
    data['wah_score_image'] = this.wahScoreImage;
    data['wah_score_colour'] = this.wahScoreColour;
    if (this.walkInsLast1Hr != null) {
      data['walk_ins_last_1Hr'] = this.walkInsLast1Hr!.toJson();
    }
    if (this.walkInsLast3Hr != null) {
      data['walk_ins_last_3Hr'] = this.walkInsLast3Hr!.toJson();
    }
    if (this.walkInsLast6Hr != null) {
      data['walk_ins_last_6Hr'] = this.walkInsLast6Hr!.toJson();
    }
    return data;
  }
}

class WalkInsLast1Hr {
  int? currentCount;
  int? previousCount;
  int? percentageChange;

  WalkInsLast1Hr(
      {this.currentCount, this.previousCount, this.percentageChange});

  WalkInsLast1Hr.fromJson(Map<String, dynamic> json) {
    currentCount = json['currentCount'];
    previousCount = json['previousCount'];
    percentageChange = json['percentageChange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentCount'] = this.currentCount;
    data['previousCount'] = this.previousCount;
    data['percentageChange'] = this.percentageChange;
    return data;
  }
}
