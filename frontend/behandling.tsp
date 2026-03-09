import "@typespec/http";
import "./feilutbetaling.tsp";
import "./beregningsresultat.tsp";
import "./common.tsp";

using Http;

alias ErrorResponse = {
  @body error: Error;
  @statusCode statusCode: 400 | 500;
};

alias SuccessResponse<Body> = {
  @body body: Body;
};

interface BehandlingApi {
  @get
  @route("/feilutbetaling")
  fakta(
    @path behandlingId: string,
  ): SuccessResponse<FaktaOmFeilutbetaling> | ErrorResponse;

  #suppress "@typespec/http/patch-implicit-optional" ""
  @patch
  @route("/feilutbetaling")
  oppdaterFakta(
    @path behandlingId: string,

    @body
    body: OppdaterFaktaOmFeilutbetaling,
  ): SuccessResponse<FaktaOmFeilutbetaling> | ErrorResponse;

  @get
  @route("/vedtak/brev")
  hentVedtaksbrev(
    @path behandlingId: string,
  ): SuccessResponse<VedtaksbrevData> | ErrorResponse;

  @put
  @route("/vedtak/brev")
  @parameterVisibility(Lifecycle.Update)
  oppdaterVedtaksbrev(
    @path @format("uuid") behandlingId: string,
    @body brevdata: VedtaksbrevRedigerbareData,
  ): SuccessResponse<VedtaksbrevRedigerbareData> | ErrorResponse;

  @get
  @route("/vedtak/resultat")
  hentVedtaksresultat(
    @path behandlingId: string,
  ): SuccessResponse<Beregningsresultat> | ErrorResponse;

  @post
  @route("/foreslå-vedtak")
  foreslaaVedtak(
    @path @format("uuid") behandlingId: string,
  ): SuccessResponse<void> | ErrorResponse;
}

@error
model Error {
  message: string;
}
