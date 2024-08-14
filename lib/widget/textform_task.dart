import 'package:flutter/material.dart';

class textform_task extends StatelessWidget {
  const textform_task({
    super.key,
    required this.controller,
    this.isForDesciption = false,
    required this.onFieldSubmitted,
    required this.onChanged,
  });

  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final isForDesciption;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ListTile(
        title: TextFormField(
          controller: controller,
          maxLines: !isForDesciption ? 6 : null,
          cursorHeight: !isForDesciption ? 50 : null,
          decoration: InputDecoration(
            border: isForDesciption ? InputBorder.none : null,
            hintText: isForDesciption ? 'Add Note' : 'Whats are you planing?',
            prefixIcon: isForDesciption
                ? const Icon(
                    Icons.bookmark_border,
                    color: Colors.grey,
                  )
                : null,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
          ),
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
