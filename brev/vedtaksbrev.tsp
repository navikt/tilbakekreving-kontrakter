import "@typespec/http";
import "@typespec/openapi";

using Http;

interface VedtaksbrevApi {
    @post
    @route("/vedtaksbrev/svg")
    @parameterVisibility(Lifecycle.Create)
    lagSvgVedtaksbrev(@body body: VedtaksbrevData): bytes;
}

model VedtaksbrevRedigerbareData {
    hovedavsnitt: Hovedavsnitt;
    avsnitt: Avsnitt[];

    @visibility(Lifecycle.Read)
    sistOppdatert: utcDateTime;
}

model VedtaksbrevData {
    ...VedtaksbrevRedigerbareData;
    brevGjelder: Brevmottaker;
    sendtDato: string;
    ytelse: Ytelse;
    signatur: Signatur;
    oppsummeringstabell: Oppsummeringsdata[];

    @visibility(Lifecycle.Create, Lifecycle.Read)
    bunntekster: Standardtekst[];

    @visibility(Lifecycle.Create, Lifecycle.Read)
    saksnummer: string;
}

model Hovedavsnitt {
    @minLength(3)
    @maxLength(300)
    tittel: string;

    @visibility(Lifecycle.Read)
    forklaring: string;

    underavsnitt: RotElement[];

    @visibility(Lifecycle.Create, Lifecycle.Read)
    hjemler: string;
}

model Avsnitt {
    @minLength(3)
    @maxLength(300)
    tittel: string;

    @visibility(Lifecycle.Read)
    forklaring: string;

    @visibility(Lifecycle.Read)
    meldingerTilSaksbehandler: string[];

    @format("uuid")
    id: string;

    underavsnitt: RotElement[];
}

@discriminated(#{ discriminatorPropertyName: "type", envelope: "none" })
union RotElement {
    rentekst: RentekstElement,
    underavsnitt: UnderavsnittElement,
    påkrevd_begrunnelse: PakrevdBegrunnelse,
}

@discriminated(#{ discriminatorPropertyName: "type", envelope: "none" })
union Element {
    rentekst: RentekstElement,
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["RotElementDto", "RotElementUpdateItemDto"]
)
model RentekstElement {
    @minLength(3)
    @maxLength(3000)
    tekst: string;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["RotElementDto", "RotElementUpdateItemDto"]
)
model UnderavsnittElement {
    tittel: string;
    underavsnitt: Element[];
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["RotElementDto", "RotElementUpdateItemDto"]
)
model PakrevdBegrunnelse {
    @visibility(Lifecycle.Create, Lifecycle.Read)
    tittel: string;

    @visibility(Lifecycle.Read)
    forklaring: string;

    @visibility(Lifecycle.Read)
    meldingerTilSaksbehandler: string[];

    begrunnelseType: string;
    underavsnitt: Element[];
}

model Standardtekst {
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

model Oppsummeringsdata {
    beregnerSkatt: boolean;
    perioder: OppsummertPeriode[];
}

model OppsummertPeriode {
    fom: string;
    tom: string;
    feilutbetaltBeløp: string;
    vurdering: string;
    andelAvBeløp: string;
    renteprosent: string;
    tilbakekrevingsbeløp: string;
    tilbakekrevesBeløpEtterSkatt: string;
}
