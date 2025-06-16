import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "../models";
import "../parameters.tsp";

using Http;
using OpenAPI;

@route("/restrictions")
namespace Catapult.Restriction {
  @route("/account")
  @tag("Restriction Account routes")
  namespace Account {
    @get
    @summary("Search account restrictions")
    @doc("""
Returns an array of account restrictions.
""")
    op searchAccountRestrictions(
      ...Parameters.addressQuery,
      ...Parameters.pageSizeQuery,
      ...Parameters.pageNumberQuery,
      ...Parameters.offsetQuery,
      ...Parameters.orderQuery,
    ): AccountRestrictionsPage | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);

    @route("/{address}")
    @get
    @summary("Get the account restrictions")
    @doc("""
Returns the account restrictions for a given address.
""")
    op getAccountRestrictions(...Parameters.address): AccountRestrictionsInfoDTO | (NotFoundResponse &
      ModelError) | (ConflictResponse & ModelError);

    @route("/{address}/merkle")
    @get
    @summary("Get the account restrictions merkle")
    @doc("""
Returns the account restrictions merkle for a given address.
""")
    op getAccountRestrictionsMerkle(...Parameters.address): MerkleStateInfoDTO | (NotFoundResponse &
      ModelError) | (ConflictResponse & ModelError);
  }

  @route("/mosaic")
  @tag("Restriction Mosaic routes")
  namespace Mosaic {
    @get
    @summary("Search mosaic restrictions")
    @doc("Returns an array of mosaic restrictions.")
    op searchMosaicRestrictions(
      ...Parameters.mosaicIdQuery,
      ...Parameters.entryType,
      ...Parameters.targetAddressQuery,
      ...Parameters.pageSizeQuery,
      ...Parameters.pageNumberQuery,
      ...Parameters.offsetQuery,
      ...Parameters.orderQuery,
    ): MosaicRestrictionsPage | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);

    @route("/{compositeHash}")
    @get
    @summary("Get the mosaic restrictions")
    @doc("Returns the mosaic restrictions for a composite hash.")
    op getMosaicRestrictions(
      ...Parameters.compositeHashPath,
    ): MosaicRestrictionDTO | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);

    @route("/{compositeHash}/merkle")
    @get
    @summary("Get the mosaic restrictions merkle")
    @doc("Returns the mosaic restrictions merkle for a given composite hash.")
    op getMosaicRestrictionsMerkle(
      ...Parameters.compositeHashPath,
    ): MerkleStateInfoDTO | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);
  }
}
