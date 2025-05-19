// To parse this JSON data, do
//
//     final orderDetails = orderDetailsFromJson(jsonString);

import 'dart:convert';

OrderDetails orderDetailsFromJson(String str) =>
    OrderDetails.fromJson(json.decode(str));

String orderDetailsToJson(OrderDetails data) => json.encode(data.toJson());

class OrderDetails {
  final int limit;
  final int offset;
  final int count;
  final List<Order> orders;

  OrderDetails({
    required this.limit,
    required this.offset,
    required this.count,
    required this.orders,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      limit: json['limit'] as int,
      offset: json['offset'] as int,
      count: json['count'] as int,
      orders: (json['orders'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'limit': limit,
        'offset': offset,
        'count': count,
        'orders': orders.map((e) => e.toJson()).toList(),
      };
}

class Order {
  final String id;
  final String? cartId;
  final String? email;
  final String? billingAddressId;
  final String? shippingAddressId;
  final String? regionId;
  final String? currencyCode;
  final int? taxRate; // in percentage * 100 (e.g., 750 = 7.5%)
  final String? customerId;
  final String? paymentStatus;
  final String? fulfillmentStatus;
  final String? status;
  final int? total; // total amount in smallest currency unit
  final int? subtotal;
  final int? discountTotal;
  final int? taxTotal;
  final int? refundedTotal;
  final int? shippingTotal;
  final int? giftCardTotal;
  final int? paidTotal;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? canceledAt;
  final DateTime? completedAt;
  final List<OrderItem>? items;
  final List<ShippingMethod>? shippingMethods;
  final List<PaymentInOrderDetails>? payments;
  final List<Discount>? discounts;
  final List<TaxLine>? taxLines;
  final List<GiftCard>? giftCards;
  final List<Return>? returns;
  final List<Claim>? claims;
  final String? idempotencyKey;
  final String? externalId;
  final String? swapId;
  final String? cart;
  final String? customer;
  final String? shippingAddress;
  final String? billingAddress;
  // Add other nested relations or optional fields as needed

  Order({
    required this.id,
    this.cartId,
    this.email,
    this.billingAddressId,
    this.shippingAddressId,
    this.regionId,
    this.currencyCode,
    this.taxRate,
    this.customerId,
    this.paymentStatus,
    this.fulfillmentStatus,
    this.status,
    this.total,
    this.subtotal,
    this.discountTotal,
    this.taxTotal,
    this.refundedTotal,
    this.shippingTotal,
    this.giftCardTotal,
    this.paidTotal,
    this.createdAt,
    this.updatedAt,
    this.canceledAt,
    this.completedAt,
    this.items,
    this.shippingMethods,
    this.payments,
    this.discounts,
    this.taxLines,
    this.giftCards,
    this.returns,
    this.claims,
    this.idempotencyKey,
    this.externalId,
    this.swapId,
    this.cart,
    this.customer,
    this.shippingAddress,
    this.billingAddress,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      cartId: json['cart_id'] as String?,
      email: json['email'] as String?,
      billingAddressId: json['billing_address_id'] as String?,
      shippingAddressId: json['shipping_address_id'] as String?,
      regionId: json['region_id'] as String?,
      currencyCode: json['currency_code'] as String?,
      taxRate:
          json['tax_rate'] != null ? (json['tax_rate'] as num).toInt() : null,
      customerId: json['customer_id'] as String?,
      paymentStatus: json['payment_status'] as String?,
      fulfillmentStatus: json['fulfillment_status'] as String?,
      status: json['status'] as String?,
      total: json['total'] as int?,
      subtotal: json['subtotal'] as int?,
      discountTotal: json['discount_total'] as int?,
      taxTotal: json['tax_total'] as int?,
      refundedTotal: json['refunded_total'] as int?,
      shippingTotal: json['shipping_total'] as int?,
      giftCardTotal: json['gift_card_total'] as int?,
      paidTotal: json['paid_total'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      canceledAt: json['canceled_at'] != null
          ? DateTime.parse(json['canceled_at'])
          : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
      items: json['items'] != null
          ? (json['items'] as List<dynamic>)
              .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      shippingMethods: json['shipping_methods'] != null
          ? (json['shipping_methods'] as List<dynamic>)
              .map((e) => ShippingMethod.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      payments: json['payments'] != null
          ? (json['payments'] as List<dynamic>)
              .map((e) =>
                  PaymentInOrderDetails.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      discounts: json['discounts'] != null
          ? (json['discounts'] as List<dynamic>)
              .map((e) => Discount.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      taxLines: json['tax_lines'] != null
          ? (json['tax_lines'] as List<dynamic>)
              .map((e) => TaxLine.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      giftCards: json['gift_cards'] != null
          ? (json['gift_cards'] as List<dynamic>)
              .map((e) => GiftCard.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      returns: json['returns'] != null
          ? (json['returns'] as List<dynamic>)
              .map((e) => Return.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      claims: json['claims'] != null
          ? (json['claims'] as List<dynamic>)
              .map((e) => Claim.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      idempotencyKey: json['idempotency_key'] as String?,
      externalId: json['external_id'] as String?,
      swapId: json['swap_id'] as String?,
      cart: json['cart'] as String?,
      customer: json['customer'] as String?,
      shippingAddress: json['shipping_address'] as String?,
      billingAddress: json['billing_address'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'cart_id': cartId,
        'email': email,
        'billing_address_id': billingAddressId,
        'shipping_address_id': shippingAddressId,
        'region_id': regionId,
        'currency_code': currencyCode,
        'tax_rate': taxRate,
        'customer_id': customerId,
        'payment_status': paymentStatus,
        'fulfillment_status': fulfillmentStatus,
        'status': status,
        'total': total,
        'subtotal': subtotal,
        'discount_total': discountTotal,
        'tax_total': taxTotal,
        'refunded_total': refundedTotal,
        'shipping_total': shippingTotal,
        'gift_card_total': giftCardTotal,
        'paid_total': paidTotal,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'canceled_at': canceledAt?.toIso8601String(),
        'completed_at': completedAt?.toIso8601String(),
        'items': items?.map((e) => e.toJson()).toList(),
        'shipping_methods': shippingMethods?.map((e) => e.toJson()).toList(),
        'payments': payments?.map((e) => e.toJson()).toList(),
        'discounts': discounts?.map((e) => e.toJson()).toList(),
        'tax_lines': taxLines?.map((e) => e.toJson()).toList(),
        'gift_cards': giftCards?.map((e) => e.toJson()).toList(),
        'returns': returns?.map((e) => e.toJson()).toList(),
        'claims': claims?.map((e) => e.toJson()).toList(),
        'idempotency_key': idempotencyKey,
        'external_id': externalId,
        'swap_id': swapId,
        'cart': cart,
        'customer': customer,
        'shipping_address': shippingAddress,
        'billing_address': billingAddress,
      };
}

// Example nested classes (simplified, expand as needed):

class OrderItem {
  final String id;
  final String title;
  final int quantity;
  final int unitPrice;
  final int total;
  final String thumbnail;
//  "title": "Polo T-shirts (Black)",
//                     "subtitle": "Polo T-shirts",
  final String subtitle;

  OrderItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.unitPrice,
    required this.total,
    required this.thumbnail,
    required this.subtitle,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] as String,
      title: json['title'] as String,
      quantity: json['quantity'] as int,
      unitPrice: json['unit_price'] as int,
      total: json['total'] as int,
      thumbnail: json['thumbnail'] as String,
      subtitle: json['subtitle'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'quantity': quantity,
        'unit_price': unitPrice,
        'total': total,
        'thumbnail': thumbnail,
        'subtitle': subtitle,
      };
}

class ShippingMethod {
  final String id;
  final String name;
  final int amount;

  ShippingMethod({
    required this.id,
    required this.name,
    required this.amount,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) {
    return ShippingMethod(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: json['amount'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'amount': amount,
      };
}

class PaymentInOrderDetails {
  final String id;
  final String status;
  final int amount;

  PaymentInOrderDetails({
    required this.id,
    required this.status,
    required this.amount,
  });

  factory PaymentInOrderDetails.fromJson(Map<String, dynamic> json) {
    return PaymentInOrderDetails(
      id: json['id'] as String,
      status: json['status'] as String,
      amount: json['amount'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'amount': amount,
      };
}

class Discount {
  final String code;
  final int amount;

  Discount({
    required this.code,
    required this.amount,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      code: json['code'] as String,
      amount: json['amount'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'amount': amount,
      };
}

class TaxLine {
  final String name;
  final int rate;
  final int amount;

  TaxLine({
    required this.name,
    required this.rate,
    required this.amount,
  });

  factory TaxLine.fromJson(Map<String, dynamic> json) {
    return TaxLine(
      name: json['name'] as String,
      rate: json['rate'] as int,
      amount: json['amount'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'rate': rate,
        'amount': amount,
      };
}

class GiftCard {
  final String id;
  final int balance;

  GiftCard({
    required this.id,
    required this.balance,
  });

  factory GiftCard.fromJson(Map<String, dynamic> json) {
    return GiftCard(
      id: json['id'] as String,
      balance: json['balance'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'balance': balance,
      };
}

class Return {
  final String id;
  final String status;

  Return({
    required this.id,
    required this.status,
  });

  factory Return.fromJson(Map<String, dynamic> json) {
    return Return(
      id: json['id'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
      };
}

class Claim {
  final String id;
  final String type;

  Claim({
    required this.id,
    required this.type,
  });

  factory Claim.fromJson(Map<String, dynamic> json) {
    return Claim(
      id: json['id'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
      };
}
