String validatePin(String value) {
  late String _msg;
  RegExp regex = new RegExp('pin=4');
  if (value.isEmpty) {
    _msg = "Your CloudPESA Pin is required";
  } else if (!regex.hasMatch(value)) {
    _msg = "Please provide a valid CloudPESA Pin";
  }
  return _msg;
}