// To parse this JSON data, do
//
//     final alreadyReadBookModel = alreadyReadBookModelFromJson(jsonString);

import 'dart:convert';

List<AlreadyReadBookModel> alreadyReadBookModelFromJson(String str) => List<AlreadyReadBookModel>.from(json.decode(str).map((x) => AlreadyReadBookModel.fromJson(x)));

String alreadyReadBookModelToJson(List<AlreadyReadBookModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlreadyReadBookModel {
    final Work? work;
    final String? loggedEdition;
    final String? loggedDate;

    AlreadyReadBookModel({
        this.work,
        this.loggedEdition,
        this.loggedDate,
    });

    factory AlreadyReadBookModel.fromJson(Map<String, dynamic> json) => AlreadyReadBookModel(
        work: json["work"] == null ? null : Work.fromJson(json["work"]),
        loggedEdition: json["logged_edition"],
        loggedDate: json["logged_date"],
    );

    Map<String, dynamic> toJson() => {
        "work": work?.toJson(),
        "logged_edition": loggedEdition,
        "logged_date": loggedDate,
    };
}

class Work {
    final String? title;
    final String? key;
    final List<String>? authorKeys;
    final List<String>? authorNames;
    final int? firstPublishYear;
    final String? lendingEditionS;
    final List<String>? editionKey;
    final int? coverId;
    final String? coverEditionKey;

    Work({
        this.title,
        this.key,
        this.authorKeys,
        this.authorNames,
        this.firstPublishYear,
        this.lendingEditionS,
        this.editionKey,
        this.coverId,
        this.coverEditionKey,
    });

    factory Work.fromJson(Map<String, dynamic> json) => Work(
        title: json["title"],
        key: json["key"],
        authorKeys: json["author_keys"] == null ? [] : List<String>.from(json["author_keys"]!.map((x) => x)),
        authorNames: json["author_names"] == null ? [] : List<String>.from(json["author_names"]!.map((x) => x)),
        firstPublishYear: json["first_publish_year"],
        lendingEditionS: json["lending_edition_s"],
        editionKey: json["edition_key"] == null ? [] : List<String>.from(json["edition_key"]!.map((x) => x)),
        coverId: json["cover_id"],
        coverEditionKey: json["cover_edition_key"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "key": key,
        "author_keys": authorKeys == null ? [] : List<dynamic>.from(authorKeys!.map((x) => x)),
        "author_names": authorNames == null ? [] : List<dynamic>.from(authorNames!.map((x) => x)),
        "first_publish_year": firstPublishYear,
        "lending_edition_s": lendingEditionS,
        "edition_key": editionKey == null ? [] : List<dynamic>.from(editionKey!.map((x) => x)),
        "cover_id": coverId,
        "cover_edition_key": coverEditionKey,
    };
}
