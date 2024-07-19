import 'package:equatable/equatable.dart';

class SearchModel extends Equatable {
  final String? status;
  final String? copyright;
  final SearchResponse? response;

  const SearchModel({
    this.status,
    this.copyright,
    this.response,
  });

  SearchModel copyWith({
    String? status,
    String? copyright,
    SearchResponse? response,
  }) =>
      SearchModel(
        status: status ?? this.status,
        copyright: copyright ?? this.copyright,
        response: response ?? this.response,
      );

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        status: json["status"],
        copyright: json["copyright"],
        response: json["response"] == null
            ? null
            : SearchResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "copyright": copyright,
        "response": response?.toJson(),
      };

  @override
  List<Object?> get props => [status, copyright, response];
}

class SearchResponse extends Equatable {
  final List<SearchDoc>? docs;

  const SearchResponse({
    this.docs,
  });

  SearchResponse copyWith({
    List<SearchDoc>? docs,
  }) =>
      SearchResponse(
        docs: docs ?? this.docs,
      );

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        docs: json["docs"] == null
            ? []
            : List<SearchDoc>.from(
                json["docs"]!.map((x) => SearchDoc.fromJson(x))),
      );

  @override
  List<Object?> get props => [docs];

  Map<String, dynamic> toJson() => {
        "docs": docs == null
            ? []
            : List<dynamic>.from(docs!.map((x) => x.toJson())),
      };
}

class SearchDoc extends Equatable {
  final String? docAbstract;
  final String? webUrl;
  final String? snippet;
  final String? leadParagraph;
  final Source? source;
  final List<Multimedia>? multimedia;
  final Headline? headline;
  final List<Keyword>? keywords;
  final String? pubDate;
  final DocumentType? documentType;
  final Byline? byline;
  final String? id;
  final int? wordCount;
  final String? uri;
  final String? printSection;
  final String? printPage;
  final String? typeOfMaterial;

  const SearchDoc({
    this.docAbstract,
    this.webUrl,
    this.snippet,
    this.leadParagraph,
    this.source,
    this.multimedia,
    this.headline,
    this.keywords,
    this.pubDate,
    this.documentType,
    this.byline,
    this.id,
    this.wordCount,
    this.uri,
    this.printSection,
    this.printPage,
    this.typeOfMaterial,
  });

  SearchDoc copyWith({
    String? docAbstract,
    String? webUrl,
    String? snippet,
    String? leadParagraph,
    Source? source,
    List<Multimedia>? multimedia,
    Headline? headline,
    List<Keyword>? keywords,
    String? pubDate,
    DocumentType? documentType,
    Byline? byline,
    String? id,
    int? wordCount,
    String? uri,
    String? printSection,
    String? printPage,
    String? typeOfMaterial,
  }) =>
      SearchDoc(
        docAbstract: docAbstract ?? this.docAbstract,
        webUrl: webUrl ?? this.webUrl,
        snippet: snippet ?? this.snippet,
        leadParagraph: leadParagraph ?? this.leadParagraph,
        source: source ?? this.source,
        multimedia: multimedia ?? this.multimedia,
        headline: headline ?? this.headline,
        keywords: keywords ?? this.keywords,
        pubDate: pubDate ?? this.pubDate,
        documentType: documentType ?? this.documentType,
        byline: byline ?? this.byline,
        id: id ?? this.id,
        wordCount: wordCount ?? this.wordCount,
        uri: uri ?? this.uri,
        printSection: printSection ?? this.printSection,
        printPage: printPage ?? this.printPage,
        typeOfMaterial: typeOfMaterial ?? this.typeOfMaterial,
      );

  factory SearchDoc.fromJson(Map<String, dynamic> json) => SearchDoc(
        docAbstract: json["abstract"],
        webUrl: json["web_url"],
        snippet: json["snippet"],
        leadParagraph: json["lead_paragraph"],
        source: sourceValues.map[json["source"]]!,
        multimedia: json["multimedia"] == null
            ? []
            : List<Multimedia>.from(
                json["multimedia"]!.map((x) => Multimedia.fromJson(x))),
        headline: json["headline"] == null
            ? null
            : Headline.fromJson(json["headline"]),
        keywords: json["keywords"] == null
            ? []
            : List<Keyword>.from(
                json["keywords"]!.map((x) => Keyword.fromJson(x))),
        pubDate: json["pub_date"],
        documentType: documentTypeValues.map[json["document_type"]]!,
        byline: json["byline"] == null ? null : Byline.fromJson(json["byline"]),
        id: json["_id"],
        wordCount: json["word_count"],
        uri: json["uri"],
        printSection: json["print_section"],
        printPage: json["print_page"],
        typeOfMaterial: json["type_of_material"],
      );

  Map<String, dynamic> toJson() => {
        "abstract": docAbstract,
        "web_url": webUrl,
        "snippet": snippet,
        "lead_paragraph": leadParagraph,
        "source": sourceValues.reverse[source],
        "multimedia": multimedia == null
            ? []
            : List<dynamic>.from(multimedia!.map((x) => x.toJson())),
        "headline": headline?.toJson(),
        "keywords": keywords == null
            ? []
            : List<dynamic>.from(keywords!.map((x) => x.toJson())),
        "pub_date": pubDate,
        "document_type": documentTypeValues.reverse[documentType],
        "byline": byline?.toJson(),
        "_id": id,
        "word_count": wordCount,
        "uri": uri,
        "print_section": printSection,
        "print_page": printPage,
        "type_of_material": typeOfMaterial,
      };

  @override
  List<Object?> get props => [
        docAbstract,
        webUrl,
        snippet,
        leadParagraph,
        source,
        multimedia,
        headline,
        keywords,
        pubDate,
        documentType,
        byline,
        id,
        wordCount,
        uri,
        printSection,
        printPage,
        typeOfMaterial,
      ];
}

class Byline extends Equatable {
  final String? original;
  final List<Person>? person;
  final dynamic organization;

  const Byline({
    this.original,
    this.person,
    this.organization,
  });

  @override
  List<Object?> get props => [
        original,
        person,
        organization,
      ];

  Byline copyWith({
    String? original,
    List<Person>? person,
    dynamic organization,
  }) =>
      Byline(
        original: original ?? this.original,
        person: person ?? this.person,
        organization: organization ?? this.organization,
      );

  factory Byline.fromJson(Map<String, dynamic> json) => Byline(
        original: json["original"],
        person: json["person"] == null
            ? []
            : List<Person>.from(json["person"]!.map((x) => Person.fromJson(x))),
        organization: json["organization"],
      );

  Map<String, dynamic> toJson() => {
        "original": original,
        "person": person == null
            ? []
            : List<dynamic>.from(person!.map((x) => x.toJson())),
        "organization": organization,
      };
}

class Person extends Equatable {
  final String? firstname;
  final dynamic middlename;
  final String? lastname;
  final dynamic qualifier;
  final dynamic title;
  final String? role;
  final String? organization;
  final int? rank;

  const Person({
    this.firstname,
    this.middlename,
    this.lastname,
    this.qualifier,
    this.title,
    this.role,
    this.organization,
    this.rank,
  });

  Person copyWith({
    String? firstname,
    dynamic middlename,
    String? lastname,
    dynamic qualifier,
    dynamic title,
    String? role,
    String? organization,
    int? rank,
  }) =>
      Person(
        firstname: firstname ?? this.firstname,
        middlename: middlename ?? this.middlename,
        lastname: lastname ?? this.lastname,
        qualifier: qualifier ?? this.qualifier,
        title: title ?? this.title,
        role: role ?? this.role,
        organization: organization ?? this.organization,
        rank: rank ?? this.rank,
      );

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        firstname: json["firstname"],
        middlename: json["middlename"],
        lastname: json["lastname"],
        qualifier: json["qualifier"],
        title: json["title"],
        role: json["role"],
        organization: json["organization"],
        rank: json["rank"],
      );

  @override
  List<Object?> get props => [
        firstname,
        middlename,
        lastname,
        qualifier,
        title,
        role,
        organization,
        rank,
      ];

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "middlename": middlename,
        "lastname": lastname,
        "qualifier": qualifier,
        "title": title,
        "role": role,
        "organization": organization,
        "rank": rank,
      };
}

enum DocumentType { article, multimedia }

final documentTypeValues = EnumValues(
    {"article": DocumentType.article, "multimedia": DocumentType.multimedia});

class Headline extends Equatable {
  final String? main;
  final dynamic kicker;
  final dynamic contentKicker;
  final String? printHeadline;
  final dynamic name;
  final dynamic seo;
  final dynamic sub;

  const Headline({
    this.main,
    this.kicker,
    this.contentKicker,
    this.printHeadline,
    this.name,
    this.seo,
    this.sub,
  });

  Headline copyWith({
    String? main,
    dynamic kicker,
    dynamic contentKicker,
    String? printHeadline,
    dynamic name,
    dynamic seo,
    dynamic sub,
  }) =>
      Headline(
        main: main ?? this.main,
        kicker: kicker ?? this.kicker,
        contentKicker: contentKicker ?? this.contentKicker,
        printHeadline: printHeadline ?? this.printHeadline,
        name: name ?? this.name,
        seo: seo ?? this.seo,
        sub: sub ?? this.sub,
      );

  factory Headline.fromJson(Map<String, dynamic> json) => Headline(
        main: json["main"],
        kicker: json["kicker"],
        contentKicker: json["content_kicker"],
        printHeadline: json["print_headline"],
        name: json["name"],
        seo: json["seo"],
        sub: json["sub"],
      );

  Map<String, dynamic> toJson() => {
        "main": main,
        "kicker": kicker,
        "content_kicker": contentKicker,
        "print_headline": printHeadline,
        "name": name,
        "seo": seo,
        "sub": sub,
      };

  @override
  List<Object?> get props =>
      [main, kicker, contentKicker, printHeadline, name, seo, sub];
}

class Keyword extends Equatable {
  final Name? name;
  final String? value;
  final int? rank;

  const Keyword({
    this.name,
    this.value,
    this.rank,
  });

  Keyword copyWith({
    Name? name,
    String? value,
    int? rank,
  }) =>
      Keyword(
        name: name ?? this.name,
        value: value ?? this.value,
        rank: rank ?? this.rank,
      );

  factory Keyword.fromJson(Map<String, dynamic> json) => Keyword(
        name: nameValues.map[json["name"]]!,
        value: json["value"],
        rank: json["rank"],
      );

  Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "value": value,
        "rank": rank,
      };

  @override
  List<Object?> get props => [
        name,
        value,
        rank,
      ];
}

enum Name { glocations, organizations, persons, subject }

final nameValues = EnumValues({
  "glocations": Name.glocations,
  "organizations": Name.organizations,
  "persons": Name.persons,
  "subject": Name.subject
});

class Multimedia extends Equatable {
  final int? rank;
  final String? subtype;
  final dynamic caption;
  final dynamic credit;
  final Type? type;
  final String? url;
  final int? height;
  final int? width;
  final String? subType;
  final String? cropName;

  const Multimedia({
    this.rank,
    this.subtype,
    this.caption,
    this.credit,
    this.type,
    this.url,
    this.height,
    this.width,
    this.subType,
    this.cropName,
  });

  Multimedia copyWith({
    int? rank,
    String? subtype,
    dynamic caption,
    dynamic credit,
    Type? type,
    String? url,
    int? height,
    int? width,
    String? subType,
    String? cropName,
  }) =>
      Multimedia(
        rank: rank ?? this.rank,
        subtype: subtype ?? this.subtype,
        caption: caption ?? this.caption,
        credit: credit ?? this.credit,
        type: type ?? this.type,
        url: url ?? this.url,
        height: height ?? this.height,
        width: width ?? this.width,
        subType: subType ?? this.subType,
        cropName: cropName ?? this.cropName,
      );

  factory Multimedia.fromJson(Map<String, dynamic> json) => Multimedia(
        rank: json["rank"],
        subtype: json["subtype"],
        caption: json["caption"],
        credit: json["credit"],
        type: typeValues.map[json["type"]]!,
        url: json["url"],
        height: json["height"],
        width: json["width"],
        subType: json["subType"],
        cropName: json["crop_name"],
      );

  Map<String, dynamic> toJson() => {
        "rank": rank,
        "subtype": subtype,
        "caption": caption,
        "credit": credit,
        "type": typeValues.reverse[type],
        "url": url,
        "height": height,
        "width": width,
        "subType": subType,
        "crop_name": cropName,
      };

  @override
  List<Object?> get props => [
        rank,
        subtype,
        caption,
        credit,
        type,
        url,
        height,
        width,
        subType,
        cropName,
      ];
}

enum Type { image }

final typeValues = EnumValues({"image": Type.image});

enum Source { theNewYorkTimes }

final sourceValues = EnumValues({"The New York Times": Source.theNewYorkTimes});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
