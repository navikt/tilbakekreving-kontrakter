import "./common.tsp";

model Logginnslag {
    behandlingId: string;
    type: string;
    aktør: string;
    aktørIdent: string;
    tittel: string;
    tekst: string | null;
    steg: string | null;
    journalpostId: string | null;
    dokumentId: string | null;
    opprettetTid: utcDateTime;
}
