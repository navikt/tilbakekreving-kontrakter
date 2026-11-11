model Hendelse {
    tittel: string;
    opprettet: plainDate;
    rolle: Rolle;
    dokumentUrl: string | null;
    rolleIdent: string | null;
    beskrivelse: string | null;
    utsettelseFrist: plainDate | null;
}

enum Rolle {
    SAKSBEHANDLER,
    BESLUTTER,
    VEDTAKSLØSNING,
}
