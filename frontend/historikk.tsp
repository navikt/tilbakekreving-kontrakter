model Hendelse {
    tittel: string;
    opprettet: utcDateTime;
    rolle: Rolle;
    rolleIdent: string | null;
    beskrivelse: string | null;
    ...Record<string>;
}

enum Rolle {
    SAKSBEHANDLER,
    BESLUTTER,
    VEDTAKSLØSNING,
}
