model SaksbehandlingSteg {
    @visibility(Lifecycle.Read)
    tilbakeført?: ArsakTilTilbakeforing;
    @visibility(Lifecycle.Read)
    ferdigvurdert: boolean;
}

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
    endringIKravgrunnlag?: KravgrunnlagForskjell;
}

@discriminated(#{ discriminatorPropertyName: "type", envelope: "none" })
union KravgrunnlagForskjell {
    ny_periode: NyPeriode,
    endret_periode: EndretPeriode,
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["KravgrunnlagForskjellDto"]
)
model NyPeriode {
    ...Periode;
    beløp: uint32;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["KravgrunnlagForskjellDto"]
)
model EndretPeriode {
    ...Periode;
    gammelPeriode: Periode;
    nyttBeløp: uint32;
    gammeltBeløp: uint32;
}

enum ArsakTilTilbakeforing {
    NyttKravgrunnlag,
    TilbakemeldingFraSaksbehandler,
}
