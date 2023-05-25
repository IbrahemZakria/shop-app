import 'package:flutter/material.dart';

class defaultTextFormField extends StatelessWidget {
  Function(String)? oncange;
  Function(String)? onsubmited;
  IconButton? sufixIcon;
  String hintText;
  bool? obsecuretext = false;
  String? Function(String?)? validator;
  TextInputType? textinputType = TextInputType.name;
  TextEditingController? textControler = TextEditingController();
  Function()? onTap;
  defaultTextFormField(
      {super.key, required this.hintText,
      this.onTap,
      this.obsecuretext,
      this.textControler,
      this.sufixIcon,
      this.oncange,
      this.textinputType,
      this.validator,
      this.onsubmited});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * .06,
        right: MediaQuery.of(context).size.width * .06,
        top: MediaQuery.of(context).size.height * .03,
      ),
      child: TextFormField(
        obscureText: obsecuretext ?? false,
        onTap: onTap,
        validator: validator,
        onChanged: oncange,
        onFieldSubmitted: onsubmited,
        keyboardType: textinputType,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        controller: textControler,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.black)),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          suffixIcon: sufixIcon,
          prefixIcon: IconButton(
              onPressed: () {
                textControler?.clear();
              },
              icon: const Icon(Icons.clear),
              color: Colors.black),
          contentPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * .01,
              top: MediaQuery.of(context).size.height * .01,
              right: MediaQuery.of(context).size.width * .02),
        ),
      ),
    );
  }
}
