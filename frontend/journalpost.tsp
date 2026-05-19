model DokumentInfo {
    journalpostId: string | null;
    dokumentId: string | null;
}

enum DokumentType {
    VARSELBREV,
    VEDTAKSBREV,
}
