class ProductCollections {
  List<Products>? products;
  int? count;
  int? offset;
  int? limit;

  ProductCollections({this.products, this.count, this.offset, this.limit});

  ProductCollections.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    count = json['count'];
    offset = json['offset'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['offset'] = this.offset;
    data['limit'] = this.limit;
    return data;
  }
}

class Products {
  String? id;
  String? title;
  String? subtitle;
  String? description;
  String? handle;
  bool? isGiftcard;
  bool? discountable;
  String? thumbnail;
  String? collectionId;
  Null? typeId;
  Null? weight;
  Null? length;
  Null? height;
  Null? width;
  Null? hsCode;
  Null? originCountry;
  Null? midCode;
  Null? material;
  String? createdAt;
  String? updatedAt;
  Null? type;
  Collection? collection;
  List<ProductsOptions>? options;
  List<Null>? tags;
  List<Images>? images;
  List<Variants>? variants;

  Products(
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

  Products.fromJson(Map<String, dynamic> json) {
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
        ? new Collection.fromJson(json['collection'])
        : null;
    if (json['options'] != null) {
      options = <ProductsOptions>[];
      json['options'].forEach((v) {
        options!.add(new ProductsOptions.fromJson(v));
      });
    }
    // if (json['tags'] != null) {
    //   tags = <Null>[];
    //   json['tags'].forEach((v) {
    //     tags!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['description'] = this.description;
    data['handle'] = this.handle;
    data['is_giftcard'] = this.isGiftcard;
    data['discountable'] = this.discountable;
    data['thumbnail'] = this.thumbnail;
    data['collection_id'] = this.collectionId;
    data['type_id'] = this.typeId;
    data['weight'] = this.weight;
    data['length'] = this.length;
    data['height'] = this.height;
    data['width'] = this.width;
    data['hs_code'] = this.hsCode;
    data['origin_country'] = this.originCountry;
    data['mid_code'] = this.midCode;
    data['material'] = this.material;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    if (this.collection != null) {
      data['collection'] = this.collection!.toJson();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    // if (this.tags != null) {
    //   data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    // }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
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
  Null? deletedAt;

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
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['handle'] = this.handle;
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class ProductsOptions {
  String? id;
  String? title;
  Null? metadata;
  String? productId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
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
        values!.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['metadata'] = this.metadata;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.values != null) {
      data['values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  String? id;
  String? value;
  Null? metadata;
  String? optionId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['metadata'] = this.metadata;
    data['option_id'] = this.optionId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Images {
  String? id;
  String? url;
  Null? metadata;
  int? rank;
  String? productId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['metadata'] = this.metadata;
    data['rank'] = this.rank;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Variants {
  String? id;
  String? title;
  Null? sku;
  Null? barcode;
  Null? ean;
  Null? upc;
  bool? allowBackorder;
  bool? manageInventory;
  Null? hsCode;
  String? originCountry;
  Null? midCode;
  Null? material;
  Null? weight;
  Null? length;
  Null? height;
  Null? width;
  Null? metadata;
  int? variantRank;
  String? productId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
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
        options!.add(new VariantsOptions.fromJson(v));
      });
    }
    calculatedPrice = json['calculated_price'] != null
        ? new CalculatedPrice.fromJson(json['calculated_price'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sku'] = this.sku;
    data['barcode'] = this.barcode;
    data['ean'] = this.ean;
    data['upc'] = this.upc;
    data['allow_backorder'] = this.allowBackorder;
    data['manage_inventory'] = this.manageInventory;
    data['hs_code'] = this.hsCode;
    data['origin_country'] = this.originCountry;
    data['mid_code'] = this.midCode;
    data['material'] = this.material;
    data['weight'] = this.weight;
    data['length'] = this.length;
    data['height'] = this.height;
    data['width'] = this.width;
    data['metadata'] = this.metadata;
    data['variant_rank'] = this.variantRank;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    if (this.calculatedPrice != null) {
      data['calculated_price'] = this.calculatedPrice!.toJson();
    }
    return data;
  }
}

class VariantsOptions {
  String? id;
  String? value;
  Null? metadata;
  String? optionId;
  Option? option;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

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
    option =
        json['option'] != null ? new Option.fromJson(json['option']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['metadata'] = this.metadata;
    data['option_id'] = this.optionId;
    if (this.option != null) {
      data['option'] = this.option!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Option {
  String? id;
  String? title;
  Null? metadata;
  String? productId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['metadata'] = this.metadata;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
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
        ? new RawCalculatedAmount.fromJson(json['raw_calculated_amount'])
        : null;
    isOriginalPricePriceList = json['is_original_price_price_list'];
    isOriginalPriceTaxInclusive = json['is_original_price_tax_inclusive'];
    originalAmount = json['original_amount'];
    rawOriginalAmount = json['raw_original_amount'] != null
        ? new RawCalculatedAmount.fromJson(json['raw_original_amount'])
        : null;
    currencyCode = json['currency_code'];
    calculatedPrice = json['calculated_price'] != null
        ? new CalculatedPriceData.fromJson(json['calculated_price'])
        : null;
    originalPrice = json['original_price'] != null
        ? new CalculatedPriceData.fromJson(json['original_price'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_calculated_price_price_list'] = this.isCalculatedPricePriceList;
    data['is_calculated_price_tax_inclusive'] =
        this.isCalculatedPriceTaxInclusive;
    data['calculated_amount'] = this.calculatedAmount;
    if (this.rawCalculatedAmount != null) {
      data['raw_calculated_amount'] = this.rawCalculatedAmount!.toJson();
    }
    data['is_original_price_price_list'] = this.isOriginalPricePriceList;
    data['is_original_price_tax_inclusive'] = this.isOriginalPriceTaxInclusive;
    data['original_amount'] = this.originalAmount;
    if (this.rawOriginalAmount != null) {
      data['raw_original_amount'] = this.rawOriginalAmount!.toJson();
    }
    data['currency_code'] = this.currencyCode;
    if (this.calculatedPrice != null) {
      data['calculated_price'] = this.calculatedPrice!.toJson();
    }
    if (this.originalPrice != null) {
      data['original_price'] = this.originalPrice!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['precision'] = this.precision;
    return data;
  }
}

class CalculatedPriceData {
  String? id;
  Null? priceListId;
  Null? priceListType;
  Null? minQuantity;
  Null? maxQuantity;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price_list_id'] = this.priceListId;
    data['price_list_type'] = this.priceListType;
    data['min_quantity'] = this.minQuantity;
    data['max_quantity'] = this.maxQuantity;
    return data;
  }
}
