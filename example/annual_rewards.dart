import 'package:dart_v4_rewards/dart_v4_rewards.dart';

void main() {
  // Example node configuration
  final nodeConfig = NodeConfig(
    gbMem: 32, // 32 GB Memory
    tbSsd: 2, // 2 TB SSD storage
    tbHdd: 10, // 10 TB HDD storage
    tbNetwork: 5, // 5 TB Network capacity
    uptimePercentage: 95.0, // 95% uptime
  );

  // Validate node configuration
  final validationResult = validateNodeConfig(nodeConfig);
  if (!validationResult.isValid) {
    print('Invalid node configuration: ${validationResult.message}');
    return;
  }

  // Calculate annual rewards
  final annualRewards = calculateAnnualIncaRewards(nodeConfig);

  // Calculate license fee
  final licenseFee = calculateNodeLicenseFee(nodeConfig);

  // Calculate income at different INCA price points
  const incaPrices = [0.1, 0.5, 1.0, 2.0, 5.0];

  // Print results
  print('INCA Rewards Calculator - Annual Rewards Calculation');
  print('---------------------------------------------------');
  print('Node Configuration:');
  print('  Memory: ${nodeConfig.gbMem} GB');
  print('  SSD Storage: ${nodeConfig.tbSsd} TB');
  print('  HDD Storage: ${nodeConfig.tbHdd} TB');
  print('  Network: ${nodeConfig.tbNetwork} TB');
  print('  Uptime: ${nodeConfig.uptimePercentage}%');
  print('\nLicense Fee: €$licenseFee');
  print('\nAnnual INCA Rewards:');
  print('  Memory: ${annualRewards.memIncaRewards.toStringAsFixed(2)} INCA');
  print('  SSD: ${annualRewards.ssdIncaRewards.toStringAsFixed(2)} INCA');
  print('  HDD: ${annualRewards.hddIncaRewards.toStringAsFixed(2)} INCA');
  print(
      '  Network: ${annualRewards.networkIncaRewards.toStringAsFixed(2)} INCA');
  print('  Total: ${annualRewards.totalIncaRewards.toStringAsFixed(2)} INCA');

  print('\nAnnual Income at Different INCA Prices:');
  print('---------------------------------------------------');
  print('| INCA Price (€) | Total Income (€) | Farmer Income (€) |');
  print('---------------------------------------------------');

  for (final price in incaPrices) {
    final income = calculateIncomePerNode(annualRewards.totalIncaRewards, price);
    print(
        '|  ${price.toStringAsFixed(2).padLeft(12)}€ | ${income.totalIncomeEur.toStringAsFixed(2).padLeft(15)}€ | ${income.farmerIncomeEur.toStringAsFixed(2).padLeft(16)}€ |');
  }

  print('---------------------------------------------------');
}
