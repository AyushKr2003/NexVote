class ProposalModel {
  final String name;
  final String des;
  final String winner;
  final String totalVote;
  final String date;
  final bool isActive;

  ProposalModel({
    required this.des,
    required this.winner,
    required this.totalVote,
    required this.date,
    required this.isActive,
    required this.name,
  });
}

class Election {
  final String? id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String creator;
  final String creatorWallet;
  final int electionIndex;
  final List<Candidate> candidates; // List of Candidate objects
  final DateTime createdAt;
  final DateTime updatedAt;

  Election({
    this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.creator,
    required this.creatorWallet,
    required this.electionIndex,
    required this.candidates,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Election.fromJson(Map<String, dynamic> json) {
    return Election(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      creator: json['creator'],
      creatorWallet: json['creatorWallet'],
      electionIndex: json['electionIndex'],
      candidates: (json['candidates'] as List<dynamic>?)
          ?.map((candidate) => Candidate.fromJson(candidate))
          .toList() ?? [],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'creator': creator,
      'creatorWallet': creatorWallet,
      'electionIndex': electionIndex,
      'candidates': candidates.map((candidate) => candidate.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Candidate {
  final String? id;
  final String name;
  final String symbol;
  final int contractIndex;
  final String walletAddress;

  Candidate({
    this.id, // Initialize ID as optional
    required this.name,
    required this.symbol,
    required this.contractIndex,
    required this.walletAddress,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['_id'], // Parse _id from JSON
      name: json['name'],
      symbol: json['symbol'],
      contractIndex: json['contractIndex'],
      walletAddress: json['walletAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id, // Include _id only if it's not null
      'name': name,
      'symbol': symbol,
      'contractIndex': contractIndex,
      'walletAddress': walletAddress,
    };
  }
}
