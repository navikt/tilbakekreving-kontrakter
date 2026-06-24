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

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["RotElementDto", "RotElementUpdateItemDto"]
)
model UnderavsnittElement {
    tittel: string;
    underavsnitt: Element[];
}
