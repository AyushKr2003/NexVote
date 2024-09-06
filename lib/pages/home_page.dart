import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    Size size = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.5,
              width: size.width,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ThemeColors().selectedIconBox,
                // border: Border.all(
                //   color: Colors.grey,
                //   width: 5.0
                // ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: UserInfo(),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: size.height * 0.5,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ThemeColors().selectedIconBox,
                      // border: Border.all(
                      //     // color: ThemeColors().selectedIconBox,
                      //     width: 5.0
                      // ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: VoteHistory(),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: size.height * 0.5,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ThemeColors().selectedIconBox,
                      // border: Border.all(
                      //     // color: Colors.grey,
                      //     width: 5.0
                      // ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ProposalCreated(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
