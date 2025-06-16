// import "@typespec/http";
// import "@typespec/openapi";
import "../types";
import "../models";
import "../parameters.tsp";

using Http;
using OpenAPI;

@tag("Transaction status routes")
@route("/transactionStatus")
namespace Catapult.TransactionStatus {
  @post
  @summary("Get transaction statuses")
  @doc("Returns an array of transaction statuses for a given array of transaction hashes.")
  op getTransactionStatuses(
    @body body: transactionHashes,
  ): Body<TransactionStatusDTO[]> | (BadRequestResponse & ModelError) | (ConflictResponse &
    ModelError);

  @route("/{hash}")
  @get
  @summary("Get transaction status")
  @doc("Returns the transaction status for a given hash.")
  op getTransactionStatus(
    ...Parameters.transactionHashPath,
  ): TransactionStatusDTO | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);
}
