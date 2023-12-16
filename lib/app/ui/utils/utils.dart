import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

Widget myInput(
    {required String label,
    bool showLabel = true,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    TextInputAction textInputAction = TextInputAction.next,
    bool readOnly = false,
    int? maxLength,
    List<TextInputFormatter>? textInputFormatters,
    bool obscureText = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    required TextEditingController controller,
    String? Function(dynamic value)? validator}) {
  return Column(
    // mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (label.isNotEmpty && showLabel) ...[
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: Constants.fontFamilyApp,
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
      TextFormField(
        readOnly: readOnly,
        maxLines: maxLines,
        obscureText: obscureText,
        cursorColor: Constants.primaryColor,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        maxLength: maxLength,
        inputFormatters: textInputFormatters,
        decoration: InputDecoration(
          hintText: label,
          counterText: '',
          hintStyle: const TextStyle(
              color: Constants.secondaryText,
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500),
          contentPadding: const EdgeInsets.all(14),
          isDense: true,
          filled: true,
          fillColor: Constants.inputBgColor,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Constants.inputBorderColor),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Constants.inputBorderColor),
            borderRadius: BorderRadius.circular(5),
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        style: const TextStyle(fontFamily: 'Roboto', fontSize: 14),
      )
    ],
  );
}

Widget myButton(
    {required String label,
    required VoidCallback onClick,
    required Color color,
    double padding = 16,
    bool loading = false}) {
  return TextButton(
    style: TextButton.styleFrom(
      foregroundColor: Constants.black, padding: EdgeInsets.all(padding),
      backgroundColor: color,
      // textStyle: const TextStyle(
      // fontFamily: 'Bariol',fontSize: 14),
    ),
    onPressed: onClick,
    child: loading
        ? const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  color: Constants.whiteColor,
                  strokeWidth: 2,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Por favor, espere...",
                style: TextStyle(
                    fontFamily: Constants.fontFamilyApp,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ],
          )
        : Text(
            label.toUpperCase(),
            style: const TextStyle(
                fontFamily: Constants.fontFamilyApp,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
  );
}

writeData({required String contents, required String filename}) async {
  // const cacheName = '/data/user/0/com.dorje.balastro_simulador/report.txt';
  // final cacheName = Directory.systemTemp.path + '/report.txt';
  // const cacheName = '/sdcard/download/report.txt';
  // const cacheName = '/sdcard0/download/report.txt';
  String path = '/storage/emulated/0/Download/$filename';
  var file = File(path);
  bool exists = await file.exists();
  if (!exists) {
    file.create();
  }
  // Escribir el archivo
  file.writeAsString(contents, mode: FileMode.append);
}

///yyyy-mm-dd hh:mm:ss
formatedDate(DateTime date) {
  var fecha = date;
  var month =
      fecha.month < 10 ? fecha.month.toString().padLeft(2, '0') : fecha.month;
  var day = fecha.day < 10 ? fecha.day.toString().padLeft(2, '0') : fecha.day;
  var hour =
      fecha.hour < 10 ? fecha.hour.toString().padLeft(2, '0') : fecha.hour;
  var min = fecha.minute < 10
      ? fecha.minute.toString().padLeft(2, '0')
      : fecha.minute;
  var seg = fecha.second < 10
      ? fecha.second.toString().padLeft(2, '0')
      : fecha.second;
  return '${fecha.year}-$month-$day $hour:$min:$seg';
}

DateTime convertirTimestampDateTime(int secondsSinceEpoch) {
  return DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
}

int convertirDateTimeTimestamp(DateTime datetime) {
  return datetime.millisecondsSinceEpoch ~/ 1000;
}

///mié., 15 mar.
String formatFecha(String fecha, String formatTipe) {
  Intl.defaultLocale = "en_EN";
  initializeDateFormatting();
  var date = DateTime.parse(fecha);
  return DateFormat(formatTipe).format(date);
}

String formato2Digitos(int valor) {
  return valor >= 10 ? "$valor" : "0$valor";
}

String fechaFormateada(DateTime fecha) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm', 'es-ES');
  return formatter.format(fecha);
}

enum TipoDeElemento {
  point,
  conductores,
  bancosTransformadores,
  subestaciones,
  estructuras,
  rutas,
  averias,
  averiasParpadeando,
  conductoresRecorridos,
  podas,
  controlFlota,
  alumbrado,
  alumbradoAveriado,
}
