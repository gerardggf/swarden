extension DateFunctions on DateTime {
  String toDDMMYYYY() {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/${year.toString().padLeft(4, '0')}';
  }
}
