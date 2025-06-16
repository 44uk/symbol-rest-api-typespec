import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "../models";
import "../parameters.tsp";

using Http;
using OpenAPI;

@route("/metadata")
@tag("Metadata routes")
namespace Catapult.Metadata {
  @get
  @summary("Search metadata entries")
  @doc("Returns an array of metadata.")
  op searchMetadataEntries(
    ...Parameters.sourceAddressQuery,
    ...Parameters.targetAddressQuery,
    ...Parameters.scopedMetadataKeyQuery,
    ...Parameters.targetIdQuery,
    ...Parameters.metadataType,
    ...Parameters.pageSizeQuery,
    ...Parameters.pageNumberQuery,
    ...Parameters.offsetQuery,
    ...Parameters.orderQuery,
  ): MetadataPage | (ConflictResponse & ModelError);

  @route("/{compositeHash}")
  @get
  @summary("Get metadata information")
  @doc("Gets the metadata for a given composite hash.")
  op getMetadata(...Parameters.compositeHashPath): MetadataInfoDTO | (ConflictResponse & ModelError);

  @route("/{compositeHash}/merkle")
  @get
  @summary("Get metadata merkle information")
  @doc("Gets the metadata merkle for a given composite hash.")
  op getMetadataMerkle(...Parameters.compositeHashPath): MerkleStateInfoDTO | (ConflictResponse &
    ModelError);
}
