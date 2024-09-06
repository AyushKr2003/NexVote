import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nex_vote/consts/conts.dart';
import 'package:nex_vote/widgets/proposal_bottom_sheet.dart';

class ProposalPage extends StatefulWidget {
  const ProposalPage({super.key});

  @override
  State<ProposalPage> createState() => _ProposalPageState();
}

class _ProposalPageState extends State<ProposalPage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine the number of columns based on screen width
    int crossAxisCount;
    if (screenWidth > 1200) {
      crossAxisCount = 4; // For larger screens, use 4 columns
    } else if (screenWidth > 800) {
      crossAxisCount = 3; // For medium screens, use 3 columns
    } else {
      crossAxisCount = 2; // For smaller screens, use 2 columns
    }

    // Calculate the aspect ratio dynamically
    double childAspectRatio = (screenWidth / crossAxisCount) / 296;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColorsHome.backgroundColor,
        title: Text(
          'Proposal History',
          style: GoogleFonts.openSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: ThemeColorsHome.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search Proposals',
                style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Search by Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.teal),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: proposalHistory
                      .where((proposal) => proposal.name.toLowerCase().contains(searchQuery.toLowerCase()))
                      .length,
                  itemBuilder: (context, index) {
                    final filteredProposals = proposalHistory
                        .where((proposal) => proposal.name.toLowerCase().contains(searchQuery.toLowerCase()))
                        .toList();
                    final proposal = filteredProposals[index];

                    return Card(
                      margin: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 3,
                      color: proposal.isActive ? ThemeColorsHome.primaryColor1 : ThemeColorsHome.primaryColor2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              proposal.name,
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Date: ${proposal.date}',
                              style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              proposal.des,
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Winner: ${proposal.winner}',
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              'Total Votes: ${proposal.totalVote}',
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProposalBottomSheet(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }

  void _showAddProposalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ProposalBottomSheet(
          onSubmit: () {
            // Add logic to handle proposal submission
            Navigator.pop(context); // Close the bottom sheet
          },
        );
      },
    );
  }
}
