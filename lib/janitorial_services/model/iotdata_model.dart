class AirQualityData {
  List<AmoniaTableData>? amoniaTableData;
  String? ammoniaUnit;
  RangeOfPpm? rangeOfPpm;
  List<AvgppmTimeRange>? avgppmTimeRange;

  AirQualityData(
      {this.amoniaTableData,
      this.ammoniaUnit,
      this.rangeOfPpm,
      this.avgppmTimeRange});

  AirQualityData.fromJson(Map<String, dynamic> json) {
    if (json['amonia_table_data'] != null) {
      amoniaTableData = <AmoniaTableData>[];
      json['amonia_table_data'].forEach((v) {
        amoniaTableData!.add(new AmoniaTableData.fromJson(v));
      });
    }
    ammoniaUnit = json['ammonia_unit'];
    rangeOfPpm = json['range_of_ppm'] != null
        ? new RangeOfPpm.fromJson(json['range_of_ppm'])
        : null;
    if (json['avgppm_time_range'] != null) {
      avgppmTimeRange = <AvgppmTimeRange>[];
      json['avgppm_time_range'].forEach((v) {
        avgppmTimeRange!.add(new AvgppmTimeRange.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.amoniaTableData != null) {
      data['amonia_table_data'] =
          this.amoniaTableData!.map((v) => v.toJson()).toList();
    }
    data['ammonia_unit'] = this.ammoniaUnit;
    if (this.rangeOfPpm != null) {
      data['range_of_ppm'] = this.rangeOfPpm!.toJson();
    }
    if (this.avgppmTimeRange != null) {
      data['avgppm_time_range'] =
          this.avgppmTimeRange!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AmoniaTableData {
  String? pcdMax;
  String? ppmAvg;
  String? heading;
  int? ppmDiff;
  List<dynamic>? value;

  AmoniaTableData(
      {this.pcdMax, this.ppmAvg, this.heading, this.ppmDiff, this.value});

  AmoniaTableData.fromJson(Map<String, dynamic> json) {
    pcdMax = json['pcd_max'];
    ppmAvg = json['ppm_avg'];
    heading = json['heading'];
    ppmDiff = json['ppm_diff'];
    if (json['value'] != null) {
      value = <dynamic>[];
      json['value'].forEach((v) {
        value!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pcd_max'] = this.pcdMax;
    data['ppm_avg'] = this.ppmAvg;
    data['heading'] = this.heading;
    data['ppm_diff'] = this.ppmDiff;
    if (this.value != null) {
      data['value'] = this.value!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RangeOfPpm {
  String? unhealthyMax;
  String? unhealthyMin;
  String? healthyMin;
  String? healthyMax;
  String? moderateMax;
  String? moderateMin;

  RangeOfPpm(
      {this.unhealthyMax,
      this.unhealthyMin,
      this.healthyMin,
      this.healthyMax,
      this.moderateMax,
      this.moderateMin});

  RangeOfPpm.fromJson(Map<String, dynamic> json) {
    unhealthyMax = json['unhealthy_max'];
    unhealthyMin = json['unhealthy_min'];
    healthyMin = json['healthy_min'];
    healthyMax = json['healthy_max'];
    moderateMax = json['moderate_max'];
    moderateMin = json['moderate_min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unhealthy_max'] = this.unhealthyMax;
    data['unhealthy_min'] = this.unhealthyMin;
    data['healthy_min'] = this.healthyMin;
    data['healthy_max'] = this.healthyMax;
    data['moderate_max'] = this.moderateMax;
    data['moderate_min'] = this.moderateMin;
    return data;
  }
}

class AvgppmTimeRange {
  String? timeRange;
  String? avgPpmAvg;
  String? avgPpmMax;
  String? avgPcdMax;
  String? avgPchMax;

  AvgppmTimeRange(
      {this.timeRange,
      this.avgPpmAvg,
      this.avgPpmMax,
      this.avgPcdMax,
      this.avgPchMax});

  AvgppmTimeRange.fromJson(Map<String, dynamic> json) {
    timeRange = json['time_range'];
    avgPpmAvg = json['avg_ppm_avg'];
    avgPpmMax = json['avg_ppm_max'];
    avgPcdMax = json['avg_pcd_max'];
    avgPchMax = json['avg_pch_max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_range'] = this.timeRange;
    data['avg_ppm_avg'] = this.avgPpmAvg;
    data['avg_ppm_max'] = this.avgPpmMax;
    data['avg_pcd_max'] = this.avgPcdMax;
    data['avg_pch_max'] = this.avgPchMax;
    return data;
  }
}

// ______________________________________________________
class Alert {
  final DateTime timestamp;
  final String condition;
  final String building;

  Alert({
    required this.timestamp,
    required this.condition,
    required this.building,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      timestamp: DateTime.parse(json['timestamp']),
      condition: json['condition'],
      building: json['building'],
    );
  }
}

// Models for the new dashboard structure

class GaugeGraphData {
  final String avgAmmonia;
  final String pcdMax;
  final Map<String, dynamic> ppm; // Updated type
  final String condition;

  GaugeGraphData({
    required this.avgAmmonia,
    required this.pcdMax,
    required this.ppm,
    required this.condition,
  });

  factory GaugeGraphData.fromJson(Map<String, dynamic> json) {
    return GaugeGraphData(
      avgAmmonia: json['avg_amonia'] ?? '0',
      pcdMax: json['pcd_max'] ?? '0',
      ppm: Map<String, dynamic>.from(json['ppm'] ?? {}), // Proper type casting
      condition: json['condition'] ?? '',
    );
  }
}

class ChartDataPoint {
  final String color;
  final int y;

  ChartDataPoint({
    required this.color,
    required this.y,
  });

  factory ChartDataPoint.fromJson(Map<String, dynamic> json) {
    return ChartDataPoint(
      color: json['color'] ?? '#000000',
      y: json['y'] ?? 0,
    );
  }
}

class WashroomData {
  final List<ChartDataPoint> data;
  final List<String> category;

  WashroomData({
    required this.data,
    required this.category,
  });

  factory WashroomData.fromJson(Map<String, dynamic> json) {
    return WashroomData(
      data: (json['data'] as List? ?? [])
          .map((data) => ChartDataPoint.fromJson(data))
          .toList(),
      category: (json['category'] as List? ?? []).cast<String>(),
    );
  }
}

class AmmoniaLevelData {
  final WashroomData distinctDataModified;
  final WashroomData distinctPeopleDataModified;
  final String distinctPeopleDataUnit;

  AmmoniaLevelData({
    required this.distinctDataModified,
    required this.distinctPeopleDataModified,
    required this.distinctPeopleDataUnit,
  });

  factory AmmoniaLevelData.fromJson(Map<String, dynamic> json) {
    return AmmoniaLevelData(
      distinctDataModified:
          WashroomData.fromJson(json['distinct_data_modified'] ?? {}),
      distinctPeopleDataModified:
          WashroomData.fromJson(json['distinct_people_data_modified'] ?? {}),
      distinctPeopleDataUnit: json['distinct_people_data_unit'] ?? '',
    );
  }
}

class AmmoniaTableData {
  final String pcdMax;
  final String ppmAvg;
  final String heading;
  final int ppmDiff;
  final List<dynamic> value;

  AmmoniaTableData({
    required this.pcdMax,
    required this.ppmAvg,
    required this.heading,
    required this.ppmDiff,
    required this.value,
  });

  factory AmmoniaTableData.fromJson(Map<String, dynamic> json) {
    return AmmoniaTableData(
      pcdMax: json['pcd_max'] ?? '0',
      ppmAvg: json['ppm_avg'] ?? '0',
      heading: json['heading'] ?? '',
      ppmDiff: json['ppm_diff'] ?? 0,
      value: json['value'] ?? [],
    );
  }
}

class PpmRange {
  final String unhealthyMax;
  final String unhealthyMin;
  final String healthyMin;
  final String healthyMax;
  final String moderateMax;
  final String moderateMin;

  PpmRange({
    required this.unhealthyMax,
    required this.unhealthyMin,
    required this.healthyMin,
    required this.healthyMax,
    required this.moderateMax,
    required this.moderateMin,
  });

  factory PpmRange.fromJson(Map<String, dynamic> json) {
    return PpmRange(
      unhealthyMax: json['unhealthy_max'] ?? '0',
      unhealthyMin: json['unhealthy_min'] ?? '0',
      healthyMin: json['healthy_min'] ?? '0',
      healthyMax: json['healthy_max'] ?? '0',
      moderateMax: json['moderate_max'] ?? '0',
      moderateMin: json['moderate_min'] ?? '0',
    );
  }
}

class TimeRangeData {
  final String timeRange;
  final String avgPpmAvg;
  final String avgPpmMax;
  final String avgPcdMax;
  final String avgPchMax;

  TimeRangeData({
    required this.timeRange,
    required this.avgPpmAvg,
    required this.avgPpmMax,
    required this.avgPcdMax,
    required this.avgPchMax,
  });

  factory TimeRangeData.fromJson(Map<String, dynamic> json) {
    return TimeRangeData(
      timeRange: json['time_range'] ?? '',
      avgPpmAvg: json['avg_ppm_avg'] ?? '0',
      avgPpmMax: json['avg_ppm_max'] ?? '0',
      avgPcdMax: json['avg_pcd_max'] ?? '0',
      avgPchMax: json['avg_pch_max'] ?? '0',
    );
  }
}

class DashboardSummary {
  final String alertsNotificationSummary;
  final String avgppmOverLocation;
  final String avgppmTimeRangeInsights;

  DashboardSummary({
    required this.alertsNotificationSummary,
    required this.avgppmOverLocation,
    required this.avgppmTimeRangeInsights,
  });

  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    return DashboardSummary(
      alertsNotificationSummary: json['alerts_notification_summary'] ?? '',
      avgppmOverLocation: json['avgppm_over_location'] ?? '',
      avgppmTimeRangeInsights: json['avgppm_time_range_insights'] ?? '',
    );
  }
}

class DashboardData {
  final GaugeGraphData gaugeGraphData;
  final AmmoniaLevelData ammoniaLevelData;
  final List<dynamic> alertsNotification;
  final List<AmmoniaTableData> amoniaTableData;
  final String ammoniaUnit;
  final PpmRange rangeOfPpm;
  final List<TimeRangeData> avgppmTimeRange;
  final DashboardSummary summary;

  DashboardData({
    required this.gaugeGraphData,
    required this.ammoniaLevelData,
    required this.alertsNotification,
    required this.amoniaTableData,
    required this.ammoniaUnit,
    required this.rangeOfPpm,
    required this.avgppmTimeRange,
    required this.summary,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    final results = json['results'] ?? {};
    return DashboardData(
      gaugeGraphData:
          GaugeGraphData.fromJson(results['gauge_graph_data'] ?? {}),
      ammoniaLevelData: AmmoniaLevelData.fromJson(
          results['ammonia_level_across_washroom_result'] ?? {}),
      alertsNotification: results['alerts_notification'] ?? [],
      amoniaTableData: (results['amonia_table_data'] as List? ?? [])
          .map((data) => AmmoniaTableData.fromJson(data))
          .toList(),
      ammoniaUnit: results['ammonia_unit'] ?? '',
      rangeOfPpm: PpmRange.fromJson(results['range_of_ppm'] ?? {}),
      avgppmTimeRange: (results['avgppm_time_range'] as List? ?? [])
          .map((data) => TimeRangeData.fromJson(data))
          .toList(),
      summary: DashboardSummary.fromJson(results['summary'] ?? {}),
    );
  }
}

class GraphData {
  final double airQuality; // avg_ppm_avg
  final double usage; // avg_pcd_max
  final String timeRange; // time_range

  GraphData({
    required this.airQuality,
    required this.usage,
    required this.timeRange,
  });

  // Factory method to create GraphData from JSON
  factory GraphData.fromJson(Map<String, dynamic> json) {
    return GraphData(
      airQuality: double.parse(json['avg_ppm_avg']),
      usage: double.parse(json['avg_pcd_max']),
      timeRange: json['time_range'],
    );
  }
}
