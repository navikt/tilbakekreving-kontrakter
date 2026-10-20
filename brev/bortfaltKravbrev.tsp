import "@typespec/http";
import "@typespec/openapi";
import "./felles.tsp";

using Http;

interface BortfaltKravbrevApi {
    @post
    @route("/bortfalt-krav/svg")
    @parameterVisibility(Lifecycle.Create)
    lagSvgBortfaltKravbrev(@body body: BortfaltKravbrevData): bytes;
}

model BortfaltKravbrevData {
    hovedavsnitt: HovedavsnittBortfaltKravbrev;
    underavsnitt: Array<UnderavsnittElement>;
    brevGjelder: Brevmottaker;
    signatur: SignaturAutomatisk;
    sendtDato: string;
    saksnummer: string;
}

model HovedavsnittBortfaltKravbrev {
    @minLength(3)
    @maxLength(300)
    tittel: string;

    innhold: Array<string>;
}
