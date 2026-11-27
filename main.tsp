import "@typespec/http";
import "./frontend/behandling.tsp";
import "./frontend/dokumenter.tsp";
import "./brev/vedtaksbrev.tsp";
import "./brev/varselbrev.tsp";
import "./brev/informasjonsbrev.tsp";

using Http;

@service(#{ title: "Tilbakekreving" })
namespace Tilbakekreving;

namespace Tilbakekreving {
    @tag("behandling")
    @route("/api/v1/behandling/{behandlingId}")
    interface Behandling extends BehandlingApi {}

    @tag("dokumenter")
    @route("/api/v1/dokumenter")
    interface Dokument extends DokumentApi {}

    @tag("brev")
    @route("/api/v1/brev")
    interface Brev extends VedtaksbrevApi, VarselbrevApi {}

    @tag("brevmottaker")
    @route("/api/v1/tilbakekreving")
    interface Brevmottaker extends BrevmottakerApi {}
}
