import "./behandling.tsp";

model Fagsak {
    id: string;
    gjeldendeBehandling: Behandling;
    revurdering: Revurdering;
}

model Revurdering {
    årsak: string;
    vedtaksdato: plainDate;
    resultat: "INNVILGET" | "OPPHØRT";
}
