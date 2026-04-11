model Forhaandsvarsel {
    skalForhaandsvarsles: SkalForhaandsvarsles;
    forhåndsvarseErSendt: ForhaandsvarseErSendt | null;
    forhaandsvarselUnntak: ForhaandsvarselUnntak | null;
}

model SkalForhaandsvarsles {
    svarAlternativer: Array<SvarAlternativ>;
    valgtAlternativ: SvarAlternativ | null;
}

model ForhaandsvarseErSendt {
    forhåndsvarselinfo: Forhaandsvarselinfo;
    brukeruttalelse: Brukersuttalelse;
    uttalelsesfrist: Uttalelsesfrist;
}

model SendForhaandsvarsel {
    tekstFraSaksbehandler: string;
}

model Forhaandsvarselinfo {
    tekstFraSaksbehandler: string;
    varselbrevSendtTid: plainDate;
}

model Brukersuttalelse {
    svarAlternativer: Array<SvarAlternativ>;
    harBrukerUttaltSeg: UttalelseVurdering | null;
    uttalelsesdetaljer: Array<Uttalelsesdetaljer>;
    kommentar: string | null;
}

model Uttalelsesdetaljer {
    uttalelsesdato: plainDate;
    hvorBrukerenUttalteSeg: string;
    uttalelseBeskrivelse: string;
}

model Uttalelsesfrist {
    opprinneligFrist: plainDate;
    nyFrist: plainDate | null;
    begrunnelse: string | null;
}

model ForhaandsvarselUnntak {
    begrunnelseForUnntak: VarslingsUnntak;
    beskrivelse: string;
}

model LagreUttalelse {
    harBrukerUttaltSeg: UttalelseVurdering;
    uttalelsesdetaljer: Array<Uttalelsesdetaljer> | null;
    kommentar: string | null;
}

model UtsettFrist {
    nyFrist: plainDate;
    begrunnelse: string;
}

enum SvarAlternativ {
    JA,
    Nei,
}

enum UttalelseVurdering {
    JA_ETTER_FORHÅNDSVARSEL,
    NEI_ETTER_FORHÅNDSVARSEL,
    UNNTAK_ALLEREDE_UTTALT_SEG,
    UNNTAK_INGEN_UTTALELSE,
}

enum VarslingsUnntak {
    IKKE_PRAKTISK_MULIG,
    UKJENT_ADRESSE_ELLER_URIMELIG_ETTERSPORING,
    ÅPENBART_UNØDVENDIG,
}
