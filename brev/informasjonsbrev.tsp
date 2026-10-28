import "./felles.tsp";

namespace Tilbakekreving;

model InformasjonsbrevData {
    hovedavsnitt: HovedavsnittInformasjonsbrev;
    underavsnitt: Array<UnderavsnittElement>;
    brevGjelder: Brevmottaker;
    signatur: SignaturAutomatisk;
    sendtDato: string;
    saksnummer: string;
}

model HovedavsnittInformasjonsbrev {
    @minLength(3)
    @maxLength(300)
    tittel: string;

    innhold: Array<string>;
}
