import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";
import "../types/basic.tsp";
import "../types/blockchain.tsp";
import "../types/crypto.tsp";
import "./mosaic.tsp";

using Http;
using OpenAPI;

/**
 * * 0 - Unlinked.
 * * 1 - Balance-holding account that is linked to a remote harvester account.
 * * 2 - Remote harvester account that is linked to a balance-holding account.
 * * 3 - Remote harvester eligible account that is unlinked.
 */
union AccountTypeEnum {
  0,
  1,
  2,
  3,
}

/**
 * Type of account key:
 * * 0 - Unset.
 * * 1 - Linked account public key.
 * * 2 - Node public key on which remote is allowed to harvest.
 * * 4 - VRF public key.
 */
union AccountKeyTypeFlagsEnum {
  0,
  1,
  2,
  4,
}

enum AccountOrderByEnum {
  id,
  balance,
}

model AccountDTO {
  version: StateVersion;
  address: Address;
  addressHeight: Height;
  publicKey: PublicKey;
  publicKeyHeight: Height;
  accountType: AccountTypeEnum;
  supplementalPublicKeys: SupplementalPublicKeysDTO;
  activityBuckets: ActivityBucketDTO[];

  /**
   * Mosaic units owned.
   */
  mosaics: Mosaic[];

  importance: Importance;
  importanceHeight: Height;
}

model AccountInfoDTO {
  /**
   * Internal resource identifier.
   */
  id: string;
  account: AccountDTO;
}

model AccountPage {
  /**
   * Array of accounts.
   */
  data: AccountInfoDTO[];
  pagination: Pagination;
}

/**
 * Supplementary data stored for importance recalculation.
 * At each importance recalculation, existing buckets are shifted, the working bucket is finalized and a new working bucket is created.
 * Each bucket influences at most five importance recalculations.
 */
model ActivityBucketDTO {
  startHeight: Height;

  /**
   * Fees paid by the account for this bucket.
   */
  totalFeesPaid: Amount;

  /**
   * Number of times the account has been a beneficiary for this bucket.
   */
  beneficiaryCount: UInt32;

  /**
   * Importance score for this bucket. This is taken into account to calculate the latest account importance.
   */
  rawScore: Importance;
}

model AccountLinkPublicKeyDTO {
  publicKey: string;
}

model AccountLinkVotingKeysDTO {
  publicKeys: AccountLinkVotingKeyDTO[];
}

model AccountLinkVotingKeyDTO {
  publicKey: string;
  startEpoch: FinalizationEpoch;
  endEpoch: FinalizationEpoch;
}

model SupplementalPublicKeysDTO {
  linked?: AccountLinkPublicKeyDTO;
  node?: AccountLinkPublicKeyDTO;
  vrf?: AccountLinkPublicKeyDTO;
  voting?: AccountLinkVotingKeysDTO;
}
