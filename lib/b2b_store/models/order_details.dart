// To parse this JSON data, do
//
//     final orderDetails = orderDetailsFromJson(jsonString);

import 'dart:convert';

OrderDetails orderDetailsFromJson(String str) =>
    OrderDetails.fromJson(json.decode(str));

String orderDetailsToJson(OrderDetails data) => json.encode(data.toJson());

class OrderDetails {
  final List<Order> orders;
  final int count;
  final int offset;
  final int limit;

  OrderDetails({
    required this.orders,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
        count: json["count"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
        "count": count,
        "offset": offset,
        "limit": limit,
      };
}

class Order {
  final String id;
  final Status status;
  final Summary summary;
  final int displayId;
  final int total;
  final CurrencyCode currencyCode;
  final dynamic metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final List<Item> items;
  final PaymentStatus paymentStatus;
  final FulfillmentStatus fulfillmentStatus;

  Order({
    required this.id,
    required this.status,
    required this.summary,
    required this.displayId,
    required this.total,
    required this.currencyCode,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.items,
    required this.paymentStatus,
    required this.fulfillmentStatus,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        status: statusValues.map[json["status"]]!,
        summary: Summary.fromJson(json["summary"]),
        displayId: json["display_id"],
        total: json["total"],
        currencyCode: currencyCodeValues.map[json["currency_code"]]!,
        metadata: json["metadata"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        version: json["version"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        paymentStatus: paymentStatusValues.map[json["payment_status"]]!,
        fulfillmentStatus:
            fulfillmentStatusValues.map[json["fulfillment_status"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": statusValues.reverse[status],
        "summary": summary.toJson(),
        "display_id": displayId,
        "total": total,
        "currency_code": currencyCodeValues.reverse[currencyCode],
        "metadata": metadata,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "version": version,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "payment_status": paymentStatusValues.reverse[paymentStatus],
        "fulfillment_status":
            fulfillmentStatusValues.reverse[fulfillmentStatus],
      };
}

enum CurrencyCode { INR }

final currencyCodeValues = EnumValues({"inr": CurrencyCode.INR});

enum FulfillmentStatus { NOT_FULFILLED }

final fulfillmentStatusValues =
    EnumValues({"not_fulfilled": FulfillmentStatus.NOT_FULFILLED});

class Item {
  final String id;
  final TitleEnum title;
  final ProductTitleEnum subtitle;
  final String? thumbnail;
  final VariantId variantId;
  final ProductId productId;
  final ProductTitleEnum productTitle;
  final dynamic productDescription;
  final dynamic productSubtitle;
  final dynamic productType;
  final dynamic productTypeId;
  final dynamic productCollection;
  final ProductHandle productHandle;
  final dynamic variantSku;
  final dynamic variantBarcode;
  final TitleEnum variantTitle;
  final dynamic variantOptionValues;
  final bool requiresShipping;
  final bool isGiftcard;
  final bool isDiscountable;
  final bool isTaxInclusive;
  final bool isCustomPrice;
  final Metadata metadata;
  final dynamic rawCompareAtUnitPrice;
  final Raw rawUnitPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final List<dynamic> taxLines;
  final List<dynamic> adjustments;
  final dynamic compareAtUnitPrice;
  final int unitPrice;
  final int quantity;
  final Raw rawQuantity;
  final Detail detail;
  final int subtotal;
  final int total;
  final int originalTotal;
  final int discountTotal;
  final int discountSubtotal;
  final int discountTaxTotal;
  final int taxTotal;
  final int originalTaxTotal;
  final int refundableTotalPerUnit;
  final int refundableTotal;
  final int fulfilledTotal;
  final int shippedTotal;
  final int returnRequestedTotal;
  final int returnReceivedTotal;
  final int returnDismissedTotal;
  final int writeOffTotal;
  final Raw rawSubtotal;
  final Raw rawTotal;
  final Raw rawOriginalTotal;
  final Raw rawDiscountTotal;
  final Raw rawDiscountSubtotal;
  final Raw rawDiscountTaxTotal;
  final Raw rawTaxTotal;
  final Raw rawOriginalTaxTotal;
  final Raw rawRefundableTotalPerUnit;
  final Raw rawRefundableTotal;
  final Raw rawFulfilledTotal;
  final Raw rawShippedTotal;
  final Raw rawReturnRequestedTotal;
  final Raw rawReturnReceivedTotal;
  final Raw rawReturnDismissedTotal;
  final Raw rawWriteOffTotal;

  Item({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.thumbnail,
    required this.variantId,
    required this.productId,
    required this.productTitle,
    required this.productDescription,
    required this.productSubtitle,
    required this.productType,
    required this.productTypeId,
    required this.productCollection,
    required this.productHandle,
    required this.variantSku,
    required this.variantBarcode,
    required this.variantTitle,
    required this.variantOptionValues,
    required this.requiresShipping,
    required this.isGiftcard,
    required this.isDiscountable,
    required this.isTaxInclusive,
    required this.isCustomPrice,
    required this.metadata,
    required this.rawCompareAtUnitPrice,
    required this.rawUnitPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.taxLines,
    required this.adjustments,
    required this.compareAtUnitPrice,
    required this.unitPrice,
    required this.quantity,
    required this.rawQuantity,
    required this.detail,
    required this.subtotal,
    required this.total,
    required this.originalTotal,
    required this.discountTotal,
    required this.discountSubtotal,
    required this.discountTaxTotal,
    required this.taxTotal,
    required this.originalTaxTotal,
    required this.refundableTotalPerUnit,
    required this.refundableTotal,
    required this.fulfilledTotal,
    required this.shippedTotal,
    required this.returnRequestedTotal,
    required this.returnReceivedTotal,
    required this.returnDismissedTotal,
    required this.writeOffTotal,
    required this.rawSubtotal,
    required this.rawTotal,
    required this.rawOriginalTotal,
    required this.rawDiscountTotal,
    required this.rawDiscountSubtotal,
    required this.rawDiscountTaxTotal,
    required this.rawTaxTotal,
    required this.rawOriginalTaxTotal,
    required this.rawRefundableTotalPerUnit,
    required this.rawRefundableTotal,
    required this.rawFulfilledTotal,
    required this.rawShippedTotal,
    required this.rawReturnRequestedTotal,
    required this.rawReturnReceivedTotal,
    required this.rawReturnDismissedTotal,
    required this.rawWriteOffTotal,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: titleEnumValues.map[json["title"]]!,
        subtitle: productTitleEnumValues.map[json["subtitle"]]!,
        thumbnail: json["thumbnail"],
        variantId: variantIdValues.map[json["variant_id"]]!,
        productId: productIdValues.map[json["product_id"]]!,
        productTitle: productTitleEnumValues.map[json["product_title"]]!,
        productDescription: json["product_description"],
        productSubtitle: json["product_subtitle"],
        productType: json["product_type"],
        productTypeId: json["product_type_id"],
        productCollection: json["product_collection"],
        productHandle: productHandleValues.map[json["product_handle"]]!,
        variantSku: json["variant_sku"],
        variantBarcode: json["variant_barcode"],
        variantTitle: titleEnumValues.map[json["variant_title"]]!,
        variantOptionValues: json["variant_option_values"],
        requiresShipping: json["requires_shipping"],
        isGiftcard: json["is_giftcard"],
        isDiscountable: json["is_discountable"],
        isTaxInclusive: json["is_tax_inclusive"],
        isCustomPrice: json["is_custom_price"],
        metadata: Metadata.fromJson(json["metadata"]),
        rawCompareAtUnitPrice: json["raw_compare_at_unit_price"],
        rawUnitPrice: Raw.fromJson(json["raw_unit_price"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        taxLines: List<dynamic>.from(json["tax_lines"].map((x) => x)),
        adjustments: List<dynamic>.from(json["adjustments"].map((x) => x)),
        compareAtUnitPrice: json["compare_at_unit_price"],
        unitPrice: json["unit_price"],
        quantity: json["quantity"],
        rawQuantity: Raw.fromJson(json["raw_quantity"]),
        detail: Detail.fromJson(json["detail"]),
        subtotal: json["subtotal"],
        total: json["total"],
        originalTotal: json["original_total"],
        discountTotal: json["discount_total"],
        discountSubtotal: json["discount_subtotal"],
        discountTaxTotal: json["discount_tax_total"],
        taxTotal: json["tax_total"],
        originalTaxTotal: json["original_tax_total"],
        refundableTotalPerUnit: json["refundable_total_per_unit"],
        refundableTotal: json["refundable_total"],
        fulfilledTotal: json["fulfilled_total"],
        shippedTotal: json["shipped_total"],
        returnRequestedTotal: json["return_requested_total"],
        returnReceivedTotal: json["return_received_total"],
        returnDismissedTotal: json["return_dismissed_total"],
        writeOffTotal: json["write_off_total"],
        rawSubtotal: Raw.fromJson(json["raw_subtotal"]),
        rawTotal: Raw.fromJson(json["raw_total"]),
        rawOriginalTotal: Raw.fromJson(json["raw_original_total"]),
        rawDiscountTotal: Raw.fromJson(json["raw_discount_total"]),
        rawDiscountSubtotal: Raw.fromJson(json["raw_discount_subtotal"]),
        rawDiscountTaxTotal: Raw.fromJson(json["raw_discount_tax_total"]),
        rawTaxTotal: Raw.fromJson(json["raw_tax_total"]),
        rawOriginalTaxTotal: Raw.fromJson(json["raw_original_tax_total"]),
        rawRefundableTotalPerUnit:
            Raw.fromJson(json["raw_refundable_total_per_unit"]),
        rawRefundableTotal: Raw.fromJson(json["raw_refundable_total"]),
        rawFulfilledTotal: Raw.fromJson(json["raw_fulfilled_total"]),
        rawShippedTotal: Raw.fromJson(json["raw_shipped_total"]),
        rawReturnRequestedTotal:
            Raw.fromJson(json["raw_return_requested_total"]),
        rawReturnReceivedTotal: Raw.fromJson(json["raw_return_received_total"]),
        rawReturnDismissedTotal:
            Raw.fromJson(json["raw_return_dismissed_total"]),
        rawWriteOffTotal: Raw.fromJson(json["raw_write_off_total"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": titleEnumValues.reverse[title],
        "subtitle": productTitleEnumValues.reverse[subtitle],
        "thumbnail": thumbnail,
        "variant_id": variantIdValues.reverse[variantId],
        "product_id": productIdValues.reverse[productId],
        "product_title": productTitleEnumValues.reverse[productTitle],
        "product_description": productDescription,
        "product_subtitle": productSubtitle,
        "product_type": productType,
        "product_type_id": productTypeId,
        "product_collection": productCollection,
        "product_handle": productHandleValues.reverse[productHandle],
        "variant_sku": variantSku,
        "variant_barcode": variantBarcode,
        "variant_title": titleEnumValues.reverse[variantTitle],
        "variant_option_values": variantOptionValues,
        "requires_shipping": requiresShipping,
        "is_giftcard": isGiftcard,
        "is_discountable": isDiscountable,
        "is_tax_inclusive": isTaxInclusive,
        "is_custom_price": isCustomPrice,
        "metadata": metadata.toJson(),
        "raw_compare_at_unit_price": rawCompareAtUnitPrice,
        "raw_unit_price": rawUnitPrice.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "tax_lines": List<dynamic>.from(taxLines.map((x) => x)),
        "adjustments": List<dynamic>.from(adjustments.map((x) => x)),
        "compare_at_unit_price": compareAtUnitPrice,
        "unit_price": unitPrice,
        "quantity": quantity,
        "raw_quantity": rawQuantity.toJson(),
        "detail": detail.toJson(),
        "subtotal": subtotal,
        "total": total,
        "original_total": originalTotal,
        "discount_total": discountTotal,
        "discount_subtotal": discountSubtotal,
        "discount_tax_total": discountTaxTotal,
        "tax_total": taxTotal,
        "original_tax_total": originalTaxTotal,
        "refundable_total_per_unit": refundableTotalPerUnit,
        "refundable_total": refundableTotal,
        "fulfilled_total": fulfilledTotal,
        "shipped_total": shippedTotal,
        "return_requested_total": returnRequestedTotal,
        "return_received_total": returnReceivedTotal,
        "return_dismissed_total": returnDismissedTotal,
        "write_off_total": writeOffTotal,
        "raw_subtotal": rawSubtotal.toJson(),
        "raw_total": rawTotal.toJson(),
        "raw_original_total": rawOriginalTotal.toJson(),
        "raw_discount_total": rawDiscountTotal.toJson(),
        "raw_discount_subtotal": rawDiscountSubtotal.toJson(),
        "raw_discount_tax_total": rawDiscountTaxTotal.toJson(),
        "raw_tax_total": rawTaxTotal.toJson(),
        "raw_original_tax_total": rawOriginalTaxTotal.toJson(),
        "raw_refundable_total_per_unit": rawRefundableTotalPerUnit.toJson(),
        "raw_refundable_total": rawRefundableTotal.toJson(),
        "raw_fulfilled_total": rawFulfilledTotal.toJson(),
        "raw_shipped_total": rawShippedTotal.toJson(),
        "raw_return_requested_total": rawReturnRequestedTotal.toJson(),
        "raw_return_received_total": rawReturnReceivedTotal.toJson(),
        "raw_return_dismissed_total": rawReturnDismissedTotal.toJson(),
        "raw_write_off_total": rawWriteOffTotal.toJson(),
      };
}

class Detail {
  final String id;
  final int version;
  final dynamic metadata;
  final String orderId;
  final dynamic rawUnitPrice;
  final dynamic rawCompareAtUnitPrice;
  final Raw rawQuantity;
  final Raw rawFulfilledQuantity;
  final Raw rawDeliveredQuantity;
  final Raw rawShippedQuantity;
  final Raw rawReturnRequestedQuantity;
  final Raw rawReturnReceivedQuantity;
  final Raw rawReturnDismissedQuantity;
  final Raw rawWrittenOffQuantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String itemId;
  final dynamic unitPrice;
  final dynamic compareAtUnitPrice;
  final int quantity;
  final int fulfilledQuantity;
  final int deliveredQuantity;
  final int shippedQuantity;
  final int returnRequestedQuantity;
  final int returnReceivedQuantity;
  final int returnDismissedQuantity;
  final int writtenOffQuantity;

  Detail({
    required this.id,
    required this.version,
    required this.metadata,
    required this.orderId,
    required this.rawUnitPrice,
    required this.rawCompareAtUnitPrice,
    required this.rawQuantity,
    required this.rawFulfilledQuantity,
    required this.rawDeliveredQuantity,
    required this.rawShippedQuantity,
    required this.rawReturnRequestedQuantity,
    required this.rawReturnReceivedQuantity,
    required this.rawReturnDismissedQuantity,
    required this.rawWrittenOffQuantity,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.itemId,
    required this.unitPrice,
    required this.compareAtUnitPrice,
    required this.quantity,
    required this.fulfilledQuantity,
    required this.deliveredQuantity,
    required this.shippedQuantity,
    required this.returnRequestedQuantity,
    required this.returnReceivedQuantity,
    required this.returnDismissedQuantity,
    required this.writtenOffQuantity,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        version: json["version"],
        metadata: json["metadata"],
        orderId: json["order_id"],
        rawUnitPrice: json["raw_unit_price"],
        rawCompareAtUnitPrice: json["raw_compare_at_unit_price"],
        rawQuantity: Raw.fromJson(json["raw_quantity"]),
        rawFulfilledQuantity: Raw.fromJson(json["raw_fulfilled_quantity"]),
        rawDeliveredQuantity: Raw.fromJson(json["raw_delivered_quantity"]),
        rawShippedQuantity: Raw.fromJson(json["raw_shipped_quantity"]),
        rawReturnRequestedQuantity:
            Raw.fromJson(json["raw_return_requested_quantity"]),
        rawReturnReceivedQuantity:
            Raw.fromJson(json["raw_return_received_quantity"]),
        rawReturnDismissedQuantity:
            Raw.fromJson(json["raw_return_dismissed_quantity"]),
        rawWrittenOffQuantity: Raw.fromJson(json["raw_written_off_quantity"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        itemId: json["item_id"],
        unitPrice: json["unit_price"],
        compareAtUnitPrice: json["compare_at_unit_price"],
        quantity: json["quantity"],
        fulfilledQuantity: json["fulfilled_quantity"],
        deliveredQuantity: json["delivered_quantity"],
        shippedQuantity: json["shipped_quantity"],
        returnRequestedQuantity: json["return_requested_quantity"],
        returnReceivedQuantity: json["return_received_quantity"],
        returnDismissedQuantity: json["return_dismissed_quantity"],
        writtenOffQuantity: json["written_off_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version": version,
        "metadata": metadata,
        "order_id": orderId,
        "raw_unit_price": rawUnitPrice,
        "raw_compare_at_unit_price": rawCompareAtUnitPrice,
        "raw_quantity": rawQuantity.toJson(),
        "raw_fulfilled_quantity": rawFulfilledQuantity.toJson(),
        "raw_delivered_quantity": rawDeliveredQuantity.toJson(),
        "raw_shipped_quantity": rawShippedQuantity.toJson(),
        "raw_return_requested_quantity": rawReturnRequestedQuantity.toJson(),
        "raw_return_received_quantity": rawReturnReceivedQuantity.toJson(),
        "raw_return_dismissed_quantity": rawReturnDismissedQuantity.toJson(),
        "raw_written_off_quantity": rawWrittenOffQuantity.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "item_id": itemId,
        "unit_price": unitPrice,
        "compare_at_unit_price": compareAtUnitPrice,
        "quantity": quantity,
        "fulfilled_quantity": fulfilledQuantity,
        "delivered_quantity": deliveredQuantity,
        "shipped_quantity": shippedQuantity,
        "return_requested_quantity": returnRequestedQuantity,
        "return_received_quantity": returnReceivedQuantity,
        "return_dismissed_quantity": returnDismissedQuantity,
        "written_off_quantity": writtenOffQuantity,
      };
}

class Raw {
  final String value;
  final int precision;

  Raw({
    required this.value,
    required this.precision,
  });

  factory Raw.fromJson(Map<String, dynamic> json) => Raw(
        value: json["value"],
        precision: json["precision"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "precision": precision,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}

enum ProductHandle { POLO_T_SHIRTS }

final productHandleValues =
    EnumValues({"polo-t-shirts": ProductHandle.POLO_T_SHIRTS});

enum ProductId { PROD_01_JV4_RJVFER0_FQW4_XN6_TV09_Q3_R }

final productIdValues = EnumValues({
  "prod_01JV4RJVFER0FQW4XN6TV09Q3R":
      ProductId.PROD_01_JV4_RJVFER0_FQW4_XN6_TV09_Q3_R
});

enum ProductTitleEnum { POLO_T_SHIRTS }

final productTitleEnumValues =
    EnumValues({"Polo T-shirts": ProductTitleEnum.POLO_T_SHIRTS});

enum TitleEnum { POLO_T_SHIRTS_BLACK }

final titleEnumValues =
    EnumValues({"Polo T-shirts (Black)": TitleEnum.POLO_T_SHIRTS_BLACK});

enum VariantId { VARIANT_01_JV4_RJVHYCXH9_QYV8_GMDCCGK9 }

final variantIdValues = EnumValues({
  "variant_01JV4RJVHYCXH9QYV8GMDCCGK9":
      VariantId.VARIANT_01_JV4_RJVHYCXH9_QYV8_GMDCCGK9
});

enum PaymentStatus { AUTHORIZED }

final paymentStatusValues =
    EnumValues({"authorized": PaymentStatus.AUTHORIZED});

enum Status { PENDING }

final statusValues = EnumValues({"pending": Status.PENDING});

class Summary {
  final int paidTotal;
  final Raw rawPaidTotal;
  final int refundedTotal;
  final int accountingTotal;
  final int creditLineTotal;
  final int transactionTotal;
  final int pendingDifference;
  final Raw rawRefundedTotal;
  final int currentOrderTotal;
  final int originalOrderTotal;
  final Raw rawAccountingTotal;
  final Raw rawCreditLineTotal;
  final Raw rawTransactionTotal;
  final Raw rawPendingDifference;
  final Raw rawCurrentOrderTotal;
  final Raw rawOriginalOrderTotal;

  Summary({
    required this.paidTotal,
    required this.rawPaidTotal,
    required this.refundedTotal,
    required this.accountingTotal,
    required this.creditLineTotal,
    required this.transactionTotal,
    required this.pendingDifference,
    required this.rawRefundedTotal,
    required this.currentOrderTotal,
    required this.originalOrderTotal,
    required this.rawAccountingTotal,
    required this.rawCreditLineTotal,
    required this.rawTransactionTotal,
    required this.rawPendingDifference,
    required this.rawCurrentOrderTotal,
    required this.rawOriginalOrderTotal,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        paidTotal: json["paid_total"],
        rawPaidTotal: Raw.fromJson(json["raw_paid_total"]),
        refundedTotal: json["refunded_total"],
        accountingTotal: json["accounting_total"],
        creditLineTotal: json["credit_line_total"],
        transactionTotal: json["transaction_total"],
        pendingDifference: json["pending_difference"],
        rawRefundedTotal: Raw.fromJson(json["raw_refunded_total"]),
        currentOrderTotal: json["current_order_total"],
        originalOrderTotal: json["original_order_total"],
        rawAccountingTotal: Raw.fromJson(json["raw_accounting_total"]),
        rawCreditLineTotal: Raw.fromJson(json["raw_credit_line_total"]),
        rawTransactionTotal: Raw.fromJson(json["raw_transaction_total"]),
        rawPendingDifference: Raw.fromJson(json["raw_pending_difference"]),
        rawCurrentOrderTotal: Raw.fromJson(json["raw_current_order_total"]),
        rawOriginalOrderTotal: Raw.fromJson(json["raw_original_order_total"]),
      );

  Map<String, dynamic> toJson() => {
        "paid_total": paidTotal,
        "raw_paid_total": rawPaidTotal.toJson(),
        "refunded_total": refundedTotal,
        "accounting_total": accountingTotal,
        "credit_line_total": creditLineTotal,
        "transaction_total": transactionTotal,
        "pending_difference": pendingDifference,
        "raw_refunded_total": rawRefundedTotal.toJson(),
        "current_order_total": currentOrderTotal,
        "original_order_total": originalOrderTotal,
        "raw_accounting_total": rawAccountingTotal.toJson(),
        "raw_credit_line_total": rawCreditLineTotal.toJson(),
        "raw_transaction_total": rawTransactionTotal.toJson(),
        "raw_pending_difference": rawPendingDifference.toJson(),
        "raw_current_order_total": rawCurrentOrderTotal.toJson(),
        "raw_original_order_total": rawOriginalOrderTotal.toJson(),
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
