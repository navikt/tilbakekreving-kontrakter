import "../brev/vedtaksbrev.tsp";

model Vedtaksbrev {
    innledning: Element[];
    perioder: VedtaksbrevPeriode[];
    brevGjelder: Brevmottaker;
    ytelse: Ytelse;
    signatur: Signatur;
}

model VedtaksbrevPeriode {
    ...Periode;
    beskrivelse: Element[];
    konklusjon: Element[];
    vurderinger: VedtaksbrevVurdering[];
}

model VedtaksbrevVurdering {
    tittel: string;
    beskrivelse: Element[];
}
