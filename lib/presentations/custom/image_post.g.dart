// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_post.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImagePostAdapter extends TypeAdapter<ImagePost> {
  @override
  final int typeId = 0;

  @override
  ImagePost read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImagePost(
      fields[0] as String,
      fields[1] as int,
      (fields[2] as List)?.cast<String>(),
      fields[3] as bool,
      fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ImagePost obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj._imagePath)
      ..writeByte(1)
      ..write(obj._likes)
      ..writeByte(2)
      ..write(obj._comments)
      ..writeByte(3)
      ..write(obj._showComments)
      ..writeByte(4)
      ..write(obj._typeComment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImagePostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
