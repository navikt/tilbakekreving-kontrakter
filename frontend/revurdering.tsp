model TilbakekrevingRevurdering{
    revurderingsarsak: TilbakekrevingRevurderingsarsak;
    fagsakdId: string;
    fagsystem: string;
}

enum TilbakekrevingRevurderingsarsak {
    REVURDERING_ANNEN_ÅRSAK
}