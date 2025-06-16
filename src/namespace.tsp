import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

using Http;
using OpenAPI;

@info(#{
  version: "1.0.4",
  license: #{ name: "Apache 2.0", url: "http://www.apache.org/licenses/LICENSE-2.0.html" },
})
@service(#{ title: "Catapult REST Endpoints" })
@doc("OpenAPI Specification of catapult-rest")
@server("http://localhost:3000", "Local development")
namespace Catapult {};
