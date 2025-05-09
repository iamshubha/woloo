// To parse this JSON data, do
//
//     final completeVendor = completeVendorFromMap(jsonString);

import 'dart:convert';

CompleteVendor completeVendorFromMap(String str) =>
    CompleteVendor.fromMap(json.decode(str));

String completeVendorToMap(CompleteVendor data) => json.encode(data.toMap());

class CompleteVendor {
  final String? type;
  final Order? order;

  CompleteVendor({
    this.type,
    this.order,
  });

  factory CompleteVendor.fromMap(Map<String, dynamic> json) => CompleteVendor(
        type: json["type"],
        order: json["order"] == null ? null : Order.fromMap(json["order"]),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "order": order?.toMap(),
      };
}

class Order {
  final ParentOrder? parentOrder;
  final List<dynamic>? vendorOrders;

  Order({
    this.parentOrder,
    this.vendorOrders,
  });

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        parentOrder: json["parent_order"] == null
            ? null
            : ParentOrder.fromMap(json["parent_order"]),
        vendorOrders: json["vendor_orders"] == null
            ? []
            : List<dynamic>.from(json["vendor_orders"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "parent_order": parentOrder?.toMap(),
        "vendor_orders": vendorOrders == null
            ? []
            : List<dynamic>.from(vendorOrders!.map((x) => x)),
      };
}

class ParentOrder {
  final String? regionId;
  final String? customerId;
  final String? salesChannelId;
  final String? email;
  final String? currencyCode;
  final String? id;
  final String? status;
  final int? version;
  final IngAddress? shippingAddress;
  final IngAddress? billingAddress;
  final List<ShippingMethod>? shippingMethods;
  final List<PaymentCollectionForOrder>? paymentCollections;
  final List<dynamic>? fulfillments;
  final String? paymentStatus;
  final String? fulfillmentStatus;

  ParentOrder({
    this.regionId,
    this.customerId,
    this.salesChannelId,
    this.email,
    this.currencyCode,
    this.id,
    this.status,
    this.version,
    this.shippingAddress,
    this.billingAddress,
    this.shippingMethods,
    this.paymentCollections,
    this.fulfillments,
    this.paymentStatus,
    this.fulfillmentStatus,
  });

  factory ParentOrder.fromMap(Map<String, dynamic> json) => ParentOrder(
        regionId: json["region_id"],
        customerId: json["customer_id"],
        salesChannelId: json["sales_channel_id"],
        email: json["email"],
        currencyCode: json["currency_code"],
        id: json["id"],
        status: json["status"],
        version: json["version"],
        shippingAddress: json["shipping_address"] == null
            ? null
            : IngAddress.fromMap(json["shipping_address"]),
        billingAddress: json["billing_address"] == null
            ? null
            : IngAddress.fromMap(json["billing_address"]),
        shippingMethods: json["shipping_methods"] == null
            ? []
            : List<ShippingMethod>.from(json["shipping_methods"]!
                .map((x) => ShippingMethod.fromMap(x))),
        paymentCollections: json["payment_collections"] == null
            ? []
            : List<PaymentCollectionForOrder>.from(json["payment_collections"]!
                .map((x) => PaymentCollectionForOrder.fromMap(x))),
        fulfillments: json["fulfillments"] == null
            ? []
            : List<dynamic>.from(json["fulfillments"]!.map((x) => x)),
        paymentStatus: json["payment_status"],
        fulfillmentStatus: json["fulfillment_status"],
      );

  Map<String, dynamic> toMap() => {
        "region_id": regionId,
        "customer_id": customerId,
        "sales_channel_id": salesChannelId,
        "email": email,
        "currency_code": currencyCode,
        "id": id,
        "status": status,
        "version": version,
        "shipping_address": shippingAddress?.toMap(),
        "billing_address": billingAddress?.toMap(),
        "shipping_methods": shippingMethods == null
            ? []
            : List<dynamic>.from(shippingMethods!.map((x) => x.toMap())),
        "payment_collections": paymentCollections == null
            ? []
            : List<dynamic>.from(paymentCollections!.map((x) => x.toMap())),
        "fulfillments": fulfillments == null
            ? []
            : List<dynamic>.from(fulfillments!.map((x) => x)),
        "payment_status": paymentStatus,
        "fulfillment_status": fulfillmentStatus,
      };
}

class IngAddress {
  final String? id;
  final dynamic customerId;
  final dynamic company;
  final String? firstName;
  final String? lastName;
  final String? address1;
  final dynamic address2;
  final String? city;
  final String? countryCode;
  final String? province;
  final String? postalCode;
  final String? phone;
  final dynamic metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  IngAddress({
    this.id,
    this.customerId,
    this.company,
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.countryCode,
    this.province,
    this.postalCode,
    this.phone,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory IngAddress.fromMap(Map<String, dynamic> json) => IngAddress(
        id: json["id"],
        customerId: json["customer_id"],
        company: json["company"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        countryCode: json["country_code"],
        province: json["province"],
        postalCode: json["postal_code"],
        phone: json["phone"],
        metadata: json["metadata"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "customer_id": customerId,
        "company": company,
        "first_name": firstName,
        "last_name": lastName,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "country_code": countryCode,
        "province": province,
        "postal_code": postalCode,
        "phone": phone,
        "metadata": metadata,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class PaymentCollectionForOrder {
  final String? id;
  final String? currencyCode;
  final dynamic completedAt;
  final String? status;
  final dynamic metadata;
  final RawAmount? rawAmount;
  final RawAmount? rawAuthorizedAmount;
  final RawAmount? rawCapturedAmount;
  final RawAmount? rawRefundedAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final double? amount;
  final double? authorizedAmount;
  final int? capturedAmount;
  final int? refundedAmount;

  PaymentCollectionForOrder({
    this.id,
    this.currencyCode,
    this.completedAt,
    this.status,
    this.metadata,
    this.rawAmount,
    this.rawAuthorizedAmount,
    this.rawCapturedAmount,
    this.rawRefundedAmount,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.amount,
    this.authorizedAmount,
    this.capturedAmount,
    this.refundedAmount,
  });

  factory PaymentCollectionForOrder.fromMap(Map<String, dynamic> json) =>
      PaymentCollectionForOrder(
        id: json["id"],
        currencyCode: json["currency_code"],
        completedAt: json["completed_at"],
        status: json["status"],
        metadata: json["metadata"],
        rawAmount: json["raw_amount"] == null
            ? null
            : RawAmount.fromMap(json["raw_amount"]),
        rawAuthorizedAmount: json["raw_authorized_amount"] == null
            ? null
            : RawAmount.fromMap(json["raw_authorized_amount"]),
        rawCapturedAmount: json["raw_captured_amount"] == null
            ? null
            : RawAmount.fromMap(json["raw_captured_amount"]),
        rawRefundedAmount: json["raw_refunded_amount"] == null
            ? null
            : RawAmount.fromMap(json["raw_refunded_amount"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        amount: json["amount"]?.toDouble(),
        authorizedAmount: json["authorized_amount"]?.toDouble(),
        capturedAmount: json["captured_amount"],
        refundedAmount: json["refunded_amount"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "currency_code": currencyCode,
        "completed_at": completedAt,
        "status": status,
        "metadata": metadata,
        "raw_amount": rawAmount?.toMap(),
        "raw_authorized_amount": rawAuthorizedAmount?.toMap(),
        "raw_captured_amount": rawCapturedAmount?.toMap(),
        "raw_refunded_amount": rawRefundedAmount?.toMap(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "amount": amount,
        "authorized_amount": authorizedAmount,
        "captured_amount": capturedAmount,
        "refunded_amount": refundedAmount,
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

class ShippingMethod {
  final String? id;
  final String? name;
  final dynamic description;
  final bool? isTaxInclusive;
  final bool? isCustomAmount;
  final String? shippingOptionId;
  final Data? data;
  final dynamic metadata;
  final RawAmount? rawAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final double? amount;
  final String? orderId;
  final Detail? detail;

  ShippingMethod({
    this.id,
    this.name,
    this.description,
    this.isTaxInclusive,
    this.isCustomAmount,
    this.shippingOptionId,
    this.data,
    this.metadata,
    this.rawAmount,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.amount,
    this.orderId,
    this.detail,
  });

  factory ShippingMethod.fromMap(Map<String, dynamic> json) => ShippingMethod(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isTaxInclusive: json["is_tax_inclusive"],
        isCustomAmount: json["is_custom_amount"],
        shippingOptionId: json["shipping_option_id"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
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
        amount: json["amount"]?.toDouble(),
        orderId: json["order_id"],
        detail: json["detail"] == null ? null : Detail.fromMap(json["detail"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "is_tax_inclusive": isTaxInclusive,
        "is_custom_amount": isCustomAmount,
        "shipping_option_id": shippingOptionId,
        "data": data?.toMap(),
        "metadata": metadata,
        "raw_amount": rawAmount?.toMap(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "amount": amount,
        "order_id": orderId,
        "detail": detail?.toMap(),
      };
}

class Data {
  Data();

  factory Data.fromMap(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toMap() => {};
}

class Detail {
  final String? id;
  final int? version;
  final String? orderId;
  final dynamic returnId;
  final dynamic exchangeId;
  final dynamic claimId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? shippingMethodId;

  Detail({
    this.id,
    this.version,
    this.orderId,
    this.returnId,
    this.exchangeId,
    this.claimId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.shippingMethodId,
  });

  factory Detail.fromMap(Map<String, dynamic> json) => Detail(
        id: json["id"],
        version: json["version"],
        orderId: json["order_id"],
        returnId: json["return_id"],
        exchangeId: json["exchange_id"],
        claimId: json["claim_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        shippingMethodId: json["shipping_method_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "version": version,
        "order_id": orderId,
        "return_id": returnId,
        "exchange_id": exchangeId,
        "claim_id": claimId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "shipping_method_id": shippingMethodId,
      };
}
