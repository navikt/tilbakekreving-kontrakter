import "@typespec/http";
import "@typespec/openapi";
import "./felles.tsp";

using Http;

interface VarselbrevApi {
    @post
    @route("/varselbrev/svg")
    @parameterVisibility(Lifecycle.Create)
    lagSvgVarselbrev(@body body: VarselbrevData): bytes;

}

model VarselbrevData{
    hovedavsnitt: HovedavsnittVarselbrev;
    underavsnitt: Array<UnderavsnittElement>;
    brevGjelder: Brevmottaker;
    signatur: Signatur;
    sendtDato: plainDate;
}

model HovedavsnittVarselbrev {
    @minLength(3)
    @maxLength(300)
    tittel: string;
    innhold: Array<string>;
}
