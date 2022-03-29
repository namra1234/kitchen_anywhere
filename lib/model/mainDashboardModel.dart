import 'dart:convert';

class MainDashboardModel {
  final String carbonEmissionMonthly,communityOffset,carName,carType,location;
  final int aqi;
  final List<dynamic> recentTripList;
  final List<dynamic> carbonCommunityList;

  MainDashboardModel(
      this.carbonEmissionMonthly,
      this.communityOffset,
      this.recentTripList,
      this.carbonCommunityList,
      this.carName,
      this.carType,
      this.location,
      this.aqi
      );

  Map<String, dynamic> toJson() {
    return {
      'carbonEmissionMonthly': carbonEmissionMonthly,
      'communityOffset': communityOffset,
      'carName': carName,
      'carType': carType,
      'recentTripList': recentTripList,
      'carbonCommunityList': carbonCommunityList,
      'location': location,
      'aqi': aqi,
    };
  }

  factory MainDashboardModel.fromMap(Map<String, dynamic> map) {

    return MainDashboardModel(
         map['recentTripList'],
        map['carbonEmissionMonthly'],
        map['carName'],
        map['carType'],
        map['communityOffset'],
        map['carbonCommunityList'],
        map['location'],
       map['aqi'],
        );
  }

  factory MainDashboardModel.fromJson(String source) => MainDashboardModel.fromMap(
        json.decode(source),
      );
}
