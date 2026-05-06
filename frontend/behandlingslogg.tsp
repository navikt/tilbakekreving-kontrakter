import "./common.tsp";

model Logginnslag {
    behandlingId: string;
    opprettetTid: utcDateTime;
    type: string;
    aktør: string;
    aktørIdent: string;
    tittel: string;
    tekst: string | null;
    steg: string | null;
    ekstraInfo: Record<unknown>;
}
