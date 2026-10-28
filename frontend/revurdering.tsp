model TilbakekrevingRevurdering {
    revurderingsarsak: TilbakekrevingRevurderingsarsak;
}

model OpprettRevurderingResponse {
    url: string;
}

// Omgjøring av vedtaket om tilbakekreving fordi det feilutbetalte beløpet er endret
// Omgjøring av vedtaket om tilbakekreving etter klage
// Omgjøring av vedtaket om tilbakekreving uten klage (fvl. § 35)
// Endring av kravet på grunn av foreldelse
@discriminated(#{
    discriminatorPropertyName: "revurderingsarsak",
    envelope: "none",
})
union TilbakekrevingRevurderingsarsak {
    feilutbetalt_belop_endret: FeilutbetaltBelopEndret,
    etter_klage: EtterKlage,
    uten_klage: UtenKlage,
    foreldelse: Foreldelse,
}

union Revurderingsinstans {
    "Førsteinstansen",
    "Klageinstansen",
    "Trygderetten",
    "Domstolen",
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["TilbakekrevingRevurderingsarsakDto"])
model FeilutbetaltBelopEndret {
    instans: Revurderingsinstans;
    begrunnelse: string;
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["TilbakekrevingRevurderingsarsakDto"])
model EtterKlage {
    instans: Revurderingsinstans;
    begrunnelse: string;
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["TilbakekrevingRevurderingsarsakDto"])
model UtenKlage {
    instans: "Førsteinstansen" | "Klageinstansen";
    begrunnelse: string;
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["TilbakekrevingRevurderingsarsakDto"])
model Foreldelse {
    begrunnelse: string;
}
