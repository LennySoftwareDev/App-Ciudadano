import 'package:app_ciudadano/utils/size_config.dart';
import 'package:flutter/material.dart';

class AppBarDetailNews extends StatelessWidget {
  const AppBarDetailNews({Key? key}) : super(key: key);

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20, context)),
        child: Row(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(40, context),
              width: getProportionateScreenWidth(40, context),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  primary: Colors.green,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => Navigator.pop(context),
                child:  const Icon(Icons.arrow_back_ios),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: const [
                 
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}