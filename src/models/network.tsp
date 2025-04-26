import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

using Http;
using OpenAPI;

model NetworkTypeDTO {
  /**
   * The name of the network.
   */
  name: string;

  /**
   * A short text describing the network.
   */
  description: string;
}

model RentalFeesDTO {
  /**
   * Absolute amount. An amount of 123456789 (absolute) for a mosaic with divisibility 6 means 123.456789 (relative).
   */
  effectiveRootNamespaceRentalFeePerBlock: string;

  /**
   * Absolute amount. An amount of 123456789 (absolute) for a mosaic with divisibility 6 means 123.456789 (relative).
   */
  effectiveChildNamespaceRentalFee: string;

  /**
   * Absolute amount. An amount of 123456789 (absolute) for a mosaic with divisibility 6 means 123.456789 (relative).
   */
  effectiveMosaicRentalFee: string;
}

model NetworkConfigurationDTO {
  network: NetworkPropertiesDTO;
  chain: ChainPropertiesDTO;
  plugins: PluginsPropertiesDTO;
}

model NetworkPropertiesDTO {
  identifier: string;
  nodeEqualityStrategy: string;
  nemesisSignerPublicKey: string;
  generationHashSeed: string;
  epochAdjustment: string;
}

model ChainPropertiesDTO {
  enableVerifiableState: boolean;
  enableVerifiableReceipts: boolean;
  currencyMosaicId: string;
  harvestingMosaicId: string;
  blockGenerationTargetTime: string;
  blockTimeSmoothingFactor: string;
  blockFinalizationInterval: string;
  importanceGrouping: string;
  importanceActivityPercentage: string;
  maxRollbackBlocks: string;
  maxDifficultyBlocks: string;
  defaultDynamicFeeMultiplier: string;
  maxTransactionLifetime: string;
  maxBlockFutureTime: string;
  initialCurrencyAtomicUnits: string;
  maxMosaicAtomicUnits: string;
  totalChainImportance: string;
  minHarvesterBalance: string;
  maxHarvesterBalance: string;
  minVoterBalance: string;
  maxVotingKeysPerAccount: string;
  minVotingKeyLifetime: string;
  maxVotingKeyLifetime: string;
  harvestBeneficiaryPercentage: string;
  harvestNetworkPercentage: string;
  harvestNetworkFeeSinkAddress: string;
  blockPruneInterval: string;
  maxTransactionsPerBlock: string;
}

model PluginsPropertiesDTO {
  accountlink: AccountLinkNetworkPropertiesDTO;
  aggregate: AggregateNetworkPropertiesDTO;
  lockhash: HashLockNetworkPropertiesDTO;
  locksecret: SecretLockNetworkPropertiesDTO;
  metadata: MetadataNetworkPropertiesDTO;
  mosaic: MosaicNetworkPropertiesDTO;
  multisig: MultisigNetworkPropertiesDTO;
  namespaceConfig: NamespaceNetworkPropertiesDTO;
  restrictionaccount: AccountRestrictionNetworkPropertiesDTO;
  restrictionmosaic: MosaicRestrictionNetworkPropertiesDTO;
  transfer: TransferNetworkPropertiesDTO;
}

model AccountLinkNetworkPropertiesDTO {
  dummy?: string;
}

model AggregateNetworkPropertiesDTO {
  maxTransactionsPerAggregate: string;
  maxCosignaturesPerAggregate: string;
  enableStrictCosignatureCheck: boolean;
  enableBondedAggregateSupport: boolean;
  maxBondedTransactionLifetime: string;
}

model HashLockNetworkPropertiesDTO {
  lockedFundsPerAggregate: string;
  maxHashLockDuration: string;
}

model SecretLockNetworkPropertiesDTO {
  maxSecretLockDuration: string;
  minProofSize: string;
  maxProofSize: string;
}

model MetadataNetworkPropertiesDTO {
  maxValueSize: string;
}

model MosaicNetworkPropertiesDTO {
  maxMosaicsPerAccount: string;
  maxMosaicDuration: string;
  maxMosaicDivisibility: string;
  mosaicRentalFeeSinkAddress: string;
  mosaicRentalFee: string;
}

model MultisigNetworkPropertiesDTO {
  maxMultisigDepth: string;
  maxCosignatoriesPerAccount: string;
  maxCosignedAccountsPerAccount: string;
}

model NamespaceNetworkPropertiesDTO {
  maxNameSize: string;
  maxChildNamespaces: string;
  maxNamespaceDepth: string;
  minNamespaceDuration: string;
  maxNamespaceDuration: string;
  namespaceGracePeriodDuration: string;
  reservedRootNamespaceNames: string;
  namespaceRentalFeeSinkAddress: string;
  rootNamespaceRentalFeePerBlock: string;
  childNamespaceRentalFee: string;
}

model AccountRestrictionNetworkPropertiesDTO {
  maxAccountRestrictionValues: string;
}

model MosaicRestrictionNetworkPropertiesDTO {
  maxMosaicRestrictionValues: string;
}

model TransferNetworkPropertiesDTO {
  maxMessageSize: string;
}

model TransactionFeesDTO {
  /**
   * Fee multiplier applied to transactions contained in block.
   */
  averageFeeMultiplier: integer;

  /**
   * Fee multiplier applied to transactions contained in block.
   */
  medianFeeMultiplier: integer;

  /**
   * Fee multiplier applied to transactions contained in block.
   */
  highestFeeMultiplier: integer;

  /**
   * Fee multiplier applied to transactions contained in block.
   */
  lowestFeeMultiplier: integer;

  /**
   * Minimum fee multiplier on the network for transaction to be valid.
   */
  minFeeMultiplier?: integer;
}
