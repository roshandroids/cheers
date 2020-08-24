class BeerModel {
  int id;
  String name;
  String tagline;
  String firstBrewed;
  String description;
  String imageUrl;
  double abv;
  double ibu;
  double targetFg;
  double targetOg;
  double ebc;
  double srm;
  double ph;
  double attenuationLevel;
  Volume volume;
  Volume boilVolume;
  Method method;
  Ingredients ingredients;
  List<String> foodPairing;
  String brewersTips;
  String contributedBy;

  BeerModel(
      {this.id,
      this.name,
      this.tagline,
      this.firstBrewed,
      this.description,
      this.imageUrl,
      this.abv,
      this.ibu,
      this.targetFg,
      this.targetOg,
      this.ebc,
      this.srm,
      this.ph,
      this.attenuationLevel,
      this.volume,
      this.boilVolume,
      this.method,
      this.ingredients,
      this.foodPairing,
      this.brewersTips,
      this.contributedBy});

  BeerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tagline = json['tagline'];
    firstBrewed = json['first_brewed'];
    description = json['description'];
    imageUrl = json['image_url'];
    abv = json["abv"] is int ? (json['abv'] as int).toDouble() : json['abv'];
    ibu = json["ibu"] is int ? (json['ibu'] as int).toDouble() : json['ibu'];
    targetFg = json["targetFg"] is int
        ? (json['targetFg'] as int).toDouble()
        : json['targetFg'];
    targetOg = json["targetOg"] is int
        ? (json['targetOg'] as int).toDouble()
        : json['targetOg'];
    ebc = json["ebc"] is int ? (json['ebc'] as int).toDouble() : json['ebc'];
    srm = json["srm"] is int ? (json['srm'] as int).toDouble() : json['srm'];
    ph = json["ph"] is int ? (json['ph'] as int).toDouble() : json['ph'];
    attenuationLevel = json["attenuationLevel"] is int
        ? (json['attenuationLevel'] as int).toDouble()
        : json['attenuationLevel'];
    volume =
        json['volume'] != null ? new Volume.fromJson(json['volume']) : null;
    boilVolume = json['boil_volume'] != null
        ? new Volume.fromJson(json['boil_volume'])
        : null;
    method =
        json['method'] != null ? new Method.fromJson(json['method']) : null;
    ingredients = json['ingredients'] != null
        ? new Ingredients.fromJson(json['ingredients'])
        : null;
    foodPairing = json['food_pairing'].cast<String>();
    brewersTips = json['brewers_tips'];
    contributedBy = json['contributed_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tagline'] = this.tagline;
    data['first_brewed'] = this.firstBrewed;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['abv'] = this.abv;
    data['ibu'] = this.ibu;
    data['target_fg'] = this.targetFg.toDouble();
    data['target_og'] = this.targetOg.toDouble();
    data['ebc'] = this.ebc;
    data['srm'] = this.srm;
    data['ph'] = this.ph;
    data['attenuation_level'] = this.attenuationLevel;
    if (this.volume != null) {
      data['volume'] = this.volume.toJson();
    }
    if (this.boilVolume != null) {
      data['boil_volume'] = this.boilVolume.toJson();
    }
    if (this.method != null) {
      data['method'] = this.method.toJson();
    }
    if (this.ingredients != null) {
      data['ingredients'] = this.ingredients.toJson();
    }
    data['food_pairing'] = this.foodPairing;
    data['brewers_tips'] = this.brewersTips;
    data['contributed_by'] = this.contributedBy;
    return data;
  }
}

class Volume {
  double value;
  String unit;

  Volume({this.value, this.unit});

  Volume.fromJson(Map<String, dynamic> json) {
    value = json["value"] is int
        ? (json['value'] as int).toDouble()
        : json['value'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value.toDouble();
    data['unit'] = this.unit;
    return data;
  }
}

class Method {
  List<MashTemp> mashTemp;
  Fermentation fermentation;
  String twist;

  Method({this.mashTemp, this.fermentation, this.twist});

  Method.fromJson(Map<String, dynamic> json) {
    if (json['mash_temp'] != null) {
      mashTemp = new List<MashTemp>();
      json['mash_temp'].forEach((v) {
        mashTemp.add(new MashTemp.fromJson(v));
      });
    }
    fermentation = json['fermentation'] != null
        ? new Fermentation.fromJson(json['fermentation'])
        : null;
    twist = json['twist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mashTemp != null) {
      data['mash_temp'] = this.mashTemp.map((v) => v.toJson()).toList();
    }
    if (this.fermentation != null) {
      data['fermentation'] = this.fermentation.toJson();
    }
    data['twist'] = this.twist;
    return data;
  }
}

class MashTemp {
  Volume temp;
  double duration;

  MashTemp({this.temp, this.duration});

  MashTemp.fromJson(Map<String, dynamic> json) {
    temp = json['temp'] != null ? new Volume.fromJson(json['temp']) : null;
    duration =
        json["abv"] is int ? (json['abv'] as int).toDouble() : json['abv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.temp != null) {
      data['temp'] = this.temp.toJson();
    }
    data['duration'] = this.duration;
    return data;
  }
}

class Fermentation {
  Volume temp;

  Fermentation({this.temp});

  Fermentation.fromJson(Map<String, dynamic> json) {
    temp = json['temp'] != null ? new Volume.fromJson(json['temp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.temp != null) {
      data['temp'] = this.temp.toJson();
    }
    return data;
  }
}

class Ingredients {
  List<Malt> malt;
  List<Hops> hops;
  String yeast;

  Ingredients({this.malt, this.hops, this.yeast});

  Ingredients.fromJson(Map<String, dynamic> json) {
    if (json['malt'] != null) {
      malt = new List<Malt>();
      json['malt'].forEach((v) {
        malt.add(new Malt.fromJson(v));
      });
    }
    if (json['hops'] != null) {
      hops = new List<Hops>();
      json['hops'].forEach((v) {
        hops.add(new Hops.fromJson(v));
      });
    }
    yeast = json['yeast'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.malt != null) {
      data['malt'] = this.malt.map((v) => v.toJson()).toList();
    }
    if (this.hops != null) {
      data['hops'] = this.hops.map((v) => v.toJson()).toList();
    }
    data['yeast'] = this.yeast;
    return data;
  }
}

class Malt {
  String name;
  Amount amount;

  Malt({this.name, this.amount});

  Malt.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount =
        json['amount'] != null ? new Amount.fromJson(json['amount']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.amount != null) {
      data['amount'] = this.amount.toJson();
    }
    return data;
  }
}

class Amount {
  double value;
  String unit;

  Amount({this.value, this.unit});

  Amount.fromJson(Map<String, dynamic> json) {
    value = json["value"] is int
        ? (json['value'] as int).toDouble()
        : json['value'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['unit'] = this.unit;
    return data;
  }
}

class Hops {
  String name;
  Amount amount;
  String add;
  String attribute;

  Hops({this.name, this.amount, this.add, this.attribute});

  Hops.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount =
        json['amount'] != null ? new Amount.fromJson(json['amount']) : null;
    add = json['add'];
    attribute = json['attribute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.amount != null) {
      data['amount'] = this.amount.toJson();
    }
    data['add'] = this.add;
    data['attribute'] = this.attribute;
    return data;
  }
}
