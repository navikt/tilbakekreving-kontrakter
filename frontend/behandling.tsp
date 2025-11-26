import "@typespec/http";
import "./feilutbetaling.tsp";
import "./common.tsp";

@tag("behandling")
@service(#{ title: "Behandling Service" })
@route("/api/v1/behandling/{behandlingId}")
namespace Behandling;

using Http;

@get
@route("/feilutbetaling")
op fakta(@path behandlingId: string): FaktaOmFeilutbetaling | Error;

@error
model Error {
  code: int32;
  message: string;
}
