using Http;

interface BrevmottakerApi {
    @get
    @route("/{tilbakekrevingId}/brevmottakere")
    hentBrevmottakere(@path tilbakekrevingId: string):
        | SuccessResponse<Brevmottakere>
        | ErrorResponse;

    @put
    @route("/{tilbakekrevingId}/brevmottakere")
    endreBrevmottaker(
        @path tilbakekrevingId: string,
        @body brevmottaker: OptionalProperties<Brevmottaker>,
    ): SuccessResponse<Brevmottakere> | ErrorResponse;

    @delete
    @route("/{tilbakekrevingId}/brevmottakere/{brevmottakerId}")
    slettBrevmottaker(
        @path tilbakekrevingId: string,
        @path @format("uuid") brevmottakerId: string,
    ): SuccessResponse<Brevmottakere> | ErrorResponse;

    @get
    @route("/brevmottakere/poststeder")
    hentPoststeder(): SuccessResponse<Record<string>>;
}

model Brevmottakere {
    hovedmottaker: HovedmottakerAddresse;
    tilleggsmottaker: Tilleggsmottaker | null;
}

@discriminated(#{ discriminatorPropertyName: "addressetype", envelope: "none" })
union HovedmottakerAddresse {
    freg: FregAdresse,
    norsk: NorskAdresse,
    utenlandsk: UtenlandskAdresse,
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["HovedmottakerAddresseDto"]
)
model FregAdresse {}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["HovedmottakerAddresseDto", "ManuellMottakerDto"]
)
model NorskAdresse {
    gate: string;
    postnummer: string;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["HovedmottakerAddresseDto", "ManuellMottakerDto"]
)
model UtenlandskAdresse {
    land: string;
    adresse: string;
}

@discriminated(#{
    discriminatorPropertyName: "tilleggsmottakerType",
    envelope: "none",
})
union Tilleggsmottaker {
    fullmektig: Fullmektig,
    verge: Verge,
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["TilleggsmottakerDto"])
model Fullmektig {
    @visibility(Lifecycle.Read)
    @format("uuid")
    id: string;

    mottaker: FullmektigMottaker;
}

@discriminated(#{ discriminatorPropertyName: "mottakerType", envelope: "none" })
union FullmektigMottaker {
    manuell: ManuellAdresse,
    organisasjon: Organisasjon,
    person: Person,
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["TilleggsmottakerDto"])
model Verge {
    @visibility(Lifecycle.Read)
    @format("uuid")
    id: string;

    mottaker: VergeMottaker;
}

@discriminated(#{ discriminatorPropertyName: "mottakerType", envelope: "none" })
union VergeMottaker {
    manuell: ManuellAdresse,
    person: Person,
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["FullmektigMottakerDto", "VergeMottakerDto"]
)
model ManuellAdresse {
    navn: string;
    mottaker: ManuellMottaker;
}

@discriminated(#{ discriminatorPropertyName: "adressetype", envelope: "none" })
union ManuellMottaker {
    norsk: NorskAdresse,
    utenlandsk: UtenlandskAdresse,
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["FullmektigMottakerDto"])
model Organisasjon {
    navn: string | null;

    @visibility(Lifecycle.Read)
    organisasjonsnavn: string;

    organisasjonsnummer: string;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["FullmektigMottakerDto", "VergeMottakerDto"]
)
model Person {
    @visibility(Lifecycle.Read)
    navn: string;

    ident: string;
}
