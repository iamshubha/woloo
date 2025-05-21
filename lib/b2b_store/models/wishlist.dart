// To parse this JSON data, do
//
//     final wishlist = wishlistFromJson(jsonString);

import 'dart:convert';

Wishlist wishlistFromJson(String str) => Wishlist.fromJson(json.decode(str));

String wishlistToJson(Wishlist data) => json.encode(data.toJson());

class Wishlist {
  final WishlistClass wishlist;

  Wishlist({
    required this.wishlist,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        wishlist: WishlistClass.fromJson(json["wishlist"]),
      );

  Map<String, dynamic> toJson() => {
        "wishlist": wishlist.toJson(),
      };
}

class WishlistClass {
  final List<Item> items;

  WishlistClass({
    required this.items,
  });

  factory WishlistClass.fromJson(Map<String, dynamic> json) => WishlistClass(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  final String id;
  final String productVariantId;
  final String wishlistId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final ProductVariant productVariant;

  Item({
    required this.id,
    required this.productVariantId,
    required this.wishlistId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.productVariant,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        productVariantId: json["product_variant_id"],
        wishlistId: json["wishlist_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        productVariant: ProductVariant.fromJson(json["product_variant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_variant_id": productVariantId,
        "wishlist_id": wishlistId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "product_variant": productVariant.toJson(),
      };
}

class ProductVariant {
  final String id;
  final String title;
  final dynamic sku;
  final dynamic barcode;
  final dynamic ean;
  final dynamic upc;
  final bool allowBackorder;
  final bool manageInventory;
  final dynamic hsCode;
  final dynamic originCountry;
  final dynamic midCode;
  final dynamic material;
  final dynamic weight;
  final dynamic length;
  final dynamic height;
  final dynamic width;
  final dynamic metadata;
  final int variantRank;
  final String productId;
  final Product product;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final CalculatedPrice calculatedPrice;

  ProductVariant({
    required this.id,
    required this.title,
    required this.sku,
    required this.barcode,
    required this.ean,
    required this.upc,
    required this.allowBackorder,
    required this.manageInventory,
    required this.hsCode,
    required this.originCountry,
    required this.midCode,
    required this.material,
    required this.weight,
    required this.length,
    required this.height,
    required this.width,
    required this.metadata,
    required this.variantRank,
    required this.productId,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.calculatedPrice,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
        id: json["id"],
        title: json["title"],
        sku: json["sku"],
        barcode: json["barcode"],
        ean: json["ean"],
        upc: json["upc"],
        allowBackorder: json["allow_backorder"],
        manageInventory: json["manage_inventory"],
        hsCode: json["hs_code"],
        originCountry: json["origin_country"],
        midCode: json["mid_code"],
        material: json["material"],
        weight: json["weight"],
        length: json["length"],
        height: json["height"],
        width: json["width"],
        metadata: json["metadata"],
        variantRank: json["variant_rank"],
        productId: json["product_id"],
        product: Product.fromJson(json["product"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        calculatedPrice: CalculatedPrice.fromJson(json["calculated_price"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sku": sku,
        "barcode": barcode,
        "ean": ean,
        "upc": upc,
        "allow_backorder": allowBackorder,
        "manage_inventory": manageInventory,
        "hs_code": hsCode,
        "origin_country": originCountry,
        "mid_code": midCode,
        "material": material,
        "weight": weight,
        "length": length,
        "height": height,
        "width": width,
        "metadata": metadata,
        "variant_rank": variantRank,
        "product_id": productId,
        "product": product.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "calculated_price": calculatedPrice.toJson(),
      };
}

class CalculatedPrice {
  final String id;
  final bool isCalculatedPricePriceList;
  final bool isCalculatedPriceTaxInclusive;
  final int calculatedAmount;
  final RawAmount rawCalculatedAmount;
  final bool isOriginalPricePriceList;
  final bool isOriginalPriceTaxInclusive;
  final int originalAmount;
  final RawAmount rawOriginalAmount;
  final String currencyCode;
  final Price calculatedPrice;
  final Price originalPrice;

  CalculatedPrice({
    required this.id,
    required this.isCalculatedPricePriceList,
    required this.isCalculatedPriceTaxInclusive,
    required this.calculatedAmount,
    required this.rawCalculatedAmount,
    required this.isOriginalPricePriceList,
    required this.isOriginalPriceTaxInclusive,
    required this.originalAmount,
    required this.rawOriginalAmount,
    required this.currencyCode,
    required this.calculatedPrice,
    required this.originalPrice,
  });

  factory CalculatedPrice.fromJson(Map<String, dynamic> json) =>
      CalculatedPrice(
        id: json["id"],
        isCalculatedPricePriceList: json["is_calculated_price_price_list"],
        isCalculatedPriceTaxInclusive:
            json["is_calculated_price_tax_inclusive"],
        calculatedAmount: json["calculated_amount"],
        rawCalculatedAmount: RawAmount.fromJson(json["raw_calculated_amount"]),
        isOriginalPricePriceList: json["is_original_price_price_list"],
        isOriginalPriceTaxInclusive: json["is_original_price_tax_inclusive"],
        originalAmount: json["original_amount"],
        rawOriginalAmount: RawAmount.fromJson(json["raw_original_amount"]),
        currencyCode: json["currency_code"],
        calculatedPrice: Price.fromJson(json["calculated_price"]),
        originalPrice: Price.fromJson(json["original_price"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_calculated_price_price_list": isCalculatedPricePriceList,
        "is_calculated_price_tax_inclusive": isCalculatedPriceTaxInclusive,
        "calculated_amount": calculatedAmount,
        "raw_calculated_amount": rawCalculatedAmount.toJson(),
        "is_original_price_price_list": isOriginalPricePriceList,
        "is_original_price_tax_inclusive": isOriginalPriceTaxInclusive,
        "original_amount": originalAmount,
        "raw_original_amount": rawOriginalAmount.toJson(),
        "currency_code": currencyCode,
        "calculated_price": calculatedPrice.toJson(),
        "original_price": originalPrice.toJson(),
      };
}

class Price {
  final String id;
  final dynamic priceListId;
  final dynamic priceListType;
  final dynamic minQuantity;
  final dynamic maxQuantity;

  Price({
    required this.id,
    required this.priceListId,
    required this.priceListType,
    required this.minQuantity,
    required this.maxQuantity,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        id: json["id"],
        priceListId: json["price_list_id"],
        priceListType: json["price_list_type"],
        minQuantity: json["min_quantity"],
        maxQuantity: json["max_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price_list_id": priceListId,
        "price_list_type": priceListType,
        "min_quantity": minQuantity,
        "max_quantity": maxQuantity,
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

class Product {
  final String id;
  final String title;
  final String handle;
  final String subtitle;
  final String description;
  final bool isGiftcard;
  final String status;
  final String thumbnail;
  final dynamic weight;
  final dynamic length;
  final dynamic height;
  final dynamic width;
  final dynamic originCountry;
  final dynamic hsCode;
  final dynamic midCode;
  final dynamic material;
  final bool discountable;
  final dynamic externalId;
  final dynamic metadata;
  final dynamic typeId;
  final dynamic type;
  final String collectionId;
  final Collection collection;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  Product({
    required this.id,
    required this.title,
    required this.handle,
    required this.subtitle,
    required this.description,
    required this.isGiftcard,
    required this.status,
    required this.thumbnail,
    required this.weight,
    required this.length,
    required this.height,
    required this.width,
    required this.originCountry,
    required this.hsCode,
    required this.midCode,
    required this.material,
    required this.discountable,
    required this.externalId,
    required this.metadata,
    required this.typeId,
    required this.type,
    required this.collectionId,
    required this.collection,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        handle: json["handle"],
        subtitle: json["subtitle"],
        description: json["description"],
        isGiftcard: json["is_giftcard"],
        status: json["status"],
        thumbnail: json["thumbnail"],
        weight: json["weight"],
        length: json["length"],
        height: json["height"],
        width: json["width"],
        originCountry: json["origin_country"],
        hsCode: json["hs_code"],
        midCode: json["mid_code"],
        material: json["material"],
        discountable: json["discountable"],
        externalId: json["external_id"],
        metadata: json["metadata"],
        typeId: json["type_id"],
        type: json["type"],
        collectionId: json["collection_id"],
        collection: Collection.fromJson(json["collection"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "handle": handle,
        "subtitle": subtitle,
        "description": description,
        "is_giftcard": isGiftcard,
        "status": status,
        "thumbnail": thumbnail,
        "weight": weight,
        "length": length,
        "height": height,
        "width": width,
        "origin_country": originCountry,
        "hs_code": hsCode,
        "mid_code": midCode,
        "material": material,
        "discountable": discountable,
        "external_id": externalId,
        "metadata": metadata,
        "type_id": typeId,
        "type": type,
        "collection_id": collectionId,
        "collection": collection.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class Collection {
  final String id;

  Collection({
    required this.id,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
