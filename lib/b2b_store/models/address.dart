class AddressReqBody {
  String? address1;
  String? addressName;
  String? city;
  String? firstName;
  String? lastName;
  String? phone;
  String? postalCode;
  String? province;

  AddressReqBody(
      {this.address1,
      this.addressName,
      this.city,
      this.firstName,
      this.lastName,
      this.phone,
      this.postalCode,
      this.province});

  AddressReqBody.fromJson(Map<String, dynamic> json) {
    address1 = json['address_1'];
    addressName = json['address_name'];
    city = json['city'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    postalCode = json['postal_code'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_1'] = address1;
    data['address_name'] = addressName;
    data['city'] = city;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['postal_code'] = postalCode;
    data['province'] = province;
    return data;
  }
}

class AddAddressResBody {
  Customer? customer;

  AddAddressResBody({this.customer});

  AddAddressResBody.fromJson(Map<String, dynamic> json) {
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class Customer {
  String? id;
  String? email;
  Null companyName;
  String? firstName;
  String? lastName;
  Null phone;
  Null metadata;
  bool? hasAccount;
  Null deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Addresses>? addresses;

  Customer(
      {this.id,
      this.email,
      this.companyName,
      this.firstName,
      this.lastName,
      this.phone,
      this.metadata,
      this.hasAccount,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.addresses});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    companyName = json['company_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    metadata = json['metadata'];
    hasAccount = json['has_account'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['company_name'] = companyName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['metadata'] = metadata;
    data['has_account'] = hasAccount;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  String? id;
  String? addressName;
  bool? isDefaultShipping;
  bool? isDefaultBilling;
  dynamic company;
  String? firstName;
  String? lastName;
  String? address1;
  dynamic address2;
  String? city;
  dynamic countryCode;
  String? province;
  String? postalCode;
  String? phone;
  dynamic metadata;
  String? customerId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Addresses(
      {this.id,
      this.addressName,
      this.isDefaultShipping,
      this.isDefaultBilling,
      this.company,
      this.firstName,
      this.lastName,
      this.address1,
      this.address2,
      this.city,
      this.countryCode,
      this.province,
      this.postalCode,
      this.phone,
      this.metadata,
      this.customerId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressName = json['address_name'];
    isDefaultShipping = json['is_default_shipping'];
    isDefaultBilling = json['is_default_billing'];
    company = json['company'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    countryCode = json['country_code'];
    province = json['province'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    metadata = json['metadata'];
    customerId = json['customer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address_name'] = addressName;
    data['is_default_shipping'] = isDefaultShipping;
    data['is_default_billing'] = isDefaultBilling;
    data['company'] = company;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['address_1'] = address1;
    data['address_2'] = address2;
    data['city'] = city;
    data['country_code'] = countryCode;
    data['province'] = province;
    data['postal_code'] = postalCode;
    data['phone'] = phone;
    data['metadata'] = metadata;
    data['customer_id'] = customerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class AddressesData {
  List<Addresses>? addresses;
  int? count;
  int? offset;
  int? limit;

  AddressesData({this.addresses, this.count, this.offset, this.limit});

  AddressesData.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
    count = json['count'];
    offset = json['offset'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    data['offset'] = offset;
    data['limit'] = limit;
    return data;
  }
}
