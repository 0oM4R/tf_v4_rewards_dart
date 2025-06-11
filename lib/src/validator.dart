/// INCA Rewards Calculator - Input validation

import 'constants.dart';
import 'models.dart';

/// Validation result for node configuration validation
class ValidationResult {
  final bool isValid;
  final String message;

  const ValidationResult({
    required this.isValid,
    required this.message,
  });
}

/// Validates uptime percentage against minimum requirements for rewards
/// 
/// @param uptimePercentage The node's uptime percentage
/// 
/// @returns Validation result with error messages if invalid
ValidationResult validateUptimePercentage(double uptimePercentage) {
  if (uptimePercentage < MIN_UPTIME_PERCENTAGE) {
    return ValidationResult(
      isValid: false,
      message: 'The node must have an uptime of at least $MIN_UPTIME_PERCENTAGE% to receive rewards (provided: $uptimePercentage%)',
    );
  }
  
  if (uptimePercentage > 100) {
    return ValidationResult(
      isValid: false,
      message: 'Uptime percentage cannot exceed 100% (provided: $uptimePercentage%)',
    );
  }
  
  return const ValidationResult(isValid: true, message: '');
}

/// Validates a node configuration against minimum requirements
/// 
/// @param nodeConfig Node configuration to validate
/// 
/// @returns Validation result with error messages if invalid
ValidationResult validateNodeConfig(NodeConfig nodeConfig) {
  final gbMem = nodeConfig.gbMem;
  final tbSsd = nodeConfig.tbSsd;
  final tbHdd = nodeConfig.tbHdd;
  final cpuPassmark = nodeConfig.cpuPassmark;

  // Check minimum memory requirement
  if (gbMem < MinRequirements.GB_MEM) {
    return ValidationResult(
      isValid: false,
      message: 'Memory must be at least ${MinRequirements.GB_MEM} GB (provided: $gbMem GB)',
    );
  }

  // Check minimum SSD requirement
  if (tbSsd < MinRequirements.TB_SSD_COUNT) {
    return ValidationResult(
      isValid: false,
      message: 'SSD storage must be at least ${MinRequirements.TB_SSD_COUNT} TB (provided: $tbSsd TB)',
    );
  }

  // Check CPU passmark requirement if provided
  if (cpuPassmark != null) {
    final minRequiredPassmark = gbMem * MinRequirements.CPU_PASSMARK_PER_GB_MEM;
    if (cpuPassmark < minRequiredPassmark) {
      return ValidationResult(
        isValid: false,
        message: 'CPU passmark must be at least $minRequiredPassmark for $gbMem GB memory ' +
                 '(${MinRequirements.CPU_PASSMARK_PER_GB_MEM} per GB) - provided: $cpuPassmark',
      );
    }
  }

  // Check for negative values
  if (gbMem <= 0) {
    return const ValidationResult(
      isValid: false,
      message: 'Memory (gbMem) must be positive',
    );
  }

  if (tbSsd <= 0) {
    return const ValidationResult(
      isValid: false,
      message: 'SSD storage (tbSsd) must be positive',
    );
  }

  if (tbHdd < 0) {
    return const ValidationResult(
      isValid: false,
      message: 'HDD storage (tbHdd) cannot be negative',
    );
  }

  if (nodeConfig.tbNetwork < 0) {
    return const ValidationResult(
      isValid: false,
      message: 'Network capacity (tbNetwork) cannot be negative',
    );
  }

  return const ValidationResult(isValid: true, message: '');
}
