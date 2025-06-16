import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "../models";
import "../parameters.tsp";

using Http;
using OpenAPI;

@tag("Account routes")
@route("/accounts")
namespace Catapult.Account {
  @get
  @summary("Search accounts")
  @doc("Gets an array of accounts.")
  op searchAccounts(
    ...Parameters.pageSizeQuery,
    ...Parameters.pageNumberQuery,
    ...Parameters.offsetQuery,
    ...Parameters.orderQuery,
    ...Parameters.orderByAccountQuery,
    ...Parameters.mosaicIdQuery,
  ): AccountPage | (ConflictResponse & ModelError);

  @post
  @summary("Get accounts information")
  @doc("Returns the account information for an array of accounts.")
  op getAccountsInfo(@body body: accountIds): Body<AccountInfoDTO[]> | (BadRequestResponse & ModelError) | (ConflictResponse & ModelError);

  @route("/{accountId}")
  @get
  @summary("Get account information")
  @doc("Returns the account information.")
  op getAccountInfo(...Parameters.accountIdPath): AccountInfoDTO | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);

  @route("/{accountId}/merkle")
  @get
  @summary("Get account merkle information")
  @doc("Returns the account merkle information.")
  op getAccountInfoMerkle(...Parameters.accountIdPath): MerkleStateInfoDTO | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);
}
