// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelPreview _$HotelPreviewFromJson(Map<String, dynamic> json) => HotelPreview(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      poster: json['poster'] as String,
      price: (json['price'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      address: json['address'] == null
          ? null
          : HotelAddress.fromJson(json['address'] as Map<String, dynamic>),
      services: json['services'] == null
          ? null
          : HotelServices.fromJson(json['services'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HotelPreviewToJson(HotelPreview instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'poster': instance.poster,
      'price': instance.price,
      'rating': instance.rating,
      'photos': instance.photos,
      'address': instance.address?.toJson(),
      'services': instance.services?.toJson(),
    };

HotelAddress _$HotelAddressFromJson(Map<String, dynamic> json) => HotelAddress(
      country: json['country'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      zip: json['zip_code'] as int,
      coords: json['coords'],
    );

Map<String, dynamic> _$HotelAddressToJson(HotelAddress instance) =>
    <String, dynamic>{
      'country': instance.country,
      'street': instance.street,
      'city': instance.city,
      'zip_code': instance.zip,
      'coords': instance.coords,
    };

HotelServices _$HotelServicesFromJson(Map<String, dynamic> json) =>
    HotelServices(
      free: (json['free'] as List<dynamic>).map((e) => e as String).toList(),
      paid: (json['paid'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$HotelServicesToJson(HotelServices instance) =>
    <String, dynamic>{
      'free': instance.free,
      'paid': instance.paid,
    };
