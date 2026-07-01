model VarselbrevTekst{
    overskrift: string;
    avsnitter: Array<Section>;
}

model Section {
    tittel: string;
    body: Array<string>;
}
