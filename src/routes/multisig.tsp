import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "../models";
import "../parameters.tsp";

using Http;
using OpenAPI;

@route("/account")
@tag("Multisig routes")
namespace Catapult.Multisig {
  @route("/{address}/multisig")
  @get
  @summary("Get multisig account information")
  @doc("Returns the multisig account information.")
  op getAccountMultisig(...Parameters.address): MultisigAccountInfoDTO | (NotFoundResponse &
    ModelError) | (ConflictResponse & ModelError);

  @route("/{address}/multisig/merkle")
  @get
  @summary("Get multisig account merkle information")
  @doc("Returns the multisig account merkle information.")
  op getAccountMultisigMerkle(...Parameters.address): MerkleStateInfoDTO | (NotFoundResponse &
    ModelError) | (ConflictResponse & ModelError);

  @route("/{address}/multisig/graph")
  @get
  @summary("Get multisig account graph information")
  @doc("Returns the multisig account graph.")
  op getAccountMultisigGraph(
    ...Parameters.address,
  ): Body<MultisigAccountGraphInfoDTO[]> | (NotFoundResponse & ModelError) | (ConflictResponse &
    ModelError);
}
