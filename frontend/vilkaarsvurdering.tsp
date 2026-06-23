model PeriodeInfo {
    @format("uuid")
    periodeId: string;

    periode: Periode;
}

model SplittPeriode {
    @format("uuid")
    vilkårsvurderingId: string;
}

model Sammenslaaing {
    @format("uuid")
    vilkårsvurderingId: string;

    @format("uuid")
    slåesSammenMedId: string;
}

model Vilkaar {
    vilkårsperioder: Array<Vilkaarsperiode>;

    @visibility(Lifecycle.Read)
    ferdigvurdert: boolean;

    @visibility(Lifecycle.Read)
    momenterSærligeGrunner: Array<Moment>;

    @visibility(Lifecycle.Read)
    momenterReduksjonGodTro: Array<Moment>;
}

model Vilkaarsperiode {
    @format("uuid")
    id: string;

    @visibility(Lifecycle.Read)
    periode: Periode;

    @visibility(Lifecycle.Read)
    delbarePerioder: Array<PeriodeInfo>;

    @visibility(Lifecycle.Read)
    feilutbetaltBeløp: uint32;

    vilkårsvurdering: Vilkaarsvurdering;

    @visibility(Lifecycle.Read)
    delresultat:
        | "FULL_TILBAKEKREVING"
        | "INGEN_TILBAKEKREVING"
        | "DELVIS_TILBAKEKREVING"
        | null;

    @visibility(Lifecycle.Read)
    fakta: Fakta;
}

model Fakta {
    rettsligGrunnlag: Array<string>;
}

@discriminated(#{ discriminatorPropertyName: "vurdering", envelope: "none" })
union Vilkaarsvurdering {
    god_tro: GodTro,
    forårsaket_av_mottaker: ForaarsaketAvMottaker,
    forsto_eller_burde_forstått: ForstoEllerBurdeForstaatt,
    ikke_vurdert: VilkaarsvurderingIkkeVurdert,
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["VilkaarsvurderingDto", "VilkaarsvurderingUpdateDto"]
)
model GodTro {
    begrunnelse: string;
    beløpIBehold: BelopIBehold;
}

@discriminated(#{ discriminatorPropertyName: "belopIBehold", envelope: "none" })
union BelopIBehold {
    ingenting: Ingenting,
    hele: Hele,
    deler: Deler,
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["BelopIBeholdDto", "BelopIBeholdUpdateDto"]
)
model Ingenting {
    begrunnelse: string;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["BelopIBeholdDto", "BelopIBeholdUpdateDto"]
)
model Hele {
    begrunnelse: string;
    reduksjon: Reduksjon;
}

@discriminated(#{ discriminatorPropertyName: "reduksjon", envelope: "none" })
union Reduksjon {
    skalReduseres: SkalReduseres,
    skalIkkeReduseres: SkalIkkeReduseres,
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["ReduksjonDto", "ReduksjonUpdateDto"]
)
model SkalIkkeReduseres {
    relevans: Array<Moment>;
    begrunnelse: string;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["ReduksjonDto", "ReduksjonUpdateDto"]
)
model SkalReduseres {
    beløp: uint32;
    relevans: Array<Moment>;
    begrunnelse: string;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["BelopIBeholdDto", "BelopIBeholdUpdateDto"]
)
model Deler {
    beløp: uint32;
    begrunnelse: string;
    reduksjon: Reduksjon;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["VilkaarsvurderingDto", "VilkaarsvurderingUpdateDto"]
)
model ForaarsaketAvMottaker {
    begrunnelse: string;
    aktsomhet: Aktsomhet;
}

@discriminated(#{ discriminatorPropertyName: "aktsomhet", envelope: "none" })
union Aktsomhet {
    uaktsomt: Uaktsomt,
    grovtUaktsomt: GrovtUaktsomt,
    forsettlig: Forsettlig,
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["AktsomhetDto", "AktsomhetUpdateDto"]
)
model Uaktsomt {
    begrunnelse: string;
    unnlatelse: Unnlatelse;
}

@discriminated(#{ discriminatorPropertyName: "unnlatelse", envelope: "none" })
union Unnlatelse {
    skalUnnlates: SkalUnnlates,
    skalIkkeUnnlates: SkalIkkeUnnlates,
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["UnnlatelseDto", "UnnlatelseUpdateDto"]
)
model SkalUnnlates {
    begrunnelse: string;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["UnnlatelseDto", "UnnlatelseUpdateDto"]
)
model SkalIkkeUnnlates {
    begrunnelse: string;
    erDetSærligeGrunner: SaerligeGrunner;
}

@discriminated(#{
    discriminatorPropertyName: "erDetSaerligeGrunner",
    envelope: "none",
})
union SaerligeGrunner {
    nei: NeiSaerligeGrunner,
    ja: JaSaerligeGrunner,
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["SaerligeGrunnerDto", "SaerligeGrunnerUpdateDto"]
)
model NeiSaerligeGrunner {
    særligeGrunnerMot: Array<Moment>;
    begrunnelse: string;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["SaerligeGrunnerDto", "SaerligeGrunnerUpdateDto"]
)
model JaSaerligeGrunner {
    særligeGrunnerFor: Array<Moment>;
    prosentReduksjon: uint8;
    begrunnelse: string;

    @visibility(Lifecycle.Read)
    simulertBeløp: uint32;
}

model Moment {
    moment: string;

    @visibility(Lifecycle.Read)
    beskrivelse: string;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["AktsomhetDto", "AktsomhetUpdateDto"]
)
model GrovtUaktsomt {
    begrunnelse: string;
    erDetSærligeGrunner: SaerligeGrunner;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["AktsomhetDto", "AktsomhetUpdateDto"]
)
model Forsettlig {
    begrunnelse: string;
}

/* TODO */
@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["VilkaarsvurderingDto", "VilkaarsvurderingUpdateDto"]
)
model ForstoEllerBurdeForstaatt {}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["VilkaarsvurderingDto"])
model VilkaarsvurderingIkkeVurdert {}
