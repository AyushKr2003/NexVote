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
