import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "../models";
import "../parameters.tsp";

using Http;
using OpenAPI;

@route("/mosaics")
@tag("Mosaic routes")
namespace Catapult.Mosaic {
  @route("/{mosaicId}")
  @get
  @summary("Get mosaic information")
  @doc("Gets the mosaic definition for a given mosaic identifier.")
  op getMosaic(...Parameters.mosaicIdPath): MosaicInfoDTO | (NotFoundResponse &
    ModelError) | (ConflictResponse & ModelError);

  @route("/{mosaicId}/merkle")
  @get
  @summary("Get mosaic merkle information")
  @doc("Gets the mosaic definition merkle for a given mosaic identifier.")
  op getMosaicMerkle(...Parameters.mosaicIdPath): MerkleStateInfoDTO | (NotFoundResponse &
    ModelError) | (ConflictResponse & ModelError);

  @get
  @summary("Search mosaics")
  @doc("Gets an array of mosaics.")
  op searchMosaics(
    ...Parameters.ownerAddressQuery,
    ...Parameters.pageSizeQuery,
    ...Parameters.pageNumberQuery,
    ...Parameters.offsetQuery,
    ...Parameters.orderQuery,
  ): MosaicPage | (ConflictResponse & ModelError);

  @post
  @summary("Get mosaics information for an array of mosaics")
  @doc("Gets an array of mosaic definition.")
  op getMosaics(@body body: mosaicIds): Body<MosaicInfoDTO[]> | (BadRequestResponse &
    ModelError) | (ConflictResponse & ModelError);
}
