import "@typespec/openapi";
import "./common.tsp";

model ForhaandsvarselResponse is SaksbehandlingSteg {
    forhaandsvarselSteg: ForhaandsvarselSteg;
    brukeruttalelse: UttalelseVurdering | null;
    sendtVarselbrev: DokumentInfo | null;
    uttalelsesfrist: Uttalelsesfrist | null;
}

@discriminated(#{ discriminatorPropertyName: "type", envelope: "none" })
union ForhaandsvarselSteg {
    ikke_vurdert: IkkeVurdert,
    sendt: ForhaandsvarselErSendt,
    unntak: ForhaandsvarselUnntak,
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["ForhaandsvarselStegDto"])
model IkkeVurdert {}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["ForhaandsvarselStegDto"])
model ForhaandsvarselErSendt {
    forhåndsvarselInfo: ForhaandsvarselInfo;
    uttalelsesfrist: Uttalelsesfrist;
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["ForhaandsvarselStegDto"])
model ForhaandsvarselUnntak {
    begrunnelseForUnntak: Varslingsunntak;
    beskrivelse: string;
}

model ForhaandsvarselInfo {
    tekstFraSaksbehandler: string;
    varselbrevSendtTid: plainDate;
}

@discriminated(#{
    discriminatorPropertyName: "harBrukerUttaltSeg",
    envelope: "none",
})
union UttalelseVurdering {
    JA: Brukeruttalelse,
    HAR_TIDLIGERE_VURDERING: TidligereBrukeruttalelse,
    NEI: IngenUttalelse,
    IKKE_VURDERT: BrukeruttalelseIkkeVurdert,
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["UttalelseVurderingDto"])
model Brukeruttalelse {
    uttalelsesdato: plainDate;
    hvorBrukerenUttalteSeg: string;
    beskrivelse: string;
}
@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["UttalelseVurderingDto"])
model TidligereBrukeruttalelse extends Brukeruttalelse {}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["UttalelseVurderingDto"])
model IngenUttalelse {
    kommentar: string;
    beskrivelse: string;
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["UttalelseVurderingDto"])
model BrukeruttalelseIkkeVurdert {}

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

enum Varslingsunntak {
    IKKE_PRAKTISK_MULIG,
    UKJENT_ADRESSE_ELLER_URIMELIG_ETTERSPORING,
    ÅPENBART_UNØDVENDIG,
    ALLEREDE_UTTALET_SEG,
}
