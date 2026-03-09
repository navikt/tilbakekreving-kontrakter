import "./common.tsp";

union BeregningsresultatVurdering {
    godTro: "GOD_TRO",
    forsett: "FORSETT",
    simpelUaktsomhet: "UAKTSOMHET",
    grovUaktsomhet: "GROV_UAKTSOMHET",
}

union Vedtaksresultat {
    ingenTilbakebetaling: "INGEN_TILBAKEBETALING",
    delvisTilbakebetaling: "DELVIS_TILBAKEBETALING",
    fullTilbakebetaling: "FULL_TILBAKEBETALING",
}

model Beregningsresultatsperiode {
    ...Periode;
    feilutbetaltBeløp: uint32;
    vurdering: BeregningsresultatVurdering;
    andelAvBeløp: string;
    renteprosent: string;
    tilbakekrevingsbeløp: uint32;
    tilbakekrevesBeløpEtterSkatt: uint32;
}

model Beregningsresultat {
    beregningsresultatsperioder: Array<Beregningsresultatsperiode>;
    vedtaksresultat: Vedtaksresultat;
    harBrukerUttaltSeg: boolean;
}
