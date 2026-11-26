import "@typespec/http";

using Http;

model Dokument {
    @header contentType: "application/pdf";
    @body body: bytes;
}

model DokumentInfo {
    brevSendt: plainDate;
    journalpostId: string;
    dokumentId: string;
}

enum DokumentType {
    VARSELBREV,
    VEDTAKSBREV,
}
