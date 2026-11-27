import "@typespec/http";
import "./behandling.tsp";

using Http;

alias VedtakId = string;

model Vedtaksdokument {
    journalpostId: string;
    dokumentInfoId: string;
}

alias DokumentErrorResponse = {
    @statusCode statusCode: 400 | 401 | 403;
    @body error: Error;
};

interface DokumentApi {
    @useAuth(BearerAuth)
    @get
    @route("/vedtak/{vedtakId}")
    @doc("""
        Henter alle brev for vedtaket. Ta bare med brev som har både journalpostId
        og dokumentInfoId. Returner tom liste når det ikke finnes noen brev.
        
        vedtakId må bestå av 1–64 ASCII-sifre. Innledende nuller er tillatt.
        """)
    hentVedtaksdokumenter(
        @header("Authorization")
        @doc("Bearer-token på formen `Bearer <jwt>`.")
        authorization: string,

        @path
        @doc("1–64 ASCII-sifre. Innledende nuller er tillatt, og tallverdien kan ikke overstige 9223372036854775807.")
        @minLength(1)
        @maxLength(64)
        @pattern("^[0-9]+$")
        vedtakId: VedtakId,
    ): SuccessResponse<Array<Vedtaksdokument>> | DokumentErrorResponse;

    @get
    @route("/journalpost/{journalpostId}/dokument/{dokumentInfoId}")
    hentDokument(
        @path journalpostId: string,
        @path dokumentInfoId: string,
        @header("Behandling-Id") behandlingId?: string,
        @header("Fagsak-Id") fagsakId?: string,
    ): File<"application/pdf"> | DokumentErrorResponse;
}
