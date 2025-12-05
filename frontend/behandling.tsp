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
op fakta(
  @path behandlingId: string
): {
  @body fakta: FaktaOmFeilutbetaling;
} | {
  @body error: Error;
  @statusCode statusCode: 400 | 500;
};

#suppress "@typespec/http/patch-implicit-optional" ""
@patch
@route("/feilutbetaling")
op oppdaterFakta(
  @path behandlingId: string,

  @body
  body: OppdaterFaktaOmFeilutbetaling,
): {
  @body fakta: FaktaOmFeilutbetaling;
} | {
  @body error: Error;
  @statusCode statusCode: 400 | 500;
};

@error
model Error {
  message: string;
}
