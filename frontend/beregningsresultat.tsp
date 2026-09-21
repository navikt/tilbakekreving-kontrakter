import "./common.tsp";

enum BeregningsresultatVurdering {
    GodTro,
    Forsett,
    Uaktsomhet,
    GrovUaktsomhet,
    BurdeForstått,
    Forstod,
    Foreldet,
}

enum Vedtaksresultat {
    IngenTilbakebetaling,
    DelvisTilbakebetaling,
    FullTilbakebetaling,
}

model Beregningsresultatsperiode {
    ...Periode;
    feilutbetaltBeløp: uint32;
    beløpIbehold: uint32 | null;
    vurdering: BeregningsresultatVurdering;
    reduksjonprosent: uint32 | null;
    renteprosent: uint32 | null;
    skattebeløp: uint32;
    tilbakekrevingsbeløp: uint32;
}

model Beregningsresultat {
    beregningsresultatsperioder: Array<Beregningsresultatsperiode>;
    vedtaksresultat: Vedtaksresultat;
}
