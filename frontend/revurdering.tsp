model TilbakekrevingRevurdering{
    revurderingsarsak: TilbakekrevingRevurderingsarsak;
}

enum TilbakekrevingRevurderingsarsak {
   REVURDERING_KLAGE_NFP,
   REVURDERING_KLAGE_KA,
   REVURDERING_OPPLYSNINGER_OM_VILKÅR,
   REVURDERING_OPPLYSNINGER_OM_FORELDELSE,
   REVURDERING_FEILUTBETALT_BELØP_HELT_ELLER_DELVIS_BORTFALT
}