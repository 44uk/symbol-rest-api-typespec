import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "../models";
import "../parameters.tsp";

using Http;
using OpenAPI;

@route("/network")
@tag("Network routes")
namespace Catapult.Network {
  @get
  @summary("Get the current network type of the chain")
  @doc("Returns the current network type.")
  op getNetworkType(): NetworkTypeDTO;

  @route("/fees")
  namespace Fee {
    @route("/rental")
    @get
    @summary("Get rental fees information")
    @doc("""
Returns the estimated effective rental fees for namespaces and mosaics.
This endpoint is only available if the REST instance has access to catapult-server ``resources/config-network.properties`` file.
To activate this feature, add the setting "network.propertiesFilePath" in the configuration file (rest/resources/rest.json).
""")
    op getRentalFees(): RentalFeesDTO | (ConflictResponse & ModelError);

    @route("/transaction")
    @get
    @summary("Get transaction fees information")
    @doc("""
Returns the average, median, highest and lower fee multiplier over the last "numBlocksTransactionFeeStats".
The setting "numBlocksTransactionFeeStats" is adjustable via the configuration file (rest/resources/rest.json) per REST instance.
""")
    op getTransactionFees(): TransactionFeesDTO;
  }

  @route("/properties")
  @get
  @summary("Get the network properties")
  @doc("""
Returns the content from a catapult-server network configuration file (resources/config-network.properties).
To enable this feature, the REST setting "network.propertiesFilePath" must define where the file is located.
This is adjustable via the configuration file (rest/resources/rest.json) per REST instance.
""")
  op getNetworkProperties(): NetworkConfigurationDTO | (ConflictResponse & ModelError);
}
