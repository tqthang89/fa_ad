extension ExString on String {
  bool isNullOrWhiteSpace() {
    return this == null ||
        this == "" ||
        this.length == 0 ||
        this == " " ||
        this.trim() == "" ||
        this.trim() == " " ||
        this.trim() == "null";
  }

  bool isNumeric() {
    if (this.isNullOrWhiteSpace()) {
      return false;
    }
    return double.tryParse(this) != null || int.tryParse(this) != null;
  }
}
