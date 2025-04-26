import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

using Http;
using OpenAPI;

/**
 * Address encoded using a 32-character set.
 */
scalar Address extends string;

/**
 * Absolute amount. An amount of 123456789 (absolute) for a mosaic with divisibility 6 means 123.456789 (relative).
 */
scalar Amount extends string;

/**
 * Duration expressed in number of blocks.
 */
scalar BlockDuration extends string;

/**
 * Fee multiplier applied to transactions contained in block.
 */
scalar BlockFeeMultiplier extends int64;

/**
 * Determines how hard is to harvest a new block, based on previous blocks.
 */
scalar Difficulty extends string;

/**
 * Finalization Epoch
 */
scalar FinalizationEpoch extends int64;

/**
 * Finalization point
 */
scalar FinalizationPoint extends int64;

/**
 * Height of the blockchain.
 */
scalar Height extends string;

/**
 * Finalized height of the blockchain.
 */
scalar FinalizedHeight extends string;

/**
 * Importance score.
 */
scalar Importance extends string;

/**
 * Score of the blockchain. During synchronization, nodes try to get the
 * blockchain with highest score in the network.
 */
scalar Score extends string;

/**
 * Number of milliseconds elapsed since the creation of the nemesis block.
 * This value can be converted to epoch time by adding the network's 'epochAdjustment'.
 */
scalar Timestamp extends string;

/**
 * Address expressed in Base32 format. If the bit 0 of byte 0 is not set (like in 0x90), then it is a
 * regular address. Example: TAOXUJOTTW3W5XTBQMQEX3SQNA6MCUVGXLXR3TA.
 * Otherwise (e.g. 0x91) it represents a namespace id which starts at byte 1. Example: THBIMC3THGH5RUYAAAAAAAAAAAAAAAAAAAAAAAA
 */
scalar UnresolvedAddress extends string;
