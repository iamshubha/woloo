// To parse this JSON data, do
//
//     final paymentCollection = paymentCollectionFromJson(jsonString);

import 'dart:convert';

PaymentProviders paymentProvidersFromJson(String str) =>
    PaymentProviders.fromJson(json.decode(str));

String paymentProvidersToJson(PaymentProviders data) =>
    json.encode(data.toJson());

class PaymentProviders {
  final List<PaymentProvider> paymentProviders;
  final int count;
  final int offset;
  final int limit;

  PaymentProviders({
    required this.paymentProviders,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory PaymentProviders.fromJson(Map<String, dynamic> json) =>
      PaymentProviders(
        paymentProviders: List<PaymentProvider>.from(
            json["payment_providers"].map((x) => PaymentProvider.fromJson(x))),
        count: json["count"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "payment_providers":
            List<dynamic>.from(paymentProviders.map((x) => x.toJson())),
        "count": count,
        "offset": offset,
        "limit": limit,
      };
}

class PaymentProvider {
  final String id;
  final bool isEnabled;

  PaymentProvider({
    required this.id,
    required this.isEnabled,
  });

  factory PaymentProvider.fromJson(Map<String, dynamic> json) =>
      PaymentProvider(
        id: json["id"],
        isEnabled: json["is_enabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_enabled": isEnabled,
      };
}

PaymentCollection paymentCollectionFromJson(String str) =>
    PaymentCollection.fromJson(json.decode(str));

String paymentCollectionToJson(PaymentCollection data) =>
    json.encode(data.toJson());

class PaymentCollection {
  final PaymentCollectionClass paymentCollection;

  PaymentCollection({
    required this.paymentCollection,
  });

  factory PaymentCollection.fromJson(Map<String, dynamic> json) =>
      PaymentCollection(
        paymentCollection:
            PaymentCollectionClass.fromJson(json["payment_collection"]),
      );

  Map<String, dynamic> toJson() => {
        "payment_collection": paymentCollection.toJson(),
      };
}

class PaymentCollectionClass {
  final String id;
  final String currencyCode;
  final int amount;
  final List<PaymentSession> paymentSessions;

  PaymentCollectionClass({
    required this.id,
    required this.currencyCode,
    required this.amount,
    required this.paymentSessions,
  });

  factory PaymentCollectionClass.fromJson(Map<String, dynamic> json) =>
      PaymentCollectionClass(
        id: json["id"],
        currencyCode: json["currency_code"],
        amount: json["amount"],
        paymentSessions: List<PaymentSession>.from(
            json["payment_sessions"].map((x) => PaymentSession.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency_code": currencyCode,
        "amount": amount,
        "payment_sessions":
            List<dynamic>.from(paymentSessions.map((x) => x.toJson())),
      };
}

class PaymentSession {
  final String id;
  final String currencyCode;
  final String providerId;
  final Data data;
  final Context context;
  final String status;
  final dynamic authorizedAt;
  final String paymentCollectionId;
  final dynamic metadata;
  final RawAmount rawAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final int amount;

  PaymentSession({
    required this.id,
    required this.currencyCode,
    required this.providerId,
    required this.data,
    required this.context,
    required this.status,
    required this.authorizedAt,
    required this.paymentCollectionId,
    required this.metadata,
    required this.rawAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.amount,
  });

  factory PaymentSession.fromJson(Map<String, dynamic> json) => PaymentSession(
        id: json["id"],
        currencyCode: json["currency_code"],
        providerId: json["provider_id"],
        data: Data.fromJson(json["data"]),
        context: Context.fromJson(json["context"]),
        status: json["status"],
        authorizedAt: json["authorized_at"],
        paymentCollectionId: json["payment_collection_id"],
        metadata: json["metadata"],
        rawAmount: RawAmount.fromJson(json["raw_amount"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency_code": currencyCode,
        "provider_id": providerId,
        "data": data.toJson(),
        "context": context.toJson(),
        "status": status,
        "authorized_at": authorizedAt,
        "payment_collection_id": paymentCollectionId,
        "metadata": metadata,
        "raw_amount": rawAmount.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "amount": amount,
      };
}

class Context {
  final Customer customer;

  Context({
    required this.customer,
  });

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        customer: Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "customer": customer.toJson(),
      };
}

class Customer {
  final Id id;
  final String email;
  final dynamic phone;
  final dynamic metadata;
  final List<Address> addresses;
  final dynamic lastName;
  final dynamic firstName;
  final dynamic companyName;
  final List<dynamic> accountHolders;
  final Address billingAddress;

  Customer({
    required this.id,
    required this.email,
    required this.phone,
    required this.metadata,
    required this.addresses,
    required this.lastName,
    required this.firstName,
    required this.companyName,
    required this.accountHolders,
    required this.billingAddress,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: idValues.map[json["id"]]!,
        email: json["email"],
        phone: json["phone"],
        metadata: json["metadata"],
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
        lastName: json["last_name"],
        firstName: json["first_name"],
        companyName: json["company_name"],
        accountHolders:
            List<dynamic>.from(json["account_holders"].map((x) => x)),
        billingAddress: Address.fromJson(json["billing_address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "email": email,
        "phone": phone,
        "metadata": metadata,
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "last_name": lastName,
        "first_name": firstName,
        "company_name": companyName,
        "account_holders": List<dynamic>.from(accountHolders.map((x) => x)),
        "billing_address": billingAddress.toJson(),
      };
}

class Address {
  final String id;
  final dynamic city;
  final String phone;
  final dynamic company;
  final dynamic metadata;
  final Province province;
  final dynamic address1;
  final dynamic address2;
  final dynamic lastName;
  final DateTime createdAt;
  final dynamic deletedAt;
  final dynamic firstName;
  final DateTime updatedAt;
  final Id customerId;
  final String postalCode;
  final AddressName addressName;
  final dynamic countryCode;
  final bool isDefaultBilling;
  final bool isDefaultShipping;

  Address({
    required this.id,
    required this.city,
    required this.phone,
    required this.company,
    required this.metadata,
    required this.province,
    required this.address1,
    required this.address2,
    required this.lastName,
    required this.createdAt,
    required this.deletedAt,
    required this.firstName,
    required this.updatedAt,
    required this.customerId,
    required this.postalCode,
    required this.addressName,
    required this.countryCode,
    required this.isDefaultBilling,
    required this.isDefaultShipping,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        city: json["city"],
        phone: json["phone"],
        company: json["company"],
        metadata: json["metadata"],
        province: provinceValues.map[json["province"]]!,
        address1: json["address_1"],
        address2: json["address_2"],
        lastName: json["last_name"],
        createdAt: DateTime.parse(json["created_at"]),
        deletedAt: json["deleted_at"],
        firstName: json["first_name"],
        updatedAt: DateTime.parse(json["updated_at"]),
        customerId: idValues.map[json["customer_id"]]!,
        postalCode: json["postal_code"],
        addressName: addressNameValues.map[json["address_name"]]!,
        countryCode: json["country_code"],
        isDefaultBilling: json["is_default_billing"],
        isDefaultShipping: json["is_default_shipping"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "phone": phone,
        "company": company,
        "metadata": metadata,
        "province": provinceValues.reverse[province],
        "address_1": address1,
        "address_2": address2,
        "last_name": lastName,
        "created_at": createdAt.toIso8601String(),
        "deleted_at": deletedAt,
        "first_name": firstName,
        "updated_at": updatedAt.toIso8601String(),
        "customer_id": idValues.reverse[customerId],
        "postal_code": postalCode,
        "address_name": addressNameValues.reverse[addressName],
        "country_code": countryCode,
        "is_default_billing": isDefaultBilling,
        "is_default_shipping": isDefaultShipping,
      };
}

enum AddressName { DEFAULT }

final addressNameValues = EnumValues({"Default": AddressName.DEFAULT});

enum Id { CUS_01_JT8_BSP0_NZJB59_BCR4_P2_ACSM7 }

final idValues = EnumValues({
  "cus_01JT8BSP0NZJB59BCR4P2ACSM7": Id.CUS_01_JT8_BSP0_NZJB59_BCR4_P2_ACSM7
});

enum Province { BANGALORE, EMPTY }

final provinceValues =
    EnumValues({"bangalore": Province.BANGALORE, "": Province.EMPTY});

class Data {
  final String id;
  final Notes notes;
  final int amount;
  final String entity;
  final String status;
  final String receipt;
  final int attempts;
  final String currency;
  final dynamic offerId;
  final int amountDue;
  final int createdAt;
  final int amountPaid;

  Data({
    required this.id,
    required this.notes,
    required this.amount,
    required this.entity,
    required this.status,
    required this.receipt,
    required this.attempts,
    required this.currency,
    required this.offerId,
    required this.amountDue,
    required this.createdAt,
    required this.amountPaid,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        notes: Notes.fromJson(json["notes"]),
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "notes": notes.toJson(),
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

class Notes {
  final Customer customer;
  final String idempotencyKey;

  Notes({
    required this.customer,
    required this.idempotencyKey,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        customer: Customer.fromJson(json["customer"]),
        idempotencyKey: json["idempotency_key"],
      );

  Map<String, dynamic> toJson() => {
        "customer": customer.toJson(),
        "idempotency_key": idempotencyKey,
      };
}

class RawAmount {
  final String value;
  final int precision;

  RawAmount({
    required this.value,
    required this.precision,
  });

  factory RawAmount.fromJson(Map<String, dynamic> json) => RawAmount(
        value: json["value"],
        precision: json["precision"],
      );

  Map<String, dynamic> toJson() => {
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
