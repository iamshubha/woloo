import 'dart:convert';

class CartModel {
  Cart? cart;

  CartModel({this.cart});

  CartModel.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
  }
}

class Region {
  String? id;
  String? name;
  String? currencyCode;
  bool? automaticTaxes;
  List<Countries>? countries;

  Region(
      {this.id,
      this.name,
      this.currencyCode,
      this.automaticTaxes,
      this.countries});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    currencyCode = json['currency_code'];
    automaticTaxes = json['automatic_taxes'];
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(Countries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['currency_code'] = currencyCode;
    data['automatic_taxes'] = automaticTaxes;
    if (countries != null) {
      data['countries'] = countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class Countries {
  String? iso2;
  String? iso3;
  String? numCode;
  String? name;
  String? displayName;
  String? regionId;
  Null metadata;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;

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

class Cart {
  final String id;
  final String currencyCode;
  final String email;
  final String regionId;
  final DateTime createdAt;
  final DateTime updatedAt;
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
  final String? metadata;
  final String salesChannelId;
  final String shippingAddressId;
  final String customerId;
  final List<Item> items;
  final List<dynamic> shippingMethods;
  final ShippingAddress shippingAddress;
  final dynamic billingAddress;
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
    required this.metadata,
    required this.salesChannelId,
    required this.shippingAddressId,
    required this.customerId,
    required this.items,
    required this.shippingMethods,
    required this.shippingAddress,
    required this.billingAddress,
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
        metadata: json["metadata"],
        salesChannelId: json["sales_channel_id"],
        shippingAddressId: json["shipping_address_id"],
        customerId: json["customer_id"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        shippingMethods: List<dynamic>.from(json["shipping_methods"]),
        shippingAddress: ShippingAddress.fromJson(json["shipping_address"]),
        billingAddress: json["billing_address"],
        customer: Customer.fromJson(json["customer"]),
        region: Region.fromJson(json["region"]),
        promotions: List<dynamic>.from(json["promotions"]),
      );
}

class Item {
  final String id;
  final String thumbnail;
  final String variantId;
  final String productId;
  final String? productTypeId;
  final String productTitle;
  final String productDescription;
  final String productSubtitle;
  final dynamic productType;
  final String productCollection;
  final String productHandle;
  final String? variantSku;
  final String? variantBarcode;
  final String variantTitle;
  final bool requiresShipping;
  final Map<String, dynamic> metadata;
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
    this.productTypeId,
    required this.productTitle,
    required this.productDescription,
    required this.productSubtitle,
    this.productType,
    required this.productCollection,
    required this.productHandle,
    this.variantSku,
    this.variantBarcode,
    required this.variantTitle,
    required this.requiresShipping,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.quantity,
    required this.unitPrice,
    this.compareAtUnitPrice,
    required this.isTaxInclusive,
    required this.taxLines,
    required this.adjustments,
    required this.product,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    // logger.w("Item: $json");
    return Item(
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
      metadata: Map<String, dynamic>.from(json["metadata"]),
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      title: json["title"],
      quantity: json["quantity"],
      unitPrice: json["unit_price"],
      compareAtUnitPrice: json["compare_at_unit_price"],
      isTaxInclusive: json["is_tax_inclusive"],
      taxLines: List<dynamic>.from(json["tax_lines"]),
      adjustments: List<dynamic>.from(json["adjustments"]),
      product: Product.fromJson(json["product"]),
    );
  }
}

class Product {
  final String id;
  final String collectionId;
  final String? typeId;
  final List<Category> categories;
  final List<dynamic> tags;

  Product({
    required this.id,
    required this.collectionId,
    this.typeId,
    required this.categories,
    required this.tags,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        collectionId: json["collection_id"],
        typeId: json["type_id"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        tags: List<dynamic>.from(json["tags"]),
      );
}

class Category {
  final String id;

  Category({required this.id});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
      );
}

class ShippingAddress {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? address1;
  final String? address2;
  final String? city;
  final String? postalCode;
  final String countryCode;
  final String? province;
  final String? phone;

  ShippingAddress({
    required this.id,
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.postalCode,
    required this.countryCode,
    this.province,
    this.phone,
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
        groups: List<dynamic>.from(json["groups"]),
      );
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
}
