import 'package:json_annotation/json_annotation.dart';

part 'hotel.g.dart';

@JsonSerializable(explicitToJson: true)
@JsonSerializable(includeIfNull: false)
class HotelPreview {
  final String uuid;
  final String name;
  final String poster;

  final double? price;
  final double? rating;
  final List<String>? photos;

  final HotelAddress? address;
  final HotelServices? services;

  factory HotelPreview.fromJson(Map<String, dynamic> json) =>
      _$HotelPreviewFromJson(json);

  HotelPreview(
      {required this.uuid,
      required this.name,
      required this.poster,
      required this.price,
      required this.rating,
      required this.photos,
      required this.address,
      required this.services});
  Map<String, dynamic> toJson() => _$HotelPreviewToJson(this);
}

@JsonSerializable(explicitToJson: true)
class HotelAddress {
  final String country;
  final String street;
  final String city;
  @JsonKey(name: 'zip_code')
  final int zip;
  final dynamic coords;

  HotelAddress(
      {required this.country,
      required this.street,
      required this.city,
      required this.zip,
      required this.coords});

  factory HotelAddress.fromJson(Map<String, dynamic> json) =>
      _$HotelAddressFromJson(json);
  Map<String, dynamic> toJson() => _$HotelAddressToJson(this);
}

@JsonSerializable(explicitToJson: true)
class HotelServices {
  final List<String> free;
  final List<String> paid;

  HotelServices({required this.free, required this.paid});

  factory HotelServices.fromJson(Map<String, dynamic> json) =>
      _$HotelServicesFromJson(json);
  Map<String, dynamic> toJson() => _$HotelServicesToJson(this);
}
