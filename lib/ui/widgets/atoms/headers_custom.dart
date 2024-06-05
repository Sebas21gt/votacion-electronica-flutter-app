import 'package:app_vote/ui/main/styles.dart';
import 'package:flutter/material.dart';

class HeaderCustom extends StatelessWidget {
  const HeaderCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      height: size.height * 0.45,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/logo_horizontal.png',
              width: 350,
            ),
          ),
          // const SizedBox(height: 10),
          Center(
            child: Text(
              'Ingresar',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
