// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toptanci.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToptanciClassAdapter extends TypeAdapter<ToptanciClass> {
  @override
  final int typeId = 3;

  @override
  ToptanciClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToptanciClass(
      id: fields[11] as String,
      tName: fields[12] as String,
      tTotalPrice: fields[13] as double,
      tAyrinti: (fields[14] as List).cast<ToptanciAyrintiClass>(),
    );
  }

  @override
  void write(BinaryWriter writer, ToptanciClass obj) {
    writer
      ..writeByte(4)
      ..writeByte(11)
      ..write(obj.id)
      ..writeByte(12)
      ..write(obj.tName)
      ..writeByte(13)
      ..write(obj.tTotalPrice)
      ..writeByte(14)
      ..write(obj.tAyrinti);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToptanciClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ToptanciAyrintiClassAdapter extends TypeAdapter<ToptanciAyrintiClass> {
  @override
  final int typeId = 4;

  @override
  ToptanciAyrintiClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToptanciAyrintiClass(
      id: fields[15] as String,
      tAciklama: fields[16] as String,
      tBorc: fields[17] as double,
      tOdenen: fields[18] as double,
      tTarih: fields[19] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ToptanciAyrintiClass obj) {
    writer
      ..writeByte(5)
      ..writeByte(15)
      ..write(obj.id)
      ..writeByte(16)
      ..write(obj.tAciklama)
      ..writeByte(17)
      ..write(obj.tBorc)
      ..writeByte(18)
      ..write(obj.tOdenen)
      ..writeByte(19)
      ..write(obj.tTarih);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToptanciAyrintiClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
