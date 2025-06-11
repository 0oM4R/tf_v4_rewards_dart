import 'package:tf_v4_rewards_dart/dart_v4_rewards.dart';
import 'package:test/test.dart';

void main() {
  group('Calculator Tests', () {
    final testNode = NodeConfig(
      gbMem: 32,
      tbSsd: 2,
      tbHdd: 10,
      tbNetwork: 5,
      cpuPassmark: 10000,
      uptimePercentage: 95.0,
    );
    
    test('calculateAnnualIncaRewards returns correct values', () {
      final rewards = calculateAnnualIncaRewards(testNode);
      
      // Expected values with 95% uptime
      final expectedMemRewards = 32 * CertifiedRewards.MEM_PER_GB_MONTH * 12 * 0.95;
      final expectedSsdRewards = 2 * CertifiedRewards.SSD_PER_TB_MONTH * 12 * 0.95;
      final expectedHddRewards = 10 * CertifiedRewards.HDD_PER_TB_MONTH * 12 * 0.95;
      final expectedNetworkRewards = 5 * CertifiedRewards.NETWORK_PER_TB_MONTH * 12 * 0.95;
      final expectedTotalRewards = expectedMemRewards + expectedSsdRewards + 
                               expectedHddRewards + expectedNetworkRewards;
      
      expect(rewards.memIncaRewards, closeTo(expectedMemRewards, 0.001));
      expect(rewards.ssdIncaRewards, closeTo(expectedSsdRewards, 0.001));
      expect(rewards.hddIncaRewards, closeTo(expectedHddRewards, 0.001));
      expect(rewards.networkIncaRewards, closeTo(expectedNetworkRewards, 0.001));
      expect(rewards.totalIncaRewards, closeTo(expectedTotalRewards, 0.001));
    });
    
    test('calculateMonthlyIncaRewards returns correct values', () {
      final rewards = calculateMonthlyIncaRewards(testNode);
      
      // Expected values with 95% uptime
      final expectedMemRewards = 32 * CertifiedRewards.MEM_PER_GB_MONTH * 0.95;
      final expectedSsdRewards = 2 * CertifiedRewards.SSD_PER_TB_MONTH * 0.95;
      final expectedHddRewards = 10 * CertifiedRewards.HDD_PER_TB_MONTH * 0.95;
      final expectedNetworkRewards = 5 * CertifiedRewards.NETWORK_PER_TB_MONTH * 0.95;
      final expectedTotalRewards = expectedMemRewards + expectedSsdRewards + 
                               expectedHddRewards + expectedNetworkRewards;
      
      expect(rewards.memIncaRewards, closeTo(expectedMemRewards, 0.001));
      expect(rewards.ssdIncaRewards, closeTo(expectedSsdRewards, 0.001));
      expect(rewards.hddIncaRewards, closeTo(expectedHddRewards, 0.001));
      expect(rewards.networkIncaRewards, closeTo(expectedNetworkRewards, 0.001));
      expect(rewards.totalIncaRewards, closeTo(expectedTotalRewards, 0.001));
    });
    
    test('calculateNodeLicenseFee returns correct value', () {
      final licenseFee = calculateNodeLicenseFee(testNode);
      
      final expectedFee = LicenseFees.SETUP + 
                      testNode.gbMem * LicenseFees.MEM_PER_GB +
                      testNode.tbSsd * LicenseFees.SSD_PER_TB +
                      testNode.tbHdd * LicenseFees.HDD_PER_TB;
                      
      expect(licenseFee, equals(expectedFee));
    });
    
    test('calculateIncomePerNode returns correct values', () {
      const totalRewards = 1000.0;
      const incaPrice = 2.0;
      
      final income = calculateIncomePerNode(totalRewards, incaPrice);
      
      final expectedTotal = totalRewards * incaPrice;
      final expectedFarmer = expectedTotal * IncomeShares.FARMER;
      final expectedPool = expectedTotal * IncomeShares.FARMING_POOL;
      final expectedThreefold = expectedTotal * IncomeShares.THREEFOLD;
      
      expect(income.totalIncomeEur, equals(expectedTotal));
      expect(income.farmerIncomeEur, equals(expectedFarmer));
      expect(income.farmingPoolIncomeEur, equals(expectedPool));
      expect(income.threefoldIncomeEur, equals(expectedThreefold));
    });
  });
  
  group('Validator Tests', () {
    test('validateUptimePercentage validates correctly', () {
      expect(validateUptimePercentage(95).isValid, isTrue);
      expect(validateUptimePercentage(100).isValid, isTrue);
      expect(validateUptimePercentage(MIN_UPTIME_PERCENTAGE).isValid, isTrue);
      
      expect(validateUptimePercentage(85).isValid, isFalse);
      expect(validateUptimePercentage(101).isValid, isFalse);
    });
    
    test('validateNodeConfig validates memory requirements', () {
      final validNode = NodeConfig(
        gbMem: MinRequirements.GB_MEM,
        tbSsd: MinRequirements.TB_SSD_COUNT,
        tbHdd: 0,
        tbNetwork: 0,
        uptimePercentage: 95.0,
      );
      
      final invalidMemNode = NodeConfig(
        gbMem: MinRequirements.GB_MEM - 1,
        tbSsd: MinRequirements.TB_SSD_COUNT,
        tbHdd: 0,
        tbNetwork: 0,
        uptimePercentage: 95.0,
      );
      
      expect(validateNodeConfig(validNode).isValid, isTrue);
      expect(validateNodeConfig(invalidMemNode).isValid, isFalse);
    });
  });
}
