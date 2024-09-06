import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nex_vote/consts/conts.dart';
import 'package:nex_vote/model/proposal_model.dart';

class ProposalCreated extends StatelessWidget {
  const ProposalCreated({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 10),
          child: Text('Proposal History',
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeColors().unselectedTextColor,
              )),
        ),
        SizedBox(height: 20),
        ...List.generate(proposalHistory.length, (index) {
          ProposalModel proposal = proposalHistory[index];
          return ExpansionTile(
            tilePadding: EdgeInsets.all(10),
            childrenPadding: EdgeInsets.all(10),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  proposal.name,
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    color: ThemeColors().unselectedTextColor,
                  ),
                ),
                Icon(
                  Icons.circle,
                  color: proposal.isActive
                      ? ThemeColors().badgeBackgroundColor
                      : ThemeColors().unselectedIconColor,
                )
              ],
            ),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    proposal.date,
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w500,
                      color: ThemeColors().unselectedTextColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    proposal.des,
                    style: GoogleFonts.openSans(
                      color: ThemeColors().unselectedTextColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Winner: ${proposal.winner}',
                        style: GoogleFonts.openSans(
                          color: ThemeColors().unselectedTextColor,
                        ),
                      ),
                      Text(
                        "Total vote: ${proposal.totalVote}",
                        style: GoogleFonts.openSans(
                          color: ThemeColors().unselectedTextColor,
                        ),
                      ),
                    ],
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
