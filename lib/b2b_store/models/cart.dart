import 'dart:convert';

import 'package:woloo_smart_hygiene/utils/logger.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  final Cart cart;

  CartModel({
    required this.cart,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    try {
      return CartModel(
        cart: Cart.fromJson(json["cart"]),
      );
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        "cart": cart.toJson(),
      };
}

class Cart {
  final String id;
  final String currencyCode;
  final String email;
  final String regionId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic completedAt;
  final int total;
  final int subtotal;
  final int taxTotal;
  final int discountTotal;
  final int discountSubtotal;
  final int discountTaxTotal;
  final int originalTotal;
  final int originalTaxTotal;
  final int itemTotal;
  final int itemSubtotal;
  final int itemTaxTotal;
  final int originalItemTotal;
  final int originalItemSubtotal;
  final int originalItemTaxTotal;
  final int shippingTotal;
  final int shippingSubtotal;
  final int shippingTaxTotal;
  final int originalShippingTaxTotal;
  final int originalShippingSubtotal;
  final int originalShippingTotal;
  final int creditLineSubtotal;
  final int creditLineTaxTotal;
  final int creditLineTotal;
  final dynamic metadata;
  final String salesChannelId;
  final String shippingAddressId;
  final String customerId;
  final List<Item> items;
  final List<dynamic> shippingMethods;
  final ShippingAddress shippingAddress;
  final dynamic billingAddress;
  final List<dynamic> creditLines;
  final Customer customer;
  final Region region;
  final List<dynamic> promotions;

  Cart({
    required this.id,
    required this.currencyCode,
    required this.email,
    required this.regionId,
    required this.createdAt,
    required this.updatedAt,
    required this.completedAt,
    required this.total,
    required this.subtotal,
    required this.taxTotal,
    required this.discountTotal,
    required this.discountSubtotal,
    required this.discountTaxTotal,
    required this.originalTotal,
    required this.originalTaxTotal,
    required this.itemTotal,
    required this.itemSubtotal,
    required this.itemTaxTotal,
    required this.originalItemTotal,
    required this.originalItemSubtotal,
    required this.originalItemTaxTotal,
    required this.shippingTotal,
    required this.shippingSubtotal,
    required this.shippingTaxTotal,
    required this.originalShippingTaxTotal,
    required this.originalShippingSubtotal,
    required this.originalShippingTotal,
    required this.creditLineSubtotal,
    required this.creditLineTaxTotal,
    required this.creditLineTotal,
    required this.metadata,
    required this.salesChannelId,
    required this.shippingAddressId,
    required this.customerId,
    required this.items,
    required this.shippingMethods,
    required this.shippingAddress,
    required this.billingAddress,
    required this.creditLines,
    required this.customer,
    required this.region,
    required this.promotions,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        currencyCode: json["currency_code"],
        email: json["email"],
        regionId: json["region_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        completedAt: json["completed_at"],
        total: json["total"],
        subtotal: json["subtotal"],
        taxTotal: json["tax_total"],
        discountTotal: json["discount_total"],
        discountSubtotal: json["discount_subtotal"],
        discountTaxTotal: json["discount_tax_total"],
        originalTotal: json["original_total"],
        originalTaxTotal: json["original_tax_total"],
        itemTotal: json["item_total"],
        itemSubtotal: json["item_subtotal"],
        itemTaxTotal: json["item_tax_total"],
        originalItemTotal: json["original_item_total"],
        originalItemSubtotal: json["original_item_subtotal"],
        originalItemTaxTotal: json["original_item_tax_total"],
        shippingTotal: json["shipping_total"],
        shippingSubtotal: json["shipping_subtotal"],
        shippingTaxTotal: json["shipping_tax_total"],
        originalShippingTaxTotal: json["original_shipping_tax_total"],
        originalShippingSubtotal: json["original_shipping_subtotal"],
        originalShippingTotal: json["original_shipping_total"],
        creditLineSubtotal: json["credit_line_subtotal"],
        creditLineTaxTotal: json["credit_line_tax_total"],
        creditLineTotal: json["credit_line_total"],
        metadata: json["metadata"],
        salesChannelId: json["sales_channel_id"],
        shippingAddressId: json["shipping_address_id"],
        customerId: json["customer_id"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        shippingMethods:
            List<dynamic>.from(json["shipping_methods"].map((x) => x)),
        shippingAddress: ShippingAddress.fromJson(json["shipping_address"]),
        billingAddress: json["billing_address"],
        creditLines: List<dynamic>.from(json["credit_lines"].map((x) => x)),
        customer: Customer.fromJson(json["customer"]),
        region: Region.fromJson(json["region"]),
        promotions: List<dynamic>.from(json["promotions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency_code": currencyCode,
        "email": email,
        "region_id": regionId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "completed_at": completedAt,
        "total": total,
        "subtotal": subtotal,
        "tax_total": taxTotal,
        "discount_total": discountTotal,
        "discount_subtotal": discountSubtotal,
        "discount_tax_total": discountTaxTotal,
        "original_total": originalTotal,
        "original_tax_total": originalTaxTotal,
        "item_total": itemTotal,
        "item_subtotal": itemSubtotal,
        "item_tax_total": itemTaxTotal,
        "original_item_total": originalItemTotal,
        "original_item_subtotal": originalItemSubtotal,
        "original_item_tax_total": originalItemTaxTotal,
        "shipping_total": shippingTotal,
        "shipping_subtotal": shippingSubtotal,
        "shipping_tax_total": shippingTaxTotal,
        "original_shipping_tax_total": originalShippingTaxTotal,
        "original_shipping_subtotal": originalShippingSubtotal,
        "original_shipping_total": originalShippingTotal,
        "credit_line_subtotal": creditLineSubtotal,
        "credit_line_tax_total": creditLineTaxTotal,
        "credit_line_total": creditLineTotal,
        "metadata": metadata,
        "sales_channel_id": salesChannelId,
        "shipping_address_id": shippingAddressId,
        "customer_id": customerId,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "shipping_methods": List<dynamic>.from(shippingMethods.map((x) => x)),
        "shipping_address": shippingAddress.toJson(),
        "billing_address": billingAddress,
        "credit_lines": List<dynamic>.from(creditLines.map((x) => x)),
        "customer": customer.toJson(),
        "region": region.toJson(),
        "promotions": List<dynamic>.from(promotions.map((x) => x)),
      };
}

class Customer {
  final String id;
  final String email;
  final List<dynamic> groups;

  Customer({
    required this.id,
    required this.email,
    required this.groups,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        email: json["email"],
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "groups": List<dynamic>.from(groups.map((x) => x)),
      };
}

class Item {
  final String id;
  final dynamic thumbnail;
  final String variantId;
  final String productId;
  final dynamic productTypeId;
  final String productTitle;
  final dynamic productDescription;
  final dynamic productSubtitle;
  final dynamic productType;
  final dynamic productCollection;
  final String productHandle;
  final dynamic variantSku;
  final dynamic variantBarcode;
  final String variantTitle;
  final bool requiresShipping;
  final Metadata metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final int quantity;
  final int unitPrice;
  final dynamic compareAtUnitPrice;
  final bool isTaxInclusive;
  final List<dynamic> taxLines;
  final List<dynamic> adjustments;
  final Product product;

  Item({
    required this.id,
    required this.thumbnail,
    required this.variantId,
    required this.productId,
    required this.productTypeId,
    required this.productTitle,
    required this.productDescription,
    required this.productSubtitle,
    required this.productType,
    required this.productCollection,
    required this.productHandle,
    required this.variantSku,
    required this.variantBarcode,
    required this.variantTitle,
    required this.requiresShipping,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.quantity,
    required this.unitPrice,
    required this.compareAtUnitPrice,
    required this.isTaxInclusive,
    required this.taxLines,
    required this.adjustments,
    required this.product,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        thumbnail: json["thumbnail"],
        variantId: json["variant_id"],
        productId: json["product_id"],
        productTypeId: json["product_type_id"],
        productTitle: json["product_title"],
        productDescription: json["product_description"],
        productSubtitle: json["product_subtitle"],
        productType: json["product_type"],
        productCollection: json["product_collection"],
        productHandle: json["product_handle"],
        variantSku: json["variant_sku"],
        variantBarcode: json["variant_barcode"],
        variantTitle: json["variant_title"],
        requiresShipping: json["requires_shipping"],
        metadata: Metadata.fromJson(json["metadata"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        title: json["title"],
        quantity: json["quantity"],
        unitPrice: json["unit_price"],
        compareAtUnitPrice: json["compare_at_unit_price"],
        isTaxInclusive: json["is_tax_inclusive"],
        taxLines: List<dynamic>.from(json["tax_lines"].map((x) => x)),
        adjustments: List<dynamic>.from(json["adjustments"].map((x) => x)),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thumbnail": thumbnail,
        "variant_id": variantId,
        "product_id": productId,
        "product_type_id": productTypeId,
        "product_title": productTitle,
        "product_description": productDescription,
        "product_subtitle": productSubtitle,
        "product_type": productType,
        "product_collection": productCollection,
        "product_handle": productHandle,
        "variant_sku": variantSku,
        "variant_barcode": variantBarcode,
        "variant_title": variantTitle,
        "requires_shipping": requiresShipping,
        "metadata": metadata.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "title": title,
        "quantity": quantity,
        "unit_price": unitPrice,
        "compare_at_unit_price": compareAtUnitPrice,
        "is_tax_inclusive": isTaxInclusive,
        "tax_lines": List<dynamic>.from(taxLines.map((x) => x)),
        "adjustments": List<dynamic>.from(adjustments.map((x) => x)),
        "product": product.toJson(),
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}

class Product {
  final String id;
  final dynamic collectionId;
  final dynamic typeId;
  final List<dynamic> categories;
  final List<dynamic> tags;

  Product({
    required this.id,
    required this.collectionId,
    required this.typeId,
    required this.categories,
    required this.tags,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        collectionId: json["collection_id"],
        typeId: json["type_id"],
        categories: List<dynamic>.from(json["categories"].map((x) => x)),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "collection_id": collectionId,
        "type_id": typeId,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
      };
}

class Region {
  final String id;
  final String name;
  final String currencyCode;
  final bool automaticTaxes;
  final List<Country> countries;

  Region({
    required this.id,
    required this.name,
    required this.currencyCode,
    required this.automaticTaxes,
    required this.countries,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"],
        name: json["name"],
        currencyCode: json["currency_code"],
        automaticTaxes: json["automatic_taxes"],
        countries: List<Country>.from(
            json["countries"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "currency_code": currencyCode,
        "automatic_taxes": automaticTaxes,
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
      };
}

class Country {
  final String iso2;
  final String iso3;
  final String numCode;
  final String name;
  final String displayName;
  final String regionId;
  final dynamic metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  Country({
    required this.iso2,
    required this.iso3,
    required this.numCode,
    required this.name,
    required this.displayName,
    required this.regionId,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        iso2: json["iso_2"],
        iso3: json["iso_3"],
        numCode: json["num_code"],
        name: json["name"],
        displayName: json["display_name"],
        regionId: json["region_id"],
        metadata: json["metadata"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "iso_2": iso2,
        "iso_3": iso3,
        "num_code": numCode,
        "name": name,
        "display_name": displayName,
        "region_id": regionId,
        "metadata": metadata,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class ShippingAddress {
  final String id;
  final dynamic firstName;
  final dynamic lastName;
  final dynamic company;
  final dynamic address1;
  final dynamic address2;
  final dynamic city;
  final dynamic postalCode;
  final String countryCode;
  final dynamic province;
  final dynamic phone;

  ShippingAddress({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.postalCode,
    required this.countryCode,
    required this.province,
    required this.phone,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        postalCode: json["postal_code"],
        countryCode: json["country_code"],
        province: json["province"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "postal_code": postalCode,
        "country_code": countryCode,
        "province": province,
        "phone": phone,
      };
}

class Countries {
  String? iso2;
  String? iso3;
  String? numCode;
  String? name;
  String? displayName;
  String? regionId;
  dynamic metadata;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Countries(
      {this.iso2,
      this.iso3,
      this.numCode,
      this.name,
      this.displayName,
      this.regionId,
      this.metadata,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Countries.fromJson(Map<String, dynamic> json) {
    iso2 = json['iso_2'];
    iso3 = json['iso_3'];
    numCode = json['num_code'];
    name = json['name'];
    displayName = json['display_name'];
    regionId = json['region_id'];
    metadata = json['metadata'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iso_2'] = iso2;
    data['iso_3'] = iso3;
    data['num_code'] = numCode;
    data['name'] = name;
    data['display_name'] = displayName;
    data['region_id'] = regionId;
    data['metadata'] = metadata;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

// _________________________________________________

class AddToCartResponse {
  final Cart cart;

  AddToCartResponse({required this.cart});

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) =>
      AddToCartResponse(cart: Cart.fromJson(json["cart"]));
}

class Category {
  final String id;

  Category({required this.id});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
      );
}
