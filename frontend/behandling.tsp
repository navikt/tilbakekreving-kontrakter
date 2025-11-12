model Behandling {
    id: string;
    feilutbetaling: Feilutbetaling;
    tidligereVarsletBeløp?: uint32;
}

model Feilutbetaling {
    fullstendigPeriode: Periode;
    beløp: uint32;
}

model Periode {
    fom: utcDateTime;
    tom: utcDateTime;
}
