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

@patch
@route("/feilutbetaling")
op oppdaterFakta(
  @path behandlingId: string,
  @body body: MergePatchUpdate<OppdaterFaktaOmFeilutbetaling>,
): FaktaOmFeilutbetaling | Error;

@error
model Error {
  message: string;
}
