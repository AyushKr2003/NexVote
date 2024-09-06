import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nex_vote/consts/conts.dart';
import 'package:nex_vote/widgets/proposal_created.dart';
import 'package:nex_vote/widgets/user_info.dart';
import 'package:nex_vote/widgets/vote_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if the screen width is less than 790 pixels
        bool isSmallScreen = constraints.maxWidth < 790;

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: constraints.maxHeight * 0.4, // Adjust height proportionally
                width: double.infinity, // Ensure it takes full width
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ThemeColorsHome.selectedIconBox,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: UserInfo(),
              ),
              if (isSmallScreen)
                Column(
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.25, // Adjust height proportionally
                      width: double.infinity, // Ensure it takes full width
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ThemeColorsHome.selectedIconBox,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: VoteHistory(),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: constraints.maxHeight * 0.25, // Adjust height proportionally
                      width: double.infinity, // Ensure it takes full width
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ThemeColorsHome.selectedIconBox,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ProposalCreated(),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: constraints.maxHeight * 0.4, // Adjust height proportionally
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ThemeColorsHome.selectedIconBox,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: VoteHistory(),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        height: constraints.maxHeight * 0.4, // Adjust height proportionally
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ThemeColorsHome.selectedIconBox,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ProposalCreated(),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
