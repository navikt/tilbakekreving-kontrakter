import "./common.tsp";

model FaktaOmFeilutbetaling {
    feilutbetaling: Feilutbetaling;
    tidligereVarsletBeløp: uint32 | null;
    muligeRettsligGrunnlag: Array<MuligeRettsligGrunnlag>;
    perioder: Array<FaktaPeriode>;
    vurdering: Vurdering;
}

model Feilutbetaling {
    beløp: uint32;
    ...Periode;
    revurdering: Revurdering;
}

model Revurdering {
    årsak: string;
    vedtaksdato: plainDate;
    resultat: string;
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
    årsak: string;
    oppdaget: Oppdaget;
}

model Oppdaget {
    dato: plainDate | null;
    av: "NAV" | "BRUKER" | "IKKE_VURDERT";
    beskrivelse: string | null;
}
