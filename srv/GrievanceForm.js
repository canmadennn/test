const cds = require('@sap/cds');
module.exports = async (srv) => {
  srv.on("SendGrievanceFormEmail", async (req) => {
    var zreport_no = req.data.zreport_no;
    var zform_type = req.data.zform_type;

    const service = await cds.connect.to('Grievance_Forms');

    return service.tx(req).post('/v1/workflow-instances', {
      "definitionId": "eu10.dev1ain.grievanceformsprocess1.grievanceForm",
      "context": {
        "zreport_no": zreport_no,
        "zform_type": zform_type
      }
    });
  });

};