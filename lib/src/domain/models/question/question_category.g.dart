// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionCategoryAdapter extends TypeAdapter<QuestionCategory> {
  @override
  final int typeId = 2;

  @override
  QuestionCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionCategory(
      name: fields[0] as String?,
      questions: (fields[1] as List?)?.cast<Question>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuestionCategory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.questions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
