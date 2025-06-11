# Dart V4 Rewards Calculator

A Dart implementation of the INCA Rewards Calculator for calculating rewards and income distribution for nodes.

## Overview

This library provides functionality for calculating INCA rewards based on node configurations, including:

- Annual and monthly INCA rewards calculation
- Node license fee calculation
- Income distribution calculation
- Node configuration validation

## Usage

```dart
import 'package:tf_v4_rewards_dart/dart_v4_rewards.dart';

void main() {
  // Create a node configuration
  final nodeConfig = NodeConfig(
    gbMem: 32,     // 32 GB Memory
    tbSsd: 2,      // 2 TB SSD storage
    tbHdd: 10,     // 10 TB HDD storage
    tbNetwork: 5,  // 5 TB Network capacity
    cpuPassmark: 10000, // CPU passmark score
  );

  // Validate the node configuration
  final validationResult = validateNodeConfig(nodeConfig);
  if (!validationResult.isValid) {
    print('Invalid configuration: ${validationResult.message}');
    return;
  }

  // Calculate annual rewards with 95% uptime
  final rewards = calculateAnnualIncaRewards(nodeConfig, 95.0);
  
  // Calculate license fee
  final licenseFee = calculateNodeLicenseFee(nodeConfig);
  
  // Calculate income at INCA price of 1 EUR
  final income = calculateIncomePerNode(rewards.totalIncaRewards, 1.0);
  
  // Print the results
  print('Total Annual INCA Rewards: ${rewards.totalIncaRewards}');
  print('License Fee: €$licenseFee');
  print('Farmer Annual Income: €${income.farmerIncomeEur}');
}
```

## Core Constants

The library uses the following core constants:

- `CertifiedRewards`: Reward rates for memory, SSD, HDD and network
- `LicenseFees`: License fees for setup, SSD, HDD and memory
- `IncomeShares`: Distribution percentages for farmer, farming pool and ThreeFold
- `MinRequirements`: Minimum requirements for node configurations

## Running Tests

To run the tests:

```bash
dart test
```

## Example

Check out the `example/annual_rewards.dart` file for a complete usage example.
