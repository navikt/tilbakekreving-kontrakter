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

@discriminated(#{ discriminatorPropertyName: "adressetype", envelope: "none" })
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
    #["HovedmottakerAddresseDto"]
)
model NorskAdresse {
    gate: string;
    postnummer: string;
}

@TypeSpec.OpenAPI.extension(
    "x-kotlin-implements",
    #["HovedmottakerAddresseDto"]
)
model UtenlandskAdresse {
    land: string;
    adresse: string;
}

@discriminated(#{
    discriminatorPropertyName: "tilleggsmottaker",
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

    navn: string;
    adresse: TilleggsmottakerAdresse;
}

@discriminated(#{ discriminatorPropertyName: "adressetype", envelope: "none" })
union TilleggsmottakerAdresse {
    norsk: NorskAdresse,
    utenlandsk: UtenlandskAdresse,
}

@TypeSpec.OpenAPI.extension("x-kotlin-implements", #["TilleggsmottakerDto"])
model Verge {
    @visibility(Lifecycle.Read)
    @format("uuid")
    id: string;

    navn: string;
}
