/// INCA Rewards Calculator - Data Models

/// Node configuration parameters
class NodeConfig {
  final double gbMem; // Gigabytes of Memory
  final double tbSsd; // Terabytes of SSD storage
  final double tbHdd; // Terabytes of HDD storage
  final double tbNetwork; // Terabytes of Network capacity
  final double uptimePercentage; // Uptime percentage
  final double? cpuPassmark; // Optional CPU passmark score

  const NodeConfig({
    required this.gbMem,
    required this.tbSsd,
    required this.tbHdd,
    required this.tbNetwork,
    required this.uptimePercentage,
    this.cpuPassmark,
  });
}

/// INCA rewards breakdown by resource type
class IncaRewards {
  final double memIncaRewards;
  final double ssdIncaRewards;
  final double hddIncaRewards;
  final double networkIncaRewards;
  final double totalIncaRewards;

  const IncaRewards({
    required this.memIncaRewards,
    required this.ssdIncaRewards,
    required this.hddIncaRewards,
    required this.networkIncaRewards,
    required this.totalIncaRewards,
  });

  /// Creates an IncaRewards object with all values set to zero
  factory IncaRewards.zero() {
    return const IncaRewards(
      memIncaRewards: 0,
      ssdIncaRewards: 0,
      hddIncaRewards: 0,
      networkIncaRewards: 0,
      totalIncaRewards: 0,
    );
  }
}

/// Income distribution for a node at a specific INCA price
class IncomeDistribution {
  final double incaPriceEur;
  final double totalIncomeEur;
  final double farmerIncomeEur;
  final double farmingPoolIncomeEur;
  final double threefoldIncomeEur;

  const IncomeDistribution({
    required this.incaPriceEur,
    required this.totalIncomeEur,
    required this.farmerIncomeEur,
    required this.farmingPoolIncomeEur,
    required this.threefoldIncomeEur,
  });
}
