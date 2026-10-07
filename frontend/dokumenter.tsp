import "@typespec/http";

using Http;

alias VedtakId = string;

model Vedtaksdokument {
    journalpostId: string;
    dokumentInfoId: string;
}

enum RessursStatus {
    SUKSESS,
    FEILET,
    IKKE_HENTET,
    IKKE_TILGANG,
    FUNKSJONELL_FEIL,
}

model Ressurs<T> {
    data: T | null;
    status: RessursStatus;
    melding: string;
    frontendFeilmelding?: string | null;
    stacktrace: string | null;
}

alias RessursSuccessResponse<Body> = {
    @body body: Ressurs<Body>;
};

alias RessursErrorResponse<Body> = {
    @statusCode statusCode: 400 | 401 | 403;
    @body body: Ressurs<Body>;
};

interface VedtaksdokumentApi {
    @get
    @route("/api/dokumenter/vedtak/{vedtakId}/v1")
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
        @pattern("^[0-9]{1,64}$")
        vedtakId: VedtakId,
    ):
        | RessursSuccessResponse<Array<Vedtaksdokument>>
        | RessursErrorResponse<Array<Vedtaksdokument>>;
}
