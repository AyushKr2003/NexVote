import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nex_vote/consts/conts.dart';
import 'package:nex_vote/metamask_provider.dart';
import 'package:nex_vote/model/proposal_model.dart';
import 'package:nex_vote/provider/api.dart';

// import 'package:nex_vote/model/election_model.dart'; // Update import to use Election model
import 'package:nex_vote/widgets/proposal_bottom_sheet.dart';
import 'package:provider/provider.dart';

// import 'package:nex_vote/providers/meta_mask_provider.dart'; // Ensure you have the correct import
// import 'package:nex_vote/services/api_service.dart'; // Ensure you have the correct import

class ProposalPage extends StatefulWidget {
  const ProposalPage({super.key});

  @override
  State<ProposalPage> createState() => _ProposalPageState();
}

class _ProposalPageState extends State<ProposalPage> {
  List<Election> elections = [];
  String searchQuery = '';
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    fetchElections();
  }

  Future<void> fetchElections() async {
    try {
      String token = Provider.of<MetaMaskProvider>(context, listen: false)
          .authResponse!
          .token;
      elections = await ApiService().fetchElections(token);
    } catch (e) {
      print('Failed to fetch elections: $e');
    } finally {
      setState(() {
        isLoading = false; // Stop loading when done
      });
    }
  }

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
          'Election History',
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
          child: isLoading
              ? Center(child: CircularProgressIndicator()) // Loading indicator
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search Elections',
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
                        itemCount: elections
                            .where((election) => election.title
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()))
                            .length,
                        itemBuilder: (context, index) {
                          final filteredElections = elections
                              .where((election) => election.title
                                  .toLowerCase()
                                  .contains(searchQuery.toLowerCase()))
                              .toList();
                          final election = filteredElections[index];

                          return GestureDetector(
                            onTap: () =>
                                _showElectionDetailsDialog(context, election),
                            child: Card(
                              margin: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 3,
                              // color: election.isVotingOpen ? ThemeColorsHome.primaryColor1 : ThemeColorsHome.primaryColor2,
                              color: ThemeColorsHome.primaryColor1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      election.title,
                                      style: GoogleFonts.openSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Start: ${election.startDate}',
                                      style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      election.description,
                                      style: GoogleFonts.openSans(
                                        fontSize: 14,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                    // SizedBox(height: 8),
                                    // Text(
                                    //   election.isVotingOpen ? 'Status: Voting Open' : 'Status: Voting Closed',
                                    //   style: GoogleFonts.openSans(
                                    //     fontSize: 14,
                                    //     color: Colors.black54,
                                    //   ),
                                    // ),
                                  ],
                                ),
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
        child: Icon(Icons.add, color: ThemeNavColors.backgroundColor),
        backgroundColor: ThemeNavColors.selectedIconBox,
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
            fetchElections();
            Navigator.pop(context); // Close the bottom sheet
          },
          onUpdateElections: fetchElections,
        );
      },
    );
  }

  void _showElectionDetailsDialog(BuildContext context, Election election) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              election.title,
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                // Display election details
                Text(
                  'Start Date: ${election.startDate}',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'End Date: ${election.endDate}',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Description: ${election.description}',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),

                // Display the candidate list if available
                if (election.candidates.isNotEmpty) ...[
                  Text(
                    'Candidates:',
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 200,
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true, // Allow the list view to take up only the required space
                      physics: NeverScrollableScrollPhysics(), // Disable scrolling to prevent overflow
                      itemCount: election.candidates.length,
                      itemBuilder: (context, index) {
                        final candidate = election.candidates[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            '${candidate.name} (${candidate.symbol})',
                            style: GoogleFonts.openSans(fontSize: 16),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                ] else ...[
                  Text(
                    'No candidates available for this election.',
                    style: GoogleFonts.openSans(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                ],

                // Button to add a new candidate
                ElevatedButton(
                  onPressed: () {
                    _showAddCandidateDialog(context, election);
                  },
                  child: Text('Add Candidate'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showAddCandidateDialog(BuildContext context, Election election) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController walletAddressController = TextEditingController();
    final TextEditingController symbolController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Candidate'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Candidate Name'),
                ),
                TextField(
                  controller: walletAddressController,
                  decoration: InputDecoration(labelText: 'Wallet Address'),
                ),
                TextField(
                  controller: symbolController,
                  decoration: InputDecoration(labelText: 'Symbol'),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    // Get the input values
                    final String name = nameController.text;
                    final String walletAddress = walletAddressController.text;
                    final String symbol = symbolController.text;

                    // Create the new candidate object
                    final newCandidate = Candidate(
                      name: name,
                      symbol: symbol,
                      contractIndex: 0, // Adjust as needed
                      walletAddress: walletAddress,
                    );

                    String token = Provider.of<MetaMaskProvider>(context, listen: false).authResponse!.token;

                    // Call the function to add a candidate to the election
                    await ApiService().addCandidateToElection(election.id!, newCandidate, token);
                    fetchElections(); // Refresh the elections list
                    Fluttertoast.showToast(msg: "Candidate Added Successfully",timeInSecForIosWeb: 3);
                    Navigator.pop(context); // Close the dialog
                    Navigator.pop(context);
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}
