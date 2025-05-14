// To parse this JSON data, do
//
//     final completeVendor = completeVendorFromJson(jsonString);

import 'dart:convert';

CompleteVendor completeVendorFromJson(String str) =>
    CompleteVendor.fromJson(json.decode(str));

String completeVendorToJson(CompleteVendor data) => json.encode(data.toJson());

class CompleteVendor {
  final OrderSet orderSet;

  CompleteVendor({
    required this.orderSet,
  });

  factory CompleteVendor.fromJson(Map<String, dynamic> json) => CompleteVendor(
        orderSet: OrderSet.fromJson(json["order_set"]),
      );

  Map<String, dynamic> toJson() => {
        "order_set": orderSet.toJson(),
      };
}

class OrderSet {
  final String id;
  final DateTime updatedAt;
  final DateTime createdAt;
  final dynamic displayId;
  final String customerId;
  final String cartId;
  final String paymentCollectionId;
  final OrderSetCustomer customer;
  final Cart cart;
  final PaymentCollection paymentCollection;
  final List<Order> orders;
  final String status;
  final String paymentStatus;
  final String fulfillmentStatus;
  final int taxTotal;
  final int shippingTaxTotal;
  final int shippingTotal;
  final int total;
  final int subtotal;

  OrderSet({
    required this.id,
    required this.updatedAt,
    required this.createdAt,
    required this.displayId,
    required this.customerId,
    required this.cartId,
    required this.paymentCollectionId,
    required this.customer,
    required this.cart,
    required this.paymentCollection,
    required this.orders,
    required this.status,
    required this.paymentStatus,
    required this.fulfillmentStatus,
    required this.taxTotal,
    required this.shippingTaxTotal,
    required this.shippingTotal,
    required this.total,
    required this.subtotal,
  });

  factory OrderSet.fromJson(Map<String, dynamic> json) => OrderSet(
        id: json["id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        displayId: json["display_id"],
        customerId: json["customer_id"],
        cartId: json["cart_id"],
        paymentCollectionId: json["payment_collection_id"],
        customer: OrderSetCustomer.fromJson(json["customer"]),
        cart: Cart.fromJson(json["cart"]),
        paymentCollection:
            PaymentCollection.fromJson(json["payment_collection"]),
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
        status: json["status"],
        paymentStatus: json["payment_status"],
        fulfillmentStatus: json["fulfillment_status"],
        taxTotal: json["tax_total"],
        shippingTaxTotal: json["shipping_tax_total"],
        shippingTotal: json["shipping_total"],
        total: json["total"],
        subtotal: json["subtotal"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "display_id": displayId,
        "customer_id": customerId,
        "cart_id": cartId,
        "payment_collection_id": paymentCollectionId,
        "customer": customer.toJson(),
        "cart": cart.toJson(),
        "payment_collection": paymentCollection.toJson(),
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
        "status": status,
        "payment_status": paymentStatus,
        "fulfillment_status": fulfillmentStatus,
        "tax_total": taxTotal,
        "shipping_tax_total": shippingTaxTotal,
        "shipping_total": shippingTotal,
        "total": total,
        "subtotal": subtotal,
      };
}

class Cart {
  final String id;
  final String regionId;
  final String customerId;
  final String salesChannelId;
  final String email;
  final String currencyCode;
  final dynamic metadata;
  final DateTime completedAt;
  final ShippingAddress shippingAddress;
  final dynamic billingAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String shippingAddressId;

  Cart({
    required this.id,
    required this.regionId,
    required this.customerId,
    required this.salesChannelId,
    required this.email,
    required this.currencyCode,
    required this.metadata,
    required this.completedAt,
    required this.shippingAddress,
    required this.billingAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.shippingAddressId,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        regionId: json["region_id"],
        customerId: json["customer_id"],
        salesChannelId: json["sales_channel_id"],
        email: json["email"],
        currencyCode: json["currency_code"],
        metadata: json["metadata"],
        completedAt: DateTime.parse(json["completed_at"]),
        shippingAddress: ShippingAddress.fromJson(json["shipping_address"]),
        billingAddress: json["billing_address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        shippingAddressId: json["shipping_address_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "region_id": regionId,
        "customer_id": customerId,
        "sales_channel_id": salesChannelId,
        "email": email,
        "currency_code": currencyCode,
        "metadata": metadata,
        "completed_at": completedAt.toIso8601String(),
        "shipping_address": shippingAddress.toJson(),
        "billing_address": billingAddress,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "shipping_address_id": shippingAddressId,
      };
}

class ShippingAddress {
  final String id;

  ShippingAddress({
    required this.id,
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
  final String id;
  final dynamic companyName;
  final dynamic firstName;
  final dynamic lastName;
  final String email;
  final dynamic phone;
  final bool hasAccount;
  final dynamic metadata;
  final dynamic createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  OrderSetCustomer({
    required this.id,
    required this.companyName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.hasAccount,
    required this.metadata,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory OrderSetCustomer.fromJson(Map<String, dynamic> json) =>
      OrderSetCustomer(
        id: json["id"],
        companyName: json["company_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        hasAccount: json["has_account"],
        metadata: json["metadata"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "has_account": hasAccount,
        "metadata": metadata,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class Order {
  final String customerId;
  final String id;
  final String currencyCode;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final int total;
  final int subtotal;
  final int taxTotal;
  final int discountTotal;
  final int discountTaxTotal;
  final int originalTotal;
  final int originalTaxTotal;
  final int itemTotal;
  final int itemSubtotal;
  final int itemTaxTotal;
  final String salesChannelId;
  final int originalItemTotal;
  final int originalItemSubtotal;
  final int originalItemTaxTotal;
  final int shippingTotal;
  final int shippingSubtotal;
  final int shippingTaxTotal;
  final List<Item> items;
  final OrderSetCustomer customer;
  final List<dynamic> fulfillments;
  final List<PaymentCollection> paymentCollections;
  final String paymentStatus;
  final String fulfillmentStatus;

  Order({
    required this.customerId,
    required this.id,
    required this.currencyCode,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.total,
    required this.subtotal,
    required this.taxTotal,
    required this.discountTotal,
    required this.discountTaxTotal,
    required this.originalTotal,
    required this.originalTaxTotal,
    required this.itemTotal,
    required this.itemSubtotal,
    required this.itemTaxTotal,
    required this.salesChannelId,
    required this.originalItemTotal,
    required this.originalItemSubtotal,
    required this.originalItemTaxTotal,
    required this.shippingTotal,
    required this.shippingSubtotal,
    required this.shippingTaxTotal,
    required this.items,
    required this.customer,
    required this.fulfillments,
    required this.paymentCollections,
    required this.paymentStatus,
    required this.fulfillmentStatus,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        customerId: json["customer_id"],
        id: json["id"],
        currencyCode: json["currency_code"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
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
        salesChannelId: json["sales_channel_id"],
        originalItemTotal: json["original_item_total"],
        originalItemSubtotal: json["original_item_subtotal"],
        originalItemTaxTotal: json["original_item_tax_total"],
        shippingTotal: json["shipping_total"],
        shippingSubtotal: json["shipping_subtotal"],
        shippingTaxTotal: json["shipping_tax_total"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        customer: OrderSetCustomer.fromJson(json["customer"]),
        fulfillments: List<dynamic>.from(json["fulfillments"].map((x) => x)),
        paymentCollections: List<PaymentCollection>.from(
            json["payment_collections"]
                .map((x) => PaymentCollection.fromJson(x))),
        paymentStatus: json["payment_status"],
        fulfillmentStatus: json["fulfillment_status"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "id": id,
        "currency_code": currencyCode,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
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
        "sales_channel_id": salesChannelId,
        "original_item_total": originalItemTotal,
        "original_item_subtotal": originalItemSubtotal,
        "original_item_tax_total": originalItemTaxTotal,
        "shipping_total": shippingTotal,
        "shipping_subtotal": shippingSubtotal,
        "shipping_tax_total": shippingTaxTotal,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "customer": customer.toJson(),
        "fulfillments": List<dynamic>.from(fulfillments.map((x) => x)),
        "payment_collections":
            List<dynamic>.from(paymentCollections.map((x) => x.toJson())),
        "payment_status": paymentStatus,
        "fulfillment_status": fulfillmentStatus,
      };
}

class Item {
  final String id;
  final String title;
  final String subtitle;
  final dynamic thumbnail;
  final String variantId;
  final String productId;
  final String productTitle;
  final dynamic productDescription;
  final dynamic productSubtitle;
  final dynamic productType;
  final dynamic productTypeId;
  final dynamic productCollection;
  final String productHandle;
  final dynamic variantSku;
  final dynamic variantBarcode;
  final String variantTitle;
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
        title: json["title"],
        subtitle: json["subtitle"],
        thumbnail: json["thumbnail"],
        variantId: json["variant_id"],
        productId: json["product_id"],
        productTitle: json["product_title"],
        productDescription: json["product_description"],
        productSubtitle: json["product_subtitle"],
        productType: json["product_type"],
        productTypeId: json["product_type_id"],
        productCollection: json["product_collection"],
        productHandle: json["product_handle"],
        variantSku: json["variant_sku"],
        variantBarcode: json["variant_barcode"],
        variantTitle: json["variant_title"],
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
        "title": title,
        "subtitle": subtitle,
        "thumbnail": thumbnail,
        "variant_id": variantId,
        "product_id": productId,
        "product_title": productTitle,
        "product_description": productDescription,
        "product_subtitle": productSubtitle,
        "product_type": productType,
        "product_type_id": productTypeId,
        "product_collection": productCollection,
        "product_handle": productHandle,
        "variant_sku": variantSku,
        "variant_barcode": variantBarcode,
        "variant_title": variantTitle,
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

class PaymentCollection {
  final String id;
  final String currencyCode;
  final dynamic completedAt;
  final String status;
  final dynamic metadata;
  final Raw rawAmount;
  final Raw rawAuthorizedAmount;
  final Raw rawCapturedAmount;
  final Raw rawRefundedAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final List<Payment>? payments;
  final int amount;
  final int authorizedAmount;
  final int capturedAmount;
  final int refundedAmount;

  PaymentCollection({
    required this.id,
    required this.currencyCode,
    required this.completedAt,
    required this.status,
    required this.metadata,
    required this.rawAmount,
    required this.rawAuthorizedAmount,
    required this.rawCapturedAmount,
    required this.rawRefundedAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    this.payments,
    required this.amount,
    required this.authorizedAmount,
    required this.capturedAmount,
    required this.refundedAmount,
  });

  factory PaymentCollection.fromJson(Map<String, dynamic> json) =>
      PaymentCollection(
        id: json["id"],
        currencyCode: json["currency_code"],
        completedAt: json["completed_at"],
        status: json["status"],
        metadata: json["metadata"],
        rawAmount: Raw.fromJson(json["raw_amount"]),
        rawAuthorizedAmount: Raw.fromJson(json["raw_authorized_amount"]),
        rawCapturedAmount: Raw.fromJson(json["raw_captured_amount"]),
        rawRefundedAmount: Raw.fromJson(json["raw_refunded_amount"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "currency_code": currencyCode,
        "completed_at": completedAt,
        "status": status,
        "metadata": metadata,
        "raw_amount": rawAmount.toJson(),
        "raw_authorized_amount": rawAuthorizedAmount.toJson(),
        "raw_captured_amount": rawCapturedAmount.toJson(),
        "raw_refunded_amount": rawRefundedAmount.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
  final String id;
  final String currencyCode;
  final String providerId;
  final Data data;
  final dynamic metadata;
  final dynamic capturedAt;
  final dynamic canceledAt;
  final String paymentCollectionId;
  final ShippingAddress paymentSession;
  final Raw rawAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String paymentSessionId;
  final List<dynamic> refunds;
  final int amount;

  Payment({
    required this.id,
    required this.currencyCode,
    required this.providerId,
    required this.data,
    required this.metadata,
    required this.capturedAt,
    required this.canceledAt,
    required this.paymentCollectionId,
    required this.paymentSession,
    required this.rawAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.paymentSessionId,
    required this.refunds,
    required this.amount,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        currencyCode: json["currency_code"],
        providerId: json["provider_id"],
        data: Data.fromJson(json["data"]),
        metadata: json["metadata"],
        capturedAt: json["captured_at"],
        canceledAt: json["canceled_at"],
        paymentCollectionId: json["payment_collection_id"],
        paymentSession: ShippingAddress.fromJson(json["payment_session"]),
        rawAmount: Raw.fromJson(json["raw_amount"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        paymentSessionId: json["payment_session_id"],
        refunds: List<dynamic>.from(json["refunds"].map((x) => x)),
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency_code": currencyCode,
        "provider_id": providerId,
        "data": data.toJson(),
        "metadata": metadata,
        "captured_at": capturedAt,
        "canceled_at": canceledAt,
        "payment_collection_id": paymentCollectionId,
        "payment_session": paymentSession.toJson(),
        "raw_amount": rawAmount.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "payment_session_id": paymentSessionId,
        "refunds": List<dynamic>.from(refunds.map((x) => x)),
        "amount": amount,
      };
}

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
  final NotesCustomer customer;
  final String idempotencyKey;

  Notes({
    required this.customer,
    required this.idempotencyKey,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        customer: NotesCustomer.fromJson(json["customer"]),
        idempotencyKey: json["idempotency_key"],
      );

  Map<String, dynamic> toJson() => {
        "customer": customer.toJson(),
        "idempotency_key": idempotencyKey,
      };
}

class NotesCustomer {
  final String id;
  final String email;
  final dynamic phone;
  final dynamic metadata;
  final List<Address> addresses;
  final dynamic lastName;
  final dynamic firstName;
  final dynamic companyName;
  final List<dynamic> accountHolders;
  final Address billingAddress;

  NotesCustomer({
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

  factory NotesCustomer.fromJson(Map<String, dynamic> json) => NotesCustomer(
        id: json["id"],
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
        "id": id,
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
  final String city;
  final String phone;
  final dynamic company;
  final dynamic metadata;
  final String province;
  final String address1;
  final dynamic address2;
  final String lastName;
  final DateTime createdAt;
  final dynamic deletedAt;
  final String firstName;
  final DateTime updatedAt;
  final String customerId;
  final String postalCode;
  final String addressName;
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
        province: json["province"],
        address1: json["address_1"],
        address2: json["address_2"],
        lastName: json["last_name"],
        createdAt: DateTime.parse(json["created_at"]),
        deletedAt: json["deleted_at"],
        firstName: json["first_name"],
        updatedAt: DateTime.parse(json["updated_at"]),
        customerId: json["customer_id"],
        postalCode: json["postal_code"],
        addressName: json["address_name"],
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
        "province": province,
        "address_1": address1,
        "address_2": address2,
        "last_name": lastName,
        "created_at": createdAt.toIso8601String(),
        "deleted_at": deletedAt,
        "first_name": firstName,
        "updated_at": updatedAt.toIso8601String(),
        "customer_id": customerId,
        "postal_code": postalCode,
        "address_name": addressName,
        "country_code": countryCode,
        "is_default_billing": isDefaultBilling,
        "is_default_shipping": isDefaultShipping,
      };
}
