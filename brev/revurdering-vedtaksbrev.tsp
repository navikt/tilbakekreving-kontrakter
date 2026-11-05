import "@typespec/http";
import "@typespec/openapi";
import "./felles.tsp";

namespace Tilbakekreving;

model RevurderingVedtaksbrevData{
    hovedavsnitt: HovedavsnittRevurderingVedtaksbrev;
    brevGjelder: Brevmottaker;
    signatur: Signatur;
    sendtDato: string;
    saksnummer: string;
}

model HovedavsnittRevurderingVedtaksbrev {
    @minLength(3)
    @maxLength(300)
    tittel: string;

    innhold: Array<string>;
}
