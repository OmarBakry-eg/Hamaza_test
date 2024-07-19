import 'package:equatable/equatable.dart';

class PopularNewsModel extends Equatable {
  final String? status;
  final String? copyright;
  final int? numResults;
  final List<PopularNewsResult>? results;

  const PopularNewsModel({
    this.status,
    this.copyright,
    this.numResults,
    this.results,
  });

  PopularNewsModel copyWith({
    String? status,
    String? copyright,
    int? numResults,
    List<PopularNewsResult>? results,
  }) =>
      PopularNewsModel(
        status: status ?? this.status,
        copyright: copyright ?? this.copyright,
        numResults: numResults ?? this.numResults,
        results: results ?? this.results,
      );

  factory PopularNewsModel.fromJson(Map<String, dynamic> json) =>
      PopularNewsModel(
        status: json["status"],
        copyright: json["copyright"],
        numResults: json["num_results"],
        results: json["results"] == null
            ? []
            : List<PopularNewsResult>.from(
                json["results"].map((x) => PopularNewsResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "copyright": copyright,
        "num_results": numResults,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [status, copyright, numResults, results];
}

class PopularNewsResult extends Equatable {
  final String? uri;
  final String? url;
  final int? id;
  final int? assetId;
  final Source? source;
  final DateTime? publishedDate;
  final DateTime? updated;
  final String? section;
  final Subsection? subsection;
  final String? nytdsection;
  final String? adxKeywords;
  final dynamic column;
  final String? byline;
  final ResultType? type;
  final String? title;
  final String? resultAbstract;
  final List<String>? desFacet;
  final List<String>? orgFacet;
  final List<String>? perFacet;
  final List<String>? geoFacet;
  final List<NewsMedia>? media;
  final int? etaId;

  const PopularNewsResult({
    this.uri,
    this.url,
    this.id,
    this.assetId,
    this.source,
    this.publishedDate,
    this.updated,
    this.section,
    this.subsection,
    this.nytdsection,
    this.adxKeywords,
    this.column,
    this.byline,
    this.type,
    this.title,
    this.resultAbstract,
    this.desFacet,
    this.orgFacet,
    this.perFacet,
    this.geoFacet,
    this.media,
    this.etaId,
  });

  PopularNewsResult copyWith({
    String? uri,
    String? url,
    int? id,
    int? assetId,
    Source? source,
    DateTime? publishedDate,
    DateTime? updated,
    String? section,
    Subsection? subsection,
    String? nytdsection,
    String? adxKeywords,
    dynamic column,
    String? byline,
    ResultType? type,
    String? title,
    String? resultAbstract,
    List<String>? desFacet,
    List<String>? orgFacet,
    List<String>? perFacet,
    List<String>? geoFacet,
    List<NewsMedia>? media,
    int? etaId,
  }) =>
      PopularNewsResult(
        uri: uri ?? this.uri,
        url: url ?? this.url,
        id: id ?? this.id,
        assetId: assetId ?? this.assetId,
        source: source ?? this.source,
        publishedDate: publishedDate ?? this.publishedDate,
        updated: updated ?? this.updated,
        section: section ?? this.section,
        subsection: subsection ?? this.subsection,
        nytdsection: nytdsection ?? this.nytdsection,
        adxKeywords: adxKeywords ?? this.adxKeywords,
        column: column ?? this.column,
        byline: byline ?? this.byline,
        type: type ?? this.type,
        title: title ?? this.title,
        resultAbstract: resultAbstract ?? this.resultAbstract,
        desFacet: desFacet ?? this.desFacet,
        orgFacet: orgFacet ?? this.orgFacet,
        perFacet: perFacet ?? this.perFacet,
        geoFacet: geoFacet ?? this.geoFacet,
        media: media ?? this.media,
        etaId: etaId ?? this.etaId,
      );

  factory PopularNewsResult.fromJson(Map<String, dynamic> json) => PopularNewsResult(
        uri: json["uri"],
        url: json["url"],
        id: json["id"],
        assetId: json["asset_id"],
        source: sourceValues.map[json["source"]],
        publishedDate: json["published_date"] == null
            ? null
            : DateTime.tryParse(
                json["published_date"],
              ),
        updated:
            json["updated"] == null ? null : DateTime.parse(json["updated"]),
        section: json["section"],
        subsection: subsectionValues.map[json["subsection"]],
        nytdsection: json["nytdsection"],
        adxKeywords: json["adx_keywords"],
        column: json["column"],
        byline: json["byline"],
        type: resultTypeValues.map[json["type"]],
        title: json["title"],
        resultAbstract: json["abstract"],
        desFacet: json["des_facet"] == null
            ? []
            : List<String>.from(json["des_facet"].map((x) => x)),
        orgFacet: json["org_facet"] == null
            ? []
            : List<String>.from(json["org_facet"].map((x) => x)),
        perFacet: json["per_facet"] == null
            ? []
            : List<String>.from(json["per_facet"].map((x) => x)),
        geoFacet: json["geo_facet"] == null
            ? []
            : List<String>.from(json["geo_facet"].map((x) => x)),
        media: json["media"] == null
            ? []
            : List<NewsMedia>.from(
                json["media"].map((x) => NewsMedia.fromJson(x))),
        etaId: json["eta_id"],
      );

  Map<String, dynamic> toJson() => {
        "uri": uri,
        "url": url,
        "id": id,
        "asset_id": assetId,
        "source": sourceValues.reverse[source],
        "published_date":
            "${publishedDate?.year.toString().padLeft(4, '0')}-${publishedDate?.month.toString().padLeft(2, '0')}-${publishedDate?.day.toString().padLeft(2, '0')}",
        "updated": updated?.toIso8601String(),
        "section": section,
        "subsection": subsectionValues.reverse[subsection],
        "nytdsection": nytdsection,
        "adx_keywords": adxKeywords,
        "column": column,
        "byline": byline,
        "type": resultTypeValues.reverse[type],
        "title": title,
        "abstract": resultAbstract,
        "des_facet":
            desFacet == null ? [] : List<dynamic>.from(desFacet!.map((x) => x)),
        "org_facet":
            orgFacet == null ? [] : List<dynamic>.from(orgFacet!.map((x) => x)),
        "per_facet":
            perFacet == null ? [] : List<dynamic>.from(perFacet!.map((x) => x)),
        "geo_facet":
            geoFacet == null ? [] : List<dynamic>.from(geoFacet!.map((x) => x)),
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
        "eta_id": etaId,
      };

  @override
  List<Object?> get props {
    return [
      uri,
      url,
      id,
      assetId,
      source,
      publishedDate,
      updated,
      section,
      subsection,
      nytdsection,
      adxKeywords,
      column,
      byline,
      type,
      title,
      resultAbstract,
      desFacet,
      orgFacet,
      perFacet,
      geoFacet,
      media,
      etaId,
    ];
  }
}

class NewsMedia extends Equatable {
  final MediaType? type;
  final Subtype? subtype;
  final String? caption;
  final String? copyright;
  final int? approvedForSyndication;
  final List<MediaMetadatum>? mediaMetadata;

  const NewsMedia({
    this.type,
    this.subtype,
    this.caption,
    this.copyright,
    this.approvedForSyndication,
    this.mediaMetadata,
  });

  NewsMedia copyWith({
    MediaType? type,
    Subtype? subtype,
    String? caption,
    String? copyright,
    int? approvedForSyndication,
    List<MediaMetadatum>? mediaMetadata,
  }) =>
      NewsMedia(
        type: type ?? this.type,
        subtype: subtype ?? this.subtype,
        caption: caption ?? this.caption,
        copyright: copyright ?? this.copyright,
        approvedForSyndication:
            approvedForSyndication ?? this.approvedForSyndication,
        mediaMetadata: mediaMetadata ?? this.mediaMetadata,
      );

  factory NewsMedia.fromJson(Map<String, dynamic> json) => NewsMedia(
        type: mediaTypeValues.map[json["type"]],
        subtype: subtypeValues.map[json["subtype"]],
        caption: json["caption"],
        copyright: json["copyright"],
        approvedForSyndication: json["approved_for_syndication"],
        mediaMetadata: json["media-metadata"] == null
            ? []
            : List<MediaMetadatum>.from(
                json["media-metadata"].map((x) => MediaMetadatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": mediaTypeValues.reverse[type],
        "subtype": subtypeValues.reverse[subtype],
        "caption": caption,
        "copyright": copyright,
        "approved_for_syndication": approvedForSyndication,
        "media-metadata": mediaMetadata == null
            ? []
            : List<dynamic>.from(mediaMetadata!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props {
    return [
      type,
      subtype,
      caption,
      copyright,
      approvedForSyndication,
      mediaMetadata,
    ];
  }
}

class MediaMetadatum extends Equatable {
  final String? url;
  final Format? format;
  final int? height;
  final int? width;

  const MediaMetadatum({
    this.url,
    this.format,
    this.height,
    this.width,
  });

  MediaMetadatum copyWith({
    String? url,
    Format? format,
    int? height,
    int? width,
  }) =>
      MediaMetadatum(
        url: url ?? this.url,
        format: format ?? this.format,
        height: height ?? this.height,
        width: width ?? this.width,
      );

  factory MediaMetadatum.fromJson(Map<String, dynamic> json) => MediaMetadatum(
        url: json["url"],
        format: formatValues.map[json["format"]],
        height: json["height"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "format": formatValues.reverse[format],
        "height": height,
        "width": width,
      };

  @override
  List<Object?> get props => [url, format, height, width];
}

enum Format { mediumThreeByTwo210, mediumThreeByTwo440, standardThumbnail }

final formatValues = EnumValues({
  "mediumThreeByTwo210": Format.mediumThreeByTwo210,
  "mediumThreeByTwo440": Format.mediumThreeByTwo440,
  "Standard Thumbnail": Format.standardThumbnail,
});

enum Subtype { empty, photo }

final subtypeValues = EnumValues({"": Subtype.empty, "photo": Subtype.photo});

enum MediaType { image }

final mediaTypeValues = EnumValues({"image": MediaType.image});

enum Source { newYorkTimes }

final sourceValues = EnumValues({"New York Times": Source.newYorkTimes});

enum Subsection { empty, politics }

final subsectionValues =
    EnumValues({"": Subsection.empty, "Politics": Subsection.politics});

enum ResultType { article, interactive }

final resultTypeValues = EnumValues(
    {"Article": ResultType.article, "Interactive": ResultType.interactive});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
