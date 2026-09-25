model DokumentInfo {
    brevSendt: plainDate;
    journalpostId: string;
    dokumentId: string;
}

enum DokumentType {
    VARSELBREV,
    VEDTAKSBREV,
}
