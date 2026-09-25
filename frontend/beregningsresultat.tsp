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
    vurdering: BeregningsresultatVurdering;
    beløpIBehold: uint32 | null;
    reduksjon: uint32 | null;
    rentebeløp: uint32;
    skattebeløp: uint32;
    tilbakekrevingsbeløp: uint32;
}

model Beregningsresultat {
    beregningsresultatsperioder: Array<Beregningsresultatsperiode>;
    vedtaksresultat: Vedtaksresultat;
    totaltFeilutbetaltBeløp: uint32;
    totaltBeløpIBehold: uint32;
    totaltReduksjon: uint32;
    totaltRentebeløp: uint32;
    totaltSkattebeløp: uint32;
    totaltTilbakekrevingsbeløp: uint32;
}
