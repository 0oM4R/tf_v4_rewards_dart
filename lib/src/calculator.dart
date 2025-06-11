/// INCA Rewards Calculator - Core calculation functions

import 'models.dart';
import 'constants.dart';
import 'validator.dart';

/// Calculator class that handles all reward calculations
/// 
/// This class accepts constants in the constructor and has methods
/// 
/// that take NodeConfig as a parameter
class Calculator {
  // Reward constants
  final double memRewardPerGbMonth;
  final double ssdRewardPerTbMonth;
  final double hddRewardPerTbMonth;
  final double networkRewardPerTbMonth;
  
  // License fee constants
  final double licenseFeeSetup;
  final double licenseFeePerTbSsd;
  final double licenseFeePerTbHdd;
  final double licenseFeePerGbMem;
  
  // Income share constants
  final double farmerIncomeShare;
  final double farmingPoolIncomeShare;
  final double threefoldIncomeShare;
  
  /// Constructor that accepts all constants used in calculations
  Calculator({
    // Reward constants
    this.memRewardPerGbMonth = CertifiedRewards.MEM_PER_GB_MONTH,
    this.ssdRewardPerTbMonth = CertifiedRewards.SSD_PER_TB_MONTH, 
    this.hddRewardPerTbMonth = CertifiedRewards.HDD_PER_TB_MONTH,
    this.networkRewardPerTbMonth = CertifiedRewards.NETWORK_PER_TB_MONTH,
    
    // License fee constants
    this.licenseFeeSetup = LicenseFees.SETUP,
    this.licenseFeePerTbSsd = LicenseFees.SSD_PER_TB,
    this.licenseFeePerTbHdd = LicenseFees.HDD_PER_TB,
    this.licenseFeePerGbMem = LicenseFees.MEM_PER_GB,
    
    // Income share constants
    this.farmerIncomeShare = IncomeShares.FARMER,
    this.farmingPoolIncomeShare = IncomeShares.FARMING_POOL,
    this.threefoldIncomeShare = IncomeShares.THREEFOLD,
  });
  
  /// Calculate annual INCA rewards for a single node based on its configuration
  /// 
  /// @param nodeConfig The node configuration parameters
  /// 
  /// @returns The annual INCA rewards breakdown by resource type
  IncaRewards calculateAnnualIncaRewards(NodeConfig nodeConfig) {
    // Validate uptime percentage
    final uptimeValidation = validateUptimePercentage(nodeConfig.uptimePercentage);
    if (!uptimeValidation.isValid) {
      print('Warning: ${uptimeValidation.message}');
      return IncaRewards.zero();
    }
    
    // Calculate annual INCA rewards by resource type
    final memIncaRewards = nodeConfig.gbMem * memRewardPerGbMonth * 12 * nodeConfig.uptimePercentage / 100;
    final ssdIncaRewards = nodeConfig.tbSsd * ssdRewardPerTbMonth * 12 * nodeConfig.uptimePercentage / 100;
    final hddIncaRewards = nodeConfig.tbHdd * hddRewardPerTbMonth * 12 * nodeConfig.uptimePercentage / 100;
    final networkIncaRewards = nodeConfig.tbNetwork * networkRewardPerTbMonth * 12 * nodeConfig.uptimePercentage / 100;
    
    // Calculate total annual INCA rewards
    final totalIncaRewards = 
      memIncaRewards +
      ssdIncaRewards +
      hddIncaRewards +
      networkIncaRewards;
    
    return IncaRewards(
      memIncaRewards: memIncaRewards,
      ssdIncaRewards: ssdIncaRewards,
      hddIncaRewards: hddIncaRewards,
      networkIncaRewards: networkIncaRewards,
      totalIncaRewards: totalIncaRewards,
    );
  }
  
  /// Calculate monthly INCA rewards for a single node based on its configuration
  /// 
  /// @param nodeConfig The node configuration parameters
  /// 
  /// @returns The monthly INCA rewards breakdown by resource type
  IncaRewards calculateMonthlyIncaRewards(NodeConfig nodeConfig) {
    // Validate uptime percentage
    final uptimeValidation = validateUptimePercentage(nodeConfig.uptimePercentage);
    if (!uptimeValidation.isValid) {
      print('Warning: ${uptimeValidation.message}');
      return IncaRewards.zero();
    }
    
    // Calculate monthly INCA rewards by resource type
    final memIncaRewards = nodeConfig.gbMem * memRewardPerGbMonth * nodeConfig.uptimePercentage / 100;
    final ssdIncaRewards = nodeConfig.tbSsd * ssdRewardPerTbMonth * nodeConfig.uptimePercentage / 100;
    final hddIncaRewards = nodeConfig.tbHdd * hddRewardPerTbMonth * nodeConfig.uptimePercentage / 100;
    final networkIncaRewards = nodeConfig.tbNetwork * networkRewardPerTbMonth * nodeConfig.uptimePercentage / 100;
    
    // Calculate total monthly INCA rewards
    final totalIncaRewards = 
      memIncaRewards +
      ssdIncaRewards +
      hddIncaRewards +
      networkIncaRewards;
    
    return IncaRewards(
      memIncaRewards: memIncaRewards,
      ssdIncaRewards: ssdIncaRewards,
      hddIncaRewards: hddIncaRewards,
      networkIncaRewards: networkIncaRewards,
      totalIncaRewards: totalIncaRewards,
    );
  }
  
  /// Calculate the license fee for a node
  /// 
  /// @param nodeConfig Node configuration
  /// @returns The total license fee in EUR
  double calculateNodeLicenseFee(NodeConfig nodeConfig) {
    return licenseFeeSetup + 
           nodeConfig.tbSsd * licenseFeePerTbSsd + 
           nodeConfig.tbHdd * licenseFeePerTbHdd + 
           nodeConfig.gbMem * licenseFeePerGbMem;
  }
  
  /// Calculate income distribution for a node at a specific INCA price
  /// 
  /// @param totalIncaRewardsAnnual Total annual INCA rewards
  /// 
  /// @param incaPriceEur INCA price in EUR
  /// 
  /// @returns Income distribution breakdown in EUR
  IncomeDistribution calculateIncomePerNode(
    double totalIncaRewardsAnnual, 
    double incaPriceEur
  ) {
    // Calculate total annual income in EUR
    final totalIncomeEurAnnual = totalIncaRewardsAnnual * incaPriceEur;
    
    // Calculate income distribution based on shares
    final farmerIncomeEurAnnual = totalIncomeEurAnnual * farmerIncomeShare;
    final farmingPoolIncomeEurAnnual = totalIncomeEurAnnual * farmingPoolIncomeShare;
    final threefoldIncomeEurAnnual = totalIncomeEurAnnual * threefoldIncomeShare;
    
    return IncomeDistribution(
      incaPriceEur: incaPriceEur,
      totalIncomeEur: totalIncomeEurAnnual,
      farmerIncomeEur: farmerIncomeEurAnnual,
      farmingPoolIncomeEur: farmingPoolIncomeEurAnnual,
      threefoldIncomeEur: threefoldIncomeEurAnnual,
    );
  }
}

/// For backward compatibility, these functions create a default calculator and delegate to it
/// Calculate annual INCA rewards for a single node based on its configuration
/// 
/// @param nodeConfig The node configuration parameters
/// 
/// @returns The annual INCA rewards breakdown by resource type
IncaRewards calculateAnnualIncaRewards(NodeConfig nodeConfig) {
  final calculator = Calculator();
  return calculator.calculateAnnualIncaRewards(nodeConfig);
}

/// Calculate monthly INCA rewards for a single node based on its configuration
/// 
/// @param nodeConfig The node configuration parameters
/// 
/// @returns The monthly INCA rewards breakdown by resource type
IncaRewards calculateMonthlyIncaRewards(NodeConfig nodeConfig) {
  final calculator = Calculator();
  return calculator.calculateMonthlyIncaRewards(nodeConfig);
}

/// Calculate the license fee for a node
/// 
/// @param nodeConfig Node configuration
/// 
/// @returns The total license fee in EUR
double calculateNodeLicenseFee(NodeConfig nodeConfig) {
  final calculator = Calculator();
  return calculator.calculateNodeLicenseFee(nodeConfig);
}

/// Calculate income distribution for a node at a specific INCA price
/// 
/// @param totalIncaRewardsAnnual Total annual INCA rewards
/// 
/// @param incaPriceEur INCA price in EUR
/// 
/// @returns Income distribution breakdown in EUR
IncomeDistribution calculateIncomePerNode(
  double totalIncaRewardsAnnual, 
  double incaPriceEur
) {
  final calculator = Calculator();
  return calculator.calculateIncomePerNode(totalIncaRewardsAnnual, incaPriceEur);
}
