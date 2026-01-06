import "./common.tsp";

model FaktaOmFeilutbetaling {
    feilutbetaling: Feilutbetaling;
    tidligereVarsletBeløp: uint32 | null;
    muligeRettsligGrunnlag: Array<MuligeRettsligGrunnlag>;
    perioder: Array<FaktaPeriode>;
    vurdering: Vurdering;
    ferdigvurdert: boolean;
}

model Feilutbetaling {
    beløp: uint32;
    ...Periode;
    revurdering: Revurdering;
}

model Revurdering {
    årsak: string;
    vedtaksdato: plainDate;
    resultat: "INNVILGET" | "OPPHØRT";
}

model MuligeRettsligGrunnlag {
    bestemmelse: BestemmelseEllerGrunnlag;
    grunnlag: Array<BestemmelseEllerGrunnlag>;
}

model BestemmelseEllerGrunnlag {
    nøkkel: string;
    beskrivelse: string;
}

model FaktaPeriode {
    id: string;
    ...Periode;
    feilutbetaltBeløp: uint32;
    splittbarePerioder: Array<OmitProperties<
        FaktaPeriode,
        "splittbarePerioder"
    >>;
    rettsligGrunnlag: Array<RettsligGrunnlag>;
}

model RettsligGrunnlag {
    bestemmelse: string;
    grunnlag: string;
}

model Vurdering {
    @minLength(3)
    @maxLength(3000)
    årsak?: string;
    oppdaget?: Oppdaget;
}

model Oppdaget {
    dato: plainDate | null;
    av: "NAV" | "BRUKER" | "IKKE_VURDERT";
    @minLength(3)
    @maxLength(3000)
    beskrivelse: string | null;
}

model OppdaterFaktaOmFeilutbetaling {
    perioder?: Array<OppdaterFaktaPeriode>;
    vurdering?: Vurdering;
}

model OppdaterFaktaPeriode {
    id: string;
    @minItems(1)
    rettsligGrunnlag: Array<RettsligGrunnlag>;
}
