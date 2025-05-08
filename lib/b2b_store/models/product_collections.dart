class ProductCollections {
  List<Product> products;
  int? count;
  int? offset;
  int? limit;

  ProductCollections(
      {this.products = const [], this.count, this.offset, this.limit});

  factory ProductCollections.fromJson(Map<String, dynamic> json) {
    return ProductCollections(
      products: json['products'] == null
          ? []
          : (json['products'] as List).map((e) => Product.fromJson(e)).toList(),
      count: json['count'],
      offset: json['offset'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['products'] = products.map((v) => v.toJson()).toList();
    data['count'] = count;
    data['offset'] = offset;
    data['limit'] = limit;
    return data;
  }
}

class Product {
  String? id;
  String? title;
  String? subtitle;
  String? description;
  String? handle;
  bool? isGiftcard;
  bool? discountable;
  String? thumbnail;
  String? collectionId;
  dynamic typeId;
  dynamic weight;
  dynamic length;
  dynamic height;
  dynamic width;
  dynamic hsCode;
  dynamic originCountry;
  dynamic midCode;
  dynamic material;
  String? createdAt;
  String? updatedAt;
  dynamic type;
  Collection? collection;
  List<ProductsOptions>? options;
  List<dynamic>? tags;
  List<Images>? images;
  List<Variants>? variants;

  Product(
      {this.id,
      this.title,
      this.subtitle,
      this.description,
      this.handle,
      this.isGiftcard,
      this.discountable,
      this.thumbnail,
      this.collectionId,
      this.typeId,
      this.weight,
      this.length,
      this.height,
      this.width,
      this.hsCode,
      this.originCountry,
      this.midCode,
      this.material,
      this.createdAt,
      this.updatedAt,
      this.type,
      this.collection,
      this.options,
      this.tags,
      this.images,
      this.variants});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    description = json['description'];
    handle = json['handle'];
    isGiftcard = json['is_giftcard'];
    discountable = json['discountable'];
    thumbnail = json['thumbnail'];
    collectionId = json['collection_id'];
    typeId = json['type_id'];
    weight = json['weight'];
    length = json['length'];
    height = json['height'];
    width = json['width'];
    hsCode = json['hs_code'];
    originCountry = json['origin_country'];
    midCode = json['mid_code'];
    material = json['material'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    collection = json['collection'] != null
        ? Collection.fromJson(json['collection'])
        : null;
    if (json['options'] != null) {
      options = <ProductsOptions>[];
      json['options'].forEach((v) {
        options!.add(ProductsOptions.fromJson(v));
      });
    }
    // if (json['tags'] != null) {
    //   tags = <dynamic>[];
    //   json['tags'].forEach((v) {
    //     tags!.add(new dynamic.fromJson(v));
    //   });
    // }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['description'] = description;
    data['handle'] = handle;
    data['is_giftcard'] = isGiftcard;
    data['discountable'] = discountable;
    data['thumbnail'] = thumbnail;
    data['collection_id'] = collectionId;
    data['type_id'] = typeId;
    data['weight'] = weight;
    data['length'] = length;
    data['height'] = height;
    data['width'] = width;
    data['hs_code'] = hsCode;
    data['origin_country'] = originCountry;
    data['mid_code'] = midCode;
    data['material'] = material;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type'] = type;
    if (collection != null) {
      data['collection'] = collection!.toJson();
    }
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    // if (this.tags != null) {
    //   data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    // }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Collection {
  String? id;
  String? title;
  String? handle;
  Metadata? metadata;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Collection(
      {this.id,
      this.title,
      this.handle,
      this.metadata,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    handle = json['handle'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['handle'] = handle;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Metadata {
  String? image;

  Metadata({this.image});

  Metadata.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    return data;
  }
}

class ProductsOptions {
  String? id;
  String? title;
  dynamic metadata;
  String? productId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<Values>? values;

  ProductsOptions(
      {this.id,
      this.title,
      this.metadata,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.values});

  ProductsOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    metadata = json['metadata'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['metadata'] = metadata;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (values != null) {
      data['values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  String? id;
  String? value;
  dynamic metadata;
  String? optionId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Values(
      {this.id,
      this.value,
      this.metadata,
      this.optionId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Values.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    metadata = json['metadata'];
    optionId = json['option_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    data['metadata'] = metadata;
    data['option_id'] = optionId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Images {
  String? id;
  String? url;
  dynamic metadata;
  int? rank;
  String? productId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Images(
      {this.id,
      this.url,
      this.metadata,
      this.rank,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    metadata = json['metadata'];
    rank = json['rank'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['metadata'] = metadata;
    data['rank'] = rank;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Variants {
  String? id;
  String? title;
  dynamic sku;
  dynamic barcode;
  dynamic ean;
  dynamic upc;
  bool? allowBackorder;
  bool? manageInventory;
  dynamic hsCode;
  String? originCountry;
  dynamic midCode;
  dynamic material;
  dynamic weight;
  dynamic length;
  dynamic height;
  dynamic width;
  dynamic metadata;
  int? variantRank;
  String? productId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<VariantsOptions>? options;
  CalculatedPrice? calculatedPrice;

  Variants(
      {this.id,
      this.title,
      this.sku,
      this.barcode,
      this.ean,
      this.upc,
      this.allowBackorder,
      this.manageInventory,
      this.hsCode,
      this.originCountry,
      this.midCode,
      this.material,
      this.weight,
      this.length,
      this.height,
      this.width,
      this.metadata,
      this.variantRank,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.options,
      this.calculatedPrice});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    sku = json['sku'];
    barcode = json['barcode'];
    ean = json['ean'];
    upc = json['upc'];
    allowBackorder = json['allow_backorder'];
    manageInventory = json['manage_inventory'];
    hsCode = json['hs_code'];
    originCountry = json['origin_country'];
    midCode = json['mid_code'];
    material = json['material'];
    weight = json['weight'];
    length = json['length'];
    height = json['height'];
    width = json['width'];
    metadata = json['metadata'];
    variantRank = json['variant_rank'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['options'] != null) {
      options = <VariantsOptions>[];
      json['options'].forEach((v) {
        options!.add(VariantsOptions.fromJson(v));
      });
    }
    calculatedPrice = json['calculated_price'] != null
        ? CalculatedPrice.fromJson(json['calculated_price'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['sku'] = sku;
    data['barcode'] = barcode;
    data['ean'] = ean;
    data['upc'] = upc;
    data['allow_backorder'] = allowBackorder;
    data['manage_inventory'] = manageInventory;
    data['hs_code'] = hsCode;
    data['origin_country'] = originCountry;
    data['mid_code'] = midCode;
    data['material'] = material;
    data['weight'] = weight;
    data['length'] = length;
    data['height'] = height;
    data['width'] = width;
    data['metadata'] = metadata;
    data['variant_rank'] = variantRank;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    if (calculatedPrice != null) {
      data['calculated_price'] = calculatedPrice!.toJson();
    }
    return data;
  }
}

class VariantsOptions {
  String? id;
  String? value;
  dynamic metadata;
  String? optionId;
  Option? option;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  VariantsOptions(
      {this.id,
      this.value,
      this.metadata,
      this.optionId,
      this.option,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  VariantsOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    metadata = json['metadata'];
    optionId = json['option_id'];
    option = json['option'] != null ? Option.fromJson(json['option']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    data['metadata'] = metadata;
    data['option_id'] = optionId;
    if (option != null) {
      data['option'] = option!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Option {
  String? id;
  String? title;
  dynamic metadata;
  String? productId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Option(
      {this.id,
      this.title,
      this.metadata,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Option.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    metadata = json['metadata'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['metadata'] = metadata;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class CalculatedPrice {
  String? id;
  bool? isCalculatedPricePriceList;
  bool? isCalculatedPriceTaxInclusive;
  int? calculatedAmount;
  RawCalculatedAmount? rawCalculatedAmount;
  bool? isOriginalPricePriceList;
  bool? isOriginalPriceTaxInclusive;
  int? originalAmount;
  RawCalculatedAmount? rawOriginalAmount;
  String? currencyCode;
  CalculatedPriceData? calculatedPrice;
  CalculatedPriceData? originalPrice;

  CalculatedPrice(
      {this.id,
      this.isCalculatedPricePriceList,
      this.isCalculatedPriceTaxInclusive,
      this.calculatedAmount,
      this.rawCalculatedAmount,
      this.isOriginalPricePriceList,
      this.isOriginalPriceTaxInclusive,
      this.originalAmount,
      this.rawOriginalAmount,
      this.currencyCode,
      this.calculatedPrice,
      this.originalPrice});

  CalculatedPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isCalculatedPricePriceList = json['is_calculated_price_price_list'];
    isCalculatedPriceTaxInclusive = json['is_calculated_price_tax_inclusive'];
    calculatedAmount = json['calculated_amount'];
    rawCalculatedAmount = json['raw_calculated_amount'] != null
        ? RawCalculatedAmount.fromJson(json['raw_calculated_amount'])
        : null;
    isOriginalPricePriceList = json['is_original_price_price_list'];
    isOriginalPriceTaxInclusive = json['is_original_price_tax_inclusive'];
    originalAmount = json['original_amount'];
    rawOriginalAmount = json['raw_original_amount'] != null
        ? RawCalculatedAmount.fromJson(json['raw_original_amount'])
        : null;
    currencyCode = json['currency_code'];
    calculatedPrice = json['calculated_price'] != null
        ? CalculatedPriceData.fromJson(json['calculated_price'])
        : null;
    originalPrice = json['original_price'] != null
        ? CalculatedPriceData.fromJson(json['original_price'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_calculated_price_price_list'] = isCalculatedPricePriceList;
    data['is_calculated_price_tax_inclusive'] = isCalculatedPriceTaxInclusive;
    data['calculated_amount'] = calculatedAmount;
    if (rawCalculatedAmount != null) {
      data['raw_calculated_amount'] = rawCalculatedAmount!.toJson();
    }
    data['is_original_price_price_list'] = isOriginalPricePriceList;
    data['is_original_price_tax_inclusive'] = isOriginalPriceTaxInclusive;
    data['original_amount'] = originalAmount;
    if (rawOriginalAmount != null) {
      data['raw_original_amount'] = rawOriginalAmount!.toJson();
    }
    data['currency_code'] = currencyCode;
    if (calculatedPrice != null) {
      data['calculated_price'] = calculatedPrice!.toJson();
    }
    if (originalPrice != null) {
      data['original_price'] = originalPrice!.toJson();
    }
    return data;
  }
}

class RawCalculatedAmount {
  String? value;
  int? precision;

  RawCalculatedAmount({this.value, this.precision});

  RawCalculatedAmount.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    precision = json['precision'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['precision'] = precision;
    return data;
  }
}

class CalculatedPriceData {
  String? id;
  dynamic priceListId;
  dynamic priceListType;
  dynamic minQuantity;
  dynamic maxQuantity;

  CalculatedPriceData(
      {this.id,
      this.priceListId,
      this.priceListType,
      this.minQuantity,
      this.maxQuantity});

  CalculatedPriceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priceListId = json['price_list_id'];
    priceListType = json['price_list_type'];
    minQuantity = json['min_quantity'];
    maxQuantity = json['max_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price_list_id'] = priceListId;
    data['price_list_type'] = priceListType;
    data['min_quantity'] = minQuantity;
    data['max_quantity'] = maxQuantity;
    return data;
  }
}
