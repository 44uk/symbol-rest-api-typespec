import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

using Http;
using OpenAPI;

/**
 * A number that allows uint 32 values.
 */
scalar UInt32 extends int64;

/**
 * A number that allows uint 64 values represented with a string.
 */
scalar UInt64 extends string;

/**
 * The version of the state
 */
scalar StateVersion extends integer;

model ModelError {
  code: string;
  message: string;
}

/**
 * Indicates how to sort the results:
 * * ``asc`` - ascending
 * * ``desc`` - descending
 *
 */
enum Order {
  asc,
  desc,
}

model Pagination {
  pageNumber: integer;
  pageSize: integer;
}
