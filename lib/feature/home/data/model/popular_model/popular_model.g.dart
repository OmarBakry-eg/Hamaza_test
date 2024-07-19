// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PopularNewsResultAdapter extends TypeAdapter<PopularNewsResult> {
  @override
  final int typeId = 1;

  @override
  PopularNewsResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PopularNewsResult(
      largeImage: fields[7] as String?,
      thumbImage: fields[5] as String?,
      url: fields[1] as String?,
      articleID: fields[0] as int?,
      publishedDate: fields[2] as DateTime?,
      byline: fields[3] as String?,
      title: fields[4] as String?,
      desFacet: (fields[6] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PopularNewsResult obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.articleID)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.publishedDate)
      ..writeByte(3)
      ..write(obj.byline)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.thumbImage)
      ..writeByte(6)
      ..write(obj.desFacet)
      ..writeByte(7)
      ..write(obj.largeImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PopularNewsResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
