model PeriodeInfo {
    @format("uuid")
    periodeId: string;
    periode: Periode;
}

model SplittPeriode {
    splittFra: plainDate;
}

model Sammenslaaing {
    @format("uuid")
    vilkårsvurderingId: string;
    @format("uuid")
    slåesSammenMedId: string;
}
