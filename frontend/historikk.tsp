model Hendelse {
    tittel: string;
    opprettet: utcDateTime;
    rolle: Rolle;
    rolleIdent: string | null;
    beskrivelse: string | null;
    ekstraInfo: Record<string>;
}

enum Rolle {
    SAKSBEHANDLER,
    BESLUTTER,
    VEDTAKSLØSNING,
}
