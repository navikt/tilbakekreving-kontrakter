model PeriodeInfo {
    @format("uuid")
    periodeId: string;
    periode: Periode;
}

model SplittPeriode {
    splittFra: plainDate;
}
