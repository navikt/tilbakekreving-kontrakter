import "@typespec/http";
import "@typespec/openapi";

using Http;

interface VedtaksbrevApi {
    @post
    @route("/vedtaksbrev/svg")
    lagSvgVedtaksbrev(@body body: VedtaksbrevData): bytes;
}

model VedtaksbrevRedigerbareData {
    hovedavsnitt: Hovedavsnitt;
    avsnitt: Avsnitt[];
}

model VedtaksbrevData {
    ...VedtaksbrevRedigerbareData;
    brevGjelder: Brevmottaker;
    sendtDato: string;
    ytelse: Ytelse;
    signatur: Signatur;
}

model Hovedavsnitt {
    @minLength(3)
    @maxLength(300)
    tittel: string;

    underavsnitt: RotElement[];
}

model Avsnitt {
    @minLength(3)
    @maxLength(300)
    tittel: string;

    @format("uuid")
    id: string;

    underavsnitt: RotElement[];
}

@discriminated(#{ discriminatorPropertyName: "type", envelope: "none" })
union RotElement {
    rentekst: RentekstElement,
    underavsnitt: UnderavsnittElement,
}

@discriminated(#{ discriminatorPropertyName: "type", envelope: "none" })
union Element {
    rentekst: RentekstElement,
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["RotElementDto"])
model RentekstElement {
    @minLength(3)
    @maxLength(3000)
    tekst: string;
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["RotElementDto"])
model UnderavsnittElement {
    tittel: string;
    underavsnitt: Element[];
}

model Brevmottaker {
    navn: string;
    personIdent: string;
}

model Ytelse {
    url: string;
    ubestemtEntall: string;
    bestemtEntall: string;
}

model Signatur {
    enhetNavn: string;
    ansvarligSaksbehandler: string;
    besluttendeSaksbehandler: string | null;
}
