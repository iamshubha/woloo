class CartModel {
  Cart? cart;

  CartModel({this.cart});

  CartModel.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cart != null) {
      data['cart'] = cart!.toJson();
    }
    return data;
  }
}

class Cart {
  String? id;
  String? currencyCode;
  String? email;
  String? regionId;
  String? createdAt;
  String? updatedAt;
  Null completedAt;
  int? total;
  int? subtotal;
  int? taxTotal;
  int? discountTotal;
  int? discountSubtotal;
  int? discountTaxTotal;
  int? originalTotal;
  int? originalTaxTotal;
  int? itemTotal;
  int? itemSubtotal;
  int? itemTaxTotal;
  int? originalItemTotal;
  int? originalItemSubtotal;
  int? originalItemTaxTotal;
  int? shippingTotal;
  int? shippingSubtotal;
  int? shippingTaxTotal;
  int? originalShippingTaxTotal;
  int? originalShippingSubtotal;
  int? originalShippingTotal;
  Null metadata;
  String? salesChannelId;
  String? shippingAddressId;
  String? customerId;
  List<Null>? items;
  List<Null>? shippingMethods;
  ShippingAddress? shippingAddress;
  Null billingAddress;
  Customer? customer;
  Region? region;
  List<Null>? promotions;

  Cart(
      {this.id,
      this.currencyCode,
      this.email,
      this.regionId,
      this.createdAt,
      this.updatedAt,
      this.completedAt,
      this.total,
      this.subtotal,
      this.taxTotal,
      this.discountTotal,
      this.discountSubtotal,
      this.discountTaxTotal,
      this.originalTotal,
      this.originalTaxTotal,
      this.itemTotal,
      this.itemSubtotal,
      this.itemTaxTotal,
      this.originalItemTotal,
      this.originalItemSubtotal,
      this.originalItemTaxTotal,
      this.shippingTotal,
      this.shippingSubtotal,
      this.shippingTaxTotal,
      this.originalShippingTaxTotal,
      this.originalShippingSubtotal,
      this.originalShippingTotal,
      this.metadata,
      this.salesChannelId,
      this.shippingAddressId,
      this.customerId,
      this.items,
      this.shippingMethods,
      this.shippingAddress,
      this.billingAddress,
      this.customer,
      this.region,
      this.promotions});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currencyCode = json['currency_code'];
    email = json['email'];
    regionId = json['region_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    completedAt = json['completed_at'];
    total = json['total'];
    subtotal = json['subtotal'];
    taxTotal = json['tax_total'];
    discountTotal = json['discount_total'];
    discountSubtotal = json['discount_subtotal'];
    discountTaxTotal = json['discount_tax_total'];
    originalTotal = json['original_total'];
    originalTaxTotal = json['original_tax_total'];
    itemTotal = json['item_total'];
    itemSubtotal = json['item_subtotal'];
    itemTaxTotal = json['item_tax_total'];
    originalItemTotal = json['original_item_total'];
    originalItemSubtotal = json['original_item_subtotal'];
    originalItemTaxTotal = json['original_item_tax_total'];
    shippingTotal = json['shipping_total'];
    shippingSubtotal = json['shipping_subtotal'];
    shippingTaxTotal = json['shipping_tax_total'];
    originalShippingTaxTotal = json['original_shipping_tax_total'];
    originalShippingSubtotal = json['original_shipping_subtotal'];
    originalShippingTotal = json['original_shipping_total'];
    metadata = json['metadata'];
    salesChannelId = json['sales_channel_id'];
    shippingAddressId = json['shipping_address_id'];
    customerId = json['customer_id'];

    shippingAddress = json['shipping_address'] != null
        ? ShippingAddress.fromJson(json['shipping_address'])
        : null;
    billingAddress = json['billing_address'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    region = json['region'] != null ? Region.fromJson(json['region']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['currency_code'] = currencyCode;
    data['email'] = email;
    data['region_id'] = regionId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['completed_at'] = completedAt;
    data['total'] = total;
    data['subtotal'] = subtotal;
    data['tax_total'] = taxTotal;
    data['discount_total'] = discountTotal;
    data['discount_subtotal'] = discountSubtotal;
    data['discount_tax_total'] = discountTaxTotal;
    data['original_total'] = originalTotal;
    data['original_tax_total'] = originalTaxTotal;
    data['item_total'] = itemTotal;
    data['item_subtotal'] = itemSubtotal;
    data['item_tax_total'] = itemTaxTotal;
    data['original_item_total'] = originalItemTotal;
    data['original_item_subtotal'] = originalItemSubtotal;
    data['original_item_tax_total'] = originalItemTaxTotal;
    data['shipping_total'] = shippingTotal;
    data['shipping_subtotal'] = shippingSubtotal;
    data['shipping_tax_total'] = shippingTaxTotal;
    data['original_shipping_tax_total'] = originalShippingTaxTotal;
    data['original_shipping_subtotal'] = originalShippingSubtotal;
    data['original_shipping_total'] = originalShippingTotal;
    data['metadata'] = metadata;
    data['sales_channel_id'] = salesChannelId;
    data['shipping_address_id'] = shippingAddressId;
    data['customer_id'] = customerId;

    if (shippingAddress != null) {
      data['shipping_address'] = shippingAddress!.toJson();
    }
    data['billing_address'] = billingAddress;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (region != null) {
      data['region'] = region!.toJson();
    }

    return data;
  }
}

class ShippingAddress {
  String? id;
  Null firstName;
  Null lastName;
  Null company;
  Null address1;
  Null address2;
  Null city;
  Null postalCode;
  String? countryCode;
  Null province;
  Null phone;

  ShippingAddress(
      {this.id,
      this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.postalCode,
      this.countryCode,
      this.province,
      this.phone});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    postalCode = json['postal_code'];
    countryCode = json['country_code'];
    province = json['province'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['company'] = company;
    data['address_1'] = address1;
    data['address_2'] = address2;
    data['city'] = city;
    data['postal_code'] = postalCode;
    data['country_code'] = countryCode;
    data['province'] = province;
    data['phone'] = phone;
    return data;
  }
}

class Customer {
  String? id;
  String? email;
  List<Null>? groups;

  Customer({this.id, this.email, this.groups});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    if (json['groups'] != null) {
      groups = <Null>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;

    return data;
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
