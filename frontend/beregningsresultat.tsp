import "./common.tsp";

enum BeregningsresultatVurdering {
    GodTro,
    Forsett,
    Uaktsomhet,
    GrovUaktsomhet,
}

enum Vedtaksresultat {
    IngenTilbakebetaling,
    DelvisTilbakebetaling,
    FullTilbakebetaling,
}

model Beregningsresultatsperiode {
    ...Periode;
    feilutbetaltBeløp: uint32;
    vurdering: BeregningsresultatVurdering;
    andelAvBeløp: uint32 | null;
    renteprosent: uint32 | null;
    tilbakekrevingsbeløp: uint32;
    tilbakekrevesBeløpEtterSkatt: uint32;
}

model Beregningsresultat {
    beregningsresultatsperioder: Array<Beregningsresultatsperiode>;
    vedtaksresultat: Vedtaksresultat;
}
