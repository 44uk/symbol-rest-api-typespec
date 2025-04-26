import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

import "../types/basic.tsp";
import "../types/blockchain.tsp";
import "../types/crypto.tsp";

using Http;
using OpenAPI;

enum BlockOrderByEnum {
  id,
  height,
}

/**
 * Position relative to the proofHash being evaluated.
 */
enum PositionEnum {
  left,
  right,
}

model BlockPage {
  /**
   * Array of blocks.
   */
  data: BlockInfoDTO[];
  pagination: Pagination;
}

model BlockInfoDTO {
  /**
   * Internal resource identifier.
   */
  id: string;

  /**
   * The block meta data.
   */
  meta: BlockMetaDTO;

  /**
   * The block data.
   */
  block: BlockDTO;
}

model BlockMetaDTO {
  /**
   * Hash of the block.
   */
  hash: Hash256;

  /**
   * Total fee paid to the network to execute the transactions included in the block.
   */
  totalFee: Amount;

  /**
   * Generation hash of the block.
   */
  generationHash: Hash256;

  /**
   * Number of statements included in the block.
   */
  statementsCount: integer;

  /**
   * Number of transactions included in the block.
   */
  transactionsCount: integer;

  /**
   * Total amount of tokens created from the start of the network.
   */
  totalTransactionsCount: integer;
}

model BlockDTO {
  /**
   * The Size of the block in bytes.
   */
  size: integer;

  /**
   * Block signature.
   */
  signature: Signature;

  /**
   * Public key of the account that harvested the block.
   */
  signerPublicKey: PublicKey;

  /**
   * Version of the block.
   */
  version: integer;

  /**
   * Network type.
   */
  network: integer;

  /**
   * Type of block.
   */
  type: integer;

  /**
   * Height of the blockchain when this block was added.
   */
  height: Height;

  /**
   * Number of milliseconds elapsed since the creation of the nemesis block.
   */
  timestamp: Timestamp;

  /**
   * Difficulty of the block.
   */
  difficulty: Difficulty;

  /**
   * Fee multiplier applied to the block.
   */
  feeMultiplier: BlockFeeMultiplier;

  /**
   * Hash of the previous block.
   */
  previousBlockHash: Hash256;

  /**
   * Hash of the block transactions.
   */
  transactionsHash: Hash256;

  /**
   * Hash of the block receipts.
   */
  receiptsHash: Hash256;

  /**
   * Hash of the block state.
   */
  stateHash: Hash256;

  /**
   * Address of the account that will receive part of the harvested fee.
   */
  beneficiaryAddress: Address;

  /**
   * Block proof gamma.
   */
  proofGamma: ProofGamma;

  /**
   * Block proof verification hash.
   */
  proofVerificationHash: ProofVerificationHash;

  /**
   * Block proof scalar.
   */
  proofScalar: ProofScalar;
}

model MerkleProofInfoDTO {
  /**
   * Merkle path.
   */
  merklePath: MerklePathItemDTO[];
}

model MerklePathItemDTO {
  /**
   * Position relative to the proofHash being evaluated.
   */
  position: PositionEnum;

  /**
   * Hash of the node.
   */
  hash: Hash256;
}
