import "@typespec/http";

using Http;

interface VedtaksbrevApi {
    @post
    @route("/vedtaksbrev/svg")
    lagSvgVedtaksbrev(@body body: VedtaksbrevData): bytes;
}

model VedtaksbrevData {
    hovedavsnitt: Hovedavsnitt;
    avsnitt: Avsnitt[];
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

model RentekstElement {
    @minLength(3)
    @maxLength(3000)
    tekst: string;
}

model UnderavsnittElement {
    tittel: string;
    underavsnitt: Element[];
}

model Brevmottaker {
    fullName: string;
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
