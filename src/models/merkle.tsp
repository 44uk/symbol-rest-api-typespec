import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";
import "../types/crypto.tsp";

using Http;
using OpenAPI;

/**
 * Type of Merkle tree node:
 * * 0 - Branch node.
 * * 255 - Leaf node.
 */
union MerkleTreeNodeTypeEnum {
  0,
  255,
}

/**
 * The merkle path information clients can use to proof the state of the given entity.
 */
model MerkleStateInfoDTO {
  raw: MerkleTreeRaw;

  /**
   * Merkle tree parsed from merkle tree raw.
   */
  tree: (MerkleTreeBranchDTO | MerkleTreeLeafDTO)[];
}

/**
 * The hex information of the complete merkle tree as returned by server api.
 * More information can be found in chapter 4.3 of the catapult whitepaper.
 */
@format("hex")
scalar MerkleTreeRaw extends string;

/**
 * Merkle tree branch node.
 */
model MerkleTreeBranchDTO {
  /**
   * Merkle tree node type.
   */
  type: MerkleTreeNodeTypeEnum;

  /**
   * Branch link path.
   */
  path: string;

  /**
   * Encoded branch link path.
   */
  encodedPath: string;

  /**
   * Nibble count.
   */
  nibbleCount: integer;

  /**
   * Branch link bitmask.
   */
  linkMask: string;

  /**
   * Branch links (max 16).
   */
  links: MerkleTreeBranchLinkDTO[];

  /**
   * Hash of the branch node.
   */
  branchHash: Hash256;
}

/**
 * Merkle tree leaf node.
 */
model MerkleTreeLeafDTO {
  /**
   * Merkle tree node type.
   */
  type: MerkleTreeNodeTypeEnum;

  /**
   * Leaf path.
   */
  path: string;

  /**
   * Encoded leaf path.
   */
  encodedPath: string;

  /**
   * Nibble count.
   */
  nibbleCount: integer;

  /**
   * Leaf value (sha256 hash).
   */
  value: string;

  /**
   * Hash of the leaf node.
   */
  leafHash: Hash256;
}

/**
 * Merkle tree branch link.
 */
model MerkleTreeBranchLinkDTO {
  /**
   * Branch link nibble bit index (hexadecimal).
   */
  bit: string;

  /**
   * Branch link hash.
   */
  link: Hash256;
}
