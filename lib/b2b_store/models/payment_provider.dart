// To parse this JSON data, do
//
//     final paymentProviders = paymentProvidersFromMap(jsonString);

import 'dart:convert';

PaymentProviders paymentProvidersFromMap(String str) =>
    PaymentProviders.fromMap(json.decode(str));

String paymentProvidersToMap(PaymentProviders data) =>
    json.encode(data.toMap());

class PaymentProviders {
  final List<PaymentProvider>? paymentProviders;
  final int? count;
  final int? offset;
  final int? limit;

  PaymentProviders({
    this.paymentProviders,
    this.count,
    this.offset,
    this.limit,
  });

  factory PaymentProviders.fromMap(Map<String, dynamic> json) =>
      PaymentProviders(
        paymentProviders: json["payment_providers"] == null
            ? []
            : List<PaymentProvider>.from(json["payment_providers"]!
                .map((x) => PaymentProvider.fromMap(x))),
        count: json["count"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toMap() => {
        "payment_providers": paymentProviders == null
            ? []
            : List<dynamic>.from(paymentProviders!.map((x) => x.toMap())),
        "count": count,
        "offset": offset,
        "limit": limit,
      };
}

class PaymentProvider {
  final String? id;
  final bool? isEnabled;

  PaymentProvider({
    this.id,
    this.isEnabled,
  });

  factory PaymentProvider.fromMap(Map<String, dynamic> json) => PaymentProvider(
        id: json["id"],
        isEnabled: json["is_enabled"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "is_enabled": isEnabled,
      };
}
// To parse this JSON data, do
//
//     final paymentCollection = paymentCollectionFromMap(jsonString);

PaymentCollection paymentCollectionFromMap(String str) =>
    PaymentCollection.fromMap(json.decode(str));

String paymentCollectionToMap(PaymentCollection data) =>
    json.encode(data.toMap());

class PaymentCollection {
  final PaymentCollectionClass? paymentCollection;

  PaymentCollection({
    this.paymentCollection,
  });

  factory PaymentCollection.fromMap(Map<String, dynamic> json) =>
      PaymentCollection(
        paymentCollection: json["payment_collection"] == null
            ? null
            : PaymentCollectionClass.fromMap(json["payment_collection"]),
      );

  Map<String, dynamic> toMap() => {
        "payment_collection": paymentCollection?.toMap(),
      };
}

class PaymentCollectionClass {
  final String? id;
  final String? currencyCode;
  final int? amount;
  final List<PaymentSession>? paymentSessions;

  PaymentCollectionClass({
    this.id,
    this.currencyCode,
    this.amount,
    this.paymentSessions,
  });

  factory PaymentCollectionClass.fromMap(Map<String, dynamic> json) =>
      PaymentCollectionClass(
        id: json["id"],
        currencyCode: json["currency_code"],
        amount: json["amount"],
        paymentSessions: json["payment_sessions"] == null
            ? []
            : List<PaymentSession>.from(json["payment_sessions"]!
                .map((x) => PaymentSession.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "currency_code": currencyCode,
        "amount": amount,
        "payment_sessions": paymentSessions == null
            ? []
            : List<dynamic>.from(paymentSessions!.map((x) => x.toMap())),
      };
}

class PaymentSession {
  final String? id;
  final String? currencyCode;
  final String? providerId;
  final Data? data;
  final Context? context;
  final String? status;
  final dynamic authorizedAt;
  final String? paymentCollectionId;
  final dynamic metadata;
  final RawAmount? rawAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final int? amount;

  PaymentSession({
    this.id,
    this.currencyCode,
    this.providerId,
    this.data,
    this.context,
    this.status,
    this.authorizedAt,
    this.paymentCollectionId,
    this.metadata,
    this.rawAmount,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.amount,
  });

  factory PaymentSession.fromMap(Map<String, dynamic> json) => PaymentSession(
        id: json["id"],
        currencyCode: json["currency_code"],
        providerId: json["provider_id"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        context:
            json["context"] == null ? null : Context.fromMap(json["context"]),
        status: json["status"],
        authorizedAt: json["authorized_at"],
        paymentCollectionId: json["payment_collection_id"],
        metadata: json["metadata"],
        rawAmount: json["raw_amount"] == null
            ? null
            : RawAmount.fromMap(json["raw_amount"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        amount: json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "currency_code": currencyCode,
        "provider_id": providerId,
        "data": data?.toMap(),
        "context": context?.toMap(),
        "status": status,
        "authorized_at": authorizedAt,
        "payment_collection_id": paymentCollectionId,
        "metadata": metadata,
        "raw_amount": rawAmount?.toMap(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "amount": amount,
      };
}

class Context {
  final Customer? customer;

  Context({
    this.customer,
  });

  factory Context.fromMap(Map<String, dynamic> json) => Context(
        customer: json["customer"] == null
            ? null
            : Customer.fromMap(json["customer"]),
      );

  Map<String, dynamic> toMap() => {
        "customer": customer?.toMap(),
      };
}

class Customer {
  final Id? id;
  final String? email;
  final dynamic phone;
  final dynamic metadata;
  final List<Address>? addresses;
  final dynamic lastName;
  final dynamic firstName;
  final dynamic companyName;
  final Address? billingAddress;

  Customer({
    this.id,
    this.email,
    this.phone,
    this.metadata,
    this.addresses,
    this.lastName,
    this.firstName,
    this.companyName,
    this.billingAddress,
  });

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
        id: idValues.map[json["id"]]!,
        email: json["email"],
        phone: json["phone"],
        metadata: json["metadata"],
        addresses: json["addresses"] == null
            ? []
            : List<Address>.from(
                json["addresses"]!.map((x) => Address.fromMap(x))),
        lastName: json["last_name"],
        firstName: json["first_name"],
        companyName: json["company_name"],
        billingAddress: json["billing_address"] == null
            ? null
            : Address.fromMap(json["billing_address"]),
      );

  Map<String, dynamic> toMap() => {
        "id": idValues.reverse[id],
        "email": email,
        "phone": phone,
        "metadata": metadata,
        "addresses": addresses == null
            ? []
            : List<dynamic>.from(addresses!.map((x) => x.toMap())),
        "last_name": lastName,
        "first_name": firstName,
        "company_name": companyName,
        "billing_address": billingAddress?.toMap(),
      };
}

class Address {
  final String? id;
  final City? city;
  final String? phone;
  final dynamic company;
  final dynamic metadata;
  final Province? province;
  final Address1? address1;
  final dynamic address2;
  final LastName? lastName;
  final DateTime? createdAt;
  final dynamic deletedAt;
  final FirstName? firstName;
  final DateTime? updatedAt;
  final Id? customerId;
  final String? postalCode;
  final AddressName? addressName;
  final dynamic countryCode;
  final bool? isDefaultBilling;
  final bool? isDefaultShipping;

  Address({
    this.id,
    this.city,
    this.phone,
    this.company,
    this.metadata,
    this.province,
    this.address1,
    this.address2,
    this.lastName,
    this.createdAt,
    this.deletedAt,
    this.firstName,
    this.updatedAt,
    this.customerId,
    this.postalCode,
    this.addressName,
    this.countryCode,
    this.isDefaultBilling,
    this.isDefaultShipping,
  });

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        id: json["id"],
        city: cityValues.map[json["city"]]!,
        phone: json["phone"],
        company: json["company"],
        metadata: json["metadata"],
        province: provinceValues.map[json["province"]]!,
        address1: address1Values.map[json["address_1"]]!,
        address2: json["address_2"],
        lastName: lastNameValues.map[json["last_name"]]!,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        deletedAt: json["deleted_at"],
        firstName: firstNameValues.map[json["first_name"]]!,
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        customerId: idValues.map[json["customer_id"]]!,
        postalCode: json["postal_code"],
        addressName: addressNameValues.map[json["address_name"]]!,
        countryCode: json["country_code"],
        isDefaultBilling: json["is_default_billing"],
        isDefaultShipping: json["is_default_shipping"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "city": cityValues.reverse[city],
        "phone": phone,
        "company": company,
        "metadata": metadata,
        "province": provinceValues.reverse[province],
        "address_1": address1Values.reverse[address1],
        "address_2": address2,
        "last_name": lastNameValues.reverse[lastName],
        "created_at": createdAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "first_name": firstNameValues.reverse[firstName],
        "updated_at": updatedAt?.toIso8601String(),
        "customer_id": idValues.reverse[customerId],
        "postal_code": postalCode,
        "address_name": addressNameValues.reverse[addressName],
        "country_code": countryCode,
        "is_default_billing": isDefaultBilling,
        "is_default_shipping": isDefaultShipping,
      };
}

enum Address1 { B_304_NANCY_BRAMHA, CFERVGEVEGRVRE, NVSKO }

final address1Values = EnumValues({
  "  B 304 nancy bramha": Address1.B_304_NANCY_BRAMHA,
  "cfervgevegrvre": Address1.CFERVGEVEGRVRE,
  "nvsko": Address1.NVSKO
});

enum AddressName { DEFAULT }

final addressNameValues = EnumValues({"Default": AddressName.DEFAULT});

enum City { BANGALORE, EFVGREGVGT, NVKSO }

final cityValues = EnumValues({
  "Bangalore": City.BANGALORE,
  "efvgregvgt": City.EFVGREGVGT,
  "nvkso": City.NVKSO
});

enum Id { CUS_01_JT8_BSP0_NZJB59_BCR4_P2_ACSM7 }

final idValues = EnumValues({
  "cus_01JT8BSP0NZJB59BCR4P2ACSM7": Id.CUS_01_JT8_BSP0_NZJB59_BCR4_P2_ACSM7
});

enum FirstName { NCFJEHNCJUNF, SHUBHA }

final firstNameValues = EnumValues(
    {"ncfjehncjunf": FirstName.NCFJEHNCJUNF, "shubha": FirstName.SHUBHA});

enum LastName { BANERJEE, FERCERFCERFCE, LAST_NAME_BANERJEE }

final lastNameValues = EnumValues({
  "banerjee": LastName.BANERJEE,
  "fercerfcerfce": LastName.FERCERFCERFCE,
  "Banerjee": LastName.LAST_NAME_BANERJEE
});

enum Province { BANGALORE, EMPTY }

final provinceValues =
    EnumValues({"bangalore": Province.BANGALORE, "": Province.EMPTY});

class Data {
  final String? id;
  final Context? notes;
  final int? amount;
  final String? entity;
  final String? status;
  final String? receipt;
  final int? attempts;
  final String? currency;
  final dynamic offerId;
  final int? amountDue;
  final int? createdAt;
  final int? amountPaid;

  Data({
    this.id,
    this.notes,
    this.amount,
    this.entity,
    this.status,
    this.receipt,
    this.attempts,
    this.currency,
    this.offerId,
    this.amountDue,
    this.createdAt,
    this.amountPaid,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        notes: json["notes"] == null ? null : Context.fromMap(json["notes"]),
        amount: json["amount"],
        entity: json["entity"],
        status: json["status"],
        receipt: json["receipt"],
        attempts: json["attempts"],
        currency: json["currency"],
        offerId: json["offer_id"],
        amountDue: json["amount_due"],
        createdAt: json["created_at"],
        amountPaid: json["amount_paid"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "notes": notes?.toMap(),
        "amount": amount,
        "entity": entity,
        "status": status,
        "receipt": receipt,
        "attempts": attempts,
        "currency": currency,
        "offer_id": offerId,
        "amount_due": amountDue,
        "created_at": createdAt,
        "amount_paid": amountPaid,
      };
}

class RawAmount {
  final String? value;
  final int? precision;

  RawAmount({
    this.value,
    this.precision,
  });

  factory RawAmount.fromMap(Map<String, dynamic> json) => RawAmount(
        value: json["value"],
        precision: json["precision"],
      );

  Map<String, dynamic> toMap() => {
        "value": value,
        "precision": precision,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
