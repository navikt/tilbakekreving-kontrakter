import "@typespec/http";
import "./feilutbetaling.tsp";
import "./common.tsp";

using Http;

interface BehandlingApi {
  @get
  @route("/feilutbetaling")
  fakta(@path behandlingId: string): {
    @body fakta: FaktaOmFeilutbetaling;
  } | {
    @body error: Error;
    @statusCode statusCode: 400 | 500;
  };

  #suppress "@typespec/http/patch-implicit-optional" ""
  @patch
  @route("/feilutbetaling")
  oppdaterFakta(
    @path behandlingId: string,

    @body
    body: OppdaterFaktaOmFeilutbetaling,
  ): {
    @body fakta: FaktaOmFeilutbetaling;
  } | {
    @body error: Error;
    @statusCode statusCode: 400 | 500;
  };
}

@error
model Error {
  message: string;
}
