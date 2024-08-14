import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todohive/utils/colors.dart';
import 'package:todohive/widget/space_exs.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    final List<IconData> icons = [
      CupertinoIcons.home,
      CupertinoIcons.person_fill,
      CupertinoIcons.settings,
      CupertinoIcons.info_circle_fill,
    ];

    final List<String> texts = ["Home", "Profile", "Settings", "Details"];

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: MyColors.primaryGradientColor)),
      child: Column(
        children: [
          50.h,
          Text(
            'Nitin Bais',
            style: textTheme.displayMedium,
          ),
          5.h,
          Text(
            'Flutter dev',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          50.h,
          Container(
            width: double.infinity,
            height: 250,
            margin: EdgeInsets.symmetric(vertical: 50),
            child: ListView.builder(
                itemCount: icons.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      child: ListTile(
                        leading: Icon(
                          icons[index],
                          color: Colors.white,
                          size: 25,
                        ),
                        title: Text(
                          texts[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
