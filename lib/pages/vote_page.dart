import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nex_vote/consts/conts.dart';

class VotePage extends StatefulWidget {
  const VotePage({super.key});

  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
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
    double childAspectRatio = (screenWidth / crossAxisCount) / 180; // Adjust height here

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColorsHome.backgroundColor,
        title: Text(
          'Vote History',
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
                'Search Votes',
                style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Search by Name',
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
                  itemCount: voteHistory
                      .where((vote) => vote.name.toLowerCase().contains(searchQuery.toLowerCase()))
                      .length,
                  itemBuilder: (context, index) {
                    final filteredVotes = voteHistory
                        .where((vote) => vote.name.toLowerCase().contains(searchQuery.toLowerCase()))
                        .toList();
                    final vote = filteredVotes[index];

                    return Card(
                      margin: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 3,
                      color: vote.isActive ? ThemeColorsHome.primaryColor1 : ThemeColorsHome.primaryColor2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vote.name,
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              vote.des,
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Date: ${vote.date}',
                              style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
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
    );
  }
}
