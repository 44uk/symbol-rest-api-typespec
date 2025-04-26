import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";
import "../types/blockchain.tsp";

using Http;
using OpenAPI;

/**
 * Mosaic identifier.
 */
@format("hex")
scalar MosaicId extends string;

/**
 * Mosaic identifier. If the most significant bit of byte 0 is set, a namespaceId (alias)
 * is used instead of the real mosaic identifier.
 */
@format("hex")
scalar UnresolvedMosaicId extends string;

model Mosaic {
  id: MosaicId;
  amount: Amount;
}

model UnresolvedMosaic {
  id: UnresolvedMosaicId;
  amount: Amount;
}
