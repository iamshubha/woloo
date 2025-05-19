// To parse this JSON data, do
//
//     final orderDetails = orderDetailsFromJson(jsonString);

import 'dart:convert';

OrderDetails orderDetailsFromJson(String str) =>
    OrderDetails.fromJson(json.decode(str));

String orderDetailsToJson(OrderDetails data) => json.encode(data.toJson());

class OrderDetails {
  final List<OrderSet> orderSets;
  final int? count;
  final int? offset;
  final int? limit;

  OrderDetails({
    this.orderSets = const [],
    this.count,
    this.offset,
    this.limit,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        orderSets: json["order_sets"] == null
            ? []
            : List<OrderSet>.from(
                json["order_sets"]!.map((x) => OrderSet.fromJson(x))),
        count: json["count"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "order_sets": List<dynamic>.from(orderSets.map((x) => x.toJson())),
        "count": count,
        "offset": offset,
        "limit": limit,
      };
}

class OrderSet {
  final String? id;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final dynamic displayId;
  final CustomerId? customerId;
  final String? cartId;
  final String? paymentCollectionId;
  final OrderSetCustomer? customer;
  final Cart? cart;
  final PaymentCollection? paymentCollection;
  final List<Order> orders;
  final PurpleStatus? status;
  final PaymentStatusEnum? paymentStatus;
  final FulfillmentStatus? fulfillmentStatus;
  final int? taxTotal;
  final int? shippingTaxTotal;
  final int? shippingTotal;
  final int? total;
  final int? subtotal;

  OrderSet({
    this.id,
    this.updatedAt,
    this.createdAt,
    this.displayId,
    this.customerId,
    this.cartId,
    this.paymentCollectionId,
    this.customer,
    this.cart,
    this.paymentCollection,
    this.orders = const [],
    this.status,
    this.paymentStatus,
    this.fulfillmentStatus,
    this.taxTotal,
    this.shippingTaxTotal,
    this.shippingTotal,
    this.total,
    this.subtotal,
  });

  factory OrderSet.fromJson(Map<String, dynamic> json) => OrderSet(
        id: json["id"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        displayId: json["display_id"],
        customerId: customerIdValues.map[json["customer_id"]]!,
        cartId: json["cart_id"],
        paymentCollectionId: json["payment_collection_id"],
        customer: json["customer"] == null
            ? null
            : OrderSetCustomer.fromJson(json["customer"]),
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
        paymentCollection: json["payment_collection"] == null
            ? null
            : PaymentCollection.fromJson(json["payment_collection"]),
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
        status: purpleStatusValues.map[json["status"]]!,
        paymentStatus: paymentStatusEnumValues.map[json["payment_status"]]!,
        fulfillmentStatus:
            fulfillmentStatusValues.map[json["fulfillment_status"]]!,
        taxTotal: json["tax_total"],
        shippingTaxTotal: json["shipping_tax_total"],
        shippingTotal: json["shipping_total"],
        total: json["total"],
        subtotal: json["subtotal"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "display_id": displayId,
        "customer_id": customerIdValues.reverse[customerId],
        "cart_id": cartId,
        "payment_collection_id": paymentCollectionId,
        "customer": customer?.toJson(),
        "cart": cart?.toJson(),
        "payment_collection": paymentCollection?.toJson(),
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
        "status": purpleStatusValues.reverse[status],
        "payment_status": paymentStatusEnumValues.reverse[paymentStatus],
        "fulfillment_status":
            fulfillmentStatusValues.reverse[fulfillmentStatus],
        "tax_total": taxTotal,
        "shipping_tax_total": shippingTaxTotal,
        "shipping_total": shippingTotal,
        "total": total,
        "subtotal": subtotal,
      };
}

class Cart {
  final String? id;
  final RegionId? regionId;
  final CustomerId? customerId;
  final SalesChannelId? salesChannelId;
  final Email? email;
  final CurrencyCode? currencyCode;
  final dynamic metadata;
  final DateTime? completedAt;
  final ShippingAddress? shippingAddress;
  final dynamic billingAddress;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? shippingAddressId;

  Cart({
    this.id,
    this.regionId,
    this.customerId,
    this.salesChannelId,
    this.email,
    this.currencyCode,
    this.metadata,
    this.completedAt,
    this.shippingAddress,
    this.billingAddress,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.shippingAddressId,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        regionId: regionIdValues.map[json["region_id"]]!,
        customerId: customerIdValues.map[json["customer_id"]]!,
        salesChannelId: salesChannelIdValues.map[json["sales_channel_id"]]!,
        email: emailValues.map[json["email"]]!,
        currencyCode: currencyCodeValues.map[json["currency_code"]]!,
        metadata: json["metadata"],
        completedAt: json["completed_at"] == null
            ? null
            : DateTime.parse(json["completed_at"]),
        shippingAddress: json["shipping_address"] == null
            ? null
            : ShippingAddress.fromJson(json["shipping_address"]),
        billingAddress: json["billing_address"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        shippingAddressId: json["shipping_address_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "region_id": regionIdValues.reverse[regionId],
        "customer_id": customerIdValues.reverse[customerId],
        "sales_channel_id": salesChannelIdValues.reverse[salesChannelId],
        "email": emailValues.reverse[email],
        "currency_code": currencyCodeValues.reverse[currencyCode],
        "metadata": metadata,
        "completed_at": completedAt?.toIso8601String(),
        "shipping_address": shippingAddress?.toJson(),
        "billing_address": billingAddress,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "shipping_address_id": shippingAddressId,
      };
}

enum CurrencyCode { INR }

final currencyCodeValues = EnumValues({"inr": CurrencyCode.INR});

enum CustomerId { CUS_01_JT8_BSP0_NZJB59_BCR4_P2_ACSM7 }

final customerIdValues = EnumValues({
  "cus_01JT8BSP0NZJB59BCR4P2ACSM7":
      CustomerId.CUS_01_JT8_BSP0_NZJB59_BCR4_P2_ACSM7
});

enum Email { THE_000000000_GMAIL_COM }

final emailValues =
    EnumValues({"000000000@gmail.com": Email.THE_000000000_GMAIL_COM});

enum RegionId { REG_01_JPH693_TAM20_TXZEJNBJ5_QBV4 }

final regionIdValues = EnumValues({
  "reg_01JPH693TAM20TXZEJNBJ5QBV4": RegionId.REG_01_JPH693_TAM20_TXZEJNBJ5_QBV4
});

enum SalesChannelId { SC_01_JPCA7_CXBJ09_KEBMBCXK3_M302 }

final salesChannelIdValues = EnumValues({
  "sc_01JPCA7CXBJ09KEBMBCXK3M302":
      SalesChannelId.SC_01_JPCA7_CXBJ09_KEBMBCXK3_M302
});

class ShippingAddress {
  final String? id;

  ShippingAddress({
    this.id,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class OrderSetCustomer {
  final CustomerId? id;
  final dynamic companyName;
  final dynamic firstName;
  final dynamic lastName;
  final Email? email;
  final dynamic phone;
  final bool? hasAccount;
  final dynamic metadata;
  final dynamic createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  OrderSetCustomer({
    this.id,
    this.companyName,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.hasAccount,
    this.metadata,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory OrderSetCustomer.fromJson(Map<String, dynamic> json) =>
      OrderSetCustomer(
        id: customerIdValues.map[json["id"]]!,
        companyName: json["company_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: emailValues.map[json["email"]]!,
        phone: json["phone"],
        hasAccount: json["has_account"],
        metadata: json["metadata"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": customerIdValues.reverse[id],
        "company_name": companyName,
        "first_name": firstName,
        "last_name": lastName,
        "email": emailValues.reverse[email],
        "phone": phone,
        "has_account": hasAccount,
        "metadata": metadata,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

enum FulfillmentStatus { NOT_FULFILLED }

final fulfillmentStatusValues =
    EnumValues({"not_fulfilled": FulfillmentStatus.NOT_FULFILLED});

class Order {
  final CustomerId? customerId;
  final String? id;
  final CurrencyCode? currencyCode;
  final Email? email;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final PurpleStatus? status;
  final int? total;
  final int? subtotal;
  final int? taxTotal;
  final int? discountTotal;
  final int? discountTaxTotal;
  final int? originalTotal;
  final int? originalTaxTotal;
  final int? itemTotal;
  final int? itemSubtotal;
  final int? itemTaxTotal;
  final SalesChannelId? salesChannelId;
  final int? originalItemTotal;
  final int? originalItemSubtotal;
  final int? originalItemTaxTotal;
  final int? shippingTotal;
  final int? shippingSubtotal;
  final int? shippingTaxTotal;
  final List<Item>? items;
  final OrderSetCustomer? customer;
  final List<dynamic>? fulfillments;
  final List<PaymentCollection>? paymentCollections;
  final PaymentStatusEnum? paymentStatus;
  final FulfillmentStatus? fulfillmentStatus;

  Order({
    this.customerId,
    this.id,
    this.currencyCode,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.total,
    this.subtotal,
    this.taxTotal,
    this.discountTotal,
    this.discountTaxTotal,
    this.originalTotal,
    this.originalTaxTotal,
    this.itemTotal,
    this.itemSubtotal,
    this.itemTaxTotal,
    this.salesChannelId,
    this.originalItemTotal,
    this.originalItemSubtotal,
    this.originalItemTaxTotal,
    this.shippingTotal,
    this.shippingSubtotal,
    this.shippingTaxTotal,
    this.items,
    this.customer,
    this.fulfillments,
    this.paymentCollections,
    this.paymentStatus,
    this.fulfillmentStatus,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        customerId: customerIdValues.map[json["customer_id"]]!,
        id: json["id"],
        currencyCode: currencyCodeValues.map[json["currency_code"]]!,
        email: emailValues.map[json["email"]]!,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        status: purpleStatusValues.map[json["status"]]!,
        total: json["total"],
        subtotal: json["subtotal"],
        taxTotal: json["tax_total"],
        discountTotal: json["discount_total"],
        discountTaxTotal: json["discount_tax_total"],
        originalTotal: json["original_total"],
        originalTaxTotal: json["original_tax_total"],
        itemTotal: json["item_total"],
        itemSubtotal: json["item_subtotal"],
        itemTaxTotal: json["item_tax_total"],
        salesChannelId: salesChannelIdValues.map[json["sales_channel_id"]]!,
        originalItemTotal: json["original_item_total"],
        originalItemSubtotal: json["original_item_subtotal"],
        originalItemTaxTotal: json["original_item_tax_total"],
        shippingTotal: json["shipping_total"],
        shippingSubtotal: json["shipping_subtotal"],
        shippingTaxTotal: json["shipping_tax_total"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        customer: json["customer"] == null
            ? null
            : OrderSetCustomer.fromJson(json["customer"]),
        fulfillments: json["fulfillments"] == null
            ? []
            : List<dynamic>.from(json["fulfillments"]!.map((x) => x)),
        paymentCollections: json["payment_collections"] == null
            ? []
            : List<PaymentCollection>.from(json["payment_collections"]!
                .map((x) => PaymentCollection.fromJson(x))),
        paymentStatus: paymentStatusEnumValues.map[json["payment_status"]]!,
        fulfillmentStatus:
            fulfillmentStatusValues.map[json["fulfillment_status"]]!,
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerIdValues.reverse[customerId],
        "id": id,
        "currency_code": currencyCodeValues.reverse[currencyCode],
        "email": emailValues.reverse[email],
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": purpleStatusValues.reverse[status],
        "total": total,
        "subtotal": subtotal,
        "tax_total": taxTotal,
        "discount_total": discountTotal,
        "discount_tax_total": discountTaxTotal,
        "original_total": originalTotal,
        "original_tax_total": originalTaxTotal,
        "item_total": itemTotal,
        "item_subtotal": itemSubtotal,
        "item_tax_total": itemTaxTotal,
        "sales_channel_id": salesChannelIdValues.reverse[salesChannelId],
        "original_item_total": originalItemTotal,
        "original_item_subtotal": originalItemSubtotal,
        "original_item_tax_total": originalItemTaxTotal,
        "shipping_total": shippingTotal,
        "shipping_subtotal": shippingSubtotal,
        "shipping_tax_total": shippingTaxTotal,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "customer": customer?.toJson(),
        "fulfillments": fulfillments == null
            ? []
            : List<dynamic>.from(fulfillments!.map((x) => x)),
        "payment_collections": paymentCollections == null
            ? []
            : List<dynamic>.from(paymentCollections!.map((x) => x.toJson())),
        "payment_status": paymentStatusEnumValues.reverse[paymentStatus],
        "fulfillment_status":
            fulfillmentStatusValues.reverse[fulfillmentStatus],
      };
}

class Item {
  final String? id;
  final TitleEnum? title;
  final ProductTitleEnum? subtitle;
  final String? thumbnail;
  final VariantId? variantId;
  final ProductId? productId;
  final ProductTitleEnum? productTitle;
  final String? productDescription;
  final String? productSubtitle;
  final dynamic productType;
  final dynamic productTypeId;
  final ProductCollection? productCollection;
  final ProductHandle? productHandle;
  final dynamic variantSku;
  final dynamic variantBarcode;
  final TitleEnum? variantTitle;
  final dynamic variantOptionValues;
  final bool? requiresShipping;
  final bool? isGiftcard;
  final bool? isDiscountable;
  final bool? isTaxInclusive;
  final bool? isCustomPrice;
  final Metadata? metadata;
  final dynamic rawCompareAtUnitPrice;
  final Raw? rawUnitPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final List<dynamic>? taxLines;
  final List<dynamic>? adjustments;
  final dynamic compareAtUnitPrice;
  final int? unitPrice;
  final int? quantity;
  final Raw? rawQuantity;
  final Detail? detail;
  final int? subtotal;
  final int? total;
  final int? originalTotal;
  final int? discountTotal;
  final int? discountSubtotal;
  final int? discountTaxTotal;
  final int? taxTotal;
  final int? originalTaxTotal;
  final int? refundableTotalPerUnit;
  final int? refundableTotal;
  final int? fulfilledTotal;
  final int? shippedTotal;
  final int? returnRequestedTotal;
  final int? returnReceivedTotal;
  final int? returnDismissedTotal;
  final int? writeOffTotal;
  final Raw? rawSubtotal;
  final Raw? rawTotal;
  final Raw? rawOriginalTotal;
  final Raw? rawDiscountTotal;
  final Raw? rawDiscountSubtotal;
  final Raw? rawDiscountTaxTotal;
  final Raw? rawTaxTotal;
  final Raw? rawOriginalTaxTotal;
  final Raw? rawRefundableTotalPerUnit;
  final Raw? rawRefundableTotal;
  final Raw? rawFulfilledTotal;
  final Raw? rawShippedTotal;
  final Raw? rawReturnRequestedTotal;
  final Raw? rawReturnReceivedTotal;
  final Raw? rawReturnDismissedTotal;
  final Raw? rawWriteOffTotal;

  Item({
    this.id,
    this.title,
    this.subtitle,
    this.thumbnail,
    this.variantId,
    this.productId,
    this.productTitle,
    this.productDescription,
    this.productSubtitle,
    this.productType,
    this.productTypeId,
    this.productCollection,
    this.productHandle,
    this.variantSku,
    this.variantBarcode,
    this.variantTitle,
    this.variantOptionValues,
    this.requiresShipping,
    this.isGiftcard,
    this.isDiscountable,
    this.isTaxInclusive,
    this.isCustomPrice,
    this.metadata,
    this.rawCompareAtUnitPrice,
    this.rawUnitPrice,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.taxLines,
    this.adjustments,
    this.compareAtUnitPrice,
    this.unitPrice,
    this.quantity,
    this.rawQuantity,
    this.detail,
    this.subtotal,
    this.total,
    this.originalTotal,
    this.discountTotal,
    this.discountSubtotal,
    this.discountTaxTotal,
    this.taxTotal,
    this.originalTaxTotal,
    this.refundableTotalPerUnit,
    this.refundableTotal,
    this.fulfilledTotal,
    this.shippedTotal,
    this.returnRequestedTotal,
    this.returnReceivedTotal,
    this.returnDismissedTotal,
    this.writeOffTotal,
    this.rawSubtotal,
    this.rawTotal,
    this.rawOriginalTotal,
    this.rawDiscountTotal,
    this.rawDiscountSubtotal,
    this.rawDiscountTaxTotal,
    this.rawTaxTotal,
    this.rawOriginalTaxTotal,
    this.rawRefundableTotalPerUnit,
    this.rawRefundableTotal,
    this.rawFulfilledTotal,
    this.rawShippedTotal,
    this.rawReturnRequestedTotal,
    this.rawReturnReceivedTotal,
    this.rawReturnDismissedTotal,
    this.rawWriteOffTotal,
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
        productCollection:
            productCollectionValues.map[json["product_collection"]]!,
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
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        rawCompareAtUnitPrice: json["raw_compare_at_unit_price"],
        rawUnitPrice: json["raw_unit_price"] == null
            ? null
            : Raw.fromJson(json["raw_unit_price"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        taxLines: json["tax_lines"] == null
            ? []
            : List<dynamic>.from(json["tax_lines"]!.map((x) => x)),
        adjustments: json["adjustments"] == null
            ? []
            : List<dynamic>.from(json["adjustments"]!.map((x) => x)),
        compareAtUnitPrice: json["compare_at_unit_price"],
        unitPrice: json["unit_price"],
        quantity: json["quantity"],
        rawQuantity: json["raw_quantity"] == null
            ? null
            : Raw.fromJson(json["raw_quantity"]),
        detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
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
        rawSubtotal: json["raw_subtotal"] == null
            ? null
            : Raw.fromJson(json["raw_subtotal"]),
        rawTotal:
            json["raw_total"] == null ? null : Raw.fromJson(json["raw_total"]),
        rawOriginalTotal: json["raw_original_total"] == null
            ? null
            : Raw.fromJson(json["raw_original_total"]),
        rawDiscountTotal: json["raw_discount_total"] == null
            ? null
            : Raw.fromJson(json["raw_discount_total"]),
        rawDiscountSubtotal: json["raw_discount_subtotal"] == null
            ? null
            : Raw.fromJson(json["raw_discount_subtotal"]),
        rawDiscountTaxTotal: json["raw_discount_tax_total"] == null
            ? null
            : Raw.fromJson(json["raw_discount_tax_total"]),
        rawTaxTotal: json["raw_tax_total"] == null
            ? null
            : Raw.fromJson(json["raw_tax_total"]),
        rawOriginalTaxTotal: json["raw_original_tax_total"] == null
            ? null
            : Raw.fromJson(json["raw_original_tax_total"]),
        rawRefundableTotalPerUnit: json["raw_refundable_total_per_unit"] == null
            ? null
            : Raw.fromJson(json["raw_refundable_total_per_unit"]),
        rawRefundableTotal: json["raw_refundable_total"] == null
            ? null
            : Raw.fromJson(json["raw_refundable_total"]),
        rawFulfilledTotal: json["raw_fulfilled_total"] == null
            ? null
            : Raw.fromJson(json["raw_fulfilled_total"]),
        rawShippedTotal: json["raw_shipped_total"] == null
            ? null
            : Raw.fromJson(json["raw_shipped_total"]),
        rawReturnRequestedTotal: json["raw_return_requested_total"] == null
            ? null
            : Raw.fromJson(json["raw_return_requested_total"]),
        rawReturnReceivedTotal: json["raw_return_received_total"] == null
            ? null
            : Raw.fromJson(json["raw_return_received_total"]),
        rawReturnDismissedTotal: json["raw_return_dismissed_total"] == null
            ? null
            : Raw.fromJson(json["raw_return_dismissed_total"]),
        rawWriteOffTotal: json["raw_write_off_total"] == null
            ? null
            : Raw.fromJson(json["raw_write_off_total"]),
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
        "product_collection":
            productCollectionValues.reverse[productCollection],
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
        "metadata": metadata?.toJson(),
        "raw_compare_at_unit_price": rawCompareAtUnitPrice,
        "raw_unit_price": rawUnitPrice?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "tax_lines":
            taxLines == null ? [] : List<dynamic>.from(taxLines!.map((x) => x)),
        "adjustments": adjustments == null
            ? []
            : List<dynamic>.from(adjustments!.map((x) => x)),
        "compare_at_unit_price": compareAtUnitPrice,
        "unit_price": unitPrice,
        "quantity": quantity,
        "raw_quantity": rawQuantity?.toJson(),
        "detail": detail?.toJson(),
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
        "raw_subtotal": rawSubtotal?.toJson(),
        "raw_total": rawTotal?.toJson(),
        "raw_original_total": rawOriginalTotal?.toJson(),
        "raw_discount_total": rawDiscountTotal?.toJson(),
        "raw_discount_subtotal": rawDiscountSubtotal?.toJson(),
        "raw_discount_tax_total": rawDiscountTaxTotal?.toJson(),
        "raw_tax_total": rawTaxTotal?.toJson(),
        "raw_original_tax_total": rawOriginalTaxTotal?.toJson(),
        "raw_refundable_total_per_unit": rawRefundableTotalPerUnit?.toJson(),
        "raw_refundable_total": rawRefundableTotal?.toJson(),
        "raw_fulfilled_total": rawFulfilledTotal?.toJson(),
        "raw_shipped_total": rawShippedTotal?.toJson(),
        "raw_return_requested_total": rawReturnRequestedTotal?.toJson(),
        "raw_return_received_total": rawReturnReceivedTotal?.toJson(),
        "raw_return_dismissed_total": rawReturnDismissedTotal?.toJson(),
        "raw_write_off_total": rawWriteOffTotal?.toJson(),
      };
}

class Detail {
  final String? id;
  final int? version;
  final dynamic metadata;
  final String? orderId;
  final dynamic rawUnitPrice;
  final dynamic rawCompareAtUnitPrice;
  final Raw? rawQuantity;
  final Raw? rawFulfilledQuantity;
  final Raw? rawDeliveredQuantity;
  final Raw? rawShippedQuantity;
  final Raw? rawReturnRequestedQuantity;
  final Raw? rawReturnReceivedQuantity;
  final Raw? rawReturnDismissedQuantity;
  final Raw? rawWrittenOffQuantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? itemId;
  final dynamic unitPrice;
  final dynamic compareAtUnitPrice;
  final int? quantity;
  final int? fulfilledQuantity;
  final int? deliveredQuantity;
  final int? shippedQuantity;
  final int? returnRequestedQuantity;
  final int? returnReceivedQuantity;
  final int? returnDismissedQuantity;
  final int? writtenOffQuantity;

  Detail({
    this.id,
    this.version,
    this.metadata,
    this.orderId,
    this.rawUnitPrice,
    this.rawCompareAtUnitPrice,
    this.rawQuantity,
    this.rawFulfilledQuantity,
    this.rawDeliveredQuantity,
    this.rawShippedQuantity,
    this.rawReturnRequestedQuantity,
    this.rawReturnReceivedQuantity,
    this.rawReturnDismissedQuantity,
    this.rawWrittenOffQuantity,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.itemId,
    this.unitPrice,
    this.compareAtUnitPrice,
    this.quantity,
    this.fulfilledQuantity,
    this.deliveredQuantity,
    this.shippedQuantity,
    this.returnRequestedQuantity,
    this.returnReceivedQuantity,
    this.returnDismissedQuantity,
    this.writtenOffQuantity,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        version: json["version"],
        metadata: json["metadata"],
        orderId: json["order_id"],
        rawUnitPrice: json["raw_unit_price"],
        rawCompareAtUnitPrice: json["raw_compare_at_unit_price"],
        rawQuantity: json["raw_quantity"] == null
            ? null
            : Raw.fromJson(json["raw_quantity"]),
        rawFulfilledQuantity: json["raw_fulfilled_quantity"] == null
            ? null
            : Raw.fromJson(json["raw_fulfilled_quantity"]),
        rawDeliveredQuantity: json["raw_delivered_quantity"] == null
            ? null
            : Raw.fromJson(json["raw_delivered_quantity"]),
        rawShippedQuantity: json["raw_shipped_quantity"] == null
            ? null
            : Raw.fromJson(json["raw_shipped_quantity"]),
        rawReturnRequestedQuantity:
            json["raw_return_requested_quantity"] == null
                ? null
                : Raw.fromJson(json["raw_return_requested_quantity"]),
        rawReturnReceivedQuantity: json["raw_return_received_quantity"] == null
            ? null
            : Raw.fromJson(json["raw_return_received_quantity"]),
        rawReturnDismissedQuantity:
            json["raw_return_dismissed_quantity"] == null
                ? null
                : Raw.fromJson(json["raw_return_dismissed_quantity"]),
        rawWrittenOffQuantity: json["raw_written_off_quantity"] == null
            ? null
            : Raw.fromJson(json["raw_written_off_quantity"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        "raw_quantity": rawQuantity?.toJson(),
        "raw_fulfilled_quantity": rawFulfilledQuantity?.toJson(),
        "raw_delivered_quantity": rawDeliveredQuantity?.toJson(),
        "raw_shipped_quantity": rawShippedQuantity?.toJson(),
        "raw_return_requested_quantity": rawReturnRequestedQuantity?.toJson(),
        "raw_return_received_quantity": rawReturnReceivedQuantity?.toJson(),
        "raw_return_dismissed_quantity": rawReturnDismissedQuantity?.toJson(),
        "raw_written_off_quantity": rawWrittenOffQuantity?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
  final String? value;
  final int? precision;

  Raw({
    this.value,
    this.precision,
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

enum ProductCollection { CARMESI, OSHINE_PRODUCTS, PAND_G }

final productCollectionValues = EnumValues({
  "Carmesi": ProductCollection.CARMESI,
  "OSHINE PRODUCTS": ProductCollection.OSHINE_PRODUCTS,
  "PandG": ProductCollection.PAND_G
});

enum ProductHandle { DEMO_PRODUCT, POLO_T_SHIRTS, TOILET_CLEANER_500_ML }

final productHandleValues = EnumValues({
  "demo-product": ProductHandle.DEMO_PRODUCT,
  "polo-t-shirts": ProductHandle.POLO_T_SHIRTS,
  "toilet-cleaner-500ml": ProductHandle.TOILET_CLEANER_500_ML
});

enum ProductId {
  PROD_01_JQV6_J4_CPDTDZQPNBQPZJAMDB,
  PROD_01_JV4_RJVFER0_FQW4_XN6_TV09_Q3_R,
  PROD_01_JVCD76_B889_HCZR00_QSWY0_KF9
}

final productIdValues = EnumValues({
  "prod_01JQV6J4CPDTDZQPNBQPZJAMDB":
      ProductId.PROD_01_JQV6_J4_CPDTDZQPNBQPZJAMDB,
  "prod_01JV4RJVFER0FQW4XN6TV09Q3R":
      ProductId.PROD_01_JV4_RJVFER0_FQW4_XN6_TV09_Q3_R,
  "prod_01JVCD76B889HCZR00QSWY0KF9":
      ProductId.PROD_01_JVCD76_B889_HCZR00_QSWY0_KF9
});

enum ProductTitleEnum { DEMO_PRODUCT, POLO_T_SHIRTS, TOILET_CLEANER_500_ML }

final productTitleEnumValues = EnumValues({
  "Demo-product": ProductTitleEnum.DEMO_PRODUCT,
  "Polo T-shirts": ProductTitleEnum.POLO_T_SHIRTS,
  "TOILET CLEANER 500ML": ProductTitleEnum.TOILET_CLEANER_500_ML
});

enum TitleEnum { DEFAULT_VARIANT, M_BLACK, POLO_T_SHIRTS_BLACK }

final titleEnumValues = EnumValues({
  "Default variant": TitleEnum.DEFAULT_VARIANT,
  "M / Black": TitleEnum.M_BLACK,
  "Polo T-shirts (Black)": TitleEnum.POLO_T_SHIRTS_BLACK
});

enum VariantId {
  VARIANT_01_JQV6_J4_GZ3_TJMJ82_TPXCFTN80,
  VARIANT_01_JV4_RJVHYCXH9_QYV8_GMDCCGK9,
  VARIANT_01_JVCD76_DQX6_Z16_GFN2_RP47_NPJ
}

final variantIdValues = EnumValues({
  "variant_01JQV6J4GZ3TJMJ82TPXCFTN80":
      VariantId.VARIANT_01_JQV6_J4_GZ3_TJMJ82_TPXCFTN80,
  "variant_01JV4RJVHYCXH9QYV8GMDCCGK9":
      VariantId.VARIANT_01_JV4_RJVHYCXH9_QYV8_GMDCCGK9,
  "variant_01JVCD76DQX6Z16GFN2RP47NPJ":
      VariantId.VARIANT_01_JVCD76_DQX6_Z16_GFN2_RP47_NPJ
});

class PaymentCollection {
  final String? id;
  final CurrencyCode? currencyCode;
  final dynamic completedAt;
  final PaymentStatusEnum? status;
  final dynamic metadata;
  final Raw? rawAmount;
  final Raw? rawAuthorizedAmount;
  final Raw? rawCapturedAmount;
  final Raw? rawRefundedAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final List<Payment>? payments;
  final int? amount;
  final int? authorizedAmount;
  final int? capturedAmount;
  final int? refundedAmount;

  PaymentCollection({
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
    this.payments,
    this.amount,
    this.authorizedAmount,
    this.capturedAmount,
    this.refundedAmount,
  });

  factory PaymentCollection.fromJson(Map<String, dynamic> json) =>
      PaymentCollection(
        id: json["id"],
        currencyCode: currencyCodeValues.map[json["currency_code"]]!,
        completedAt: json["completed_at"],
        status: paymentStatusEnumValues.map[json["status"]]!,
        metadata: json["metadata"],
        rawAmount: json["raw_amount"] == null
            ? null
            : Raw.fromJson(json["raw_amount"]),
        rawAuthorizedAmount: json["raw_authorized_amount"] == null
            ? null
            : Raw.fromJson(json["raw_authorized_amount"]),
        rawCapturedAmount: json["raw_captured_amount"] == null
            ? null
            : Raw.fromJson(json["raw_captured_amount"]),
        rawRefundedAmount: json["raw_refunded_amount"] == null
            ? null
            : Raw.fromJson(json["raw_refunded_amount"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        payments: json["payments"] == null
            ? []
            : List<Payment>.from(
                json["payments"]!.map((x) => Payment.fromJson(x))),
        amount: json["amount"],
        authorizedAmount: json["authorized_amount"],
        capturedAmount: json["captured_amount"],
        refundedAmount: json["refunded_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency_code": currencyCodeValues.reverse[currencyCode],
        "completed_at": completedAt,
        "status": paymentStatusEnumValues.reverse[status],
        "metadata": metadata,
        "raw_amount": rawAmount?.toJson(),
        "raw_authorized_amount": rawAuthorizedAmount?.toJson(),
        "raw_captured_amount": rawCapturedAmount?.toJson(),
        "raw_refunded_amount": rawRefundedAmount?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "payments": payments == null
            ? []
            : List<dynamic>.from(payments!.map((x) => x.toJson())),
        "amount": amount,
        "authorized_amount": authorizedAmount,
        "captured_amount": capturedAmount,
        "refunded_amount": refundedAmount,
      };
}

class Payment {
  final String? id;
  final CurrencyCode? currencyCode;
  final ProviderId? providerId;
  final Data? data;
  final dynamic metadata;
  final dynamic capturedAt;
  final dynamic canceledAt;
  final String? paymentCollectionId;
  final ShippingAddress? paymentSession;
  final Raw? rawAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? paymentSessionId;
  final List<dynamic>? refunds;
  final int? amount;

  Payment({
    this.id,
    this.currencyCode,
    this.providerId,
    this.data,
    this.metadata,
    this.capturedAt,
    this.canceledAt,
    this.paymentCollectionId,
    this.paymentSession,
    this.rawAmount,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.paymentSessionId,
    this.refunds,
    this.amount,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        currencyCode: currencyCodeValues.map[json["currency_code"]]!,
        providerId: providerIdValues.map[json["provider_id"]]!,
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        metadata: json["metadata"],
        capturedAt: json["captured_at"],
        canceledAt: json["canceled_at"],
        paymentCollectionId: json["payment_collection_id"],
        paymentSession: json["payment_session"] == null
            ? null
            : ShippingAddress.fromJson(json["payment_session"]),
        rawAmount: json["raw_amount"] == null
            ? null
            : Raw.fromJson(json["raw_amount"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        paymentSessionId: json["payment_session_id"],
        refunds: json["refunds"] == null
            ? []
            : List<dynamic>.from(json["refunds"]!.map((x) => x)),
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency_code": currencyCodeValues.reverse[currencyCode],
        "provider_id": providerIdValues.reverse[providerId],
        "data": data?.toJson(),
        "metadata": metadata,
        "captured_at": capturedAt,
        "canceled_at": canceledAt,
        "payment_collection_id": paymentCollectionId,
        "payment_session": paymentSession?.toJson(),
        "raw_amount": rawAmount?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "payment_session_id": paymentSessionId,
        "refunds":
            refunds == null ? [] : List<dynamic>.from(refunds!.map((x) => x)),
        "amount": amount,
      };
}

class Data {
  final String? id;
  final Notes? notes;
  final int? amount;
  final Entity? entity;
  final DataStatus? status;
  final String? receipt;
  final int? attempts;
  final Currency? currency;
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        notes: json["notes"] == null ? null : Notes.fromJson(json["notes"]),
        amount: json["amount"],
        entity: entityValues.map[json["entity"]]!,
        status: dataStatusValues.map[json["status"]]!,
        receipt: json["receipt"],
        attempts: json["attempts"],
        currency: currencyValues.map[json["currency"]]!,
        offerId: json["offer_id"],
        amountDue: json["amount_due"],
        createdAt: json["created_at"],
        amountPaid: json["amount_paid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "notes": notes?.toJson(),
        "amount": amount,
        "entity": entityValues.reverse[entity],
        "status": dataStatusValues.reverse[status],
        "receipt": receipt,
        "attempts": attempts,
        "currency": currencyValues.reverse[currency],
        "offer_id": offerId,
        "amount_due": amountDue,
        "created_at": createdAt,
        "amount_paid": amountPaid,
      };
}

enum Currency { INR }

final currencyValues = EnumValues({"INR": Currency.INR});

enum Entity { ORDER }

final entityValues = EnumValues({"order": Entity.ORDER});

class Notes {
  final NotesCustomer? customer;
  final String? idempotencyKey;

  Notes({
    this.customer,
    this.idempotencyKey,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        customer: json["customer"] == null
            ? null
            : NotesCustomer.fromJson(json["customer"]),
        idempotencyKey: json["idempotency_key"],
      );

  Map<String, dynamic> toJson() => {
        "customer": customer?.toJson(),
        "idempotency_key": idempotencyKey,
      };
}

class NotesCustomer {
  final CustomerId? id;
  final Email? email;
  final dynamic phone;
  final dynamic metadata;
  final List<Address>? addresses;
  final dynamic lastName;
  final dynamic firstName;
  final dynamic companyName;
  final List<dynamic>? accountHolders;
  final Address? billingAddress;

  NotesCustomer({
    this.id,
    this.email,
    this.phone,
    this.metadata,
    this.addresses,
    this.lastName,
    this.firstName,
    this.companyName,
    this.accountHolders,
    this.billingAddress,
  });

  factory NotesCustomer.fromJson(Map<String, dynamic> json) => NotesCustomer(
        id: customerIdValues.map[json["id"]]!,
        email: emailValues.map[json["email"]]!,
        phone: json["phone"],
        metadata: json["metadata"],
        addresses: json["addresses"] == null
            ? []
            : List<Address>.from(
                json["addresses"]!.map((x) => Address.fromJson(x))),
        lastName: json["last_name"],
        firstName: json["first_name"],
        companyName: json["company_name"],
        accountHolders: json["account_holders"] == null
            ? []
            : List<dynamic>.from(json["account_holders"]!.map((x) => x)),
        billingAddress: json["billing_address"] == null
            ? null
            : Address.fromJson(json["billing_address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": customerIdValues.reverse[id],
        "email": emailValues.reverse[email],
        "phone": phone,
        "metadata": metadata,
        "addresses": addresses == null
            ? []
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
        "last_name": lastName,
        "first_name": firstName,
        "company_name": companyName,
        "account_holders": accountHolders == null
            ? []
            : List<dynamic>.from(accountHolders!.map((x) => x)),
        "billing_address": billingAddress?.toJson(),
      };
}

class Address {
  final Id? id;
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
  final CustomerId? customerId;
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

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: idValues.map[json["id"]]!,
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
        customerId: customerIdValues.map[json["customer_id"]]!,
        postalCode: json["postal_code"],
        addressName: addressNameValues.map[json["address_name"]]!,
        countryCode: json["country_code"],
        isDefaultBilling: json["is_default_billing"],
        isDefaultShipping: json["is_default_shipping"],
      );

  Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
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
        "customer_id": customerIdValues.reverse[customerId],
        "postal_code": postalCode,
        "address_name": addressNameValues.reverse[addressName],
        "country_code": countryCode,
        "is_default_billing": isDefaultBilling,
        "is_default_shipping": isDefaultShipping,
      };
}

enum Address1 { B_304_NANCY_BRAMHA, CFERVGEVEGRVRE, LANCE_DOWN, NVSKO }

final address1Values = EnumValues({
  "  B 304 nancy bramha": Address1.B_304_NANCY_BRAMHA,
  "cfervgevegrvre": Address1.CFERVGEVEGRVRE,
  "LanceDown ": Address1.LANCE_DOWN,
  "nvsko": Address1.NVSKO
});

enum AddressName { DEFAULT }

final addressNameValues = EnumValues({"Default": AddressName.DEFAULT});

enum City { BANGALORE, EFVGREGVGT, NEW_YORK, NVKSO }

final cityValues = EnumValues({
  "Bangalore": City.BANGALORE,
  "efvgregvgt": City.EFVGREGVGT,
  "NewYork": City.NEW_YORK,
  "nvkso": City.NVKSO
});

enum FirstName { ARNAB, NCFJEHNCJUNF, SHUBHA }

final firstNameValues = EnumValues({
  "Arnab": FirstName.ARNAB,
  "ncfjehncjunf": FirstName.NCFJEHNCJUNF,
  "shubha": FirstName.SHUBHA
});

enum Id {
  CUADDR_01_JTKQ0_ZBPS48_K5_TS849_Q8_PB1_R,
  CUADDR_01_JTKQ2_EGSEYP5_FHJZ1_WJXH7_BQ,
  CUADDR_01_JTKQ2_P3_BHGZ6_MCQH7_JMKW74_G,
  CUADDR_01_JTKQCNCH4_V0_MTNP6_PZ8_Y9_XCM,
  CUADDR_01_JTMPZ7_XAAJAYYFD3_VKYAMWA0,
  CUADDR_01_JTN6_J3_Y7_WHSXRA5_X54173_QH6,
  CUADDR_01_JV6_WK7_ZNAVVM0_TS0_VQ6_GVVS9,
  CUADDR_01_JVEMKARD4960_GEF4_SY03_GEB5
}

final idValues = EnumValues({
  "cuaddr_01JTKQ0ZBPS48K5TS849Q8PB1R":
      Id.CUADDR_01_JTKQ0_ZBPS48_K5_TS849_Q8_PB1_R,
  "cuaddr_01JTKQ2EGSEYP5FHJZ1WJXH7BQ":
      Id.CUADDR_01_JTKQ2_EGSEYP5_FHJZ1_WJXH7_BQ,
  "cuaddr_01JTKQ2P3BHGZ6MCQH7JMKW74G":
      Id.CUADDR_01_JTKQ2_P3_BHGZ6_MCQH7_JMKW74_G,
  "cuaddr_01JTKQCNCH4V0MTNP6PZ8Y9XCM":
      Id.CUADDR_01_JTKQCNCH4_V0_MTNP6_PZ8_Y9_XCM,
  "cuaddr_01JTMPZ7XAAJAYYFD3VKYAMWA0": Id.CUADDR_01_JTMPZ7_XAAJAYYFD3_VKYAMWA0,
  "cuaddr_01JTN6J3Y7WHSXRA5X54173QH6":
      Id.CUADDR_01_JTN6_J3_Y7_WHSXRA5_X54173_QH6,
  "cuaddr_01JV6WK7ZNAVVM0TS0VQ6GVVS9":
      Id.CUADDR_01_JV6_WK7_ZNAVVM0_TS0_VQ6_GVVS9,
  "cuaddr_01JVEMKARD4960GEF4SY03GEB5": Id.CUADDR_01_JVEMKARD4960_GEF4_SY03_GEB5
});

enum LastName { BANERJEE, FERCERFCERFCE, GHOSH, LAST_NAME_BANERJEE }

final lastNameValues = EnumValues({
  "banerjee": LastName.BANERJEE,
  "fercerfcerfce": LastName.FERCERFCERFCE,
  "ghosh": LastName.GHOSH,
  "Banerjee": LastName.LAST_NAME_BANERJEE
});

enum Province { BANGALORE, EMPTY }

final provinceValues =
    EnumValues({"bangalore": Province.BANGALORE, "": Province.EMPTY});

enum DataStatus { CREATED }

final dataStatusValues = EnumValues({"created": DataStatus.CREATED});

enum ProviderId { PP_RAZORPAY_RAZORPAY }

final providerIdValues =
    EnumValues({"pp_razorpay_razorpay": ProviderId.PP_RAZORPAY_RAZORPAY});

enum PaymentStatusEnum { AUTHORIZED }

final paymentStatusEnumValues =
    EnumValues({"authorized": PaymentStatusEnum.AUTHORIZED});

enum PurpleStatus { PENDING }

final purpleStatusValues = EnumValues({"pending": PurpleStatus.PENDING});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
