import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:todohive/main.dart';
import 'package:todohive/utils/toast.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({super.key, required this.drawerKey});
  final GlobalKey<SliderDrawerState> drawerKey;

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isDrawerOpen = false;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

// on Toggle drawer
  void onDrawerToggle() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        animationController.forward();
        widget.drawerKey.currentState!.openSlider();
      } else {
        animationController.reverse();
        widget.drawerKey.currentState!.closeSlider();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var base = BaseWidget.of(context).dataStore.box;
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
                onPressed: onDrawerToggle,
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: animationController,
                  size: 32,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
                onPressed: () {
                  base.isEmpty
                      ? noTaskWarning(context)
                      : deleteAllTask(context);
                },
                icon: const Icon(
                  CupertinoIcons.trash_fill,
                  size: 32,
                )),
          ),
        ],
      ),
    );
  }
}
