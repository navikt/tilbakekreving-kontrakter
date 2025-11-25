import "@typespec/http";
import "./fakta.tsp";

@tag("behandling")
@service(#{ title: "Behandling Service" })
@route("/api/v1/behandling/{behandlingId}")
namespace Behandling;

using Http;

@get
@route("/fakta")
op fakta(@path behandlingId: string): Fakta | Error;

model Behandling {
  id: string;
  feilutbetaling: Feilutbetaling;
  tidligereVarsletBeløp?: uint32;
}

model Feilutbetaling {
  fullstendigPeriode: Periode;
  beløp: uint32;
}

model Periode {
  fom: plainDate;
  tom: plainDate;
}

@error
model Error {
  code: int32;
  message: string;
}
