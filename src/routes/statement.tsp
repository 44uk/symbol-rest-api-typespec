import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "../models";
import "../parameters.tsp";

using Http;
using OpenAPI;

@route("/statements")
@tag("Receipt routes")
namespace Catapult.Statement {
  @route("/transaction")
  @get
  @summary("Search transaction statements")
  @doc("""
Gets an array of transaction statements.
""")
  op searchReceipts(
    ...Parameters.heightQuery,
    ...Parameters.fromHeightQuery,
    ...Parameters.toHeightQuery,
    ...Parameters.receiptTypeQuery,
    ...Parameters.recipientAddressQuery,
    ...Parameters.senderAddressQuery,
    ...Parameters.targetAddressQuery,
    ...Parameters.artifactIdQuery,
    ...Parameters.pageSizeQuery,
    ...Parameters.pageNumberQuery,
    ...Parameters.offsetQuery,
    ...Parameters.orderQuery,
  ): TransactionStatementPage | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);

  @route("/resolutions")
  @tag("Receipt routes")
  namespace Resolution {
    @route("/address")
    @get
    @summary("Get receipts address resolution statements")
    @doc("""
Gets an array of address resolution statements.
""")
    op searchAddressResolutionStatements(
      ...Parameters.heightQuery,
      ...Parameters.pageSizeQuery,
      ...Parameters.pageNumberQuery,
      ...Parameters.offsetQuery,
      ...Parameters.orderQuery,
    ): ResolutionStatementPage | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);

    @route("/mosaic")
    @get
    @summary("Get receipts mosaic resolution statements")
    @doc("""
Gets an array of mosaic resolution statements.
""")
    op searchMosaicResolutionStatements(
      ...Parameters.heightQuery,
      ...Parameters.pageSizeQuery,
      ...Parameters.pageNumberQuery,
      ...Parameters.offsetQuery,
      ...Parameters.orderQuery,
    ): ResolutionStatementPage | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);
  }
}
