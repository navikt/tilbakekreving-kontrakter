import "@typespec/http";
import "./feilutbetaling.tsp";
import "./beregningsresultat.tsp";
import "./common.tsp";
import "./behandlingslogg.tsp";
import "./forhaandsvarsel.tsp";
import "./journalpost.tsp";

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
  @route("/journalpost/{journalpostId}/dokument/{dokumentInfoId}")
  hentDokument(
    @path @format("uuid") behandlingId: string,
    @path journalpostId: string,
    @path dokumentInfoId: string,
  ): SuccessResponse<bytes> | ErrorResponse;

  @get
  @route("/{dokumentType}/gjeldende")
  hentDokumentInfo(
    @path @format("uuid") behandlingId: string,
    @path dokumentType: DokumentType
  ): SuccessResponse<DokumentInfo> | ErrorResponse;

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
    @path @format("uuid") behandlingId: string,
  ): SuccessResponse<Beregningsresultat> | ErrorResponse;

  @post
  @route("/foreslå-vedtak")
  foreslaaVedtak(
    @path @format("uuid") behandlingId: string,
  ): SuccessResponse<void> | ErrorResponse;

  @get
  @route("/behandlingslogg")
  behandlingslogg(
    @path @format("uuid") behandlingId: string,
  ): SuccessResponse<Array<Logginnslag>> | ErrorResponse;

    @get
    @route("/forhåndsvarsel")
    forhandsvarsel(
      @path @format("uuid") behandlingId: string,
    ): SuccessResponse<ForhaandsvarselResponse> | ErrorResponse;

    @post
    @route("/forhåndsvarsel/send-varselbrev")
    sendVarselbrev(
        @path @format("uuid") behandlingId: string,
        @body sendForhaandsvarsel: SendForhaandsvarsel,
    ): SuccessResponse<void> | ErrorResponse;

    @post
    @route("/forhåndsvarsel/uttalelse")
    lagreBrukersuttalelse(
        @path @format("uuid") behandlingId: string,
        @body uttalelse: Uttalelse,
    ): SuccessResponse<void> | ErrorResponse;

    @put
    @route("/forhåndsvarsel/utsett-frist")
    @parameterVisibility(Lifecycle.Update)
    utsettUttalelsesfrist(
  @path @format("uuid") behandlingId: string,
      @body utsettFrist:Update<Uttalelsesfrist>,
    ): SuccessResponse<Uttalelsesfrist> | ErrorResponse;

    @post
    @route("/forhåndsvarsel/unntak")
    lagreForhaandsvarselUnntak(
        @path @format("uuid") behandlingId: string,
        @body unntak: Unntak,
    ): SuccessResponse<void> | ErrorResponse;

    @post
    @route("/vilkårsvurdering/splitt")
    splittPeriode(
        @path @format("uuid") behandlingId: string,
        @body splittFra: plainDate,
    ): SuccessResponse<void> | ErrorResponse;

    @get
    @route("/vilkårsvurdering/perioder")
    vilkaarsvurderingsperioder(
        @path @format("uuid") behandlingId: string,
    ): SuccessResponse<Array<Periode>> | ErrorResponse;
}

@error
model Error {
  tittel: string;
  melding: string;
}
