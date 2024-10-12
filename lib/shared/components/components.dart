import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget articalItemsSperator() {
  return Padding(
    padding: const EdgeInsets.only(right: 10, left: 10),
    child: Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey,
    ),
  );
}

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => widget), (route) {
    return false;
  });
}

Widget defualtTextinput({
  required TextEditingController controller,
  required TextInputType Type,
  required String label,
  IconData? prefixIcon,
  IconData? suffixIcon,
  required String? Function(dynamic value) validate,
  Function()? onIconPresses,
  required bool password,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: Type,
      obscureText: password,
      validator: validate,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixIcon: Icon(prefixIcon),
          suffixIcon:
              IconButton(icon: Icon(suffixIcon), onPressed: onIconPresses)),
    );
PreferredSizeWidget defualtAppbar({
  required BuildContext context,
  String? title,
  List<Widget>? action,
  Widget? leading,
}) =>
    AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      titleSpacing: 5,
      title: Text(title!),
      actions: action,
    );
Widget defualtButton({required String text, required Function()? onPressed}) =>
    Container(
      width: double.infinity,
      color: Colors.blue,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
void showtoast({
  required String msg,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ChoseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color ChoseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}
