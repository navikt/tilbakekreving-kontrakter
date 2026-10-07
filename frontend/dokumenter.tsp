import "@typespec/http";
import "./behandling.tsp";

using Http;

alias VedtakId = string;

model Vedtaksdokument {
    journalpostId: string;
    dokumentInfoId: string;
}

alias VedtaksdokumentErrorResponse = {
    @statusCode statusCode: 400 | 401 | 403;
    @body error: Error;
};

interface VedtaksdokumentApi {
    @get
    @route("/vedtak/{vedtakId}")
    @doc("""
    Henter alle brev for vedtaket. Ta bare med brev som har både journalpostId
    og dokumentInfoId. Samle treff fra flere iverksettelser i gammel og ny modell,
    fjern duplikater, og returner tom liste når det ikke finnes treff.

    Den nye modellen kan hente brev fra flere behandlinger på samme sak.
    Tvangsgrunnlag API kontrollerer koblingen mellom skyldner og vedtakId.
    Familie-tilbake håndterer autentisering og tilgang.

    vedtakId må bestå av 1–64 ASCII-sifre, med en tallverdi på høyst
    9223372036854775807. Innledende nuller er tillatt.
    Returner 400 ved ugyldig vedtakId, 401 ved ugyldig eller manglende
    autentisering og 403 når kalleren mangler tilgang.
    """)
    hentVedtaksdokumenter(
        @path
        @doc("1–64 ASCII-sifre. Innledende nuller er tillatt, og tallverdien kan ikke overstige 9223372036854775807.")
        @minLength(1)
        @maxLength(64)
        @pattern("^[0-9]+$")
        vedtakId: VedtakId,
    ): SuccessResponse<Array<Vedtaksdokument>> | VedtaksdokumentErrorResponse;
}
