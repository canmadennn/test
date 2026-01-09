const cds = require('@sap/cds');
module.exports = async (srv) => {
    srv.on("SendOBSCardEmail", async (req) => {
        var zcard_no = req.data.zcard_no;
        const service = await cds.connect.to('obscard_spa');

        return service.tx(req).post('/v1/workflow-instances', {
            "definitionId": "eu10.dev1ain.observationcardprocess.observationCardInitial",
            "context": {
                "observationCardId": zcard_no
            }
        });
    });

    srv.on('CREATE', 'OBSCard', async (req) => {
        return ZBTP_EHS_DD_OBS_CARD_CDS.run(INSERT.into("ZBTP_EHS_DD_OBS_CARD").entries(req.data));
    });
};