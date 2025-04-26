import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

import "./types/basic.tsp";
import "./types/crypto.tsp";
import "./types/blockchain.tsp";

import "./models/account.tsp";
import "./models/block.tsp";
import "./models/chain.tsp";
import "./models/merkle.tsp";
import "./models/mosaic.tsp";
import "./models/network.tsp";
import "./models/node.tsp";

using Http;
using OpenAPI;

/**
 * OpenAPI Specification of catapult-rest
 */
@service(#{ title: "Catapult REST Endpoints" })
@info(#{
  version: "1.0.4",
  license: #{ name: "Apache 2.0", url: "http://www.apache.org/licenses/LICENSE-2.0.html" },
})
@server("http://symbol.ninja:3000", "Symbol REST API")
@server("http://cheetah.catapult.ninja:3000", "Symbol REST API")
@server("http://jaguar.catapult.ninja:3000", "Symbol REST API")
@server("http://leopard.catapult.ninja:3000", "Symbol REST API")
@server("http://lion.catapult.ninja:3000", "Symbol REST API")
@server("http://tiger.catapult.ninja:3000", "Symbol REST API")
namespace CatapultRESTEndpoints;

@route("/accounts")
@tag("accounts")
interface AccountRoutes {
  @get
  @summary("Search accounts")
  @doc("Gets an array of accounts.")
  searchAccounts(
    @query pageSize?: integer,
    @query pageNumber?: integer,
    @query offset?: string,
    @query order?: Order,
    @query orderBy?: AccountOrderByEnum,
    @query mosaicId?: string,
  ): AccountPage | {
    @statusCode statusCode: 409;
    @body error: ModelError;
  };

  @post
  @summary("Get accounts information")
  @doc("Returns the account information for an array of accounts.")
  getAccountsInfo(
    @body accountIds: string[],
  ): AccountInfoDTO[] | {
    @statusCode statusCode: 400;
    @body error: ModelError;
  } | {
    @statusCode statusCode: 409;
    @body error: ModelError;
  };

  @route("{accountId}")
  @get
  @summary("Get account information")
  @doc("Returns the account information.")
  getAccountInfo(
    @path accountId: string,
  ): AccountInfoDTO | {
    @statusCode statusCode: 404;
    @body error: ModelError;
  } | {
    @statusCode statusCode: 409;
    @body error: ModelError;
  };

  @route("{accountId}/merkle")
  @get
  @summary("Get account merkle information")
  @doc("Returns the account merkle information.")
  getAccountInfoMerkle(
    @path accountId: string,
  ): MerkleStateInfoDTO | {
    @statusCode statusCode: 404;
    @body error: ModelError;
  } | {
    @statusCode statusCode: 409;
    @body error: ModelError;
  };
}

@route("/blocks")
@tag("blocks")
interface BlockRoutes {
  @get
  @summary("Search blocks")
  @doc("Gets an array of blocks.")
  searchBlocks(
    @query signerPublicKey?: string,
    @query beneficiaryAddress?: string,
    @query pageSize?: integer,
    @query pageNumber?: integer,
    @query offset?: string,
    @query order?: Order,
    @query orderBy?: BlockOrderByEnum,
  ): BlockPage | {
    @statusCode statusCode: 409;
    @body error: ModelError;
  };

  @route("{height}")
  @get
  @summary("Get block information")
  @doc("Gets a block from the chain that has the given height.")
  getBlockByHeight(
    @path height: string,
  ): BlockInfoDTO | {
    @statusCode statusCode: 404;
    @body error: ModelError;
  } | {
    @statusCode statusCode: 409;
    @body error: ModelError;
  };

  @route("{height}/transactions/{hash}/merkle")
  @get
  @summary("Get the merkle path for a given a transaction and block")
  @doc("""
    Returns the merkle path for a transaction included in a block.
    The merkle path is the minimum number of nodes needed to calculate the merkle root.

    Steps to calculate the merkle root:
    1. proofHash = hash (leaf).
    2. Concatenate proofHash with the first unprocessed item from the merklePath list as follows:
    * a) If item.position == left -> proofHash = sha_256(item.hash + proofHash).
    * b) If item.position == right -> proofHash = sha_256(proofHash+ item.hash).
    3. Repeat 2. for every item in the merklePath list.
    4. Compare if the calculated proofHash equals the one recorded in the
    block header (block.transactionsHash) to verify if the transaction was included in the block.
  """)
  getMerkleTransaction(
    @path height: string,
    @path hash: string,
  ): MerkleProofInfoDTO | {
    @statusCode statusCode: 404;
    @body error: ModelError;
  } | {
    @statusCode statusCode: 409;
    @body error: ModelError;
  };

  @route("{height}/statements/{hash}/merkle")
  @get
  @summary("Get the merkle path for a given a receipt statement hash and block")
  @doc("""
    Returns the merkle path for a receipt statement or resolution linked to a block.
    The merkle path is the minimum number of nodes needed to calculate the merkle root.

    Steps to calculate the merkle root:
    1. proofHash = hash (leaf).
    2. Concatenate proofHash with the first unprocessed item from the merklePath list as follows:
    * a) If item.position == left -> proofHash = sha_256(item.hash + proofHash).
    * b) If item.position == right -> proofHash = sha_256(proofHash+ item.hash).
    3. Repeat 2. for every item in the merklePath list.
    4. Compare if the calculated proofHash equals the one recorded in the
    block header (block.receiptsHash) to verify if the statement was linked with the block.
  """)
  getMerkleReceipts(
    @path height: string,
    @path hash: string,
  ): MerkleProofInfoDTO | {
    @statusCode statusCode: 404;
    @body error: ModelError;
  } | {
    @statusCode statusCode: 409;
    @body error: ModelError;
  };
}

@route("/chain")
@tag("chain")
interface ChainRoutes {
  @route("info")
  @get
  @summary("Get the current information of the chain")
  @doc("""
    Returns the current information of the blockchain.

    The higher the score, the better the chain.
    During synchronization, nodes try to get the best blockchain in the network.

    The score for a block is derived from its difficulty and the time (in seconds) that has elapsed since the last block:

    block score = difficulty − time elapsed since last block
  """)
  getChainInfo(): ChainInfoDTO;
}

@route("/finalization/proof")
@tag("finalization")
interface FinalizationRoutes {
  @route("epoch/{epoch}")
  @get
  @summary("Get finalization proof")
  @doc("Gets finalization proof for the greatest height associated with the given epoch.")
  getFinalizationProofAtEpoch(
    @path epoch: FinalizationEpoch,
  ): FinalizationProofDTO | {
    @statusCode statusCode: 404;
    @body error: ModelError;
  } | {
    @statusCode statusCode: 409;
    @body error: ModelError;
  };

  @route("height/{height}")
  @get
  @summary("Get finalization proof")
  @doc("Gets finalization proof at the given height.")
  getFinalizationProofAtHeight(
    @path height: string,
  ): FinalizationProofDTO | {
    @statusCode statusCode: 404;
    @body error: ModelError;
  } | {
    @statusCode statusCode: 409;
    @body error: ModelError;
  };
}

@route("/network")
@tag("network")
interface NetworkRoutes {
  @get
  @summary("Get the current network type of the chain")
  @doc("Returns the current network type.")
  getNetworkType(): NetworkTypeDTO;

  @route("fees/rental")
  @get
  @summary("Get rental fees information")
  @doc("""
    Returns the estimated effective rental fees for namespaces and mosaics.
    This endpoint is only available if the REST instance has access to catapult-server ``resources/config-network.properties`` file.
    To activate this feature, add the setting "network.propertiesFilePath" in the configuration file (rest/resources/rest.json).
  """)
  getRentalFees(): RentalFeesDTO | {
    @statusCode statusCode: 409;
    @body error: ModelError;
  };

  @route("fees/transaction")
  @get
  @summary("Get transaction fees information")
  @doc("""
    Returns the average, median, highest and lower fee multiplier over the last "numBlocksTransactionFeeStats".
    The setting "numBlocksTransactionFeeStats" is adjustable via the configuration file (rest/resources/rest.json) per REST instance.
  """)
  getTransactionFees(): TransactionFeesDTO;

  @route("properties")
  @get
  @summary("Get the network properties")
  @doc("""
    Returns the content from a catapult-server network configuration file (resources/config-network.properties).
    To enable this feature, the REST setting "network.propertiesFilePath" must define where the file is located.
    This is adjustable via the configuration file (rest/resources/rest.json) per REST instance.
  """)
  getNetworkProperties(): NetworkConfigurationDTO | {
    @statusCode statusCode: 409;
    @body error: ModelError;
  };
}

@route("/node")
@tag("node")
interface NodeRoutes {
  @route("health")
  @get
  @summary("Get the node health information")
  @doc("Supplies information regarding the connection and services status.")
  getNodeHealth(): NodeHealthInfoDTO | {
    @statusCode statusCode: 503;
    @body error: NodeHealthInfoDTO;
  };

  @route("info")
  @get
  @summary("Get the node information")
  @doc("Supplies additional information about the application running on a node.")
  getNodeInfo(): NodeInfoDTO;

  @route("peers")
  @get
  @summary("Get peers information")
  @doc("Gets the list of peers visible by the node.")
  getNodePeers(): NodeInfoDTO[];

  @route("storage")
  @get
  @summary("Get the storage information of the node")
  @doc("Returns storage information about the node.")
  getNodeStorage(): StorageInfoDTO;

  @route("time")
  @get
  @summary("Get the node time")
  @doc("Gets the node time at the moment the reply was sent and received.")
  getNodeTime(): NodeTimeDTO;

  @route("server")
  @get
  @summary("Get the version of the running REST component")
  @doc("Returns the version of the running catapult-rest component.")
  getServerInfo(): ServerInfoDTO;

  @route("unlockedaccount")
  @get
  @summary("Get the unlocked harvesting account public keys")
  @doc("Returns array of unlocked account public keys.")
  getUnlockedAccount(): UnlockedAccountDTO;
}
