import 'package:flutter/material.dart';

class UserFields extends StatefulWidget {
  const UserFields(
      {super.key,
      this.obscure = false,
      required this.controller,
      required this.label,
      required this.hint});

  final bool obscure;
  final TextEditingController controller;
  final String label;
  final String hint;

  @override
  State<UserFields> createState() => _UserFieldsState();
}

class _UserFieldsState extends State<UserFields> {
  bool isObscuring = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        obscureText: isObscuring,
        controller: widget.controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget.label,
            hintText: widget.hint,
            suffixIcon: widget.obscure
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscuring = !isObscuring;
                      });
                    },
                    icon: Icon(
                        isObscuring ? Icons.visibility_off : Icons.visibility))
                : null),
      ),
    );
  }
}
