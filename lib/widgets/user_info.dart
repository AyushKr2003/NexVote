import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nex_vote/consts/conts.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Wallet Address', style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold,color: ThemeColors().unselectedTextColor)),
                    Row(
                      children: [
                        Text(walletAdd, style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w500, color: ThemeColors().unselectedTextColor),),
                        SizedBox(width: 5),
                        IconButton(onPressed: (){
                          Clipboard.setData(ClipboardData(text: walletAdd));
                        },icon: Icon(Icons.copy_rounded,color: ThemeColors().badgeTextColor,)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(child: Icon(Icons.person_2_rounded,size: 250,)),
      ],
    );
  }
}
