import 'dart:convert';

import 'package:teamxsdk/models/partner.dart';
import 'package:encrypt/encrypt.dart';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

// ignore: todo
//TODO Read from API
// ignore: constant_identifier_names
const String aes_encryption_key = "FiugQTgPNwCWUY,VhfmM4cKXTLVFvHFe";

class TXEnryptionManager {
  static String encrypt({required TXPartnerInterface partner}) {
    final date = TXEnryptionManager.getCurrentDate();
    final session =
        TXEnryptionManager.generateSession(partner: partner, date: date);
    final plainText =
        "${partner.partnerCode}|${partner.productCode.name.toUpperCase()}|$date|$session";
    // ignore: avoid_print
    //print("Plain Text To Encrypt $plainText");

    final key = Key.fromBase64('CJg4fL5thRG+TELABigyivwLZlVSN0RxgXbi1XTyjIA=');
    final iv = IV.fromBase64('FxIOBAcEEhISHgICCRYhEA==');
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    // final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return encrypted.base64;
  }

  static String generateSession(
      {required TXPartnerInterface partner, required String date}) {
    final plainText =
        "${partner.partnerCode}|${partner.productCode.name.toUpperCase()}|$date";

    final bytes1 = utf8.encode(plainText); // data being hashed
    final digest1 = sha256.convert(bytes1).toString(); // Hashing Process;

    return digest1;
  }

  static String getCurrentDate() {
    var outputFormat = DateFormat('dd-MM-yyyy hh:mm:ss a');
    var outputDate = outputFormat.format(DateTime.now());
    return outputDate;
  }
}
