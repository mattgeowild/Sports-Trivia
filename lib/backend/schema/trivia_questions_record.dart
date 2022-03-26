import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'trivia_questions_record.g.dart';

abstract class TriviaQuestionsRecord
    implements Built<TriviaQuestionsRecord, TriviaQuestionsRecordBuilder> {
  static Serializer<TriviaQuestionsRecord> get serializer =>
      _$triviaQuestionsRecordSerializer;

  @nullable
  String get question;

  @nullable
  String get answer1;

  @nullable
  String get answer2;

  @nullable
  String get answer3;

  @nullable
  String get answer4;

  @nullable
  @BuiltValueField(wireName: 'correct_answer')
  int get correctAnswer;

  @nullable
  String get image;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(TriviaQuestionsRecordBuilder builder) =>
      builder
        ..question = ''
        ..answer1 = ''
        ..answer2 = ''
        ..answer3 = ''
        ..answer4 = ''
        ..correctAnswer = 0
        ..image = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('trivia_questions');

  static Stream<TriviaQuestionsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<TriviaQuestionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  TriviaQuestionsRecord._();
  factory TriviaQuestionsRecord(
          [void Function(TriviaQuestionsRecordBuilder) updates]) =
      _$TriviaQuestionsRecord;

  static TriviaQuestionsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createTriviaQuestionsRecordData({
  String question,
  String answer1,
  String answer2,
  String answer3,
  String answer4,
  int correctAnswer,
  String image,
}) =>
    serializers.toFirestore(
        TriviaQuestionsRecord.serializer,
        TriviaQuestionsRecord((t) => t
          ..question = question
          ..answer1 = answer1
          ..answer2 = answer2
          ..answer3 = answer3
          ..answer4 = answer4
          ..correctAnswer = correctAnswer
          ..image = image));
