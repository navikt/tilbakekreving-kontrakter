import "./common.tsp";

enum BeregningsresultatVurdering {
    GodTro,
    Forsett,
    SimpelUaktsomhet,
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
    andelAvBeløp: uint32;
    renteprosent: uint32;
    tilbakekrevingsbeløp: uint32;
    tilbakekrevesBeløpEtterSkatt: uint32;
}

model Beregningsresultat {
    beregningsresultatsperioder: Array<Beregningsresultatsperiode>;
    vedtaksresultat: Vedtaksresultat;
}
