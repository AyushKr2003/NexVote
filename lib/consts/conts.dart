import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:nex_vote/model/proposal_model.dart';
import 'package:nex_vote/model/vote_model.dart';

class ThemeColors {
  final Color backgroundColor = const Color(0xff2B3138);
  final Color avatarBackgroundColor = const Color(0xff6A7886);
  final Color selectedIconBox = const Color(0xff2F4047);
  final Color selectedIconColor = const Color(0xff4AC6EA);
  final Color selectedTextColor = const Color(0xffF3F7F7);
  final Color unselectedIconColor = const Color(0xff6A7886);
  final Color unselectedTextColor = const Color(0xffC0C7D0);
  final Color badgeBackgroundColor = const Color(0xffFF6767);
  final Color badgeTextColor = const Color(0xffF3F7F7);
}

const String walletAdd = "1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa";

final List<VoteModel> voteHistory = [
  VoteModel(
    name: 'John Doe',
    des: 'Voted in favor of the new community park development.',
    date: '2024-09-01',
    isActive: true,
  ),
  VoteModel(
    name: 'Jane Smith',
    des: 'Supported the proposal for increasing school funding.',
    date: '2024-09-02',
    isActive: true,
  ),
  VoteModel(
    name: 'Emily Johnson',
    des: 'Cast vote for the renewable energy initiative.',
    date: '2024-09-03',
    isActive: false,
  ),
  VoteModel(
    name: 'Michael Brown',
    des: 'Participated in voting for the health and wellness program.',
    date: '2024-09-04',
    isActive: true,
  ),
  VoteModel(
    name: 'Olivia Davis',
    des: 'Voted on the library expansion project.',
    date: '2024-09-05',
    isActive: false,
  ),
];

final List<ProposalModel> proposalHistory = [
  ProposalModel(
    name: 'City Park Expansion',
    des: 'Proposal for expanding the current city park to include new recreational facilities.',
    winner: 'Green Team',
    totalVote: '1,234',
    date: '2024-09-01',
    isActive: true,
  ),
  ProposalModel(
    name: 'School Funding Initiative',
    des: 'Increase funding for local schools to enhance educational resources and facilities.',
    winner: 'Education Advocates',
    totalVote: '987',
    date: '2024-09-02',
    isActive: true,
  ),
  ProposalModel(
    name: 'Green Energy Proposal',
    des: 'Implementation of renewable energy sources to reduce carbon footprint and promote sustainability.',
    winner: 'Eco Warriors',
    totalVote: '1,678',
    date: '2024-09-03',
    isActive: false,
  ),
  ProposalModel(
    name: 'Health and Wellness Program',
    des: 'Community initiative to promote health and wellness through various programs and events.',
    winner: 'Health Heroes',
    totalVote: '654',
    date: '2024-09-04',
    isActive: true,
  ),
  ProposalModel(
    name: 'Library Expansion Plan',
    des: 'Expansion of the local library to include additional study areas and resources.',
    winner: 'Book Lovers',
    totalVote: '1,045',
    date: '2024-09-05',
    isActive: false,
  ),
];