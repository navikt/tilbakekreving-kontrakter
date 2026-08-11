model Periode {
    @visibility(Lifecycle.Read)
    fom: plainDate;

    @visibility(Lifecycle.Read)
    tom: plainDate;
}

model PeriodeVurdering {
    @format("uuid")
    id: string;

    ...Periode;

    @visibility(Lifecycle.Read)
    tilbakeført?: ArsakTilTilbakeforing;
}

enum ArsakTilTilbakeforing {
    ØktBeløp,
    LavereBeløp,
    NyPeriode,
    EndretPeriode,
    EndretPeriodeOgØktBeløp,
    EndretPeriodeOgLavereBeløp,
}
