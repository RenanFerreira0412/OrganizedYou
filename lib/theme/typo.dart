import 'package:flutter/material.dart';

@immutable
class AppTypo {
  // Texto preto
  TextStyle black(
          double size, Color color, double height, double letterSpacing) =>
      TextStyle(
          color: color,
          fontFamily: "Satoshi",
          fontSize: size,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.normal,
          letterSpacing: letterSpacing,
          height: height);

  // Texto preto em itálico
  TextStyle blackItalic(
          double size, Color color, double height, double letterSpacing) =>
      TextStyle(
          color: color,
          fontFamily: "Satoshi",
          fontSize: size,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          letterSpacing: letterSpacing,
          height: height);

  // Texto negrito
  TextStyle bold(
          double size, Color color, double height, double letterSpacing) =>
      TextStyle(
          color: color,
          fontFamily: "Satoshi",
          fontSize: size,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          letterSpacing: letterSpacing,
          height: height);

  // Texto itálico em negrito
  TextStyle boldItalic(
          double size, Color color, double height, double letterSpacing) =>
      TextStyle(
          color: color,
          fontFamily: "Satoshi",
          fontSize: size,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          letterSpacing: letterSpacing,
          height: height);

  // Texto em itálico
  TextStyle italic(
          double size, Color color, double height, double letterSpacing) =>
      TextStyle(
          color: color,
          fontFamily: "Satoshi",
          fontSize: size,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          letterSpacing: letterSpacing,
          height: height);

  // Texto intermediário
  TextStyle medium(
          double size, Color color, double height, double letterSpacing) =>
      TextStyle(
          color: color,
          fontFamily: "Satoshi",
          fontSize: size,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          letterSpacing: letterSpacing,
          height: height);

  // Texto intermediário em itálico
  TextStyle mediumItalic(
          double size, Color color, double height, double letterSpacing) =>
      TextStyle(
          color: color,
          fontFamily: "Satoshi",
          fontSize: size,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
          letterSpacing: letterSpacing,
          height: height);

  // Texto normal
  TextStyle regular(
          double size, Color color, double height, double letterSpacing) =>
      TextStyle(
          color: color,
          fontFamily: "Satoshi",
          fontSize: size,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: letterSpacing,
          height: height);

  // Texto claro
  TextStyle light(
          double size, Color color, double height, double letterSpacing) =>
      TextStyle(
          color: color,
          fontFamily: "Satoshi",
          fontSize: size,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          letterSpacing: letterSpacing,
          height: height);

  // Texto claro em itálico
  TextStyle lightItalic(
          double size, Color color, double height, double letterSpacing) =>
      TextStyle(
          color: color,
          fontFamily: "Satoshi",
          fontSize: size,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.italic,
          letterSpacing: letterSpacing,
          height: height);

  const AppTypo();
}
