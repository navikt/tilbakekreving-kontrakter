import "@typespec/http";
import "./frontend/fakta.tsp";

using Http;
@service(#{ title: "Behandling Service" })
namespace BehandlingService;

@error
model Error {
  code: int32;
  message: string;
}

@route("/api/v1/behandling/{behandlingId}")
interface Behandling {
  @get
  @route("/fakta")
  fakta(@path behandlingId: string): Fakta | Error;
}
