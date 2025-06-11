/// INCA Rewards Calculator - Constants

/// Core constants as defined in the requirements
class LicenseFees {
  static const double SETUP = 3.0; // EUR
  static const double SSD_PER_TB = 10.0; // EUR
  static const double HDD_PER_TB = 4.0; // EUR
  static const double MEM_PER_GB = 3.0; // EUR
}

/// Reward constants
class CertifiedRewards {
  static const double MEM_PER_GB_MONTH = 8.0; // INCA
  static const double SSD_PER_TB_MONTH = 31.5; // INCA
  static const double HDD_PER_TB_MONTH = 7.0; // INCA
  static const double NETWORK_PER_TB_MONTH = 30.0; // INCA
}

/// Minimum required uptime percentage for rewards
const double MIN_UPTIME_PERCENTAGE = 90.0;

/// Minimum requirements
class MinRequirements {
  static const double CPU_PASSMARK_PER_GB_MEM = 200.0;
  static const double GB_MEM = 16.0;
  static const double TB_SSD_COUNT = 2.0; // 2x 1TB SSDs minimum
}

/// Income shares
class IncomeShares {
  static const double FARMER = 0.60; // 60%
  static const double FARMING_POOL = 0.20; // 20%
  static const double THREEFOLD = 0.20; // 20%
}

/// Time periods
const int GUARANTEED_REWARD_MONTHS = 18;
const int INCA_LOCKUP_MONTHS = 24;
