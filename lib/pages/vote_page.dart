import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nex_vote/consts/conts.dart';
import 'package:nex_vote/metamask_provider.dart';
import 'package:nex_vote/model/proposal_model.dart';
import 'package:nex_vote/model/vote_model.dart';
import 'package:nex_vote/provider/api.dart';
import 'package:provider/provider.dart';

class VotePage extends StatefulWidget {
  const VotePage({super.key});

  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  String searchQuery = '';
  List<Election> elections = [];
  List<ElectionVote> vote_history = [];
  bool isLoading = true;

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
      // Fetch elections and user's voting history
      elections = await ApiService().fetchElections(token);
      List<ElectionVote> vote_history = await ApiService().fetchUserVotes(token);

      // Extract the election IDs from the vote_history
      List<String> votedElectionIds = vote_history.map((vote) => vote.electionId).toList();

      // Filter out elections that the user has already voted in
      setState(() {
        elections = elections.where((election) => !votedElectionIds.contains(election.id)).toList();
      });


    } catch (e) {
      print('Failed to fetch elections: $e');
    } finally {
      setState(() {
        isLoading = false; // Stop loading when done
      });
    }
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
          content: Container(
            width: 500,
            height: 300,
            child: SingleChildScrollView(
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
                  // Display candidates and vote buttons
                  if (election.candidates.isNotEmpty) ...[
                    Text(
                      'Candidates:',
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: election.candidates.length,
                      itemBuilder: (context, index) {
                        final candidate = election.candidates[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${candidate.name} (${candidate.symbol})',
                                style: GoogleFonts.openSans(fontSize: 16),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _castVote(candidate.id, election.id);
                                },
                                child: Text('Vote'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ] else ...[
                    Text(
                      'No candidates available for this election.',
                      style: GoogleFonts.openSans(fontSize: 16),
                    ),
                  ],
                ],
              ),
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

  void _castVote(String? candidateId, String? electionId) async{
    // Implement your vote casting logic here
    if (candidateId != null && electionId != null) {
      // Example API call to cast the vote

      String token = Provider.of<MetaMaskProvider>(context, listen: false).authResponse!.token;
      String transactionHash = '0x354yhgf3456uikjhgfr4567yt';
      await ApiService().castVote(electionId, candidateId, transactionHash, token);
      print('Casting vote for candidate: $candidateId in election: $electionId');
      Fluttertoast.showToast(msg: 'Vote Successfully', timeInSecForIosWeb: 3);
      await fetchElections();
      Navigator.pop(context);
      // Perform the API call, and handle the response as needed
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
    double childAspectRatio =
        (screenWidth / crossAxisCount) / 180; // Adjust height here

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColorsHome.backgroundColor,
        title: Text(
          'Votes',
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
                child: isLoading
                    ? Center(child: CircularProgressIndicator()) // Show loading indicator
                    : GridView.builder(
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
                      onTap: () {
                        _showElectionDetailsDialog(context, election);
                      },
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 3,
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
                                election.description,
                                style: GoogleFonts.openSans(
                                  fontSize: 14,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Start Date: ${election.startDate}',
                                style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                'End Date: ${election.endDate}',
                                style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[600],
                                ),
                              ),
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
    );
  }
}
