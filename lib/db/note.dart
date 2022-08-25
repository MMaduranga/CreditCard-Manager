// final String tableNotes = 'cardDetails';
//
// class NoteFields {
//   // static final List<String> values = [
//   //   /// Add all fields
//   //   id, nickName, billingDate, currentAmount, cashLimit
//   // ];
// ///colum names
// //   static final String id = '_id';
// //   static final String nickName = 'nickName';
// //   static final String billingDate = 'billingDate';
// //   static final String currentAmount = 'currentAmount';
// //   static final String cashLimit = 'cashLimit';
//
//
// }
//
// class Note {
//   final int? id;
//   final String nickName;
//   final int billingDate;
//   final double currentAmount;
//   final double cashLimit;
//
//   const Note({
//     this.id,
//     required this.nickName,
//     required this.billingDate,
//     required this.currentAmount,
//     required this.cashLimit,
//   });
//
//   Note copy({
//     int? id,
//     bool? isImportant,
//     int? number,
//     String? title,
//     String? description,
//     DateTime? createdTime,
//   }) =>
//       Note(
//         id: id ?? this.id,
//         isImportant: isImportant ?? this.isImportant,
//         number: number ?? this.number,
//         nickName: title ?? this.nickName,
//         description: description ?? this.description,
//         createdTime: createdTime ?? this.createdTime,
//       );
//
//   static Note fromJson(Map<String, Object?> json) => Note(
//     id: json[NoteFields.id] as int?,
//     isImportant: json[NoteFields.nickName] == 1,
//     number: json[NoteFields.billingDate] as int,
//     nickName: json[NoteFields.currentAmount] as String,
//     description: json[NoteFields.cashLimit] as String,
//     createdTime: DateTime.parse(json[NoteFields.time] as String),
//   );
//
//   // Map<String, Object?> toJson() => {
//   //   NoteFields.id: id,
//   //   NoteFields.currentAmount: nickName,
//   //   NoteFields.nickName: isImportant ? 1 : 0,
//   //   NoteFields.billingDate: number,
//   //   NoteFields.cashLimit: description,
//   //   NoteFields.time: createdTime.toIso8601String(),
//   // };
// }