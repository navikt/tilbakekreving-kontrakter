model Fakta {
    perioder: Array<FaktaPeriode>;
}

model FaktaPeriode {
    id: string;
    fom: utcDateTime;
    tom: utcDateTime;
    feilutbetaltBeløp: uint32;
    splittbarePerioder: Array<OmitProperties<FaktaPeriode, "splittbarePerioder">>;
    rettsligGrunnlag: Array<RettsligGrunnlag>;
}

model RettsligGrunnlag {
    bestemmelse: BestemmelseEllerGrunnlag;
    grunnlag: BestemmelseEllerGrunnlag;
}

model BestemmelseEllerGrunnlag {
    nøkkel: string;
    beskrivelse: string;
}

model DetaljerOmFeilutbetaling {
    årsak: string;
    oppdaget: Oppdaget;
}

model Oppdaget {
    dato: utcDateTime;
    av: "NAV" | "BRUKER";
    beskrivelse: string;
}
