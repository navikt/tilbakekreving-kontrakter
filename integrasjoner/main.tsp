import "@typespec/json-schema";

using JsonSchema;

@discriminator("hendelsestype")
model Hendelse {
    hendelsestype: string;
    versjon: uint16;
    eksternFagsakId: string;
    hendelseOpprettet: utcDateTime;
}

model BehandlingEndret extends Hendelse {
    hendelsestype: "behandling_endret";
    eksternBehandlingId: string | null;
    tilbakekreving: Tilbakekreving;
}

model Tilbakekreving {
    @format("uuid")
    behandlingId: string;

    venter: Venter | null;
    sakOpprettet: utcDateTime;
    varselSendt: plainDate | null;
    behandlingsstatus: Behandlingsstatus;
    forrigeBehandlingsstatus: Behandlingsstatus | null;
    totaltFeilutbetaltBeløp: string;
    saksbehandlingURL: string;
    fullstendigPeriode: Periode;
}

model Periode {
    fom: plainDate;
    tom: plainDate;
}

enum Behandlingsstatus {
    OPPRETTET,
    TIL_FORHÅNDSVARSEL,
    TIL_BEHANDLING,
    TIL_GODKJENNING,
    AVSLUTTET,
}

model Venter {
    grunn: Ventegrunn;
    gjenopptas: plainDate;
}

enum Ventegrunn {
    AVVENTER_BRUKERUTTALELSE,
}

model FagsysteminfoBehov {
    hendelsestype: "fagsysteminfo_behov";
}
