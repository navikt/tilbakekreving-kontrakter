model DokumentInfo {
    brevSendt: plainDate;
    journalpostId: string;
    dokumentId: string;
    uttalelsesfrist: plainDate;
}

enum DokumentType {
    VARSELBREV,
    VEDTAKSBREV,
}
