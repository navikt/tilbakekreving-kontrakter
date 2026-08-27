import "@typespec/openapi";
import "./common.tsp";

model ForhaandsvarselResponse {
    forhaandsvarselSteg: ForhaandsvarselSteg;
    brukeruttalelse: Uttalelse | null;
}

@discriminated(#{ discriminatorPropertyName: "type", envelope: "none" })
union ForhaandsvarselSteg {
  ikke_vurdert: IkkeVurdert,
  sendt: ForhaandsvarselErSendt,
  unntak: ForhaandsvarselUnntak,
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["ForhaandsvarselStegDto"]
)
model IkkeVurdert{}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["ForhaandsvarselStegDto"]
)
model ForhaandsvarselErSendt is SaksbehandlingSteg {
    forhåndsvarselInfo: ForhaandsvarselInfo;
    uttalelsesfrist: Uttalelsesfrist;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["ForhaandsvarselStegDto"]
)
model ForhaandsvarselUnntak is SaksbehandlingSteg {
    begrunnelseForUnntak: Varslingsunntak;
    beskrivelse: string;
}

model ForhaandsvarselInfo {
    tekstFraSaksbehandler: string;
    varselbrevSendtTid: plainDate;
}

model Uttalelse {
    harBrukerUttaltSeg: UttalelseVurdering;
    uttalelsesdato?: plainDate;
    hvorBrukerenUttalteSeg?: string;
    beskrivelse?: string;
}

model Uttalelsesfrist {
    nyFrist?: plainDate;
    begrunnelse?: string;

    @visibility(Lifecycle.Read)
    opprinneligFrist: plainDate;
}

model SendForhaandsvarsel {
    tekstFraSaksbehandler: string;
}

model Unntak {
    begrunnelseForUnntak: Varslingsunntak;
    beskrivelse: string;
}

enum UttalelseVurdering {
    JA_ETTER_FORHÅNDSVARSEL,
    NEI_ETTER_FORHÅNDSVARSEL,
    UNNTAK_ALLEREDE_UTTALT_SEG,
    UNNTAK_INGEN_UTTALELSE,
    IKKE_VURDERT,
}

enum Varslingsunntak {
    IKKE_PRAKTISK_MULIG,
    UKJENT_ADRESSE_ELLER_URIMELIG_ETTERSPORING,
    ÅPENBART_UNØDVENDIG,
    ALLEREDE_UTTALET_SEG
}
