model TilbakekrevingRevurdering{
    revurderingsarsak: TilbakekrevingRevurderingsarsak;
}

model OpprettRevurderingResponse {
    url: string;
}

enum TilbakekrevingRevurderingsarsak {
    REVURDERING_ANNEN_ÅRSAK
}