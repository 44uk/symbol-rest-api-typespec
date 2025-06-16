import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "../models";
import "../parameters.tsp";

using Http;
using OpenAPI;

@route("/namespaces")
@tag("Namespace routes")
namespace Catapult.Namespace {
  @get
  @summary("Search namespaces")
  @doc("Gets an array of namespaces.")
  op searchNamespaces(
    ...Parameters.ownerAddressQuery,
    ...Parameters.registrationTypeQuery,
    ...Parameters.level0Query,
    ...Parameters.aliasTypeQuery,
    ...Parameters.pageSizeQuery,
    ...Parameters.pageNumberQuery,
    ...Parameters.offsetQuery,
    ...Parameters.orderQuery,
  ): NamespacePage | (ConflictResponse & ModelError);

  @route("/{namespaceId}")
  @get
  @summary("Get namespace information")
  @doc("Gets the namespace for a given namespace identifier.")
  op getNamespace(...Parameters.namespaceIdPath): NamespaceInfoDTO | (NotFoundResponse &
    ModelError) | (ConflictResponse & ModelError);

  @route("/{namespaceId}/merkle")
  @get
  @summary("Get namespace merkle information")
  @doc("Gets the namespace merkle for a given namespace identifier.")
  op getNamespaceMerkle(...Parameters.namespaceIdPath): MerkleStateInfoDTO | (NotFoundResponse &
    ModelError) | (ConflictResponse & ModelError);

  @route("/names")
  @post
  @summary("Get readable names for a set of namespaces")
  @doc("Returns friendly names for namespaces.")
  op getNamespacesNames(@body body: namespaceIds): Body<NamespaceNameDTO[]> | (BadRequestResponse &
    ModelError) | (ConflictResponse & ModelError);

  @route("/account")
  namespace Account {
    @route("/names")
    @post
    @summary("Get readable names for a set of accountIds")
    @doc("Returns friendly names for accounts.")
    op getAccountsNames(@body body: addresses): AccountsNamesDTO | (BadRequestResponse &
      ModelError) | (ConflictResponse & ModelError);
  }

  @route("/mosaic")
  namespace Mosaic {
    @route("/names")
    @post
    @summary("Get readable names for a set of mosaics")
    @doc("Returns friendly names for mosaics.")
    op getMosaicsNames(@body body: mosaicIds): MosaicsNamesDTO | (BadRequestResponse &
      ModelError) | (ConflictResponse & ModelError);
  }
}
