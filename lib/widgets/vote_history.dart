import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nex_vote/consts/conts.dart';
import 'package:nex_vote/model/vote_model.dart';

class VoteHistory extends StatelessWidget {
  const VoteHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 10),
          child: Text(
            'Vote History',
            style: GoogleFonts.openSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ThemeColors().unselectedTextColor,
            ),
          ),
        ),
        SizedBox(height: 20),
        ...List.generate(voteHistory.length, (index) {
          VoteModel vote = voteHistory[index];
          return ExpansionTile(
            tilePadding: EdgeInsets.all(10),
            childrenPadding: EdgeInsets.all(10),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  vote.name,
                  style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: ThemeColors().unselectedTextColor,),
                ),
                Icon(
                  Icons.circle,
                  color: vote.isActive ? ThemeColors().badgeBackgroundColor : ThemeColors().unselectedIconColor,
                )
              ],
            ),
            children: [
              Column(
                children: [
                  Text(
                    vote.date,
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w500, color: ThemeColors().unselectedIconColor,),
                  ),
                  SizedBox(height: 5),
                  Text(
                    vote.des,
                    style: GoogleFonts.openSans(color: ThemeColors().unselectedTextColor,),
                  )
                ],
              )
            ],
          );
        })
      ],
    );
  }
}
