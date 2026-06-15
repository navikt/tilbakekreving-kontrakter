model PeriodeInfo {
    @format("uuid")
    periodeId: string;
    periode: Periode;
}

model SplittPeriode {
    @format("uuid")
    vilkårsvurderingId: string;
}

model Sammenslaaing {
    @format("uuid")
    vilkårsvurderingId: string;
    @format("uuid")
    slåesSammenMedId: string;
}
