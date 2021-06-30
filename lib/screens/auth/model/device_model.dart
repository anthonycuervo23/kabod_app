class Device {
  String id;
  DateTime createdAt;
  bool expired;
  bool uninstalled;
  int lastUpdatedAt;
  DeviceDetails deviceInfo;
  String token;

  Device(
      {this.id,
      this.token,
      this.createdAt,
      this.expired,
      this.uninstalled,
      this.lastUpdatedAt,
      this.deviceInfo});

  Device.fromDS(String id, Map<String, dynamic> data)
      : id = id,
        createdAt = data['created_at']?.toDate(),
        expired = data['expired'],
        uninstalled = data['uninstalled'] ?? false,
        lastUpdatedAt = data['last_updated_at'],
        deviceInfo = DeviceDetails.fromJson(data['device_info']),
        token = data['token'];

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt,
      'device_info': deviceInfo.toJson(),
      'expired': expired,
      'uninstalled': uninstalled,
      'last_updated_at': lastUpdatedAt,
      'token': token,
    };
  }
}

class DeviceDetails {
  String device;
  String model;
  String osVersion;
  String platform;

  DeviceDetails({this.device, this.model, this.osVersion, this.platform});

  DeviceDetails.fromJson(Map<String, dynamic> json) {
    device = json['device'];
    model = json['model'];
    osVersion = json['os_version'];
    platform = json['platform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device'] = this.device;
    data['model'] = this.model;
    data['os_version'] = this.osVersion;
    data['platform'] = this.platform;
    return data;
  }
}
