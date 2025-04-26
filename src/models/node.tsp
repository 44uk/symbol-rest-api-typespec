import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";
import "../types/blockchain.tsp";
import "../types/crypto.tsp";

using Http;
using OpenAPI;

model NodeHealthInfoDTO {
  /**
   * Status message indicating what is the current condition of the API node.
   */
  status: NodeStatusEnum;

  /**
   * Additional information about the node health.
   */
  message?: string;
}

/**
 * Node status:
 * * up - Node is up.
 * * down - Node is down.
 */
enum NodeStatusEnum {
  up,
  down,
}

model NodeInfoDTO {
  /**
   * Version of the application.
   */
  version: integer;

  /**
   * Public key.
   */
  publicKey: PublicKey;

  /**
   * Network generation hash seed.
   */
  networkGenerationHashSeed: string;

  /**
   * Roles of the node.
   */
  roles: integer;

  /**
   * Port used for the communication.
   */
  port: integer;

  /**
   * Network identifier.
   */
  networkIdentifier: integer;

  /**
   * Node friendly name.
   */
  friendlyName: string;

  /**
   * Node host.
   */
  host: string;
}

model ServerInfoDTO {
  /**
   * REST component version.
   */
  serverInfo: string;
}

model StorageInfoDTO {
  /**
   * Number of blocks stored.
   */
  numBlocks: integer;

  /**
   * Number of transactions stored.
   */
  numTransactions: integer;

  /**
   * Number of accounts created.
   */
  numAccounts: integer;
}

model NodeTimeDTO {
  /**
   * Public key.
   */
  communicationTimestamps: CommunicationTimestampsDTO;
}

model CommunicationTimestampsDTO {
  /**
   * Number of seconds elapsed since the creation of the nemesis block.
   */
  sendTimestamp: Timestamp;

  /**
   * Number of seconds elapsed since the creation of the nemesis block.
   */
  receiveTimestamp: Timestamp;
}

model UnlockedAccountDTO {
  /**
   * Array of unlocked account public keys.
   */
  unlockedAccount: string[];
}
