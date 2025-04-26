import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

import "../types/blockchain.tsp";

using Http;
using OpenAPI;

model ChainInfoDTO {
  /**
   * Height of the blockchain.
   */
  height: Height;

  /**
   * Score of the blockchain. During synchronization nodes try to get the blockchain with highest score in the network.
   */
  scoreHigh: string;
  scoreLow: string;

  /**
   * Finalization epoch.
   */
  latestFinalizedBlock: FinalizationProofDTO;
}

model FinalizationProofDTO {
  /**
   * Finalization version.
   */
  version: integer;

  /**
   * Finalization epoch.
   */
  finalizationEpoch: FinalizationEpoch;

  /**
   * Finalization point.
   */
  finalizationPoint: FinalizationPoint;

  /**
   * Height of the blockchain.
   */
  height: Height;

  /**
   * Hash.
   */
  hash: string;

  /**
   * Array of vote messages.
   */
  messageGroups: MessageGroup[];
}

model MessageGroup {
  /**
   * Stage of the message group.
   */
  stage: integer;

  /**
   * Height of the blockchain.
   */
  height: Height;

  /**
   * Hash.
   */
  hashes: string[];

  /**
   * Array of signatures.
   */
  signatures: BmTreeSignature[];
}

model BmTreeSignature {
  /**
   * Root of the signature.
   */
  root: ParentPublicKeySignaturePair;

  /**
   * Bottom of the signature.
   */
  bottom: ParentPublicKeySignaturePair;
}

model ParentPublicKeySignaturePair {
  /**
   * Public key.
   */
  parentPublicKey: string;

  /**
   * Signature.
   */
  signature: string;
}
