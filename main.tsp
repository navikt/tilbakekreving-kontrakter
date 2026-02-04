import "@typespec/http";
import "./frontend/behandling.tsp";
import "./brev/vedtaksbrev.tsp";

using Http;

@service(#{ title: "Tilbakekreving" })
namespace Tilbakekreving;

namespace Tilbakekreving {
    @tag("behandling")
    @route("/api/v1/behandling/{behandlingId}")
    interface Behandling extends BehandlingApi {}

    @tag("brev")
    @route("/api/v1/brev/")
    interface Vedtaksbrev extends VedtaksbrevApi {}
}
