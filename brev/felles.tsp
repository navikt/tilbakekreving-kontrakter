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

model SignaturAutomatisk {
    enhetNavn: string;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["RotElementDto", "RotElementUpdateItemDto"]
)
model UnderavsnittElement {
    tittel: string;
    underavsnitt: Element[];
}
