import "@typespec/http";
import "@typespec/openapi";
import "../types";
import "../models";
import "../parameters.tsp";

using Http;
using OpenAPI;

@route("/node")
@tag("Node routes")
namespace Catapult.Node {
  @route("/health")
  @get
  @summary("Get the node health information")
  @doc("Supplies information regarding the connection and services status.")
  op getNodeHealth(): NodeHealthInfoDTO | {
    @statusCode statusCode: 503;
    @body body: NodeHealthInfoDTO;
  };

  @route("/info")
  @get
  @summary("Get the node information")
  @doc("Supplies additional information about the application running on a node.")
  op getNodeInfo(): NodeInfoDTO;

  @route("/peers")
  @get
  @summary("Get peers information")
  @doc("Gets the list of peers visible by the node.")
  op getNodePeers(): Body<NodeInfoDTO[]>;

  @route("/storage")
  @get
  @summary("Get the storage information of the node")
  @doc("Returns storage information about the node.")
  op getNodeStorage(): StorageInfoDTO;

  @route("/time")
  @get
  @summary("Get the node time")
  @doc("Gets the node time at the moment the reply was sent and received.")
  op getNodeTime(): NodeTimeDTO;

  @route("/server")
  @get
  @summary("Get the version of the running REST component")
  @doc("Returns the version of the running catapult-rest component.")
  op getServerInfo(): ServerInfoDTO;

  @route("/unlockedaccount")
  @get
  @summary("Get the unlocked harvesting account public keys.")
  @doc("Returns array of unlocked account public keys.")
  op getUnlockedAccount(): UnlockedAccountDTO;
}
