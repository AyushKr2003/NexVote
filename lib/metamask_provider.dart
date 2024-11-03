import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web3/ethereum.dart';
import 'package:flutter_web3/flutter_web3.dart' as flutter_web3;
import 'package:nex_vote/model/auth_model.dart';
import 'package:web3dart/web3dart.dart' as web3dart;
import 'package:http/http.dart';

class MetaMaskProvider extends ChangeNotifier {
  String currentAddress = '';
  String account = '';
  int? currentChain;
  Client httpClient = Client();
  late web3dart.Web3Client ethClient;

  // Replace with your smart contract address
  final String contractAddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3';
  // Replace with your private key
  final String privateKey = 'ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80';

  late web3dart.DeployedContract contract;

  bool get isEnabled => flutter_web3.ethereum != null;
  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  // Fields for authentication response
  AuthResponse? authResponse;

  MetaMaskProvider() {
    String url = 'http://127.0.0.1:8545/';
    ethClient = web3dart.Web3Client(url, httpClient);
    print('Web3Client initialized with URL: $url');

    loadContract();
  }

  Future<void> loadContract() async {
    try {
      final String abiString = await rootBundle.loadString('assets/abi.json');
      // print('ABI loaded successfully: $abiString');

      // Initialize the contract
      contract = web3dart.DeployedContract(
        web3dart.ContractAbi.fromJson(abiString, 'SimpleVotingSystem'),
        web3dart.EthereumAddress.fromHex(contractAddress),
      );
      print('Contract initialized with address: $contractAddress');

    } catch (e) {
      print('Error loading contract: $e');
    }
  }

  Future<void> connect(Function onSuccess) async {
    if (isEnabled) {
      try {
        final List<String> accs = await flutter_web3.ethereum!.requestAccount();
        print('Accounts retrieved: $accs');

        if (accs.isNotEmpty) {
          account = accs.first;
          currentAddress = account;
          currentChain = await flutter_web3.ethereum!.getChainId();
          print('Connected to account: $account on chain ID: $currentChain');

          await loadContract();
          notifyListeners();
          onSuccess();
        }
      } catch (e) {
        print('Error connecting to MetaMask: $e');
      }
    } else {
      print('MetaMask is not enabled');
    }
  }

  Future<void> callContractFunction(String functionName, List<dynamic> params) async {
    if (!isConnected) {
      print('Not connected to MetaMask');
      return;
    }

    try {
      final contractFunction = contract.function(functionName);
      print('Calling contract function: $functionName with params: $params');

      final result = await ethClient.call(
        contract: contract,
        function: contractFunction,
        params: params,
      );

      print('Contract function result: $result');
    } catch (e) {
      print('Error calling contract function: $e');
    }
  }

  Future<int> getElectionCount() async {
    if (!isConnected) {
      throw Exception('Not connected to MetaMask');
    }

    try {
      final result = await ethClient.call(
        contract: contract,
        function: contract.function('electionCount'),
        params: [],
      );

      print('Raw result from candidateCount: $result');

      if (result is List && result.isNotEmpty) {
        BigInt candidateCountBigInt = result[0] as BigInt;
        return candidateCountBigInt.toInt();
      } else {
        throw Exception('Unexpected result format: $result');
      }
    } catch (e) {
      print('Error fetching candidate count: $e');
      throw e;
    }
  }


  Future<String> callFunction(String funcname, List<dynamic> args, web3dart.Web3Client ethClient, String privateKey) async {
    web3dart.EthPrivateKey credentials = web3dart.EthPrivateKey.fromHex(privateKey);

    final ethFunction = contract.function(funcname);
    final result = await ethClient.sendTransaction(
        credentials,
        web3dart.Transaction.callContract(
          contract: contract,
          function: ethFunction,
          parameters: args,
        ),
        chainId: null,
        fetchChainIdFromNetworkId: true);
    return result;
  }

  Future<String> createElection(String name) async {
    var response =
    await callFunction('createElection', [name], ethClient, privateKey);
    print('Election started successfully');
    return response;
  }
}
