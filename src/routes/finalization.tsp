import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "../models";
import "../parameters.tsp";

using Http;
using OpenAPI;

@route("/finalization")
@tag("Finalization routes")
namespace Catapult.Finalization {
  @route("/proof")
  namespace Proof {
    @route("/epoch/{epoch}")
    @get
    @summary("Get finalization proof")
    @doc("Gets finalization proof for the greatest height associated with the given epoch.")
    op getFinalizationProofAtEpoch(
      /**
       * Finalization epoch.
       */
      @path epoch: FinalizationEpoch,
    ): FinalizationProofDTO | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);

    @route("/height/{height}")
    @get
    @summary("Get finalization proof")
    @doc("Gets finalization proof at the given height.")
    op getFinalizationProofAtHeight(
      ...Parameters.heightPath,
    ): FinalizationProofDTO | (NotFoundResponse & ModelError) | (ConflictResponse & ModelError);
  }
}
