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

    @visibility(Lifecycle.Read)
    erUnder4xRettsgebyr: boolean;
}

model Vilkaarsperiode {
    @visibility(Lifecycle.Read)
    feilutbetaltBeløp: uint32;

    @visibility(Lifecycle.Read)
    delresultat:
        | "FULL_TILBAKEKREVING"
        | "INGEN_TILBAKEKREVING"
        | "DELVIS_TILBAKEKREVING"
        | null;

    @visibility(Lifecycle.Read)
    fakta: Fakta;

    @visibility(Lifecycle.Read)
    simulertBeløp: uint32 | null;

    vilkårsvurdering: Vilkaarsvurdering;
}

model Fakta {
    rettsligGrunnlag: Array<string>;
}

model Vilkaarsvurdering is PeriodeVurdering {
    @visibility(Lifecycle.Read)
    delbarePerioder: Array<PeriodeInfo>;

    valg: VilkaarsvurderingValg;
}

@discriminated(#{ discriminatorPropertyName: "vurdering", envelope: "none" })
union VilkaarsvurderingValg {
    god_tro: GodTro,
    forårsaket_av_mottaker: ForaarsaketAvMottaker,
    forsto_eller_burde_forstått: ForstoEllerBurdeForstaatt,
    ikke_vurdert: VilkaarsvurderingIkkeVurdert,
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["VilkaarsvurderingValgDto"]
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

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["BelopIBeholdDto"])
model Ingenting {
    begrunnelse: string;
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["BelopIBeholdDto"])
model Hele {
    begrunnelse: string;
    reduksjon: Reduksjon;
}

@discriminated(#{ discriminatorPropertyName: "reduksjon", envelope: "none" })
union Reduksjon {
    skalReduseres: SkalReduseres,
    skalIkkeReduseres: SkalIkkeReduseres,
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["ReduksjonDto"])
model SkalIkkeReduseres {
    relevans: Array<Moment>;
    annetBegrunnelse: string | null;
    begrunnelse: string;
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["ReduksjonDto"])
model SkalReduseres {
    beløp: uint32;
    relevans: Array<Moment>;
    annetBegrunnelse: string | null;
    begrunnelse: string;
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["BelopIBeholdDto"])
model Deler {
    beløp: uint32;
    begrunnelse: string;
    reduksjon: Reduksjon;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["VilkaarsvurderingValgDto"]
)
model ForaarsaketAvMottaker {
    aktsomhet: Aktsomhet;
}

@discriminated(#{ discriminatorPropertyName: "aktsomhet", envelope: "none" })
union Aktsomhet {
    uaktsomt: Uaktsomt,
    grovtUaktsomt: GrovtUaktsomt,
    forsettlig: Forsettlig,
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["AktsomhetDto"])
model Uaktsomt {
    begrunnelse: string;
    unnlatelse: Unnlatelse;
}

@discriminated(#{ discriminatorPropertyName: "unnlatelse", envelope: "none" })
union Unnlatelse {
    skalUnnlates: SkalUnnlates,
    skalIkkeUnnlates: SkalIkkeUnnlates,
    ikkeAktuelt: IkkeAktuelt,
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["UnnlatelseDto"])
model SkalUnnlates {
    begrunnelse: string;
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["UnnlatelseDto"])
model SkalIkkeUnnlates {
    begrunnelse: string;
    erDetSærligeGrunner: SaerligeGrunner;
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["UnnlatelseDto"])
model IkkeAktuelt {
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

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["SaerligeGrunnerDto"])
model NeiSaerligeGrunner {
    særligeGrunnerMot: Array<Moment>;
    begrunnelse: string;
    annetBegrunnelse: string | null;
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["SaerligeGrunnerDto"])
model JaSaerligeGrunner {
    særligeGrunnerFor: Array<Moment>;
    prosentReduksjon: uint8;
    begrunnelse: string;
    annetBegrunnelse: string | null;
}

model Moment {
    moment: string;

    @visibility(Lifecycle.Read)
    beskrivelse: string;
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["AktsomhetDto"])
model GrovtUaktsomt {
    begrunnelse: string;
    erDetSærligeGrunner: SaerligeGrunner;
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["AktsomhetDto"])
model Forsettlig {
    begrunnelse: string;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["VilkaarsvurderingValgDto"]
)
model ForstoEllerBurdeForstaatt {
    forståelse: Forstaaelse;
}

@discriminated(#{ discriminatorPropertyName: "forståelse", envelope: "none" })
union Forstaaelse {
    forsto: Forsto,
    burdeForstått: BurdeForstaatt,
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["ForstaaelseDto"])
model Forsto {
    begrunnelse: string;
    unnlatelse: Unnlatelse;
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["ForstaaelseDto"])
model BurdeForstaatt {
    begrunnelse: string;
    unnlatelse: Unnlatelse;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["VilkaarsvurderingValgDto"]
)
model VilkaarsvurderingIkkeVurdert {}
