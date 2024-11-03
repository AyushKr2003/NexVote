import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nex_vote/consts/conts.dart';
import 'package:nex_vote/model/proposal_model.dart'; // Update this import to where your Election model is defined

class ProposalCreated extends StatelessWidget {
  final List<Election> elections; // Accepting the list of Election as a parameter

  const ProposalCreated({super.key, required this.elections});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Election History',
              style: GoogleFonts.openSans(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: elections.length,
              itemBuilder: (context, index) {
                Election election = elections[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.all(12),
                    childrenPadding: EdgeInsets.all(12),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          election.title,
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          color: Colors.blue, // You can change this to reflect election status
                        ),
                      ],
                    ),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description: ${election.description}',
                            style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Start Date: ${election.startDate.toLocal()}',
                            style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'End Date: ${election.endDate.toLocal()}',
                            style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Creator: ${election.creator}',
                            style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Total Candidates: ${election.candidates.length}',
                            style: GoogleFonts.openSans(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
