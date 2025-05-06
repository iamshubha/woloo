class CartModel {
  Cart? cart;

  CartModel({this.cart});

  CartModel.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.toJson();
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
  Null? completedAt;
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
  Null? metadata;
  String? salesChannelId;
  String? shippingAddressId;
  String? customerId;
  List<Null>? items;
  List<Null>? shippingMethods;
  ShippingAddress? shippingAddress;
  Null? billingAddress;
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
        ? new ShippingAddress.fromJson(json['shipping_address'])
        : null;
    billingAddress = json['billing_address'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    region =
        json['region'] != null ? new Region.fromJson(json['region']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['currency_code'] = this.currencyCode;
    data['email'] = this.email;
    data['region_id'] = this.regionId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['completed_at'] = this.completedAt;
    data['total'] = this.total;
    data['subtotal'] = this.subtotal;
    data['tax_total'] = this.taxTotal;
    data['discount_total'] = this.discountTotal;
    data['discount_subtotal'] = this.discountSubtotal;
    data['discount_tax_total'] = this.discountTaxTotal;
    data['original_total'] = this.originalTotal;
    data['original_tax_total'] = this.originalTaxTotal;
    data['item_total'] = this.itemTotal;
    data['item_subtotal'] = this.itemSubtotal;
    data['item_tax_total'] = this.itemTaxTotal;
    data['original_item_total'] = this.originalItemTotal;
    data['original_item_subtotal'] = this.originalItemSubtotal;
    data['original_item_tax_total'] = this.originalItemTaxTotal;
    data['shipping_total'] = this.shippingTotal;
    data['shipping_subtotal'] = this.shippingSubtotal;
    data['shipping_tax_total'] = this.shippingTaxTotal;
    data['original_shipping_tax_total'] = this.originalShippingTaxTotal;
    data['original_shipping_subtotal'] = this.originalShippingSubtotal;
    data['original_shipping_total'] = this.originalShippingTotal;
    data['metadata'] = this.metadata;
    data['sales_channel_id'] = this.salesChannelId;
    data['shipping_address_id'] = this.shippingAddressId;
    data['customer_id'] = this.customerId;

    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    data['billing_address'] = this.billingAddress;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.region != null) {
      data['region'] = this.region!.toJson();
    }

    return data;
  }
}

class ShippingAddress {
  String? id;
  Null? firstName;
  Null? lastName;
  Null? company;
  Null? address1;
  Null? address2;
  Null? city;
  Null? postalCode;
  String? countryCode;
  Null? province;
  Null? phone;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company'] = this.company;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['country_code'] = this.countryCode;
    data['province'] = this.province;
    data['phone'] = this.phone;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;

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
        countries!.add(new Countries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['currency_code'] = this.currencyCode;
    data['automatic_taxes'] = this.automaticTaxes;
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
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
  Null? metadata;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_2'] = this.iso2;
    data['iso_3'] = this.iso3;
    data['num_code'] = this.numCode;
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    data['region_id'] = this.regionId;
    data['metadata'] = this.metadata;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
