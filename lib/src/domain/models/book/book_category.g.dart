// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookCategoryAdapter extends TypeAdapter<BookCategory> {
  @override
  final int typeId = 0;

  @override
  BookCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookCategory(
      name: fields[0] as String,
      books: (fields[1] as List?)?.cast<Book>(),
    );
  }

  @override
  void write(BinaryWriter writer, BookCategory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.books);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
