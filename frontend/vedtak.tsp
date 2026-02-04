import "../brev/vedtaksbrev.tsp";

model Vedtaksbrev {
    innledning: string;
    perioder: VedtaksbrevPeriode[];
    brevGjelder: Brevmottaker;
    ytelse: Ytelse;
    signatur: Signatur;
}

model VedtaksbrevPeriode {
    fom: string;
    tom: string;
    beskrivelse: Element[];
    konklusjon: Element[];
    vurderinger: VedtaksbrevVurdering[];
}

model VedtaksbrevVurdering {
    tittel: string;
    beskrivelse: Element[];
}
