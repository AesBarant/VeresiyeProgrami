// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'musteri.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MusteriClassAdapter extends TypeAdapter<MusteriClass> {
  @override
  final int typeId = 1;

  @override
  MusteriClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MusteriClass(
      id: fields[0] as String,
      name: fields[1] as String,
      address: fields[2] as String,
      number: fields[3] as String,
      totalPrice: fields[4] as double,
      ayrinti: (fields[5] as List?)?.cast<MusteriAyrintiClass>(),
    );
  }

  @override
  void write(BinaryWriter writer, MusteriClass obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.number)
      ..writeByte(4)
      ..write(obj.totalPrice)
      ..writeByte(5)
      ..write(obj.ayrinti);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusteriClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MusteriAyrintiClassAdapter extends TypeAdapter<MusteriAyrintiClass> {
  @override
  final int typeId = 2;

  @override
  MusteriAyrintiClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MusteriAyrintiClass(
      id: fields[6] as String,
      aciklama: fields[7] as String,
      borc: fields[8] as double,
      odenen: fields[9] as double,
      tarih: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MusteriAyrintiClass obj) {
    writer
      ..writeByte(5)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.aciklama)
      ..writeByte(8)
      ..write(obj.borc)
      ..writeByte(9)
      ..write(obj.odenen)
      ..writeByte(10)
      ..write(obj.tarih);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusteriAyrintiClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
