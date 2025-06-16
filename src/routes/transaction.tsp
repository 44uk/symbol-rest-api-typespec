// import "@typespec/http";
// import "@typespec/openapi";
import "../types";
import "../models";
import "../parameters.tsp";

using Http;
using OpenAPI;

@tag("Transaction routes")
@route("/transactions")
namespace Catapult.Transaction {
  @put
  @summary("Announce a new transaction")
  @doc("""
Announces a transaction to the network.
The [catbuffer library](https://github.com/nemtech/catbuffer) defines the protocol to serialize and deserialize Symbol entities.
Catbuffers are integrated into [Symbol SDKs](https://nemtech.github.io/sdk.html).
It's recommended to use SDKs instead of calling the API endpoint directly to announce transactions.
""")
  op announceTransaction(@body body: transactionPayload): (AcceptedResponse &
    AnnounceTransactionInfoDTO) | (BadRequestResponse & ModelError) | (ConflictResponse & ModelError);

  @route("/confirmed")
  @get
  @summary("Search confirmed transactions")
  @doc("""
Returns an array of confirmed transactions.
If a transaction was announced with an alias rather than an address,
the address that will be considered when querying is the one that
was resolved from the alias at confirmation time.
""")
  op searchConfirmedTransactions(
    ...Parameters.addressQuery,
    ...Parameters.recipientAddressQuery,
    ...Parameters.signerPublicKeyQuery,
    ...Parameters.heightQuery,
    ...Parameters.fromHeightQuery,
    ...Parameters.toHeightQuery,
    ...Parameters.fromTransferAmountQuery,
    ...Parameters.toTransferAmountQuery,
    ...Parameters.transactionTypeQuery,
    ...Parameters.embedded,
    ...Parameters.transferMosaicIdQuery,
    ...Parameters.pageSizeQuery,
    ...Parameters.pageNumberQuery,
    ...Parameters.offsetQuery,
    ...Parameters.orderQuery,
  ): TransactionPage | (ConflictResponse & ModelError);

  @route("/confirmed")
  @post
  @summary("Get confirmed trasactions information")
  @doc("Returns confirmed transactions information for a given array of transactionIds.")
  op getConfirmedTransactions(
    @body body: transactionIds,
  ): Body<TransactionInfoDTO[]> | (BadRequestResponse & ModelError) | (ConflictResponse & ModelError);

  /**
   * Returns confirmed transaction information given a transactionId or hash.
   */
  @route("/confirmed/{transactionId}")
  @get
  @summary("Get confirmed transaction information")
  @doc("Returns confirmed transaction information given a transactionId or hash.")
  op getConfirmedTransaction(
    ...Parameters.transactionIdPath,
  ): TransactionInfoDTO | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);

  @route("/unconfirmed")
  @get
  @summary("Search unconfirmed transactions")
  @doc("Returns an array of unconfirmed transactions.")
  op searchUnconfirmedTransactions(
    ...Parameters.addressQuery,
    ...Parameters.recipientAddressQuery,
    ...Parameters.signerPublicKeyQuery,
    ...Parameters.heightQuery,
    ...Parameters.fromHeightQuery,
    ...Parameters.toHeightQuery,
    ...Parameters.fromTransferAmountQuery,
    ...Parameters.toTransferAmountQuery,
    ...Parameters.transactionTypeQuery,
    ...Parameters.embedded,
    ...Parameters.transferMosaicIdQuery,
    ...Parameters.pageSizeQuery,
    ...Parameters.pageNumberQuery,
    ...Parameters.offsetQuery,
    ...Parameters.orderQuery,
  ): TransactionPage | (ConflictResponse & ModelError);

  @route("/unconfirmed")
  @post
  @summary("Get unconfirmed trasactions information")
  @doc("Returns unconfirmed transactions information for a given array of transactionIds.")
  op getUnconfirmedTransactions(
    @body body: transactionIds,
  ): Body<TransactionInfoDTO[]> | (BadRequestResponse & ModelError) | (ConflictResponse & ModelError);

  @route("/unconfirmed/{transactionId}")
  @get
  @summary("Get unconfirmed transaction information")
  @doc("Returns unconfirmed transaction information given a transactionId or hash.")
  op getUnconfirmedTransaction(
    ...Parameters.transactionIdPath,
  ): TransactionInfoDTO | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);

  @route("/partial")
  @get
  @summary("Search partial transactions")
  @doc("Returns an array of partial transactions.")
  op searchPartialTransactions(
    ...Parameters.addressQuery,
    ...Parameters.recipientAddressQuery,
    ...Parameters.signerPublicKeyQuery,
    ...Parameters.heightQuery,
    ...Parameters.fromHeightQuery,
    ...Parameters.toHeightQuery,
    ...Parameters.fromTransferAmountQuery,
    ...Parameters.toTransferAmountQuery,
    ...Parameters.transactionTypeQuery,
    ...Parameters.embedded,
    ...Parameters.transferMosaicIdQuery,
    ...Parameters.pageSizeQuery,
    ...Parameters.pageNumberQuery,
    ...Parameters.offsetQuery,
    ...Parameters.orderQuery,
  ): TransactionPage | (ConflictResponse & ModelError);

  @route("/partial")
  @post
  @summary("Get partial trasactions information")
  @doc("Returns partial transactions information for a given array of transactionIds.")
  op getPartialTransactions(
    @body body: transactionIds,
  ): Body<TransactionInfoDTO[]> | (BadRequestResponse & ModelError) | (ConflictResponse & ModelError);

  @route("/partial")
  @put
  @summary("Announce an aggregate bonded transaction")
  @doc("Announces an aggregate bonded transaction to the network.")
  op announcePartialTransaction(@body body: transactionPayload): (AcceptedResponse &
    AnnounceTransactionInfoDTO) | (BadRequestResponse & ModelError) | (ConflictResponse & ModelError);

  @route("/partial/{transactionId}")
  @get
  @summary("Get partial transaction information")
  @doc("Returns partial transaction information given a transactionId or hash.")
  op getPartialTransaction(...Parameters.transactionIdPath): TransactionInfoDTO | (NotFoundResponse &
    ModelError) | (ConflictResponse & ModelError);

  @route("/cosignature")
  @put
  @summary("Announce a cosignature transaction")
  @doc("Announces a cosignature transaction to the network.")
  op announceCosignatureTransaction(@body body: cosignature): (AcceptedResponse &
    AnnounceTransactionInfoDTO) | (BadRequestResponse & ModelError) | (ConflictResponse & ModelError);
}
