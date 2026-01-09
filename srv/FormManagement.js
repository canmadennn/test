const cds = require('@sap/cds');
const { executeHttpRequest } = require('@sap-cloud-sdk/http-client');
const textBundle = require('./util/textBundle');


async function getDMSRepositories() {
  try {
    return await executeHttpRequest({
      destinationName: 'IncidentManagementDMS'
    },
      {
        method: 'GET',
        url: "/browser"
      }
    )
  } catch (error) {
    console.error(error);
    throw new Error(error);
  }
}

async function getDMSRepositoryFolders(repositoryId, folderName) {
  try {
    return await executeHttpRequest({
      destinationName: 'IncidentManagementDMS'
    },
      {
        method: 'GET',
        url: folderName ? `/browser/${encodeURIComponent(repositoryId)}/root/${encodeURIComponent(folderName)}` : `/browser/${encodeURIComponent(repositoryId)}/root`
      }
    )
  } catch (error) {
    console.error(error);
    throw new Error(error);
  }
}

async function createDMSRepositoryFolderForForm(repositoryId, zreport_no, url_end) {
  try {
    var Body = new FormData();
    Body.append("cmisaction", "createFolder");
    Body.append("propertyId[0]", "cmis:name");
    Body.append("propertyValue[0]", zreport_no);
    Body.append("propertyId[1]", "cmis:objectTypeId");
    Body.append("propertyValue[1]", "cmis:folder");
    Body.append("succinct", true);
    return await executeHttpRequest({
      destinationName: 'IncidentManagementDMS'
    },
      {
        method: 'POST',
        url: `/browser/${encodeURIComponent(repositoryId)}/root${url_end}`,
        headers: {
          'Content-Type': 'multipart/form-data'
        },
        data: Body
      }
    )
  } catch (error) {
    console.error(error);
    throw new Error(error);
  }
}

async function postFileToDMSRepository(repositoryId, zreport_no, filename, base64) {
  try {
    var Body = new FormData();
    Body.append("cmisaction", "createDocument");
    Body.append("propertyId[0]", "cmis:name");
    Body.append("propertyValue[0]", filename);
    Body.append("propertyId[1]", "cmis:objectTypeId");
    Body.append("propertyValue[1]", "cmis:document");
    Body.append("filename", filename);
    Body.append("_charset_", "UTF-8");
    Body.append("succinct", true);
    Body.append("includeAllowableActions", true);
    Body.append("media", base64);
    // Body.append("media", new Buffer.from(base64));
    return await executeHttpRequest({
      destinationName: 'IncidentManagementDMS'
    },
      {
        method: 'POST',
        url: `/browser/${encodeURIComponent(repositoryId)}/root/${encodeURIComponent(zreport_no)}/`,
        headers: {
          'Content-Type': 'multipart/form-data'
        },
        data: Body
      }
    )
  } catch (error) {
    console.error(error);
    throw new Error(error);
  }
}

async function getDMSFolderForForm(repositoryId, zreport_no, url_end) {
  try {
    return await executeHttpRequest({
      destinationName: 'IncidentManagementDMS'
    },
      {
        method: 'GET',
        url: `/browser/${encodeURIComponent(repositoryId)}/root/${encodeURIComponent(zreport_no)}${url_end}?cmisselector=children`
      }
    )
  } catch (error) {
    console.error(error);
    throw new Error(error);
  }
}

async function getDMSFilesForForm(repositoryId, zreport_no, filename) {
  try {

    var response = await executeHttpRequest({
      destinationName: 'IncidentManagementDMS'
    },
      {
        method: 'GET',
        url: `/browser/${encodeURIComponent(repositoryId)}/root/${encodeURIComponent(zreport_no)}/${encodeURIComponent(filename)}?download=inline&cmisselector=content`,
        responseType: 'arraybuffer'
      }
    )
    console.log(response);
    return response;
  } catch (error) {
    console.error(error);
    throw new Error(error);
  }
}


async function CreateRiskMatrix(formNo, locale) {
  const ZBTP_EHS_INCIDENT_MANAGEMENT_SRV = await cds.connect.to("ZBTP_EHS_INCIDENT_MANAGEMENT_SRV");
  const bundle = textBundle.getTextBundle(locale);
  var aFormMatrix = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from('ZBTP_EHS_DD_CONSEQUENCES').where(`zreport_no='${formNo}'`));
  if (!aFormMatrix || aFormMatrix.length === 0) {
    // req.error(404, bundle.getText("riskMatrixNotFound"));
    // return;
  }
  var aConseq = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from('ZBTP_EHS_DD_CONSEQUENCES_SH').where(`spras = '${locale}'`).orderBy('zorder'));


  var aResponse = [];
  aConseq.forEach(conseq => {
    var oFormMatrix = aFormMatrix.find(row => { return conseq.zconsequences_key === row.zconsequences_key });//matrix hatası
    if (oFormMatrix) {
      aResponse.push({
        zconsequences_type: conseq.zconsequences_type,
        zincident_severity: conseq.zincident_severity,
        zconsequences_key: conseq.zconsequences_key,
        zlikelihood: oFormMatrix.zlikelihood,
        zinv_lvl: "",
        zorder: conseq.zorder
      });
    }
  });

  var aRisk = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from('ZBTP_EHS_DD_RISK').where(`spras='${locale}'`));

  for (let index = 0; index < aResponse.length; index++) {
    var element = aResponse[index];
    var oRisk = aRisk.find(row => { return row.zrisk_key === `${element.zlikelihood}${element.zincident_severity}` });
    if (oRisk) {
      aResponse[index].zinv_lvl = oRisk.zrisk;
    };
  };

  aConseq.forEach(conseq => {
    if (!aResponse.find(resp => { return resp.zconsequences_type === conseq.zconsequences_type })) {
      aResponse.push({
        zconsequences_type: conseq.zconsequences_type,
        zincident_severity: "",
        zconsequences_key: "",
        zlikelihood: "",
        zinv_lvl: "",
        zorder: conseq.zorder
      });
    }
  });

  aResponse.sort((a, b) => { return a.zorder - b.zorder }); //orijinal 18.02.2025 

  return aResponse;

}
module.exports = async (srv) => {
  const { FlashForm } = srv.entities("FlashForm");
  const { InitialForm } = srv.entities("InitialForm");
  const { InvestigationForm } = srv.entities("InvestigationForm");
  // Using CDS API      
  // const ZBTP_EHS_DD_FLASHFORM_CDS = await cds.connect.to("ZBTP_EHS_DD_FLASHFORM_CDS");
  // const ZBTP_EHS_DD_INITIAL_CDS = await cds.connect.to("ZBTP_EHS_DD_INITIAL_CDS");
  // const ZBTP_EHS_DD_CONSEQUENCES_CDS = await cds.connect.to("ZBTP_EHS_DD_CONSEQUENCES_CDS");
  // const ZBTP_EHS_DD_INIT_POS_CAU_CDS = await cds.connect.to("ZBTP_EHS_DD_INIT_POS_CAU_CDS");
  // const ZBTP_EHS_DD_INIT_IMM_ACT_CDS = await cds.connect.to("ZBTP_EHS_DD_INIT_IMM_ACT_CDS");
  // const ZBTP_EHS_DD_RISK_CDS = await cds.connect.to("ZBTP_EHS_DD_RISK_CDS");
  // const ZBTP_EHS_DD_INVESTIGATION_CDS = await cds.connect.to("ZBTP_EHS_DD_INVESTIGATION_CDS");
  // const ZBTP_EHS_DD_INV_INJ_DMG_CDS = await cds.connect.to("ZBTP_EHS_DD_INV_INJ_DMG_CDS");
  // const ZBTP_EHS_DD_INV_BODY_PART_CDS = await cds.connect.to("ZBTP_EHS_DD_INV_BODY_PART_CDS");
  // const ZBTP_EHS_DD_ROOT_CAUSES_SH_CDS = await cds.connect.to("ZBTP_EHS_DD_ROOT_CAUSES_SH_CDS");
  // const ZBTP_EHS_DD_WORK_GRV_CDS = await cds.connect.to("ZBTP_EHS_DD_WORK_GRV_CDS");
  const ZBTP_EHS_INCIDENT_MANAGEMENT_SRV = await cds.connect.to("ZBTP_EHS_INCIDENT_MANAGEMENT_SRV");
  const ADS_SRV = await cds.connect.to('ADS_SRV');

  srv.on('READ', ['FlashForm', 'ZBTP_EHS_INITIAL', 'ZBTP_EHS_DD_INITIAL', 'ZBTP_EHS_DD_INVESTIGATION1', 'ZBTP_EHS_INC_STS'], async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', ['FlashformList', 'FlashformListSet'], async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', ['InitialForm', 'ZBTP_EHS_DD_INVESTIGATION'], async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'WUsers', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'WRoles', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'RoleUserList', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'RoleUserListAll', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', ['ManagementRoles', 'ManagementRolesSet', 'DepartmentRoles', 'DepartmentRolesSet', 'FacilityRoles', 'FacilityRolesSet'], async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });


  srv.on('READ', 'Management', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
    // return ZBTP_EHS_DD_FLASHFORM_CDS.run(req.query);
  });


  srv.on('READ', 'ManagementNoCRP', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });


  srv.on('READ', 'FullManagement', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'Department', async (req) => {

    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'Facility', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'ManagementTable', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'DepartmentTable', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'FacilityTable', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'IncidentClass', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'IncidentType', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'IncidentRelevance', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'Consequences', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'ImmediateCauses', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'MainImmediateCauses', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'InitialPossibleCauses', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'ImmediateActions', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'Likelihood', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'Risk', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', ['RootCauses', 'InvRootCauses', 'MainRootCauses'], async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', ['InjuryDamage'], async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', ['BodyParts', 'InvBodyParts'], async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  })

  srv.on('READ', ['InvestigationForm', 'ZBTP_EHS_DD_ROOT_CAUSES_SH', 'ZBTP_EHS_DD_INV_INJ_PPL', 'ZBTP_EHS_DD_INV_TEAM', 'ZBTP_EHS_DD_INV_IMM_ACT', 'InvImmAct', 'ZBTP_EHS_INJ_P_C', 'ZBTP_EHS_DD_INV_INJ_DMG'], async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', ['RemdActs'], async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  })

  srv.on('READ', 'CompanyDirector', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'CompanyManager', async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });

  srv.on('READ', 'UserRole', async (req) => {
    try {
      return await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
    } catch (error) {
      console.error(error);
      req.error(500, "Error fetching data from ZBTP_EHS_USERS");
    }
  });

  srv.on('CREATE', 'FlashForm', async (req) => {
    var oCurrentDate = new Date();
    const locale = req.user.locale;

    const bundle = textBundle.getTextBundle(locale);
    req.data["zreport_date"] = oCurrentDate.toLocaleDateString('en-CA', { timeZone: "Turkey" });
    if (req.data["zreport_date"].length === 10) {
      req.data["zreport_date"] = req.data["zreport_date"] + "T00:00:00";
    };

    req.data["zreport_time"] = `${oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
    req.data["zreport_time"] = `PT${req.data["zreport_time"].substr(0, 2)}H${req.data["zreport_time"].substr(2, 2)}M${req.data["zreport_time"].substr(4, 2)}S`;

    if (req.data["zincident_date"].length === 10) {
      req.data["zincident_date"] = req.data["zincident_date"] + "T00:00:00"
    };
    if (!req.data["zfacility"]) {
      req.error({ code: 400, message: bundle.getText("emptyFacility") });
      return;
    };
    if (!req.data["zdepartment"]) {
      req.error({ code: 400, message: bundle.getText("emptyDepartment") });
      return;
    };
    if (!req.data["zmanagement"]) {
      req.error({ code: 400, message: bundle.getText("emptyManagement") });
      return;
    };
    if (!req.data["zincident_class"]) {
      req.error({ code: 400, message: bundle.getText("emptyIncidentClass") });
      return;
    };
    if (!req.data["zincident_date"]) {
      req.error({ code: 400, message: bundle.getText("emptyIncidentDate") });
      return;
    };
    if (!req.data["zincident_time"]) {
      req.error({ code: 400, message: bundle.getText("emptyIncidentTime") });
      return;
    };
    var aFacility = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_UNITS").where(`zunit_key='${req.data["zfacility"]}'`))
    if (!aFacility) {
      req.error({ code: 404, message: bundle.getText("invalidFacility") });
      return;
    };

    var aManagement = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_MNGMT").where(`zmanagement_key='${req.data["zmanagement"]}'`))
    if (!aManagement) {
      req.error({ code: 404, message: bundle.getText("invalidManagement") });
      return;
    };

    var aDepartment = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_DEPARTM").where(`zdepartment_key='${req.data["zdepartment"]}' AND zmanagement_key='${req.data["zmanagement"]}'`))
    if (!aDepartment) {
      req.error({ code: 404, message: bundle.getText("invalidDepartment") });
      return;
    };

    var aIncidentClass = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INC_CLASS").where(`zincident_classname_key='${req.data["zincident_class"]}'`))
    if (!aIncidentClass) {
      req.error({ code: 404, message: bundle.getText("invalidIncidentClass") });
      return;
    };


    req.data["ernam"] = req.user.id;
    req.data["erdat"] = oCurrentDate.toLocaleDateString('en-CA', { timeZone: "Turkey" }) + "T00:00:00";
    req.data["erzet"] = `${oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
    req.data["erzet"] = `PT${req.data["erzet"].substr(0, 2)}H${req.data["erzet"].substr(2, 2)}M${req.data["erzet"].substr(4, 2)}S`;


    var lvYear = req.data["zincident_date"].slice(0, 4);
    // var lvYear = req.data["zincident_date"].substr(0,4);   //---- Yeni Rapor Yılı
    var aReportNo = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from("ZBTP_EHS_DD_FLASHFORM").columns('zreport_no').where(`zfacility = '${req.data["zfacility"]}'`));
    var counter = "000";
    if (aReportNo) {
      aReportNo.forEach(report_no => {
        if (report_no["zreport_no"].length < 14) {

        } else if (report_no["zreport_no"].startsWith(`INCD-${req.data["zfacility"]}-${lvYear}-`)) {  //- incYear -lvYear yerine yazıldı
          var aSplit = report_no["zreport_no"].split("-");
          if (parseInt(aSplit[aSplit.length - 1]) > parseInt(counter)) {
            counter = aSplit[aSplit.length - 1];
          }
        };
      })
    };
    counter = parseInt(counter);
    counter += 1;
    counter = counter.toString().padStart(3, "0");
    req.data["zreport_no"] = req.data["zreport_no"] + counter;
    req.data["status"] = "";
    // req.data["status"] = "S";
    req.data["zincident_time"] = `${req.data["zincident_time"].split(":").join("")}`;
    req.data["zincident_time"] = `PT${req.data["zincident_time"].substr(0, 2)}H${req.data["zincident_time"].substr(2, 2)}M${req.data["zincident_time"].substr(4, 2)}S`;
    // var oInitialData = {};
    // oInitialData = { ...req.data };
    // oInitialData.zincident_relevance = "";
    // oInitialData.zincident_type = "";
    // oInitialData.zreport_date = null;
    // oInitialData.zreport_time = null;
    // oInitialData.status = "";
    //Initial report'lar da oluşsun
    // var oResult = await ZBTP_EHS_DD_INITIAL_CDS.run(INSERT.into("ZBTP_EHS_DD_INITIAL").entries(oInitialData));
    var oRepositoryResponse = await getDMSRepositories();
    if (oRepositoryResponse.data) {
      var aRepositories = oRepositoryResponse.data;
      var oRepository = aRepositories['EHS_REPOSITORY'];
      var oFoldersResponse = await getDMSRepositoryFolders(oRepository.repositoryId, "");
      var aFolders = oFoldersResponse.data.objects;
      if (aFolders.length === 0 || !aFolders.find(row => { return row.object.properties["cmis:name"].value === req.data["zreport_no"] })) {
        var oFolderCreateResponse = await createDMSRepositoryFolderForForm(oRepository.repositoryId, req.data["zreport_no"], "");
        var oSignatureFolderCreateResponse = await createDMSRepositoryFolderForForm(oRepository.repositoryId, "FlashForm-SIGNATURES", "/" + req.data["zreport_no"]);
        req.data["signfolderid"] = oSignatureFolderCreateResponse.data.succinctProperties["cmis:objectId"];
      };
    };
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT.into("ZBTP_EHS_DD_FLASHFORM").entries(req.data));
    // return ZBTP_EHS_DD_FLASHFORM_CDS.run(INSERT.into("ZBTP_EHS_DD_FLASHFORM").entries(req.data));
  });

  srv.on('CancelFlashReport', async (req) => {
    const [flashForm] = req.params;
    const locale = req.user.locale;

    const bundle = textBundle.getTextBundle(locale);
    var oFlashForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_FLASHFORM").where(`zreport_no='${flashForm.zreport_no}'`));
    var oInitialForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INITIAL").where(`zreport_no='${flashForm.zreport_no}'`));
    var oInvestigation = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INVESTIGATION").where(`zreport_no='${flashForm.zreport_no}'`));;

    console.log("oFlashForm ", oFlashForm)
    if (oInvestigation && (oInvestigation.status === 'S' || oInvestigation.status === 'F')) {//Submit edilmiş veya iptal edilmiş bir form iptal edilemez
      // if (oFlashForm.status === 'S' || oFlashForm.status === 'C') {//Submit edilmiş veya iptal edilmiş bir form iptal edilemez
      req.error(409, bundle.getText("CancelFlashFormAlreadySubmitted"));
      return;
    };
    var sTime = `${new Date().toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
    sTime = `PT${sTime.substr(0, 2)}H${sTime.substr(2, 2)}M${sTime.substr(4, 2)}S`;

    var oUpdate = {
      status: "C",
      aedat: new Date().toLocaleDateString('en-CA', { timeZone: "Turkey" }) + "T00:00:00",
      aezet: sTime,
      aenam: req.user.id
    };
    if (!oFlashForm.zreport_date) {
      oUpdate.zreport_date = oUpdate.aedat;
      oUpdate.zreport_time = oUpdate.aezet;
    };
    var sQuery = UPDATE("ZBTP_EHS_DD_FLASHFORM").with(oUpdate).where(`zreport_no='${oFlashForm.zreport_no}'`);
    var oResponse = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);

    if (oInitialForm) {
      if (!oInitialForm.zreport_date) {
        oUpdate.zreport_date = oUpdate.aedat;
        oUpdate.zreport_time = oUpdate.aezet;
      } else if (oUpdate.zreport_date) {
        delete oUpdate.zreport_date;
        delete oUpdate.zreport_time;
      };

      sQuery = UPDATE("ZBTP_EHS_DD_INITIAL").with(oUpdate).where(`zreport_no='${oFlashForm.zreport_no}'`);
      oResponse = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
    }

    if (oInvestigation) {
      if (!oInvestigation.zreport_date) {
        oUpdate.zreport_date = oUpdate.aedat;
        oUpdate.zreport_time = oUpdate.aezet;
      } else if (oUpdate.zreport_date) {
        delete oUpdate.zreport_date;
        delete oUpdate.zreport_time;
      };

      sQuery = UPDATE("ZBTP_EHS_DD_INVESTIGATION").with(oUpdate).where(`zreport_no='${oFlashForm.zreport_no}'`);
      oResponse = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
    }

  });

  srv.on('SubmitFlashReport', async (req) => {
    var oCurrentDate = new Date();
    const locale = req.user.locale;

    const bundle = textBundle.getTextBundle(locale);

    const [flashForm] = req.params;
    var oFlashForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_FLASHFORM").where(`zreport_no='${flashForm.zreport_no}'`));

    var sTime = `${oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
    sTime = `PT${sTime.substr(0, 2)}H${sTime.substr(2, 2)}M${sTime.substr(4, 2)}S`;
    var oInitialData = {};
    delete oFlashForm["to_Department"];
    delete oFlashForm["to_Management"];
    delete oFlashForm["to_Facility"];
    delete oFlashForm["to_IncCLass"];
    delete oFlashForm["to_Init"];
    delete oFlashForm["to_Status"];
    delete oFlashForm["to_Inv"];
    delete oFlashForm["to_IncStatus"];
    delete oFlashForm["to_Inv"];
    delete oFlashForm["zinc_status"];
    delete oFlashForm["InitStatusText"];
    delete oFlashForm["InvStatusText"];
    delete oFlashForm["zincident_relevance_desc"];
    delete oFlashForm["zincident_type_desc"];
    delete oFlashForm["signfolderid"];
    delete oFlashForm["zinc_status_Text"];
    oInitialData = { ...oFlashForm };

    var oUpdate = {
      status: "S",
      aedat: oCurrentDate.toLocaleDateString('en-CA', { timzeone: "Turkey" }) + "T00:00:00",
      aezet: sTime,
      aenam: req.user.id
    };
    if (!oFlashForm.zreport_date) {
      oUpdate.zreport_date = oUpdate.aedat;
      oUpdate.zreport_time = oUpdate.aezet;
    }

    var sQuery = UPDATE("ZBTP_EHS_DD_FLASHFORM").with(oUpdate).where(`zreport_no='${oFlashForm.zreport_no}'`);

    var oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);

    oInitialData.zincident_relevance = "";
    oInitialData.zincident_type = "";
    oInitialData.zreport_date = null;
    oInitialData.zreport_time = null;
    oInitialData.status = "";
    oInitialData.zincident_type = "";
    oInitialData.zincident_relevance = "";
    oInitialData.zprepared_name = "";
    oInitialData.zprepared_signature = "";
    oInitialData.zprepared_date = null;
    oInitialData.zapproved_name = "";
    oInitialData.zapproved_signature = "";
    oInitialData.zapproved_date = null;
    oInitialData.zreal_outcome = "";

    oInitialData["ernam"] = req.user.id;
    oInitialData["erdat"] = oCurrentDate.toLocaleDateString('en-CA', { timeZone: "Turkey" }) + "T00:00:00";
    oInitialData["erzet"] = `${oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
    oInitialData["erzet"] = `PT${oInitialData["erzet"].substr(0, 2)}H${oInitialData["erzet"].substr(2, 2)}M${oInitialData["erzet"].substr(4, 2)}S`;

    // var oRepositoryResponse = await getDMSRepositories();
    // if (oRepositoryResponse.data) {
    //   var aRepositories = oRepositoryResponse.data;
    //   var oRepository = aRepositories['EHS_REPOSITORY'];
    //   var oFoldersResponse = await getDMSRepositoryFolders(oRepository.repositoryId, "");
    //   var aFolders = oFoldersResponse.data.objects;
    //   if (aFolders.length === 0 || !aFolders.find(row => { return row.object.properties["cmis:name"].value === flashForm.zreport_no })) {
    //     var oFolderCreateResponse = await createDMSRepositoryFolderForForm(oRepository.repositoryId, flashForm.zreport_no, "");
    //     await createDMSRepositoryFolderForForm(oRepository.repositoryId, flashForm.zreport_no + "-SIGNATURES", "/" + flashForm.zreport_no);
    //   };
    // };

    var oRepositoryResponse = await getDMSRepositories();
    if (oRepositoryResponse.data) {
      var aRepositories = oRepositoryResponse.data;
      var oRepository = aRepositories['EHS_REPOSITORY'];
      var oFoldersResponse = await getDMSRepositoryFolders(oRepository.repositoryId, oFlashForm.zreport_no);
      var aFolders = oFoldersResponse.data.objects;
      if (aFolders.length === 0 || !aFolders.find(row => { return row.object.properties["cmis:name"].value === "InitialForm-SIGNATURES" })) {
        var oFolderCreateResponse = await createDMSRepositoryFolderForForm(oRepository.repositoryId, "InitialForm-SIGNATURES", "/" + oFlashForm.zreport_no);
        oInitialData["signfolderid"] = oFolderCreateResponse.data.succinctProperties["cmis:objectId"];
      };
    };

    var oInitResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT.into("ZBTP_EHS_DD_INITIAL").entries(oInitialData))
    return;

  });

  srv.on('SubmitInitialReport', async (req) => {
    var oCurrentDate = new Date();
    var aNonMandatoryFields = ['zincident_title', 'aedat', 'aenam', 'aezet', 'erdat', 'ernam', 'erzet', 'zcustom_dec1', 'zcustom_dec2', 'zcustom_dec3',
      'zcustom_text1', 'zcustom_text2', 'zcustom_text3', 'zdrop', 'zmedevac', 'zprepared_signature',
      'zapproved_signature', 'status', 'zapproved_date', 'zprepared_date', 'signfolderid', 'signfolderpresent'];
    const locale = req.user.locale;

    const bundle = textBundle.getTextBundle(locale);

    const [initialForm] = req.params;
    var oInitialForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INITIAL").where(`zreport_no='${initialForm.zreport_no}'`));

    if (!oInitialForm) {
      req.error(404, bundle.getText("InitialformNotFound"));
      return;
    }

    if (oInitialForm.status === 'S' || oInitialForm.status === 'C') {//Submit edilmiş veya iptal edilmiş bir form bir daha submit edilemez
      req.error(409, oInitialForm.status === 'S' ? bundle.getText("SubmitInitialFormAlreadySubmitted") : bundle.getText("SubmitInitialFormAlreadyCancelled"));
      return;
    };
    var sTime = `${oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
    sTime = `PT${sTime.substr(0, 2)}H${sTime.substr(2, 2)}M${sTime.substr(4, 2)}S`;

    var aImmActs = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from("ZBTP_EHS_DD_INIT_IMM_ACT").where(`zreport_no='${initialForm.zreport_no}'`));
    if (aImmActs.length === 0) {
      req.error(404, bundle.getText("ImmActsNotFound"));
      return;
    };

    var aPosCau = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from("ZBTP_EHS_DD_INIT_POS_CAU").where(`zreport_no='${initialForm.zreport_no}'`));
    if (aPosCau.length === 0) {
      req.error(404, bundle.getText("PosCauNotFound"));
      return;
    };

    var aConseq = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from("ZBTP_EHS_DD_CONSEQUENCES").where(`zreport_no='${initialForm.zreport_no}'`));
    if (aConseq.length === 0) {
      req.error(404, bundle.getText("ConseqNotFound"));
      return;
    };

    var oUpdate = {
      status: "S",
      aedat: oCurrentDate.toLocaleDateString('en-CA', { timzeone: "Turkey" }) + "T00:00:00",
      aezet: sTime,
      aenam: req.user.id
    };

    if (!oInitialForm.zreport_date) {
      oUpdate.zreport_date = oUpdate.aedat;
      oUpdate.zreport_time = oUpdate.aezet;
      oInitialForm["zreport_date"] = oCurrentDate.toLocaleDateString('en-CA', { timeZone: "Turkey" });
      oInitialForm["zreport_time"] = oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" });
    }
    var isValid = true;
    Object.keys(oInitialForm).forEach(key => {
      if (!aNonMandatoryFields.find(key2 => { return key2 === key })) {
        if (oInitialForm[key] === undefined || oInitialForm[key] === null || oInitialForm[key] === '') {
          console.log(`Eksik alan: ${key}`);
          isValid = false;
        }
      }
    });
    if (!isValid) {
      req.error(404, bundle.getText("InvestigationFormNotFilled"));
      return;
    }

    var sQuery = UPDATE("ZBTP_EHS_DD_INITIAL").with(oUpdate).where(`zreport_no='${oInitialForm.zreport_no}'`);

    var oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);

    var oInvForm = {};
    Object.assign(oInvForm, oInitialForm);
    //Burada Investigationform yaratılacak
    delete oInvForm["zprepared_name"];
    delete oInvForm["zprepared_signature"];
    delete oInvForm["zprepared_date"];
    delete oInvForm["to_Act"];
    delete oInvForm["to_Cons"];
    delete oInvForm["to_Department"];
    delete oInvForm["to_Facility"];
    delete oInvForm["to_IncClass"];
    delete oInvForm["to_IncRelv"];
    delete oInvForm["to_IncType"];
    delete oInvForm["to_Management"];
    delete oInvForm["to_Pos"];
    delete oInvForm["to_RealOut"];
    delete oInvForm["to_Status"];
    delete oInvForm["to_Inv"];
    delete oInvForm["to_Files"];

    oInvForm.zreport_date = null;
    oInvForm.zreport_time = null;
    oInvForm.status = "";
    oInvForm.zapproved_name = "";
    oInvForm.zapproved_signature = "";
    oInvForm.zapproved_date = null;

    oInvForm["ernam"] = req.user.id;
    oInvForm["erdat"] = oCurrentDate.toLocaleDateString('en-CA', { timeZone: "Turkey" }) + "T00:00:00";
    oInvForm["erzet"] = `${oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
    oInvForm["erzet"] = `PT${oInvForm["erzet"].substr(0, 2)}H${oInvForm["erzet"].substr(2, 2)}M${oInvForm["erzet"].substr(4, 2)}S`;

    oInvForm["aedat"] = null;
    oInvForm["aenam"] = "";
    oInvForm["aezet"] = null;
    oInvForm["zinvestigator_name"] = "";
    oInvForm["zinvestigator_signature"] = "";
    oInvForm["zinvestigator_date"] = null;
    oInvForm["zverification_name"] = "";
    oInvForm["zverification_signature"] = "";
    oInvForm["zverification_date"] = null;
    oInvForm["zcomp_name"] = "";
    oInvForm["zinj_per_comp_key"] = "";
    // oInvForm["zexp_occu"] = null;
    // oInvForm["zexp_pos"] = null;
    // oInvForm["zdays_shift"] = null;
    // oInvForm["ztour_time"] = null;
    oInvForm["zactivity"] = "";
    oInvForm["zinc_det_desc"] = "";
    oInvForm["zjob_undertaken"] = "";
    oInvForm["zjra_no"] = "";
    oInvForm["zpermit_no"] = "";
    oInvForm["zfindings"] = "";
    oInvForm["zlessons"] = "";
    oInvForm["signfolderid"] = "";
    oInvForm["signfolderpresent"] = "";
    if (oInvForm.zincident_date.length === 10) {
      oInvForm.zincident_date = oInvForm.zincident_date + "T00:00:00"
    };
    var oRepositoryResponse = await getDMSRepositories();
    if (oRepositoryResponse.data) {
      var aRepositories = oRepositoryResponse.data;
      var oRepository = aRepositories['EHS_REPOSITORY'];
      var oFoldersResponse = await getDMSRepositoryFolders(oRepository.repositoryId, oInitialForm.zreport_no);
      var aFolders = oFoldersResponse.data.objects;
      if (aFolders.length === 0 || !aFolders.find(row => { return row.object.properties["cmis:name"].value === "InvestigationForm-SIGNATURES" })) {
        var oSignatureFolderCreateResponse = await createDMSRepositoryFolderForForm(oRepository.repositoryId, "InvestigationForm-SIGNATURES", "/" + oInitialForm["zreport_no"]);
        oInvForm["signfolderid"] = oSignatureFolderCreateResponse.data.succinctProperties["cmis:objectId"];

      }
      if (aFolders.length === 0 || !aFolders.find(row => { return row.object.properties["cmis:name"].value === oInitialForm.zreport_no + '-INV' })) {
        var oFolderCreateResponse = await createDMSRepositoryFolderForForm(oRepository.repositoryId, oInitialForm.zreport_no + '-INV', "/" + encodeURIComponent(oInitialForm.zreport_no));
      };;
    };

    var oInitResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT.into("ZBTP_EHS_DD_INVESTIGATION").entries(oInvForm));

    return { zreport_date: oInitialForm.zreport_date, zreport_time: oInitialForm.zreport_time };
  });

  srv.on('CancelInitialReport', async (req) => {
    const [initialForm] = req.params;
    const locale = req.user.locale;

    const bundle = textBundle.getTextBundle(locale);
    var oInitialForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INITIAL").where(`zreport_no='${initialForm.zreport_no}'`));

    if (oInitialForm.status === 'S' || oInitialForm.status === 'C') {//Submit edilmiş veya iptal edilmiş bir form iptal edilemez
      req.error(409, oInitialForm.status === 'S' ? bundle.getText("CancelInitialFormAlreadySubmitted") : bundle.getText("CancelInitialFormAlreadyCancelled"));
      return;
    };
    var oCurrentDate = new Date();
    var sTime = `${oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
    sTime = `PT${sTime.substr(0, 2)}H${sTime.substr(2, 2)}M${sTime.substr(4, 2)}S`;

    var oUpdate = {
      status: "C",
      aedat: oCurrentDate.toLocaleDateString('en-CA', { timeZone: "Turkey" }) + "T00:00:00",
      aezet: sTime,
      aenam: req.user.id
    };
    if (!oInitialForm.zreport_date) {
      oUpdate.zreport_date = oUpdate.aedat;
      oUpdate.zreport_time = oUpdate.aezet;
      oInitialForm["zreport_date"] = oCurrentDate.toLocaleDateString('en-CA', { timeZone: "Turkey" });
      oInitialForm["zreport_time"] = oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" });
    }

    var sQuery = UPDATE("ZBTP_EHS_DD_INITIAL").with(oUpdate).where(`zreport_no='${oInitialForm.zreport_no}'`);
    var oResponse = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
    var oUpdate2 = {
      status: "C"
    };

    sQuery = UPDATE("ZBTP_EHS_DD_FLASHFORM").with(oUpdate2).where(`zreport_no='${oInvestigationForm.zreport_no}'`);

    oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
    return { zreport_date: oInitialForm.zreport_date, zreport_time: oInitialForm.zreport_time };

  });

  srv.on('CloseInitialReport', async (req) => {

    const [initialForm] = req.params;
    const locale = req.user.locale;

    const bundle = textBundle.getTextBundle(locale);
    var oInitialForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INITIAL").where(`zreport_no='${initialForm.zreport_no}'`));

    if (oInitialForm.status === 'S' || oInitialForm.status === 'C' || oInitialForm.status === 'F') {//Submit edilmiş veya iptal edilmiş bir form iptal edilemez
      var statusProperty = {}
      switch (oInitialForm.status) {
        case 'S':
          statusProperty = 'CancelInitialFormAlreadySubmitted';
          break;
        case 'F':
          statusProperty = 'CancelInitialFormAlreadyClosed';
          break;
        case 'C':
          statusProperty = 'CancelInitialFormAlreadyCancelled';
          break;
        default:
          break;
      }
      req.error(409, bundle.getText(statusProperty));
      return;
    };
    var oCurrentDate = new Date();
    var sTime = `${oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
    sTime = `PT${sTime.substr(0, 2)}H${sTime.substr(2, 2)}M${sTime.substr(4, 2)}S`;

    var oUpdate = {
      status: "F",
      aedat: oCurrentDate.toLocaleDateString('en-CA', { timeZone: "Turkey" }) + "T00:00:00",
      aezet: sTime,
      aenam: req.user.id
    };
    if (!oInitialForm.zreport_date) {
      oUpdate.zreport_date = oUpdate.aedat;
      oUpdate.zreport_time = oUpdate.aezet;
      oInitialForm["zreport_date"] = oCurrentDate.toLocaleDateString('en-CA', { timeZone: "Turkey" });
      oInitialForm["zreport_time"] = oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" });
    }
    var sQuery = UPDATE("ZBTP_EHS_DD_INITIAL").with(oUpdate).where(`zreport_no='${oInitialForm.zreport_no}'`);
    var oResponse = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
    return { zreport_date: oInitialForm.zreport_date, zreport_time: oInitialForm.zreport_time };
    // return ; 
    // let oFlashForm = await tx.run(SELECT.one.from("FlashForm").where(`zreport_no = ${flashForm.zreport_no}`));

  });

  srv.on('SubmitInvestigationReport', async (req) => {
    var oCurrentDate = new Date();
    var aNonMandatoryFields = ['zincident_title', 'aedat', 'aenam', 'aezet', 'erdat', 'ernam', 'erzet', 'zcustom_dec1', 'zcustom_dec2', 'zcustom_dec3',
      'zcustom_text1', 'zcustom_text2', 'zcustom_text3', 'zdrop', 'zmedevac', 'zverification_signature', 'zinvestigator_signature',
      'zapproved_signature', 'status', 'zapproved_date', 'zverification_date', 'zinvestigator_date', 'zjra_no', 'zpermit_no', 'signfolderid', 'signfolderpresent', 'zdirector_key', 'zmanager_key', 'zdirector_desc', 'zmanager_desc'];
    const locale = req.user.locale;

    const bundle = textBundle.getTextBundle(locale);

    const [investigationForm] = req.params;
    var oFlashForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_FLASHFORM").where(`zreport_no='${investigationForm.zreport_no}'`));
    // var oFlashForm = await ZBTP_EHS_DD_FLASHFORM_CDS.run(SELECT.one.from("ZBTP_EHS_DD_FLASHFORM").where(`zreport_no='${investigationForm.zreport_no}'`));
    var oInitialForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INITIAL").where(`zreport_no='${investigationForm.zreport_no}'`));
    // var oInitialForm = await ZBTP_EHS_DD_INITIAL_CDS.run(SELECT.one.from("ZBTP_EHS_DD_INITIAL").where(`zreport_no='${investigationForm.zreport_no}'`));
    var oInvestigationForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INVESTIGATION").where(`zreport_no='${investigationForm.zreport_no}'`));
    // var oInvestigationForm = await ZBTP_EHS_DD_INVESTIGATION_CDS.run(SELECT.one.from("ZBTP_EHS_DD_INVESTIGATION").where(`zreport_no='${investigationForm.zreport_no}'`));

    if (!oInvestigationForm) {
      req.error(404, bundle.getText("InvestigationformNotFound"));
      return;
    };

    var aRemdActsClosed = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from('ZBTP_EHS_DD_REMEDIAL_ACTIONS').where(`zreport_no='${investigationForm.zreport_no}'`));
    if (aRemdActsClosed.length === 0) {
      req.error(404, bundle.getText("RemActNotFound"));
      return;
    }

    var aRootCauses = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from("ZBTP_EHS_DD_ROOT_CAUSES_SH").where(`zreport_no='${investigationForm.zreport_no}'`));
    if (aRootCauses.length === 0) {
      req.error(404, bundle.getText("RootCausesNotFound"));
      return;
    };

    var aInvTeam = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from("ZBTP_EHS_DD_INV_TEAM").where(`zreport_no='${investigationForm.zreport_no}'`));
    if (aInvTeam.length === 0) {
      req.error(404, bundle.getText("InvTeamNotFound"));
      return;
    }

    var aImmActs = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from("ZBTP_EHS_DD_INIT_IMM_ACT").where(`zreport_no='${investigationForm.zreport_no}'`));
    if (aImmActs.length === 0) {
      req.error(404, bundle.getText("ImmActsNotFound"));
      return;
    }

    var aPosCau = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from("ZBTP_EHS_DD_INIT_POS_CAU").where(`zreport_no='${investigationForm.zreport_no}'`));
    if (aPosCau.length === 0) {
      req.error(404, bundle.getText("PosCauNotFound"));
      return;
    }

    var aBodyParts = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from("ZBTP_EHS_DD_INV_BODY_PART").where(`zreport_no='${investigationForm.zreport_no}'`));
    if (oInvestigationForm.zincident_class === "INJ" && aBodyParts.length === 0) {
      req.error(404, bundle.getText("BodyPartsNotFound"));
      return;
    }

    var aInjPeople = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from("ZBTP_EHS_DD_INV_INJ_PPL").where(`zreport_no='${investigationForm.zreport_no}'`));
    if (oInvestigationForm.zincident_class === "INJ" && aInjPeople.length === 0) {
      req.error(404, bundle.getText("InjPeopleNotFound"));
      return;
    } else if (aInjPeople.length !== 0 && aInjPeople.filter(body => !aBodyParts.some(row => row.idx === body.idx)).length !== 0) {
      req.error(404, bundle.getText("BodyPartsNotFound"));
    };

    var aDmg = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INJ_ILL").where(`zincident_class='${oInvestigationForm.zincident_class}'`));
    if (aDmg.length != 0) {

      var aInjDmg = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from("ZBTP_EHS_DD_INV_INJ_DMG").where(`zreport_no='${investigationForm.zreport_no}'`));
      if (aInjDmg.length === 0) {
        req.error(404, bundle.getText("InjDMgNotFound"));
        return;
      }
    }

    if (oInvestigationForm.status === 'S' || oInvestigationForm.status === 'F' || oInvestigationForm.status === 'C') {//Submit edilmiş veya iptal edilmiş bir form bir daha submit edilemez
      req.error(409, oInvestigationForm.status === 'C' ? bundle.getText("SubmitInvestigationFormAlreadyCancelled") : bundle.getText("SubmitInvestigationFormAlreadySubmitted"));
      return;
    };
    var sTime = `${oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
    sTime = `PT${sTime.substr(0, 2)}H${sTime.substr(2, 2)}M${sTime.substr(4, 2)}S`;
    var isValid = true;

    if (oInvestigationForm.zincident_class !== "INJ") {
      aNonMandatoryFields.push("zposition");
      aNonMandatoryFields.push("ztour_time");
      aNonMandatoryFields.push("zdays_shift");
      aNonMandatoryFields.push("zexp_occu");
      aNonMandatoryFields.push("zexp_pos");
    }
    Object.keys(oInvestigationForm).forEach(key => {
      if (!aNonMandatoryFields.find(key2 => { return key2 === key })) {
        if (oInvestigationForm[key] === undefined || oInvestigationForm[key] === null || oInvestigationForm[key] === '') {
          console.log(`❌ INV_FORM: Validation failed for mandatory field: ${key} = '${oInvestigationForm[key]}'`);
          isValid = false;
        }
      }
    });
    if (!isValid) {
      req.error(404, bundle.getText("InvestigationFormNotFilled"));
      return;
    };

    //İmzalı dosya kontrolü

    var bSigned = false;
    //İçerisine bakılacak klasörleri  bir dizide tut
    var aURLEndpoints = [`/${encodeURIComponent("InvestigationForm-SIGNATURES")}`];
    var iIndex = -1;
    //Eğer imzalı dosya yoksa bakmaya devam et
    while (!bSigned) {
      //Sıradaki klasöre bak
      iIndex += 1;
      //Eğer sınırı aşarsan dur
      if (iIndex >= aURLEndpoints.length) {
        break;
      };
      //İlgili klasör alınır
      var aFolderContent = await getDMSFolderForForm("EHS_REPOSITORY", oInvestigationForm.zreport_no, aURLEndpoints[iIndex]);
      //Klasörün içi boş değilse VE içinde klasörden başka dosya tipi varsa, imzalı dosya var demektir
      if (aFolderContent.data && aFolderContent.data.objects.length !== 0 && aFolderContent.data.objects.find(row => {
        return row.object.properties["cmis:objectTypeId"].value !== "cmis:folder"
      })) {
        bSigned = true;
      } else if (aFolderContent.data && aFolderContent.data.objects.length !== 0) {
        // } else {
        //Klasörün içinde klasörden başka bir şey yoksa, bu klasörlerin içine bak
        aFolderContent.data.objects.forEach(row => {
          aURLEndpoints.push(`${aURLEndpoints[iIndex]}/${encodeURIComponent(row.object.properties["cmis:name"].value)}`);
        });
      }
    };
    if (!bSigned) {
      req.error(404, bundle.getText("InvestigationFormSignatureNotFound"));
      return;
    };

    bSigned = false;
    //İçerisine bakılacak klasörleri  bir dizide tut
    aURLEndpoints = [`/${encodeURIComponent("InitialForm-SIGNATURES")}`];
    iIndex = -1;
    //Eğer imzalı dosya yoksa bakmaya devam et
    while (!bSigned) {
      //Sıradaki klasöre bak
      iIndex += 1;
      //Eğer sınırı aşarsan dur
      if (iIndex >= aURLEndpoints.length) {
        break;
      };
      //İlgili klasör alınır
      var aFolderContent = await getDMSFolderForForm("EHS_REPOSITORY", oInvestigationForm.zreport_no, aURLEndpoints[iIndex]);
      //Klasörün içi boş değilse VE içinde klasörden başka dosya tipi varsa, imzalı dosya var demektir
      if (aFolderContent.data && aFolderContent.data.objects.length !== 0 && aFolderContent.data.objects.find(row => {
        return row.object.properties["cmis:objectTypeId"].value !== "cmis:folder"
      })) {
        bSigned = true;
      } else if (aFolderContent.data && aFolderContent.data.objects.length !== 0) {
        // } else {
        //Klasörün içinde klasörden başka bir şey yoksa, bu klasörlerin içine bak
        aFolderContent.data.objects.forEach(row => {
          aURLEndpoints.push(`${aURLEndpoints[iIndex]}/${encodeURIComponent(row.object.properties["cmis:name"].value)}`);
        });
      }
    };
    if (!bSigned) {
      req.error(404, bundle.getText("InitialFormSignatureNotFound"));
      return;
    };

    var aRemdActs = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from('ZBTP_EHS_DD_REMEDIAL_ACTIONS').where(`zreport_no='${oInvestigationForm.zreport_no}'`));
    if (aRemdActs?.some(row =>
      (row.zrem_act_status === "1" || row.zrem_act_status === "2") && row.zrem_act_closed_date === null
    )) {
      req.error(404, bundle.getText("RemedialActionsCheck"));
      return;
    }

    var oUpdate = {
      status: "F",
      aedat: oCurrentDate.toLocaleDateString('en-CA', { timzeone: "Turkey" }) + "T00:00:00",
      aezet: sTime,
      aenam: req.user.id
    };

    if (!oInvestigationForm.zreport_date) {
      oUpdate.zreport_date = oUpdate.aedat;
      oUpdate.zreport_time = oUpdate.aezet;
      oInvestigationForm["zreport_date"] = oCurrentDate.toLocaleDateString('en-CA', { timeZone: "Turkey" });
      oInvestigationForm["zreport_time"] = oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" });
    }

    var sQuery = UPDATE("ZBTP_EHS_DD_INVESTIGATION").with(oUpdate).where(`zreport_no='${oInvestigationForm.zreport_no}'`);
    var oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);

    if (oFlashForm) {
      if (!oFlashForm.zreport_date) {
        oUpdate.zreport_date = oUpdate.aedat;
        oUpdate.zreport_time = oUpdate.aezet;
      } else if (oUpdate.zreport_date) {
        delete oUpdate.zreport_date;
        delete oUpdate.zreport_time;
      };

      sQuery = UPDATE("ZBTP_EHS_DD_FLASHFORM").with(oUpdate).where(`zreport_no='${oInvestigationForm.zreport_no}'`);
      oResponse = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
    }

    if (oInitialForm) {
      if (!oInitialForm.zreport_date) {
        oUpdate.zreport_date = oUpdate.aedat;
        oUpdate.zreport_time = oUpdate.aezet;
      } else if (oUpdate.zreport_date) {
        delete oUpdate.zreport_date;
        delete oUpdate.zreport_time;
      };

      sQuery = UPDATE("ZBTP_EHS_DD_INITIAL").with(oUpdate).where(`zreport_no='${oInvestigationForm.zreport_no}'`);
      oResponse = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
    }

    return { zreport_date: oInvestigationForm.zreport_date, zreport_time: oInvestigationForm.zreport_time };

  });

  srv.on('CancelInvestigationReport', async (req) => {

    var oCurrentDate = new Date();
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);
    const [investigationForm] = req.params;
    var oInvestigationForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INVESTIGATION").where(`zreport_no='${investigationForm.zreport_no}'`));

    if (!oInvestigationForm) {
      req.error(404, bundle.getText("InvestigationformNotFound"));
      return;
    }

    if (oInvestigationForm.status === 'S' || oInvestigationForm.status === 'C') {//Submit edilmiş veya iptal edilmiş bir form bir daha iptal edilemez
      req.error(409, oInvestigationForm.status === 'C' ? bundle.getText("CancelInvestigationFormAlreadySubmitted") : bundle.getText("CancelInvestigationFormAlreadyCancelled"));
      return;
    };
    var sTime = `${oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
    sTime = `PT${sTime.substr(0, 2)}H${sTime.substr(2, 2)}M${sTime.substr(4, 2)}S`;

    var oUpdate = {
      status: "C",
      aedat: oCurrentDate.toLocaleDateString('en-CA', { timeZone: "Turkey" }) + "T00:00:00",
      aezet: sTime,
      aenam: req.user.id
    };

    if (!oInvestigationForm.zreport_date) {
      oUpdate.zreport_date = oUpdate.aedat;
      oUpdate.zreport_time = oUpdate.aezet;

      oInvestigationForm["zreport_date"] = oCurrentDate.toLocaleDateString('en-CA', { timeZone: "Turkey" });
      oInvestigationForm["zreport_time"] = oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" });
    }
    var sQuery = UPDATE("ZBTP_EHS_DD_INVESTIGATION").with(oUpdate).where(`zreport_no='${oInvestigationForm.zreport_no}'`);

    var oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);

    var oUpdate2 = {
      status: "C",
    };

    sQuery = UPDATE("ZBTP_EHS_DD_INITIAL").with(oUpdate2).where(`zreport_no='${oInvestigationForm.zreport_no}'`);
    oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
    sQuery = UPDATE("ZBTP_EHS_DD_FLASHFORM").with(oUpdate2).where(`zreport_no='${oInvestigationForm.zreport_no}'`);
    oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);

    return { zreport_date: oInvestigationForm.zreport_date, zreport_time: oInvestigationForm.zreport_time };
  });

  srv.on('UPDATE', 'FlashForm', async (req) => {

    var sReportNo = req.params[0].zreport_no;
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);
    var oFlashForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_FLASHFORM").where(`zreport_no='${sReportNo}'`));
    var oInitForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INITIAL").where(`zreport_no='${sReportNo}'`));

    if (oFlashForm["status"] === "C" || (oInitForm && oInitForm["status"] === "S")) {
      req.error(422, oFlashForm.status === 'C' ? bundle.getText("UpdateFlashFormAlreadyCancelled") : bundle.getText("UpdateFlashFormInitialSubmitted"));
      return;
    };


    Object.assign(oFlashForm, req.data);

    var oCurrentDate = new Date();
    var sTime = `${oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
    sTime = `PT${sTime.substr(0, 2)}H${sTime.substr(2, 2)}M${sTime.substr(4, 2)}S`;
    oFlashForm["aedat"] = oCurrentDate.toLocaleDateString('en-CA', { timeZone: "Turkey" }) + "T00:00:00";
    oFlashForm["aezet"] = sTime;
    oFlashForm["aenam"] = req.user.id;
    oFlashForm["zincident_date"] = oFlashForm["zincident_date"] + "T00:00:00"
    oFlashForm["zincident_time"] = `${oFlashForm["zincident_time"].split(":").join("")}`;
    oFlashForm["zincident_time"] = `PT${oFlashForm["zincident_time"].substr(0, 2)}H${oFlashForm["zincident_time"].substr(2, 2)}M${oFlashForm["zincident_time"].substr(4, 2)}S`;

    delete oFlashForm["to_Department"];
    delete oFlashForm["to_Management"];
    delete oFlashForm["to_Facility"];
    delete oFlashForm["to_IncCLass"];
    delete oFlashForm["to_Init"];
    delete oFlashForm["to_Status"];
    // delete oFlashForm["zid"];

    var oUpdate = {
      zincident_desc: oFlashForm["zincident_desc"],
      zwell: oFlashForm["zwell"],
      // zincident_title: oFlashForm["zincident_title"],
      ztitle_max: oFlashForm["ztitle_max"],
      zincident_loc: oFlashForm["zincident_loc"],
      zincident_class: oFlashForm["zincident_class"],
      zmedevac: oFlashForm["zmedevac"],
      zdrop: oFlashForm["zdrop"],
      aedat: new Date().toLocaleDateString('en-CA', { timeZone: "Turkey" }) + "T00:00:00",
      aezet: sTime,
      aenam: req.user.id,
      zincident_date: oFlashForm["zincident_date"],
      zincident_time: oFlashForm["zincident_time"]
    };

    var sQuery = UPDATE("ZBTP_EHS_DD_FLASHFORM").with(oUpdate).where(`zreport_no='${sReportNo}'`);
    var oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
    if (oResponse) {
      return oResponse;
    } else {
    }

  });

  srv.on('UpdateInitialForm', async (req) => {

    const [initialForm] = req.params;

    const userEmail = req.user.id;
    const userRole = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_USER").where(`smtp_addr='${userEmail}'`));
    const bypassControl = userRole?.id === '00000000';
    const locale = req.user.locale;

    const bundle = textBundle.getTextBundle(locale);
    var oInitialForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INITIAL").where(`zreport_no='${initialForm.zreport_no}'`));
    if (!bypassControl) {
      if (oInitialForm["status"] === "C" || oInitialForm["status"] === "F") {
        req.error(422, bundle.getText("UpdateInitialFormAlreadyCancelled"));
        return;
      } else if (oInitialForm["status"] === "S") {
        var oInvForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INVESTIGATION").where(`zreport_no='${initialForm.zreport_no}'`));
        if (oInvForm && oInvForm["status"] !== "" && oInvForm["status"] !== undefined) {
          req.error(422, bundle.getText("UpdateInitialFormAlreadyCancelled"));
          return;
        }
      };
    }

    var { FormDetails, PossibleCauses, ImmediateActions, Consequences, InitFiles } = req.data;
    var oDate = new Date();
    if (FormDetails) {
      if (!oInitialForm["zreport_date"]) {

        FormDetails["zreport_date"] = oDate.toLocaleDateString('en-CA', { timeZone: "Turkey" }) + "T00:00:00";
        FormDetails["zreport_time"] = `${oDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
        FormDetails["zreport_time"] = `PT${FormDetails["zreport_time"].substr(0, 2)}H${FormDetails["zreport_time"].substr(2, 2)}M${FormDetails["zreport_time"].substr(4, 2)}S`;

        oInitialForm["zreport_date"] = oDate.toLocaleDateString('en-CA', { timeZone: "Turkey" });
        oInitialForm["zreport_time"] = oDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" });

      }
      if (FormDetails["zincident_class"]) {
        if (!await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INC_CLASS").where(`zincident_classname_key='${FormDetails["zincident_class"]}'`))) {
          req.error(404, bundle.getText("invalidIncidentClass"));
          return;
        }
        if (FormDetails["zincident_type"]) {
          if (!await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INC_TYPE").where(`zincident_class_id='${FormDetails["zincident_class"]}' AND zincident_type_key='${FormDetails["zincident_type"]}'`))) {
            req.error(404, bundle.getText("invalidIncidentType"));
            return;
          }
        }
      }
      if (FormDetails["zincident_relevance"]) {
        if (!await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_RELEVANCE_SH").where(`zincident_relevance_key='${FormDetails["zincident_relevance"]}'`))) {
          req.error(404, bundle.getText("invalidIncidentRelevance"));
          return;
        }
      }
      var sTime = `${oDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
      sTime = `PT${sTime.substr(0, 2)}H${sTime.substr(2, 2)}M${sTime.substr(4, 2)}S`;

      FormDetails.aedat = oDate.toLocaleDateString('en-CA', { timeZone: "Turkey" }) + "T00:00:00";
      FormDetails.aezet = sTime;
      FormDetails.aenam = req.user.id;

      var sQuery = UPDATE("ZBTP_EHS_DD_INITIAL").with(FormDetails).where(`zreport_no='${oInitialForm.zreport_no}'`);
      var oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
      var oInvForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT("zreport_no").from("ZBTP_EHS_DD_INVESTIGATION").where(`zreport_no='${oInitialForm.zreport_no}'`));

      if (oInvForm.length !== 0) {
        delete FormDetails.zapproved_name;
        delete FormDetails.zapproved_signature;
        delete FormDetails.zapproved_date;
        delete FormDetails.zprepared_name;
        delete FormDetails.zprepared_signature;
        delete FormDetails.zprepared_date;

        sQuery = UPDATE("ZBTP_EHS_DD_INVESTIGATION").with(FormDetails).where(`zreport_no='${oInitialForm.zreport_no}'`);
        oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
      }
    }

    //Tablolar

    var oResponse2 = "";
    var aConseqs = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT("zreport_no", "zconsequences_key", "zlikelihood").from("ZBTP_EHS_DD_CONSEQUENCES").where(`zreport_no='${oInitialForm.zreport_no}'`));
    if (aConseqs.length !== 0) {
      await aConseqs.forEach(async conseq => {
        if (Consequences && Consequences.find(row => {
          return row.zreport_no === conseq.zreport_no && row.zconsequences_key === conseq.zconsequences_key && row.zlikelihood === conseq.zlikelihood
        }) !== undefined) {
        } else {
          setTimeout(async function () {
            oResponse2 = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(DELETE.from("ZBTP_EHS_DD_CONSEQUENCES").where(conseq));
            // oResponse2 = await ZBTP_EHS_DD_CONSEQUENCES_CDS.run(DELETE.from("ZBTP_EHS_DD_CONSEQUENCES").where(conseq));
          }, 2000);
          // oResponse2 = await ZBTP_EHS_DD_CONSEQUENCES_CDS.run(DELETE.from("ZBTP_EHS_DD_CONSEQUENCES").where(conseq));
        }
      })
    };
    if (Consequences && Consequences.length !== 0) {
      await Consequences.forEach(async conseq => {
        if (aConseqs && aConseqs.find(row => {
          return row.zreport_no === conseq.zreport_no && row.zconsequences_key === conseq.zconsequences_key && row.zlikelihood === conseq.zlikelihood
        }) !== undefined) {
        } else {
          setTimeout(async function () {
            oResponse2 = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT.into("ZBTP_EHS_DD_CONSEQUENCES").entries(conseq));
          }, 2000);
        }
      });
    };

    var aPoscau = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT("zreport_no", "mic_key", "immediate_key", "znote", "zrow_no").from("ZBTP_EHS_DD_INIT_POS_CAU").where(`zreport_no='${oInitialForm.zreport_no}'`));

    if (PossibleCauses) {
      try {
        const zreport_no = oInitialForm.zreport_no;
        const dbCauses = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from("ZBTP_EHS_DD_INIT_POS_CAU").where({ zreport_no: zreport_no }));

        const getKey = (row) => `${row.mic_key}-${row.immediate_key}-${row.zrow_no}`;
        const dbMap = new Map(dbCauses.map(row => [getKey(row), row]));
        const uiMap = new Map(PossibleCauses.map(row => [getKey(row), row]));

        const allOperations = [];

        for (const [key, dbRow] of dbMap.entries()) {
          if (!uiMap.has(key)) {
            const deletePromise = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
              DELETE.from("ZBTP_EHS_DD_INIT_POS_CAU").where({
                zreport_no: dbRow.zreport_no,
                mic_key: dbRow.mic_key,
                immediate_key: dbRow.immediate_key,
                zrow_no: dbRow.zrow_no
              })
            );
            allOperations.push(deletePromise);
          }
        }

        for (const [key, uiRow] of uiMap.entries()) {
          const dbRow = dbMap.get(key);
          if (!dbRow) {
            const insertPromise = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
              INSERT.into("ZBTP_EHS_DD_INIT_POS_CAU").entries(uiRow)
            );
            allOperations.push(insertPromise);
          } else if (dbRow.znote !== uiRow.znote) {
            const updatePromise = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
              UPDATE("ZBTP_EHS_DD_INIT_POS_CAU")
                .set({ znote: uiRow.znote })
                .where({
                  zreport_no: uiRow.zreport_no,
                  mic_key: uiRow.mic_key,
                  immediate_key: uiRow.immediate_key,
                  zrow_no: uiRow.zrow_no
                })
            );
            allOperations.push(updatePromise);
          }
        }
        if (allOperations.length > 0) {
          await Promise.all(allOperations);
        }

      } catch (err) {
        console.error("PossibleCauses güncellenirken hata:", err);
        req.error(500, 'Possible Causes güncellenirken bir hata oluştu.');
        return;
      }
    }

    var aImmAct = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT("zreport_no", "zrow_no", "zimm_act_taken", "zresponsible_party").from("ZBTP_EHS_DD_INIT_IMM_ACT").where(`zreport_no='${oInitialForm.zreport_no}'`));
    if (aImmAct.length !== 0) {
      await aImmAct.forEach(async immact => {
        if (ImmediateActions && ImmediateActions.find(row => {
          return row.zreport_no === immact.zreport_no && row.zrow_no === immact.zrow_no
        }) !== undefined) {

        } else {
          var oImmAct = {};
          Object.assign(oImmAct, immact);
          delete oImmAct.zimm_act_taken;
          delete oImmAct.zresponsible_party;
          setTimeout(async function () {
            await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(DELETE.from("ZBTP_EHS_DD_INIT_IMM_ACT").where(oImmAct));
          }, 2000);
        }
      })
    };
    if (ImmediateActions && ImmediateActions.length !== 0) {
      // var aImmediateActions = ImmediateActions.sort((a, b) => (a.zrow_no - b.zrow_no) * -1);
      await ImmediateActions.forEach(async actions => {
        if (aImmAct.length !== 0 && aImmAct.find(row => {
          return row.zreport_no === actions.zreport_no && row.zrow_no === actions.zrow_no && row.zimm_act_taken === actions.zimm_act_taken && row.zresponsible_party === actions.zresponsible_party
        }) !== undefined) {

        } else if (aImmAct.length !== 0 && aImmAct.find(row => {
          return row.zreport_no === actions.zreport_no && row.zrow_no === actions.zrow_no
        }) !== undefined) {
          var oImmAct2 = {};
          Object.assign(oImmAct2, actions);
          delete oImmAct2.zreport_no;
          delete oImmAct2.zrow_no;
          setTimeout(async function () {
            sQuery = UPDATE("ZBTP_EHS_DD_INIT_IMM_ACT").with(oImmAct2).where(`zreport_no='${actions.zreport_no}' AND zrow_no='${actions.zrow_no}'`);
            oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
          }, 2000);

        } else {
          setTimeout(async function () {
            oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT(actions).into("ZBTP_EHS_DD_INIT_IMM_ACT"))
          }, 2000);
        }
      })

    };
    return { zreport_date: oInitialForm.zreport_date, zreport_time: oInitialForm.zreport_time };
  });

  srv.on('updateComplaintStatus', async (req) => {
    console.log(req);
  });

  srv.on('UpdateInvestigationForm', async (req) => {

    const [InvestigationForm] = req.params;
    const locale = req.user.locale;
    const userEmail = req.user.id;
    const userRole = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_USER").where(`smtp_addr='${userEmail}'`));
    const bypassControl = userRole?.id === '00000000';
    const bundle = textBundle.getTextBundle(locale);
    var oInvestigationForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INVESTIGATION").where(`zreport_no='${InvestigationForm.zreport_no}'`));

    if (!oInvestigationForm) {
      req.error(404, bundle.getText("InvestigationFormNotFound"));
      return;
    }

    if (!bypassControl) {
      if (oInvestigationForm["status"] !== "" && oInvestigationForm["status"] !== undefined) {
        req.error(422, bundle.getText("UpdateInitialFormAlreadyCancelled"));
        return;
      };
    }


    var { FormDetails, ImmediateActions, RootCauses, InvTeam, InjDmg, InjuryPeople, BodyParts, RemdActs } = req.data;
    var oDate = new Date();
    if (FormDetails) {
      if (!oInvestigationForm["zreport_date"]) {

        FormDetails["zreport_date"] = oDate.toLocaleDateString('en-CA', { timeZone: "Turkey" }) + "T00:00:00";
        FormDetails["zreport_time"] = `${oDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
        FormDetails["zreport_time"] = `PT${FormDetails["zreport_time"].substr(0, 2)}H${FormDetails["zreport_time"].substr(2, 2)}M${FormDetails["zreport_time"].substr(4, 2)}S`;

        oInvestigationForm["zreport_date"] = oDate.toLocaleDateString('en-CA', { timeZone: "Turkey" });
        oInvestigationForm["zreport_time"] = oDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" });

      }
      if (FormDetails["zincident_relevance"]) {
        if (!await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from("ZBTP_EHS_DD_INj_PERS_COMP").where(`ZINJ_PER_COMP_KEY='${FormDetails["zinj_per_comp_key"]}'`))) {
          req.error(404, bundle.getText("invalidPersonelCompany"));
          return;
        }
      }
      var sTime = `${oDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
      sTime = `PT${sTime.substr(0, 2)}H${sTime.substr(2, 2)}M${sTime.substr(4, 2)}S`;

      FormDetails.aedat = oDate.toLocaleDateString('en-CA', { timeZone: "Turkey" }) + "T00:00:00";
      FormDetails.aezet = sTime;
      FormDetails.aenam = req.user.id;

      if (FormDetails.zexp_occu) {
        FormDetails.zexp_occu = parseInt(FormDetails.zexp_occu);
      }
      if (FormDetails.zexp_pos) {
        FormDetails.zexp_pos = parseInt(FormDetails.zexp_pos);
      }
      if (FormDetails.zdays_shift) {
        FormDetails.zdays_shift = parseInt(FormDetails.zdays_shift);
      }
      if (FormDetails.ztour_time) {
        FormDetails.ztour_time = parseInt(FormDetails.ztour_time);
      }
      var sQuery = UPDATE("ZBTP_EHS_DD_INVESTIGATION").with(FormDetails).where(`zreport_no='${oInvestigationForm.zreport_no}'`);
      var oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
      if (oResponse) {
        return oResponse;
      }

    }
    //---------------------ImmediateActions----------------------------
    // var aImmAct = await ZBTP_EHS_DD_INVESTIGATION_CDS.run(SELECT.from('ZBTP_EHS_DD_INV_IMM_ACT').where(`zreport_no='${InvestigationForm.zreport_no}'`));
    // if (aImmAct && aImmAct.length !== 0) {
    //   await aImmAct.forEach(async immact => {
    //     if (ImmediateActions && ImmediateActions.find(row => {
    //       return row.zreport_no === immact.zreport_no && row.zrow_no === immact.zrow_no
    //     }) !== undefined) {

    //     } else {
    //       var oImmAct = {};
    //       Object.assign(oImmAct, immact);
    //       delete oImmAct.zimm_act_taken;
    //       delete oImmAct.zresponsible_party;
    //       setTimeout(async function () {
    //         await ZBTP_EHS_DD_INVESTIGATION_CDS.run(DELETE.from("ZBTP_EHS_DD_INV_IMM_ACT").where(oImmAct));
    //       }, 2000);
    //       // await ZBTP_EHS_DD_INIT_IMM_ACT_CDS.run(DELETE.from("ZBTP_EHS_DD_INIT_IMM_ACT").where(oImmAct));
    //     }
    //   })
    //   // oResponse = await ZBTP_EHS_DD_INIT_IMM_ACT_CDS.run(DELETE.from("ZBTP_EHS_DD_INIT_IMM_ACT").where(oResponse));
    //   // oResponse = await ZBTP_EHS_DD_INITIAL_CDS.run(DELETE.from("ZBTP_EHS_DD_INIT_IMM_ACT").where(`zreport_no='${oInitialForm.zreport_no}'`));
    // };
    // if (ImmediateActions && ImmediateActions.length !== 0) {
    //   console.log("IMMACT-BEFORE-INSERT ", ImmediateActions);
    //   console.log("IMMACT-BEFORE-INSERT:aImmAct ", aImmAct);
    //   var int = 0;
    //   var aImmediateActions = ImmediateActions.sort((a, b) => (a.zrow_no - b.zrow_no) * -1);
    //   await aImmediateActions.forEach(async actions => {
    //     if (int === 0) {
    //       int = actions.zrow_no + 1;
    //     }
    //     if (!actions.zrow_no) {
    //       actions.zrow_no = int;
    //       int += 1;
    //       setTimeout(async function () {
    //         oResponse = await ZBTP_EHS_DD_INVESTIGATION_CDS.run(INSERT(actions).into("ZBTP_EHS_DD_INV_IMM_ACT"));
    //       }, 2000);
    //     } else if (aImmAct.length !== 0 && aImmAct.find(row => {
    //       return row.zreport_no === actions.zreport_no && row.zrow_no === actions.zrow_no && row.zimm_act_taken === actions.zimm_act_taken && row.zresponsible_party === actions.zresponsible_party
    //     }) !== undefined) {

    //     } else if (aImmAct.length !== 0 && aImmAct.find(row => {
    //       return row.zreport_no === actions.zreport_no && row.zrow_no === actions.zrow_no
    //     }) !== undefined) {
    //       var oImmAct2 = {};
    //       Object.assign(oImmAct2, actions);
    //       delete oImmAct2.zreport_no;
    //       delete oImmAct2.zrow_no;
    //       setTimeout(async function () {
    //         sQuery = UPDATE("ZBTP_EHS_DD_INV_IMM_ACT").with(oImmAct2).where(`zreport_no='${actions.zreport_no}' AND zrow_no='${actions.zrow_no}'`);
    //         oResponse = await ZBTP_EHS_DD_INVESTIGATION_CDS.run(sQuery);
    //       }, 2000);

    //     } else {
    //       setTimeout(async function () {
    //         oResponse = await ZBTP_EHS_DD_INVESTIGATION_CDS.run(INSERT(actions).into("ZBTP_EHS_DD_INV_IMM_ACT"))
    //       }, 2000);
    //     }
    //   })

    // }


    //---------------------RootCauses----------------------------------
    var aRootCauses = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from('ZBTP_EHS_DD_ROOT_CAUSES_SH').where(`zreport_no='${InvestigationForm.zreport_no}'`));
    if (aRootCauses && aRootCauses.length !== 0) {
      await aRootCauses.forEach(async rootcause => {
        if (RootCauses && RootCauses.find(row => {
          return row.zreport_no === rootcause.zreport_no && row.zmrc_key === rootcause.zmrc_key && row.zrc_key === rootcause.zrc_key
        }) !== undefined) {

        } else {
          setTimeout(async function () {
            var oTemp = {};
            Object.assign(oTemp, rootcause);
            delete oTemp.znote;
            delete oTemp.zrow_no;
            delete oTemp.to_MainRoot;
            delete oTemp.to_Root;
            await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(DELETE.from("ZBTP_EHS_DD_ROOT_CAUSES_SH").where(oTemp));
          }, 2000);
        }
      })
    };
    if (RootCauses && RootCauses.length !== 0) {
      await RootCauses.forEach(async causes => {
        if (aRootCauses.length !== 0 && aRootCauses.find(row => {
          return row.zreport_no === causes.zreport_no && row.zmrc_key === causes.zmrc_key && row.zrc_key === causes.zrc_key && row.znote === causes.znote && row.zrow_no === causes.zrow_no
        }) !== undefined) {

        } else if (aRootCauses.length !== 0 && aRootCauses.find(row => {
          return row.zreport_no === causes.zreport_no && row.zmrc_key === causes.zmrc_key && row.zrc_key === causes.zrc_key
        }) !== undefined) {
          var oRootCause = {};
          Object.assign(oRootCause, causes);
          delete oRootCause.zreport_no;
          delete oRootCause.zmrc_key;
          delete oRootCause.zrc_key;
          setTimeout(async function () {
            sQuery = UPDATE("ZBTP_EHS_DD_ROOT_CAUSES_SH").with(oRootCause).where(`zreport_no='${causes.zreport_no}' AND zmrc_key='${causes.zmrc_key}' AND zrc_key='${causes.zrc_key}'`);
            oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
          }, 2000);
        }
        else {
          setTimeout(async function () {
            oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT(causes).into("ZBTP_EHS_DD_ROOT_CAUSES_SH"))
          }, 2000);
        }
      });
    }

    //---------------------InvTeam-------------------------------------
    var aInvTeam = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from('ZBTP_EHS_DD_INV_TEAM').where(`zreport_no='${InvestigationForm.zreport_no}'`));
    if (aInvTeam && aInvTeam.length !== 0) {
      await aInvTeam.forEach(async invteam => {
        if (InvTeam && InvTeam.find(row => {
          return row.zreport_no === invteam.zreport_no && row.zrow_no === invteam.zrow_no
        }) !== undefined) {

        } else {
          var oInvteam = {};
          Object.assign(oInvteam, invteam);
          delete oInvteam.zinvestigator_name;
          delete oInvteam.zcompany;
          delete oInvteam.zposition;
          setTimeout(async function () {
            await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(DELETE.from("ZBTP_EHS_DD_INV_TEAM").where(oInvteam));
          }, 2000);
        }
      })
    };
    if (InvTeam && InvTeam.length !== 0) {
      var int = 0;
      var aInvTeam2 = InvTeam.sort((a, b) => (a.zrow_no - b.zrow_no) * -1);
      await aInvTeam2.forEach(async invteam => {
        if (int === 0) {
          int = invteam.zrow_no + 1;
        }
        if (!invteam.zrow_no) {
          invteam.zrow_no = int;
          int += 1;
          setTimeout(async function () {
            oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT(invteam).into("ZBTP_EHS_DD_INV_TEAM"));
          }, 2000);
        } else if (aInvTeam.length !== 0 && aInvTeam.find(row => {
          return row.zreport_no === invteam.zreport_no && row.zrow_no === invteam.zrow_no && row.zinvestigator_name === invteam.zinvestigator_name && row.zposition === invteam.zposition && row.zcompany === invteam.zcompany
        }) !== undefined) {

        } else if (aInvTeam.length !== 0 && aInvTeam.find(row => {
          return row.zreport_no === invteam.zreport_no && row.zrow_no === invteam.zrow_no
        }) !== undefined) {
          var oInvTeam2 = {};
          Object.assign(oInvTeam2, invteam);
          delete oInvTeam2.zreport_no;
          delete oInvTeam2.zrow_no;
          setTimeout(async function () {
            sQuery = UPDATE("ZBTP_EHS_DD_INV_TEAM").with(oInvTeam2).where(`zreport_no='${invteam.zreport_no}' AND zrow_no='${invteam.zrow_no}'`);
            oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
            // oResponse = await ZBTP_EHS_DD_INVESTIGATION_CDS.run(sQuery);
          }, 2000);

        } else {
          setTimeout(async function () {
            oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT(invteam).into("ZBTP_EHS_DD_INV_TEAM"))
          }, 2000);
        }
      })

    }

    //---------------------InjDmg----------------------------------
    var aInjDmg = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from('ZBTP_EHS_DD_INV_INJ_DMG').where(`zreport_no='${InvestigationForm.zreport_no}'`));
    if (aInjDmg && aInjDmg.length !== 0) {
      await aInjDmg.forEach(async rootcause => {
        if (InjDmg && InjDmg.find(row => {
          return row.zreport_no === rootcause.zreport_no && row.zill_types_key === rootcause.zill_types_key
        }) !== undefined) {

        } else {
          setTimeout(async function () {
            var oTemp = {};
            Object.assign(oTemp, rootcause);
            delete oTemp.to_Inv;
            await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(DELETE.from("ZBTP_EHS_DD_INV_INJ_DMG").where(oTemp));
          }, 2000);
        }
      })
    };
    if (InjDmg && InjDmg.length !== 0) {
      await InjDmg.forEach(async damage => {
        if (aInjDmg.length !== 0 && aInjDmg.find(row => {
          return row.zreport_no === damage.zreport_no && row.zill_types_key === damage.zill_types_key
        }) !== undefined) {

        } else {
          setTimeout(async function () {
            oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT(damage).into("ZBTP_EHS_DD_INV_INJ_DMG"))
          }, 2000);
        }
      });
    }

    //---------------------InjuryPeople----------------------------------
    var aInjPpl = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from('ZBTP_EHS_DD_INV_INJ_PPL').where(`zreport_no='${InvestigationForm.zreport_no}'`));
    if (aInjPpl && aInjPpl.length !== 0) {
      await aInjPpl.forEach(async bodypart => {
        if (InjuryPeople && InjuryPeople.find(row => {
          return row.zreport_no === bodypart.zreport_no && row.idx === bodypart.idx
        }) !== undefined) {

        } else {
          var oTemp = {};
          Object.assign(oTemp, bodypart);
          delete oTemp.name;
          delete oTemp.lastname;
          delete oTemp.zposition;
          delete oTemp.zexp_occu;
          delete oTemp.zexp_pos;
          delete oTemp.zdays_shift;
          delete oTemp.ztour_time;
          delete oTemp.to_Parts;
          await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(DELETE.from("ZBTP_EHS_DD_INV_INJ_PPL").where(oTemp));
        }
      })
    };
    if (InjuryPeople && InjuryPeople.length !== 0) {
      await InjuryPeople.forEach(async part => {
        if (aInjPpl.length !== 0 && aInjPpl.find(row => {
          return row.zreport_no === part.zreport_no && row.idx === part.idx && (row.zposition !== part.zposition || row.zexp_occu !== part.zexp_occu || row.zexp_pos !== part.zexp_pos || row.zdays_shift !== part.zdays_shift || row.ztour_time !== part.ztour_time || row.name !== part.name || row.lastname !== part.lastname)
        }) !== undefined) {
          var oInjPpl = {};
          Object.assign(oInjPpl, part);
          delete oInjPpl.zreport_no;
          delete oInjPpl.idx;
          sQuery = UPDATE("ZBTP_EHS_DD_INV_INJ_PPL").with(oInjPpl).where(`zreport_no='${part.zreport_no}' AND idx='${part.idx}'`);
          oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
        } else if (aInjPpl.length !== 0 && aInjPpl.find(row => {
          return row.zreport_no === part.zreport_no && row.idx === part.idx
        }) !== undefined) {

        } else {
          oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT(part).into("ZBTP_EHS_DD_INV_INJ_PPL"));
        }
      });
    }

    //---------------------BodyParts----------------------------------
    var aBodyParts = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from('ZBTP_EHS_DD_INV_BODY_PART').where(`zreport_no='${InvestigationForm.zreport_no}'`));
    if (aBodyParts && aBodyParts.length !== 0) {
      await aBodyParts.forEach(async bodypart => {
        if (BodyParts && BodyParts.find(row => {
          return row.zreport_no === bodypart.zreport_no && row.zbody_key === bodypart.zbody_key && row.idx === bodypart.idx
        }) !== undefined) {

        } else {
          var oTemp = {};
          Object.assign(oTemp, bodypart);
          delete oTemp.to_Body;
          await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(DELETE.from("ZBTP_EHS_DD_INV_BODY_PART").where(oTemp));
        }
      })
    };
    if (BodyParts && BodyParts.length !== 0) {
      await BodyParts.forEach(async part => {
        if (aBodyParts.length !== 0 && aBodyParts.find(row => {
          return row.zreport_no === part.zreport_no && row.zbody_key === part.zbody_key && row.idx === part.idx
        }) !== undefined) {

        } else {
          oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT(part).into("ZBTP_EHS_DD_INV_BODY_PART"))
        }
      });
    }

    //---------------------RemedialActions----------------------------
    var aRemdActs = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from('ZBTP_EHS_DD_REMEDIAL_ACTIONS').where(`zreport_no='${InvestigationForm.zreport_no}'`));
    if (aRemdActs && aRemdActs.length !== 0) {
      await aRemdActs.forEach(async remact => {
        if (RemdActs && RemdActs.find(row => {
          return row.zreport_no === remact.zreport_no && row.zrow_no === remact.zrow_no
        }) !== undefined) {

        } else {
          var oRemAct = {};
          Object.assign(oRemAct, remact);
          delete oRemAct.zrem_act_actions;
          delete oRemAct.zrem_act_respons;
          delete oRemAct.zrem_act_due_date;
          delete oRemAct.zrem_act_status;
          delete oRemAct.zrem_act_closed_date;
          setTimeout(async function () {
            await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(DELETE.from("ZBTP_EHS_DD_REMEDIAL_ACTIONS").where(oRemAct));
          }, 2000);
        }
      })
    };
    if (RemdActs && RemdActs.length !== 0) {
      var int = 0;
      var aRemdActs2 = RemdActs.sort((a, b) => (a.zrow_no - b.zrow_no) * -1);
      await aRemdActs2.forEach(async actions => {
        if (int === 0) {
          int = actions.zrow_no + 1;
        }
        if (!actions.zrow_no) {
          actions.zrow_no = int;
          int += 1;
          setTimeout(async function () {
            oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT(actions).into("ZBTP_EHS_DD_REMEDIAL_ACTIONS"));
          }, 2000);
        } else if (aRemdActs.length !== 0 && aRemdActs.find(row => {
          return row.zreport_no === actions.zreport_no && row.zrow_no === actions.zrow_no && row.zrem_act_actions === actions.zrem_act_actions && row.zrem_act_respons === actions.zrem_act_respons && row.zrem_act_due_date === actions.zrem_act_due_date && row.zrem_act_status === actions.zrem_act_status && row.zrem_act_closed_date === actions.zrem_act_closed_date
        }) !== undefined) {

        } else if (aRemdActs.length !== 0 && aRemdActs.find(row => {
          return row.zreport_no === actions.zreport_no && row.zrow_no === actions.zrow_no
        }) !== undefined) {
          var oRemdAct2 = {};
          Object.assign(oRemdAct2, actions);
          delete oRemdAct2.zreport_no;
          delete oRemdAct2.zrow_no;
          setTimeout(async function () {
            sQuery = UPDATE("ZBTP_EHS_DD_REMEDIAL_ACTIONS").with(oRemdAct2).where(`zreport_no='${actions.zreport_no}' AND zrow_no='${actions.zrow_no}'`);
            oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
          }, 2000);

        } else {
          setTimeout(async function () {
            oResponse = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT(actions).into("ZBTP_EHS_DD_REMEDIAL_ACTIONS"))
          }, 2000);
        }
      })

    }

    return { zreport_date: oInvestigationForm.zreport_date, zreport_time: oInvestigationForm.zreport_time };
  });

  srv.on('RiskMatrix', async (req) => {
    var formNo;
    if (req.params.length !== 0) {
      [formNo] = req.params;
    } else if (req.data) {
      formNo = req.data;
    };
    const locale = req.user.locale ? req.user.locale : req.locale.toUpperCase();
    const bundle = textBundle.getTextBundle(locale);
    var aFormMatrix = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from('ZBTP_EHS_DD_CONSEQUENCES').where(`zreport_no='${formNo.zreport_no}'`));
    if (!aFormMatrix || aFormMatrix.length === 0) {
      req.error(404, bundle.getText("riskMatrixNotFound"));
      return;
    }
    var aConseq = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from('ZBTP_EHS_DD_CONSEQUENCES_SH').where(`spras = '${locale}'`).orderBy('zorder'));

    var aResponse = [];
    aConseq.forEach(conseq => {
      var oFormMatrix = aFormMatrix.find(row => { return conseq.zconsequences_key === row.zconsequences_key });
      if (oFormMatrix) {
        aResponse.push({
          zconsequences_type: conseq.zconsequences_type,
          zincident_severity: conseq.zincident_severity,
          zconsequences_key: conseq.zconsequences_key,
          zlikelihood: oFormMatrix.zlikelihood,
          zinv_lvl: "",
          zorder: conseq.zorder
        });
      }
    });

    var aRisk = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from('ZBTP_EHS_DD_RISK').where(`spras='${locale}'`));
    for (let index = 0; index < aResponse.length; index++) {
      var element = aResponse[index];
      var oRisk = aRisk.find(row => { return row.zrisk_key === `${element.zlikelihood}${element.zincident_severity}` });
      if (oRisk) {
        aResponse[index].zinv_lvl = oRisk.zrisk;
      };
    };

    aConseq.forEach(conseq => {
      if (!aResponse.find(resp => { return resp.zconsequences_type === conseq.zconsequences_type })) {
        aResponse.push({
          zconsequences_type: conseq.zconsequences_type,
          zincident_severity: "",
          zconsequences_key: "",
          zlikelihood: "",
          zinv_lvl: "",
          zorder: conseq.zorder
        });
      }
    });
    aResponse.sort((a, b) => { return a.zorder - b.zorder });

    return aResponse;
  });

  srv.on('GetDMSFiles', async (req) => {
    var formNo;
    var zinv;
    if (req.params.length !== 0) {
      [formNo, zinv] = req.params;
    } else if (req.data.zreport_no) {
      formNo = req.data.zreport_no;
      zinv = req.data.zinv;
    } else if (req.req.body) {
      formNo = req.req.body.zreport_no;
      zinv = req.req.body.zinv;
    }
    else {
      return;
    };
    var oRepositoryResponse = await getDMSRepositories();
    if (oRepositoryResponse.data) {
      var aRepositories = oRepositoryResponse.data;
    }
    var oRepository = aRepositories['EHS_REPOSITORY'];
    var oFoldersResponse = await getDMSRepositoryFolders(oRepository.repositoryId, "");
    var aFolders = oFoldersResponse.data.objects;
    var oFolderCreateResponse;
    var aFiles;
    var aFileContents = [];
    if (aFolders.length === 0 || !aFolders.find(row => { return row.object.properties["cmis:name"].value === formNo })) {
    } else {
      aFiles = await getDMSFolderForForm(oRepository.repositoryId, formNo, "");
      var aInvFiles = [];
      if (aFiles.data.objects) {
        for (let index = 0; index < aFiles.data.objects.length; index++) {
          try {
            var file = aFiles.data.objects[index];
            var fileName = file.object.properties["cmis:name"].value;
            if (fileName === formNo + "-INV") {
              // if (fileName === formNo + "-INV" || file.object.properties["cmis:objectTypeId"].value === "cmis:folder") {
              if (zinv === "X") {
                aInvFiles = await getDMSFolderForForm(oRepository.repositoryId, formNo, "/" + encodeURIComponent(fileName));
              }
            } else if (file.object.properties["cmis:objectTypeId"].value === "cmis:folder") {
              //Klasörler hariç tutulur
              if (fileName === `${formNo}-SIGNATURES`) {
                var aSignatures = await getDMSFolderForForm(oRepository.repositoryId, formNo, "/" + encodeURIComponent(fileName));
                aSignatures.data.objects.forEach(row => {
                  if (zinv === 'X' && row.object.properties["cmis:name"].value === `${formNo}-InvestigationForm`) {
                    //InvestigationForm'da imzalı belge mevcut
                  } else if (zinv === '' && row.object.properties["cmis:name"].value === `${formNo}-InitialForm`) {
                    //InitialForm'da imzalı belge mevcut
                  };
                });
              }
            } else {
              var sEndpoint = `/browser/${encodeURIComponent(oRepository.repositoryId)}/root/${encodeURIComponent(formNo)}/${encodeURIComponent(fileName)}?download=inline&cmisselector=content`
              aFileContents.push({ zreport_no: formNo, filename: fileName, fileContent: sEndpoint, fileType: file.object.properties["cmis:contentStreamMimeType"].value, zinv: "" });
            }

          } catch (error) {
            console.log(error);
          };

        }
        if (aInvFiles.length !== 0 && aInvFiles.data.objects.length !== 0) {
          for (let index = 0; index < aInvFiles.data.objects.length; index++) {
            try {
              var file = aInvFiles.data.objects[index];
              var fileName = file.object.properties["cmis:name"].value;
              var sEndpoint = `/browser/${encodeURIComponent(oRepository.repositoryId)}/root/${encodeURIComponent(formNo)}/${encodeURIComponent(formNo + "-INV")}/${encodeURIComponent(fileName)}?download=inline&cmisselector=content`
              aFileContents.push({ zreport_no: formNo, filename: fileName, fileContent: sEndpoint, fileType: file.object.properties["cmis:contentStreamMimeType"].value, zinv: "X" });
            } catch (error) {
              console.log(error);
            };
          }
        }
        return aFileContents;
      };
    }
  });

  srv.on('GetSignature', async (req) => {
    var formNo;
    var formType;
    if (req.params.length !== 0) {
      [formNo, formType] = req.params;
      formNo = formNo.zreport_no;
      formType = req.entity.split(".")[1];
    } else if (req.data.zreport_no) {
      formNo = req.data.zreport_no;
      formType = req.data.formType;
    } else if (req.req.body) {
      formNo = req.req.body.zreport_no;
      formType = req.req.body.formType;
    } else {
      return;
    };
    var oRepositoryResponse = await getDMSRepositories();
    if (oRepositoryResponse.data) {
      var aRepositories = oRepositoryResponse.data;
    }
    var oRepository = aRepositories['EHS_REPOSITORY'];
    var oFoldersResponse = await getDMSRepositoryFolders(oRepository.repositoryId, "");
    var aFolders = oFoldersResponse.data.objects;
    var aFiles;
    var aFileContents = [];
    var filename = formNo + "_" + formType;
    if (aFolders.length === 0 || !aFolders.find(row => { return row.object.properties["cmis:name"].value === formNo })) {
    } else {
      aFiles = await getDMSFolderForForm(oRepository.repositoryId, formNo, "/" + encodeURIComponent(formNo + "-SIGNATURES"));
      if (aFiles.data.objects) {
        var file = aFiles.data.objects.find(row => {
          return row.object.properties["cmis:name"].value === filename
        });
        if (file) {
          var sEndpoint = `/browser/${encodeURIComponent(oRepository.repositoryId)}/root/${encodeURIComponent(formNo)}/${encodeURIComponent(formNo + "-SIGNATURES")}/${filename}?download=inline&cmisselector=content`
          aFileContents.push({ zreport_no: formNo, filename: filename, fileContent: sEndpoint, fileType: file.object.properties["cmis:contentStreamMimeType"].value, zinv: "" });

          return aFileContents;
        }
      };
    }
  });

  srv.on('CheckSignature', async (req) => {
    var formNo;
    var formType;
    if (req.params.length !== 0) {
      [formNo, formType] = req.params;
      formNo = formNo.zreport_no;
      formType = req.entity.split(".")[1];
    } else if (req.data.zreport_no) {
      formNo = req.data.zreport_no;
      formType = req.data.formType;
    } else if (req.req.body) {
      formNo = req.req.body.zreport_no;
      formType = req.req.body.formType;
    } else {
      return;
    };

    var bSigned = false;
    var aURLEndpoints = [`/${encodeURIComponent(formType + "-SIGNATURES")}`];
    var iIndex = -1;
    while (!bSigned) {
      iIndex += 1;
      if (iIndex >= aURLEndpoints.length) {
        break;
      };

      var aFolderContent = await getDMSFolderForForm("EHS_REPOSITORY", formNo, aURLEndpoints[iIndex]);
      if (aFolderContent.data && aFolderContent.data.objects.length !== 0 && aFolderContent.data.objects.find(row => {
        return row.object.properties["cmis:objectTypeId"].value !== "cmis:folder"
      })) {
        bSigned = true;
      } else if (aFolderContent.data && aFolderContent.data.objects.length !== 0) {
        aFolderContent.data.objects.forEach(row => {
          aURLEndpoints.push(`${aURLEndpoints[iIndex]}/${encodeURIComponent(row.object.properties["cmis:name"].value)}`);
        });
      }
    };
    var oUpdate = { signfolderpresent: bSigned ? 'X' : '' };
    var sQuery = '';
    if (formType === 'InitialForm') {
      sQuery = UPDATE("ZBTP_EHS_DD_INITIAL").with(oUpdate).where(`zreport_no='${formNo}'`);
    } else if (formType === 'InvestigationForm') {
      sQuery = UPDATE("ZBTP_EHS_DD_INVESTIGATION").with(oUpdate).where(`zreport_no='${formNo}'`);
    }
    await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
    return bSigned;
  });


  srv.on('CreatePDF', async (req) => {
    var formNo;
    var formType;
    if (req.params.length !== 0) {
      [formNo, formType] = req.params;
      formNo = formNo.zreport_no;
      formType = req.entity.split(".")[1];
    } else if (req.data.zreport_no) {
      formNo = req.data.zreport_no;
      formType = req.data.formType;
    } else if (req.req.body) {
      formNo = req.req.body.zreport_no;
      formType = req.req.body.formType;
    } else {
      return;
    };
    const locale = req.user.locale ? req.user.locale : req.locale.toUpperCase();
    switch (formType) {
      case "FlashForm":
        var sQuery = SELECT('*', { ref: ['to_Facility'], expand: ['*'] }, { ref: ['to_IncCLass'], expand: ['*'] }).from("ZBTP_EHS_DD_FLASHFORM").where(`zreport_no='${formNo}'`);
        var aFlashForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
        // var aFlashForm = await ZBTP_EHS_DD_FLASHFORM_CDS.run(sQuery);
        var sLocale = req.locale;
        var sxdpTemplate = `${formType}/${formType}_` + req.locale[0].toUpperCase() + req.locale[1];
        if (!aFlashForm) {
          req.error(404, "Not Found!");
          return;
        }
        var oFlashForm = aFlashForm[0];
        var sXMLString = `<?xml version="1.0" encoding="UTF-8"?><form1><Facility_Unit>${oFlashForm['to_Facility']['zfacility_unit']}</Facility_Unit><Well_Project_Site>${oFlashForm['zwell']}</Well_Project_Site><Report_No>${formNo}</Report_No><Incident_Location>${oFlashForm['zincident_loc']}</Incident_Location><Date_of_Incident>${oFlashForm['zincident_date']}</Date_of_Incident><Time_of_Incident>${oFlashForm['zincident_time']}</Time_of_Incident><Incident_Title>${oFlashForm['ztitle_max']}</Incident_Title><Personel_Injury>${oFlashForm['zincident_class'] === 'INJ' ? 1 : 0}</Personel_Injury><Environmental_damage>${oFlashForm["zincident_class"] === 'END' ? 1 : 0}</Environmental_damage><Propery_Damage>${oFlashForm["zincident_class"] === 'PRD' ? 1 : 0}</Propery_Damage><Near_Miss>${oFlashForm["zincident_class"] === 'NEM' ? 1 : 0}</Near_Miss><occupatiional_illess>${oFlashForm["zincident_class"] === 'OIL' ? 1 : 0}</occupatiional_illess><DROP>${oFlashForm['zdrop'] === 'X' ? 1 : 0}</DROP><MEDEVAC>${oFlashForm['zmedevac'] === 'X' ? 1 : 0}</MEDEVAC><illness>${oFlashForm["zincident_class"] === 'ILN' ? 1 : 0}</illness><not_applicable>${oFlashForm["zincident_class"] === 'N/A' ? 1 : 0}</not_applicable><Brief_Descripton_of_the_Incident>${oFlashForm['zincident_desc']}</Brief_Descripton_of_the_Incident></form1>`;
        sXMLString = sXMLString.replace(/>([^<]*)</g, (match, content) => {
          return '>' + content
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&apos;") + '<';
        });

        sXMLString = sXMLString.replace(/[\x00-\x08\x0B\x0C\x0E-\x1F]/g, "");
        break;

      case 'InitialForm':
        sQuery = SELECT('*', { ref: ['to_Facility'], expand: ['*'] }, { ref: ['to_IncClass'], expand: ['*'] }, { ref: ['to_Pos'], expand: ['*'] }, { ref: ['to_Act'], expand: ['*'] }, { ref: ['to_RealOut'], expand: ['*'] }, { ref: ['to_Cons'], expand: ['*'] }).from("ZBTP_EHS_DD_INITIAL").where(`zreport_no='${formNo}'`);
        aFlashForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
        sLocale = req.locale;
        sxdpTemplate = `${formType}/${formType}_` + req.locale[0].toUpperCase() + req.locale[1];
        if (!aFlashForm) {
          req.error(404, "Not Found!");
          return;
        }
        oFlashForm = aFlashForm[0];

        sXMLString = `<?xml version="1.0" encoding="UTF-8"?><form1><Facility_Unit>${oFlashForm['to_Facility']['zfacility_unit']}</Facility_Unit><Well_Project>${oFlashForm['zwell']}</Well_Project><Report_No>${formNo}</Report_No><Incident_location>${oFlashForm['zincident_loc']}</Incident_location><Date_of_Incident>${oFlashForm['zincident_date']}</Date_of_Incident><Time_of_incident>${oFlashForm['zincident_time']}</Time_of_incident><Incident_title>${oFlashForm['ztitle_max']}</Incident_title><NM>${oFlashForm['zincident_type'] === 'NM' ? 1 : 0}</NM><NWR>${oFlashForm['zincident_relevance'] === '2' ? 1 : 0}</NWR><FTL>${["FT1", "FT2", "FT3"].find(row => { return row === oFlashForm["zincident_type"]; }) ? 1 : 0}</FTL><LTI>${["LT1", "LT2", "LT3"].find(row => { return row === oFlashForm["zincident_type"]; }) ? 1 : 0}</LTI><RWC>${["RW1", "RW2", "RW3"].find(row => { return row === oFlashForm["zincident_type"]; }) ? 1 : 0}</RWC><MTC>${["MT1", "MT2", "MT3"].find(row => { return row === oFlashForm["zincident_type"]; }) ? 1 : 0}</MTC><FAC>${["FA1", "FA2", "FA3"].find(row => { return row === oFlashForm["zincident_type"]; }) ? 1 : 0}</FAC><MVA>${['MV1', 'MV2'].includes(oFlashForm['zincident_type']) ? 1 : 0}</MVA><Environmental>${oFlashForm['zincident_type'] === 'EN1' ? 1 : 0}</Environmental><Property_Damage>${oFlashForm['zincident_type'] === 'PD' ? 1 : 0}</Property_Damage><Drop>${oFlashForm['zdrop'] === 'X' ? 1 : 0}</Drop><Medevac>${oFlashForm['zmedevac'] === 'X' ? 1 : 0}</Medevac><Incident_Description>${oFlashForm['zincident_desc']}</Incident_Description>`;

        oFlashForm['to_Act'].sort((a, b) => {
          const rowNoA = (a.zrow_no === null || a.zrow_no === undefined) ? Infinity : Number(a.zrow_no);
          const rowNoB = (b.zrow_no === null || b.zrow_no === undefined) ? Infinity : Number(b.zrow_no);
          return rowNoA - rowNoB;
        });

        oFlashForm['to_Act'].forEach(row => {
          sXMLString = sXMLString + `<immediate_action_taken_row><immediate_action>${row.zimm_act_taken}</immediate_action><immediate_responsible>${row.zresponsible_party}</immediate_responsible></immediate_action_taken_row>`;
        });
        sXMLString = sXMLString + `<initial_findings>${oFlashForm['zinitial_findings']}</initial_findings>`;
        var aPos = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT('*', { ref: ['to_Immc'], expand: ['*'] }, { ref: ['to_Mimm'], expand: ['*'] }).from('ZBTP_EHS_DD_INIT_POS_CAU').where(`zreport_no='${formNo}'`))

        aPos.sort((a, b) => {
          const rowNoA = (a.zrow_no === null || a.zrow_no === undefined) ? Infinity : Number(a.zrow_no);
          const rowNoB = (b.zrow_no === null || b.zrow_no === undefined) ? Infinity : Number(b.zrow_no);
          return rowNoA - rowNoB;
        });

        aPos.forEach(row => {
          sXMLString = sXMLString + `<possible_causes_row><main_immediate_causes>${row['to_Mimm'].zmain_imm_causes}</main_immediate_causes><immediate_caıses>${row['to_Immc'].zimmediate_causes}</immediate_caıses><cause_definition>${row['to_Immc'].zdefinition}</cause_definition><notes>${row.znote}</notes></possible_causes_row>`;
        });
        var aLevel = ["Negligible", "Slight", "Moderate", "High", "Very High", "İhmal edilebilir", "Hafif", "Orta", "Yüksek", "Çok Yüksek"];
        var risk = "";
        var i = -1;

        var aConseqs = await CreateRiskMatrix(formNo, locale);

        aConseqs = aConseqs.filter(item => item.zconsequences_key);

        var aLevel = ["Very Low", "Low", "Medium", "High", "Very High", "Çok Düşük", "Düşük", "Orta", "Yüksek", "Çok Yüksek"];

        //! 25.10.2025
        // aConseqs.sort((a, b) => {
        //   if (!a.zconsequences_key) return 1;
        //   if (!b.zconsequences_key) return -1;

        //   let levelA = aLevel.indexOf(a.zinv_lvl);
        //   let levelB = aLevel.indexOf(b.zinv_lvl);

        //   if (levelA !== levelB) {
        //     return levelB - levelA;
        //   }

        //   let likelihoodA = parseInt(a.zlikelihood) || 0;
        //   let likelihoodB = parseInt(b.zlikelihood) || 0;

        //   if (likelihoodA !== likelihoodB) {
        //     return likelihoodA - likelihoodB;
        //   }
        //   return a.zorder - b.zorder;
        // });
        //! 25.10.2025

        aConseqs.forEach((row, index) => {
          if (i !== -1 && aLevel.indexOf(row.zinv_lvl) > aLevel.indexOf(aConseqs[i].zinv_lvl)) {
            i = index;
            risk = row.zincident_severity + row.zlikelihood;
            // Object.assign(oResult, row);
            //! 25.10.2025
            // } else if (i === -1) {
            //! 25.10.2025
          } else if (i === -1 && row.zconsequences_key) {
            i = index;
            risk = row.zincident_severity + row.zlikelihood;
          }
        });

        sXMLString = sXMLString + `<Real_outcome>${oFlashForm['to_RealOut'] ? oFlashForm['to_RealOut']['zincident_severity'] : ''}</Real_outcome><Potetial_outcome>${risk}</Potetial_outcome><Investigatio_leval>${aConseqs[i]?.zinv_lvl}</Investigatio_leval><incident_effect>${aConseqs[i]?.zconsequences_type}</incident_effect>`;
        sXMLString = sXMLString.replace(/>([^<]*)</g, (match, content) => {
          return '>' + content
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&apos;") + '<';
        });
        var oRepositoryResponse = await getDMSRepositories();
        if (oRepositoryResponse.data) {
          var aRepositories = oRepositoryResponse.data;
        }
        var oRepository = aRepositories['EHS_REPOSITORY'];
        var oFoldersResponse = await getDMSRepositoryFolders(oRepository.repositoryId, "");
        var aFolders = oFoldersResponse.data.objects;
        var aFiles;
        if (aFolders.length === 0 || !aFolders.find(row => { return row.object.properties["cmis:name"].value === formNo })) {
        } else {
          aFiles = await getDMSFolderForForm(oRepository.repositoryId, formNo, "");
          if (aFiles.data.objects) {
            const fileProcessingPromises = aFiles.data.objects.map(async (file) => {
              try {
                var sFileString = "";
                var fileName = file.object.properties["cmis:name"].value;
                if (fileName === formNo + "-INV") {
                  return ""; // Skip INV folder itself in this loop
                } else if (file.object.properties["cmis:objectTypeId"].value === "cmis:folder") {
                  //Klasörler hariç tutulur
                  return "";
                } else {
                  var oFile = await getDMSFilesForForm(oRepository.repositoryId, formNo, fileName);
                  if (file.object.properties["cmis:contentStreamMimeType"].value === "application/pdf") {
                    const { pdf: PdfToImg } = await import('pdf-to-img');
                    var scalee = 1;
                    const document = await PdfToImg(oFile.data, {
                      scale: scalee
                    });
                    let pdfImagesXml = "";
                    let countt = 2;
                    const image2 = await document.getPage(countt);
                    for await (const image of document) {
                      pdfImagesXml += `<pdf_row><pdf>${image.toString('base64')}</pdf></pdf_row>`;
                    }
                    return pdfImagesXml;
                  } else {
                    sFileString = `${oFile.data.toString('base64')}`;
                    return `<photos_row><Cell1>${sFileString}</Cell1></photos_row>`;
                  }
                }
              } catch (error) {
                console.log(error);
                return "";
              };
            });
            const processedFileResults = await Promise.all(fileProcessingPromises);
            sXMLString += processedFileResults.join('');
          }
        };
        let sXMLString2 = `<verification_prepared_name>${oFlashForm['zprepared_name']}</verification_prepared_name><verification_prepared_date>${oFlashForm['zprepared_date'] ? oFlashForm['zprepared_date'] : ""}</verification_prepared_date><verification_approved_name>${oFlashForm['zapproved_name']}</verification_approved_name><verification_approved_date>${oFlashForm['zapproved_date'] ? oFlashForm['zapproved_date'] : ""}</verification_approved_date></form1>`;
        sXMLString = sXMLString + sXMLString2.replace(/>([^<]*)</g, (match, content) => {
          return '>' + content
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&apos;") + '<';
        });
        break;
      case 'InvestigationForm':
        sQuery = SELECT('*', { ref: ['to_Facility'], expand: ['*'] }, { ref: ['to_IncClass'], expand: ['*'] }, { ref: ['to_Pos'], expand: ['*'] }, { ref: ['to_Act'], expand: ['*'] }, { ref: ['to_Body'], expand: ['*'] },
          { ref: ['to_RealOut'], expand: ['*'] }, { ref: ['to_Cons'], expand: ['*'] }, { ref: ['to_RemAct'], expand: ['*'] }, { ref: ['to_InvTeam'], expand: ['*'] }).from("ZBTP_EHS_DD_INVESTIGATION").where(`zreport_no='${formNo}'`);
        aFlashForm = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);
        // aFlashForm = await ZBTP_EHS_DD_INVESTIGATION_CDS.run(sQuery);
        sLocale = req.locale;
        sxdpTemplate = `${formType}/${formType}_` + req.locale[0].toUpperCase() + req.locale[1];
        if (!aFlashForm) {
          req.error(404, "Not Found!");
          return;
        }

        oFlashForm = aFlashForm[0];

        sXMLString = `<?xml version="1.0" encoding="UTF-8"?><form1><Facility_Unit>${oFlashForm['to_Facility']['zfacility_unit']}</Facility_Unit><Well_Project>${oFlashForm['zwell']}</Well_Project><Report_No>${formNo}</Report_No><Incıdent_Locatıon>${oFlashForm['zincident_loc']}</Incıdent_Locatıon>`
        sXMLString = sXMLString + `<Date_Of_Incıdent>${oFlashForm['zincident_date']}</Date_Of_Incıdent><Tıme_of_ıncıdent>${oFlashForm['zincident_time']}</Tıme_of_ıncıdent><Incident_title>${oFlashForm['ztitle_max']}</Incident_title><MVA>${['MV1', 'MV2'].includes(oFlashForm['zincident_type']) ? 1 : 0}</MVA>`;  //- MV2 Alanı - CP
        sXMLString = sXMLString + `<NM>${oFlashForm['zincident_type'] === 'NM' ? 1 : 0}</NM><Property_Damage>${oFlashForm['zincident_type'] === 'PD' ? 1 : 0}</Property_Damage><FTL>${["FT1", "FT2", "FT3"].find(row => { return row === oFlashForm["zincident_type"]; }) ? 1 : 0}</FTL><NWR>${oFlashForm['zincident_relevance'] === '2' ? 1 : 0}</NWR>`;
        sXMLString = sXMLString + `<Drop>${oFlashForm['zdrop'] === 'X' ? 1 : 0}</Drop><Medevac>${oFlashForm['zmedevac'] === 'X' ? 1 : 0}</Medevac><LTI>${["LT1", "LT2", "LT3"].find(row => { return row === oFlashForm["zincident_type"]; }) ? 1 : 0}</LTI><RWC>${["RW1", "RW2", "RW3"].find(row => { return row === oFlashForm["zincident_type"]; }) ? 1 : 0}</RWC>`;
        sXMLString = sXMLString + `<MTC>${["MT1", "MT2", "MT3"].find(row => { return row === oFlashForm["zincident_type"]; }) ? 1 : 0}</MTC><FAC>${["FA1", "FA2", "FA3"].find(row => { return row === oFlashForm["zincident_type"]; }) ? 1 : 0}</FAC><Environmental>${oFlashForm['zincident_type'] === 'EN1' ? 1 : 0}</Environmental>`;
        sXMLString = sXMLString + `<Tp_otc>${oFlashForm['zinj_per_comp_key'] === '1' ? 1 : 0}</Tp_otc><tp_otc_contractor>${oFlashForm['zinj_per_comp_key'] === '2' ? 1 : 0}</tp_otc_contractor><Sub_Contractor>${oFlashForm['zinj_per_comp_key'] === '3' ? 1 : 0}</Sub_Contractor><Visitor>${oFlashForm['zinj_per_comp_key'] === '4' ? 1 : 0}</Visitor>`;
        oFlashForm['to_Body'].sort((a, b) => { return a.idx - b.idx });
        oFlashForm['to_Body'].forEach(row => {
          sXMLString = sXMLString + `<INJURED_PERSONEL_TABLE><injured_personel_row1><pi>${row['idx']}</pi><position>${row['zposition']}</position></injured_personel_row1><injured_personel_row2><time_in_tour>${row['ztour_time']}</time_in_tour><days_in_shift>${row['zdays_shift']}</days_in_shift></injured_personel_row2><injured_personel_row3><occupation_year>${row['zexp_occu']}</occupation_year><present_position_year>${row['zexp_pos']}</present_position_year></injured_personel_row3></INJURED_PERSONEL_TABLE>`;
        });

        sXMLString = sXMLString + `<Activity_at_time_of_the_Incident>${oFlashForm['zactivity']}</Activity_at_time_of_the_Incident><Time_of_the_Incident>${oFlashForm['zincident_time']}</Time_of_the_Incident>`;
        sXMLString = sXMLString + `<Job_Being_Undertaken>${oFlashForm['zjob_undertaken']}</Job_Being_Undertaken><JRA_No>${oFlashForm['zjra_no']}</JRA_No><Permit_No>${oFlashForm['zpermit_no']}</Permit_No><Incident_Detaıled_Description>${oFlashForm['zinc_det_desc']}</Incident_Detaıled_Description>`;
        sXMLString = sXMLString + `<IMMEDIATE_ACTION><Immediat_action_taken>`;

        oFlashForm['to_Act'].sort((a, b) => {
          const rowNoA = (a.zrow_no === null || a.zrow_no === undefined) ? Infinity : Number(a.zrow_no);
          const rowNoB = (b.zrow_no === null || b.zrow_no === undefined) ? Infinity : Number(b.zrow_no);
          return rowNoA - rowNoB;
        });

        oFlashForm['to_Act'].forEach(row => {
          sXMLString = sXMLString + `<immediate_action_taken_row><action>${row.zimm_act_taken}</action><responsible_party>${row.zresponsible_party}</responsible_party></immediate_action_taken_row>`;
        });
        sXMLString = sXMLString + `</Immediat_action_taken></IMMEDIATE_ACTION><POSSIBLE_CAUSES_TABLE>`;

        var aPos = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT('*', { ref: ['to_Immc'], expand: ['*'] }, { ref: ['to_Mimm'], expand: ['*'] }).from('ZBTP_EHS_DD_INIT_POS_CAU').where(`zreport_no='${formNo}'`))

        aPos.sort((a, b) => {
          const rowNoA = (a.zrow_no === null || a.zrow_no === undefined) ? Infinity : Number(a.zrow_no);
          const rowNoB = (b.zrow_no === null || b.zrow_no === undefined) ? Infinity : Number(b.zrow_no);
          return rowNoA - rowNoB;
        });

        aPos.forEach(row => {
          sXMLString = sXMLString + `<possible_causes_row><main_immediate_causes>${row['to_Mimm'].zmain_imm_causes}</main_immediate_causes><immediate_causes>${row['to_Immc'].zimmediate_causes}</immediate_causes><cause_definition>${row['to_Immc'].zdefinition}</cause_definition><notes>${row.znote}</notes></possible_causes_row>`;
        });
        sXMLString = sXMLString + `</POSSIBLE_CAUSES_TABLE><Finding_From_Investigation>${oFlashForm['zfindings']}</Finding_From_Investigation><cause_of_incident_table>`;


        sQuery = SELECT('*', { ref: ['to_Root'], expand: ['*'] }, { ref: ['to_MainRoot'], expand: ['*'] }).from("ZBTP_EHS_DD_ROOT_CAUSES_SH").where(`zreport_no='${formNo}'`);
        var aRootCauses = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);


        aRootCauses.sort((a, b) => {
          const rowNoA = (a.zrow_no === null || a.zrow_no === undefined) ? Infinity : Number(a.zrow_no);
          const rowNoB = (b.zrow_no === null || b.zrow_no === undefined) ? Infinity : Number(b.zrow_no);
          return rowNoA - rowNoB;
        });



        //! 25.10.2025
        // aRootCauses.forEach(row => {
        //   sXMLString = sXMLString + `<cause_of_incident_row><main_root_causes>${row['to_MainRoot']['zmain_root_causes']}</main_root_causes><root_causes>${row['to_Root']['zroot_causes_desc']}</root_causes><definition>${row['to_Root']['zr_c_definition']}</definition><notes>${row['znote']}</notes></cause_of_incident_row>`;
        // });
        //! 25.10.2025

        //- 25.10.2025
        aRootCauses.forEach(row => {
          const mainRootCauses = row['to_MainRoot'] && row['to_MainRoot']['zmain_root_causes'] ? row['to_MainRoot']['zmain_root_causes'] : '';
          const rootCausesDesc = row['to_Root'] && row['to_Root']['zroot_causes_desc'] ? row['to_Root']['zroot_causes_desc'] : '';
          const definition = row['to_Root'] && row['to_Root']['zr_c_definition'] ? row['to_Root']['zr_c_definition'] : '';
          const notes = row['znote'] || '';
          sXMLString = sXMLString + `<cause_of_incident_row><main_root_causes>${mainRootCauses}</main_root_causes><root_causes>${rootCausesDesc}</root_causes><definition>${definition}</definition><notes>${notes}</notes></cause_of_incident_row>`;
        });
        //- 25.10.2025


        var aLevel = ["Very Low", "Low", "Medium", "High", "Very High", "Çok Düşük", "Düşük", "Orta", "Yüksek", "Çok Yüksek"];
        var risk = "";
        var i = -1;
        var aConseqs = await CreateRiskMatrix(formNo, locale);

        //! 25.10.2025
        // Sadece dolu consequence'ları filtrele
        aConseqs = aConseqs.filter(item => item.zconsequences_key);
        //! 25.10.2025

        aConseqs.forEach((row, index) => {
          if (i !== -1 && aLevel.indexOf(row.zinv_lvl) > aLevel.indexOf(aConseqs[i].zinv_lvl)) {
            i = index;
            risk = row.zincident_severity + row.zlikelihood;
            //! 25.10.2025
            // } else if (i === -1) {
            //! 25.10.2025
          } else if (i === -1 && row.zconsequences_key) {
            i = index;
            risk = row.zincident_severity + row.zlikelihood;
          }
        });

        sXMLString = sXMLString + `</cause_of_incident_table><remedial_action_table>`;

        oFlashForm['to_RemAct'].sort((a, b) => {
          const rowNoA = (a.zrow_no === null || a.zrow_no === undefined) ? Infinity : Number(a.zrow_no);
          const rowNoB = (b.zrow_no === null || b.zrow_no === undefined) ? Infinity : Number(b.zrow_no);
          return rowNoA - rowNoB;
        });

        oFlashForm['to_RemAct'].forEach(row => {
          sXMLString = sXMLString + `<remedial_action_row><remedial_action>${row.zrem_act_actions}</remedial_action><remedial_action_responsible>${row.zrem_act_respons}</remedial_action_responsible><remedial_action_due>${row.zrem_act_due_date ? row.zrem_act_due_date : ""}</remedial_action_due><remedial_action_status>${row.zrem_act_status}</remedial_action_status></remedial_action_row>`;
        });
        sXMLString = sXMLString + `</remedial_action_table><lessons_learned>${oFlashForm.zlessons}</lessons_learned><Investıgatıon_Team_Table>`;


        oFlashForm['to_InvTeam'].sort((a, b) => {
          const rowNoA = (a.zrow_no === null || a.zrow_no === undefined) ? Infinity : Number(a.zrow_no);
          const rowNoB = (b.zrow_no === null || b.zrow_no === undefined) ? Infinity : Number(b.zrow_no);
          return rowNoA - rowNoB;
        });

        oFlashForm['to_InvTeam'].forEach(row => {
          sXMLString = sXMLString + `<Investigation_Team_rows><Name>${row.zinvestigator_name}</Name><Company>${row.zcompany}</Company><Position>${row.zposition}</Position></Investigation_Team_rows>`;
        });
        sXMLString = sXMLString + `</Investıgatıon_Team_Table><verification_lead_name>${oFlashForm['zinvestigator_name']}</verification_lead_name><verification_lead_date>${oFlashForm['zinvestigator_date'] ? oFlashForm['zinvestigator_date'] : ""}</verification_lead_date><verification_verification_name>${oFlashForm['zverification_name']}</verification_verification_name><verification_verification_date>${oFlashForm['zverification_date'] ? oFlashForm['zverification_date'] : ""}</verification_verification_date><verification_approved_name>${oFlashForm['zapproved_name']}</verification_approved_name><verification_approved_date>${oFlashForm['zapproved_date'] ? oFlashForm['zapproved_date'] : ""}</verification_approved_date>`;

        sXMLString = sXMLString + `<Real_outcome>${oFlashForm['to_RealOut']['zincident_severity']}</Real_outcome><Potetial_outcome>${risk}</Potetial_outcome><Investigatio_leval>${aConseqs[i].zinv_lvl}</Investigatio_leval><incident_effect>${aConseqs[i].zconsequences_type}</incident_effect>`;
        sXMLString = sXMLString.replace(/>([^<]*)</g, (match, content) => {
          return '>' + content
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&apos;") + '<';
        });
        var oRepositoryResponse = await getDMSRepositories();
        if (oRepositoryResponse.data) {
          var aRepositories = oRepositoryResponse.data;
        }
        var oRepository = aRepositories['EHS_REPOSITORY'];
        var oFoldersResponse = await getDMSRepositoryFolders(oRepository.repositoryId, "");
        var aFolders = oFoldersResponse.data.objects;
        var aFiles;
        var aInvFiles;
        if (aFolders.length === 0 || !aFolders.find(row => { return row.object.properties["cmis:name"].value === formNo })) {
        } else {
          aFiles = await getDMSFolderForForm(oRepository.repositoryId, formNo, "");
          if (aFiles.data.objects) {
            const mainFolderFileObjects = [];
            for (const fileObj of aFiles.data.objects) {
              const fileName = fileObj.object.properties["cmis:name"].value;
              if (fileName === formNo + "-INV") {
                aInvFiles = await getDMSFolderForForm(oRepository.repositoryId, formNo, "/" + encodeURIComponent(fileName));
              } else if (fileObj.object.properties["cmis:objectTypeId"].value !== "cmis:folder") {
                mainFolderFileObjects.push(fileObj);
              }
            }

            const mainFolderProcessingPromises = mainFolderFileObjects.map(async (file) => {
              try {
                var fileName = file.object.properties["cmis:name"].value;
                var oFile = await getDMSFilesForForm(oRepository.repositoryId, formNo, fileName);
                if (file.object.properties["cmis:contentStreamMimeType"].value === "application/pdf") {
                  const { pdf: PdfToImg } = await import('pdf-to-img');
                  const document = await PdfToImg(oFile.data);
                  let pdfImagesXml = "";
                  for await (const image of document) {
                    pdfImagesXml += `<pdf_row><pdf>${image.toString('base64')}</pdf></pdf_row>`;
                  }
                  return pdfImagesXml;
                } else {
                  var sFileString3 = `${oFile.data.toString('base64')}`;
                  return `<photos_row><Cell1>${sFileString3}</Cell1></photos_row>`;
                }
              } catch (error) {
                console.log(error);
                return "";
              };
            });
            const mainFolderResults = await Promise.all(mainFolderProcessingPromises);
            sXMLString += mainFolderResults.join('');
          }
        };

        if (aInvFiles && aInvFiles.data && aInvFiles.data.objects && aInvFiles.data.objects.length !== 0) {
          const invFolderProcessingPromises = aInvFiles.data.objects.map(async (file) => {
            try {
              var fileName = file.object.properties["cmis:name"].value;
              if (file.object.properties["cmis:objectTypeId"].value === "cmis:folder") {
                return "";
              }
              var response = await executeHttpRequest({
                destinationName: 'IncidentManagementDMS'
              },
                {
                  method: 'GET',
                  url: `/browser/${encodeURIComponent(oRepository.repositoryId)}/root/${encodeURIComponent(formNo)}/${encodeURIComponent(formNo + "-INV")}/${encodeURIComponent(fileName)}?download=inline&cmisselector=content`,
                  responseType: 'arraybuffer'
                }
              )
              if (file.object.properties["cmis:contentStreamMimeType"].value === "application/pdf") {
                const { pdf: PdfToImg } = await import('pdf-to-img');
                const document = await PdfToImg(response.data);
                let pdfImagesXml = "";
                for await (const image of document) {
                  pdfImagesXml += `<pdf_row><pdf>${image.toString('base64')}</pdf></pdf_row>`;
                }
                return pdfImagesXml;
              } else {
                var sFileString3 = `${response.data.toString('base64')}`;
                return `<photos_row><Cell1>${sFileString3}</Cell1></photos_row>`;
              }
            } catch (error) {
              console.error(error);
              return "";
            }
          });
          const invFolderResults = await Promise.all(invFolderProcessingPromises);
          sXMLString += invFolderResults.join('');
        }
        sXMLString = sXMLString + '</form1>';
        sXMLString = sXMLString.replace(/[\x00-\x08\x0B\x0C\x0E-\x1F]/g, "");
        break;
    }

    var base64PDF = Buffer.from(sXMLString).toString('base64');
    var body = {
      "xdpTemplate": sxdpTemplate,
      "xmlData": base64PDF,
      "formType": "print",
      // "formLocale": sLocale,
      "taggedPdf": 1,
      "embedFont": 0
    };
    var oPDF = await ADS_SRV.post('/v1/adsRender/pdf?templateSource=storageName', body);

    return { pdfContent: oPDF.fileContent };
    return oPDF.fileContent;
    return {
      fileContent: oPDF.fileContent,
      fileName: `${oFlashForm.zreport_no}-${oFlashForm["to_IncCLass"] !== undefined ? oFlashForm["to_IncCLass"]["zincident_classname"] : oFlashForm["to_IncClass"]["zincident_classname"]}-${oFlashForm["ztitle_max"]}`
    };
  });



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



  srv.on('READ', ['RemedialAdminListSet', 'RemedialAdminList'], async (req) => {
    return ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(req.query);
  });


  srv.on('DeleteRemedial', async (req) => {

    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);

    const { zreport_no, zrow_no } = req.data;
    const logPrefix = `DeleteRemedial (Rapor=${zreport_no}, Satır=${zrow_no}):`;

    if (!zreport_no || (zrow_no === undefined || zrow_no === null)) {
      console.error(`${logPrefix} Anahtar bilgi eksik.`);
      return req.error(400, bundle.getText('errorMissingKeysDelete'));
    }

    try {
      const deleteResult = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        DELETE.from("ZBTP_EHS_DD_REMEDIAL_ACTIONS")
          .where({ zreport_no: zreport_no, zrow_no: zrow_no })
      );
      return { success: true, message: bundle.getText('successDeleteRequestSent') };

    } catch (error) {
      console.error(`${logPrefix} Harici servis silme hatası:`, error);
      const statusCode = error.response?.status || error.status || 500;
      const specificErrorMessage = error.reason?.response?.body?.error?.message?.value || error.message;
      let errorMessage;
      if (specificErrorMessage) {
        errorMessage = bundle.getText('errorExternalDeletePrefix', [specificErrorMessage]);
      } else {
        errorMessage = bundle.getText('errorExternalDeleteUnknown');
      }
      return req.error(statusCode, errorMessage);
    }
  });


  srv.on('UpdateRemedial', async (req) => {

    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);
    const { zreport_no, zrow_no, ...updatePayload } = req.data;
    const logPrefix = `UpdateRemedial (Rapor=${zreport_no}, Satır=${zrow_no}):`;

    if (!zreport_no || (zrow_no === undefined || zrow_no === null)) {
      console.error(`${logPrefix} Anahtar bilgi eksik.`);
      return req.error(400, bundle.getText('errorMissingKeysUpdate'));
    }

    delete updatePayload['@odata.context'];
    delete updatePayload['__metadata'];

    try {
      const updateResult = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        UPDATE("ZBTP_EHS_DD_REMEDIAL_ACTIONS")
          .set(updatePayload)
          .where({ zreport_no: zreport_no, zrow_no: zrow_no })
      );
      return { success: true, message: bundle.getText('successUpdateRequestSent') };

    } catch (error) {
      console.error(`${logPrefix} Harici servis güncelleme hatası:`, error);
      const statusCode = error.response?.status || error.status || 500;
      const specificErrorMessage = error.reason?.response?.body?.error?.message?.value || error.message;
      let errorMessage;
      if (specificErrorMessage) {
        errorMessage = bundle.getText('errorExternalUpdatePrefix', [specificErrorMessage]);
      } else {
        errorMessage = bundle.getText('errorExternalUpdateUnknown');
      }
      return req.error(statusCode, errorMessage);
    }
  });


  srv.on('regenerateRoles', async (req) => {

    const logPrefix = "[regenerateRoles]";
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);
    const ZBTP_EHS_INCIDENT_MANAGEMENT_SRV = await cds.connect.to("ZBTP_EHS_INCIDENT_MANAGEMENT_SRV");
    const {
      ZBTP_EHS_DD_FULL_MNGMNT,
      ZBTP_EHS_DD_DEPARTM,
      ZBTP_EHS_DD_UNITS,
      ZBTP_EHS_DD_WROLES
    } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;

    const keyFields = {
      mgmt: 'zmanagement_key',
      dept: 'zdepartment_key',
      unit: 'zfacility_key',
      dept_rel: 'zmanagement_key',
      unit_rel: 'zdepartment_id'
    };

    const nameFields = {
      mgmt: 'zmanagement_name',
      dept: 'zdepartment_name',
      unit: 'zfacility_unit'
    };


    try {
      const managementCount = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from(ZBTP_EHS_DD_FULL_MNGMNT).columns(['zmanagement_key']).limit(1));
      if (!managementCount || managementCount.length === 0) {
        console.warn(`${logPrefix} Management verisi bulunamadı. İşlem sonlandırıldı.`);
        return {
          regenerateRoles: bundle.getText('roleManagementDataNotFound'),
          success: false,
          result: null
        };
      }

      setImmediate(async () => {
        await performRoleRegenerationInBackground(ZBTP_EHS_INCIDENT_MANAGEMENT_SRV, keyFields, nameFields, logPrefix);
      });

      return {
        regenerateRoles: bundle.getText('roleRegenerationStarted'),
        success: true,
        result: {
          status: "started",
          message: "İşlem arka planda çalışıyor..."
        }
      };

    } catch (error) {
      console.error(`\n--- ${logPrefix} !!!HATA!!! İşlem sırasında bir hata oluştu. ---`);
      console.error("Detaylı Hata Objesi:", error);
      console.error("Hata Mesajı:", error.message);
      return req.error(500, `Rol oluşturma sırasında beklenmedik bir hata oluştu: ${error.message}`);
    }
  });


  async function performRoleRegenerationInBackground(ZBTP_EHS_INCIDENT_MANAGEMENT_SRV, keyFields, nameFields, logPrefix) {
    try {
      const { ZBTP_EHS_DD_FULL_MNGMNT, ZBTP_EHS_DD_DEPARTM, ZBTP_EHS_DD_UNITS, ZBTP_EHS_DD_WROLES } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;

      let [management, department, facility, existingRoles] = await Promise.all([
        ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from(ZBTP_EHS_DD_FULL_MNGMNT)),
        ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from(ZBTP_EHS_DD_DEPARTM)),
        ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from(ZBTP_EHS_DD_UNITS)),
        ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from(ZBTP_EHS_DD_WROLES))
      ]);

      const mgmtKeys = new Set(management.map(m => m[keyFields.mgmt]));
      const deptKeys = new Set(department.map(d => d[keyFields.dept]));
      const unitKeys = new Set(facility.map(u => u[keyFields.unit]));

      const rolesToDelete = existingRoles.filter(role => {

        if (role.role_id === '00000000') return false;

        const mgmtExists = role[keyFields.mgmt] ? mgmtKeys.has(role[keyFields.mgmt]) : true;
        const deptExists = role[keyFields.dept] ? deptKeys.has(role[keyFields.dept]) : true;
        const unitExists = role[keyFields.unit] ? unitKeys.has(role[keyFields.unit]) : true;

        return !mgmtExists || !deptExists || !unitExists;
      }).map(role => role.role_id);

      if (rolesToDelete.length > 0) {
        console.log(`${logPrefix} ${rolesToDelete.length} adet geçersiz rol bulundu ve silinecek.`);
        const deleteOperations = rolesToDelete.map(id => DELETE.from(ZBTP_EHS_DD_WROLES).where({ role_id: id }));
        if (deleteOperations.length > 0) {
          await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(deleteOperations);
          console.log(`${logPrefix} Geçersiz roller başarıyla silindi.`);
          const rolesToDeleteSet = new Set(rolesToDelete);
          existingRoles = existingRoles.filter(role => !rolesToDeleteSet.has(role.role_id));
        }
      }


      const calculatedRoles = [];

      const generateDescription = (mgmt, dept, unit) => {
        const parts = [];
        if (mgmt) parts.push(mgmt[nameFields.mgmt]);
        if (dept) parts.push(dept[nameFields.dept]);
        if (unit) parts.push(unit[nameFields.unit]);
        return parts.join('  -  ');
      };


      calculatedRoles.push({
        role_id: '00000000',
        [keyFields.mgmt]: '',
        [keyFields.dept]: '',
        [keyFields.unit]: '',
        ownforms: false,
        is_active: true,
        description: "EDIT  -  ADMIN"
      });


      const generateRoleId = (str) => {
        let hash = 0;
        if (!str || str.length === 0) return '00000000';
        for (let i = 0; i < str.length; i++) {
          const char = str.charCodeAt(i);
          hash = ((hash << 5) - hash) + char;
          hash |= 0;
        }
        return (hash >>> 0).toString(36).padStart(8, '0');
      };


      for (const ownforms of [false, true]) {
        for (const mgmt of management) {
          const roleStringMgmt = `${mgmt[keyFields.mgmt] || ''}|${''}|${''}|${ownforms}`;
          const roleIdMgmt = generateRoleId(roleStringMgmt);
          calculatedRoles.push({
            role_id: roleIdMgmt,
            [keyFields.mgmt]: mgmt[keyFields.mgmt],
            [keyFields.dept]: '',
            [keyFields.unit]: '',
            ownforms: ownforms,
            is_active: true,
            description: generateDescription(mgmt, null, null)
          });

          const relevantDepts = department.filter(d => d[keyFields.dept_rel] === mgmt[keyFields.mgmt]);
          for (const dept of relevantDepts) {
            const roleStringDept = `${mgmt[keyFields.mgmt] || ''}|${dept[keyFields.dept] || ''}|${''}|${ownforms}`;
            const roleIdDept = generateRoleId(roleStringDept);
            calculatedRoles.push({
              role_id: roleIdDept,
              [keyFields.mgmt]: mgmt[keyFields.mgmt],
              [keyFields.dept]: dept[keyFields.dept],
              [keyFields.unit]: '',
              ownforms: ownforms,
              is_active: true,
              description: generateDescription(mgmt, dept, null)
            });


            const relevantFacility = facility.filter(u => u[keyFields.unit_rel] === dept[keyFields.dept]);
            for (const unit of relevantFacility) {
              const sourceFacilityKey = unit.zunit_key;
              const uniquePartForId = sourceFacilityKey || unit[nameFields.unit] || '';
              const roleStringFacility = `${mgmt[keyFields.mgmt] || ''}|${dept[keyFields.dept] || ''}|${uniquePartForId}|${ownforms}`;
              const roleIdFacility = generateRoleId(roleStringFacility);

              calculatedRoles.push({
                role_id: roleIdFacility,
                [keyFields.mgmt]: mgmt[keyFields.mgmt],
                [keyFields.dept]: dept[keyFields.dept],
                [keyFields.unit]: sourceFacilityKey,
                ownforms: ownforms,
                is_active: true,
                description: generateDescription(mgmt, dept, unit)
              });
            }
          }
        }
      }

      const calculatedRolesMap = new Map(calculatedRoles.map(r => [r.role_id, r]));
      const existingRolesMap = new Map(existingRoles.map(r => [r.role_id, r]));

      const rolesToInsert = [];
      const rolesToReactivate = [];

      for (const [id, role] of calculatedRolesMap.entries()) {
        const existing = existingRolesMap.get(id);
        if (!existing) {
          rolesToInsert.push(role);
        } else if (!existing.is_active) {
          rolesToReactivate.push(id);
        }
      }

      const rolesToDeactivate = existingRoles
        .filter(er => er.is_active && !calculatedRolesMap.has(er.role_id))
        .map(er => er.role_id);

      try {
        if (rolesToInsert.length > 0) {

          let insertedCount = 0;
          for (let i = 0; i < rolesToInsert.length; i++) {
            const role = rolesToInsert[i];
            try {
              await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT.into(ZBTP_EHS_DD_WROLES).entries([role]));
              insertedCount++;
              if (insertedCount % 50 === 0 || insertedCount === rolesToInsert.length) {
              }
            } catch (singleRoleError) {
              console.error(` -> ${i + 1}. rol eklenirken hata (ID: ${role.role_id}):`, singleRoleError.message);
              throw singleRoleError;
            }
          }
        }

        if (rolesToReactivate.length > 0) {
          await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(UPDATE(ZBTP_EHS_DD_WROLES).set({ is_active: true }).where({ role_id: { in: rolesToReactivate } }));
        }

        if (rolesToDeactivate.length > 0) {
          await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(UPDATE(ZBTP_EHS_DD_WROLES).set({ is_active: false }).where({ role_id: { in: rolesToDeactivate } }));
        }

        const totalChanges = rolesToInsert.length + rolesToReactivate.length + rolesToDeactivate.length;

      } catch (dbError) {
        console.error(`\n--- ${logPrefix} [ARKA PLAN] Veritabanı güncelleme hatası:`, dbError.message);
      }

    } catch (error) {
      console.error(`\n--- ${logPrefix} [ARKA PLAN] !!!HATA!!! İşlem sırasında bir hata oluştu. ---`);
      console.error("Detaylı Hata Objesi:", error);
      console.error("Hata Mesajı:", error.message);
    }
  }



  srv.on('deleteRoleById', async (req) => {

    const { roleId } = req.data;
    const ZBTP_EHS_INCIDENT_MANAGEMENT_SRV = await cds.connect.to("ZBTP_EHS_INCIDENT_MANAGEMENT_SRV");
    const { ZBTP_EHS_DD_WROLES } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;
    const logPrefix = "[deleteRoleById]";
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);

    if (!roleId) {
      return req.error(400, bundle.getText('roleIdRequired'));
    }

    if (roleId === '00000000') {
      return req.error(400, bundle.getText('adminRoleCannotBeDeleted'));
    }

    try {
      const deletedCount = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(DELETE.from(ZBTP_EHS_DD_WROLES).where({ role_id: roleId }));

      if (deletedCount > 0) {
        console.log(`${logPrefix} Rol (ID: ${roleId}) başarıyla silindi.`);
        return {
          deleteRoleById: bundle.getText('roleDeletedSuccessfully', [roleId]),
          success: true,
          deletedCount: deletedCount
        };
      } else {
        console.warn(`${logPrefix} Silinecek rol bulunamadı. ID: ${roleId}`);
        return {
          deleteRoleById: bundle.getText('roleNotFoundForDeletion', [roleId]),
          success: false,
          deletedCount: 0
        };
      }
    } catch (error) {
      console.error(`\n--- ${logPrefix} HATA: Rol (ID: ${roleId}) silinirken bir hata oluştu. ---`);
      console.error("Detaylı Hata Objesi:", error);
      return req.error(500, bundle.getText('roleDeletionError'));
    }
  });



  srv.on('deleteAllRoles', async (req) => {

    const logPrefix = "[deleteAllRoles]";
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);
    const ZBTP_EHS_INCIDENT_MANAGEMENT_SRV = await cds.connect.to("ZBTP_EHS_INCIDENT_MANAGEMENT_SRV");
    const { ZBTP_EHS_DD_WROLES } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;

    try {
      const existingRoles = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.from(ZBTP_EHS_DD_WROLES).columns(['role_id'])); // Önce mevcut rolleri say

      if (!existingRoles || existingRoles.length === 0) {
        const locale = req.user.locale;
        const bundle = textBundle.getTextBundle(locale);

        return {
          deleteAllRoles: bundle.getText('deleteNoRoleFound'),
          success: true,
          deletedCount: 0
        };
      }

      const totalRoles = existingRoles.length;


      if (totalRoles > 50) {

        setImmediate(async () => {
          await performBulkDeletionInBackground(ZBTP_EHS_INCIDENT_MANAGEMENT_SRV, existingRoles, logPrefix);
        });

        return {
          deleteAllRoles: bundle.getText('bulkRoleDeletionStarted', [totalRoles]),
          success: true,
          result: {
            status: "started",
            totalRoles: totalRoles,
            message: bundle.getText('operationInProgress')
          }
        };
      }

      let deletedCount = 0;
      for (const role of existingRoles) {
        try {
          await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(DELETE.from(ZBTP_EHS_DD_WROLES).where({ role_id: role.role_id }));
          deletedCount++;
          console.log(` -> ${deletedCount}/${totalRoles} rol silindi...`);
        } catch (singleDeleteError) {
          console.error(` -> Rol silme hatası (ID: ${role.role_id}):`, singleDeleteError.message);
        }
      }

      return {
        deleteAllRoles: bundle.getText('allRolesDeletedSuccessfully', [deletedCount]),
        success: true,
        deletedCount: deletedCount
      };

    } catch (error) {
      console.error(`\n--- ${logPrefix} HATA: Roller silinirken bir hata oluştu. ---`);
      console.error("Detaylı Hata Objesi:", error);
      return req.error(500, bundle.getText('roleDeletionError'));
    }
  });



  async function performBulkDeletionInBackground(ZBTP_EHS_INCIDENT_MANAGEMENT_SRV, existingRoles, logPrefix) {
    try {
      const { ZBTP_EHS_DD_WROLES } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;
      const totalRoles = existingRoles.length;
      let deletedCount = 0;
      let errorCount = 0;

      for (let i = 0; i < existingRoles.length; i++) {
        const role = existingRoles[i];
        try {
          await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(DELETE.from(ZBTP_EHS_DD_WROLES).where({ role_id: role.role_id }));
          deletedCount++;

          if (deletedCount % 25 === 0 || deletedCount === totalRoles) {
            console.log(`${logPrefix} [ARKA PLAN] -> ${deletedCount}/${totalRoles} rol silindi...`);
          }
        } catch (singleDeleteError) {
          errorCount++;
          console.error(`${logPrefix} [ARKA PLAN] -> ${i + 1}. rol silme hatası (ID: ${role.role_id}):`, singleDeleteError.message);
        }
      }

    } catch (error) {
      console.error(`\n--- ${logPrefix} [ARKA PLAN] !!!HATA!!! Toplu silme işlemi sırasında bir hata oluştu. ---`);
      console.error("Detaylı Hata Objesi:", error);
      console.error("Hata Mesajı:", error.message);
    }
  }



  srv.on('createUser', async (req) => {

    const { email, firstname, lastname, title, department, description } = req.data;
    const ZBTP_EHS_INCIDENT_MANAGEMENT_SRV = await cds.connect.to("ZBTP_EHS_INCIDENT_MANAGEMENT_SRV");
    const { ZBTP_EHS_DD_WUSERS } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;
    const logPrefix = "[createUser]";
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);

    if (!email) {
      return req.error(400, bundle.getText('userCreationMissingEmail'));
    }

    try {
      const existingUser = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        SELECT.one.from(ZBTP_EHS_DD_WUSERS).where({ email: email })
      );

      if (existingUser) {
        return req.error(409, bundle.getText('userAlreadyExists', [email]));
      }

      const lastUserResult = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        SELECT.from(ZBTP_EHS_DD_WUSERS).orderBy({ user_id: 'desc' }).limit(1)
      );

      let userIdToUse;
      if (lastUserResult && lastUserResult.length > 0) {
        userIdToUse = (parseInt(lastUserResult[0].user_id, 10) + 1).toString().padStart(5, '0');
      } else {
        userIdToUse = '00001';
      }

      const newUserRecord = {
        user_id: userIdToUse,
        email: email,
        firstname: firstname || null,
        lastname: lastname || null,
        title: title || null,
        department: department || null,
        description: description || null
      };

      await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        INSERT.into(ZBTP_EHS_DD_WUSERS).entries(newUserRecord)
      );
      console.log(`${logPrefix} Kullanıcı başarıyla oluşturuldu:`, newUserRecord);

      return newUserRecord;

    } catch (error) {
      console.error(`${logPrefix} İşlem sırasında bir hata oluştu:`, error);
      return req.error(500, bundle.getText('userCreationError', [error.message]));
    }
  });


  srv.on('updateUser', async (req) => {

    const user_id = req.data?.user_id || req.query?.user_id || (req._?.req?.query?.user_id);
    const email = req.data?.email || req.query?.email || (req._?.req?.query?.email);
    const firstname = req.data?.firstname || req.query?.firstname || (req._?.req?.query?.firstname);
    const lastname = req.data?.lastname || req.query?.lastname || (req._?.req?.query?.lastname);
    const title = req.data?.title || req.query?.title || (req._?.req?.query?.title);
    const department = req.data?.department || req.query?.department || (req._?.req?.query?.department);
    const description = req.data?.description || req.query?.description || (req._?.req?.query?.description);
    const logPrefix = '[updateUser]';
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);

    if (!user_id || !email) {
      return req.error(400, bundle.getText('userIdAndEmailRequired'));
    }

    try {

      const ZBTP_EHS_INCIDENT_MANAGEMENT_SRV = await cds.connect.to("ZBTP_EHS_INCIDENT_MANAGEMENT_SRV");
      const { ZBTP_EHS_DD_WUSERS } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;

      const result = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        UPDATE(ZBTP_EHS_DD_WUSERS)
          .set({
            firstname: firstname,
            lastname: lastname,
            title: title,
            department: department,
            description: description
          })
          .where({ user_id: user_id, email: email })
      );

      if (result >= 0) {
        const successMessage = bundle.getText('userUpdatedSuccessfully', [email]);
        return {
          updateUser: successMessage,
          success: true,
          updatedRows: result
        };
      } else {
        return req.error(500, bundle.getText('unexpectedUpdateResult'));
      }

    } catch (error) {
      console.error(`${logPrefix} İşlem sırasında bir hata oluştu:`, error);
      console.error('Orijinal Hata:', error.reason || error.message);
      return req.error(500, bundle.getText('userUpdateError', [error.message]));
    }
  });



  srv.on('deleteUser', async (req) => {

    const email = req.data?.email || req.query?.email || (req._?.req?.query?.email);
    const ZBTP_EHS_INCIDENT_MANAGEMENT_SRV = await cds.connect.to("ZBTP_EHS_INCIDENT_MANAGEMENT_SRV");
    const { ZBTP_EHS_DD_WUSERS, ZBTP_EHS_DD_USER } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;
    const logPrefix = "[deleteUser]";
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);

    if (!email) {
      return req.error(400, bundle.getText('emailRequired'));
    }

    try {
      const userRolesToDelete = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        SELECT.from(ZBTP_EHS_DD_USER).where({ smtp_addr: email })
      );

      if (userRolesToDelete && userRolesToDelete.length > 0) {
        for (const role of userRolesToDelete) {
          await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
            DELETE.from(ZBTP_EHS_DD_USER).where({ id: role.id, smtp_addr: role.smtp_addr })
          );
        }
        console.log(`${logPrefix} ${email} için rol atamaları başarıyla silindi.`);
      } else {
        console.log(`${logPrefix} ${email} için silinecek rol ataması bulunamadı.`);
      }

      const userAccountsToDelete = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        SELECT.from(ZBTP_EHS_DD_WUSERS).where({ email: email })
      );

      if (userAccountsToDelete && userAccountsToDelete.length > 0) {
        for (const user of userAccountsToDelete) {
          await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
            DELETE.from(ZBTP_EHS_DD_WUSERS).where({ user_id: user.user_id, email: user.email })
          );
        }
        console.log(`${logPrefix} ${email} için ana kullanıcı kayıtları başarıyla silindi.`);
      } else {
        console.warn(`${logPrefix} Ana kullanıcı kaydı (${email}) bulunamadı. Muhtemelen daha önce silinmiş.`);
      }

      const successMessage = bundle.getText('userAndAssignmentsDeleted', [email]);
      console.log(successMessage);

      return {
        deleteUser: successMessage,
        success: true,
        deletedRoles: userRolesToDelete.length,
        deletedUsers: userAccountsToDelete.length
      };

    } catch (error) {
      console.error('[deleteUser] İşlem sırasında bir hata oluştu:', error);
      console.error('Orijinal Hata:', error.reason || error.message);
      return req.error(500, bundle.getText('userUpdateError', [error.message]));
    }
  });




  srv.on('assignUsersToRole', async (req) => {

    const role_id = req.data?.role_id || req.query?.role_id || (req._?.req?.query?.role_id);
    let user_emails = req.data?.user_emails || req.query?.user_emails || (req._?.req?.query?.user_emails);

    const logPrefix = '[assignUsersToRole]';

    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);

    if (typeof user_emails === 'string') {
      console.log(`${logPrefix} user_emails is string, attempting to parse...`);
      try {
        user_emails = JSON.parse(user_emails);
      } catch (e) {
        console.error(`${logPrefix} user_emails JSON parse hatası:`, e);
        user_emails = user_emails.split(',').map(email => email.trim());
      }
    }


    let emailArray = [];
    if (Array.isArray(user_emails)) {
      user_emails.forEach(email => {
        if (typeof email === 'string' && email.includes(',')) {
          emailArray.push(...email.split(',').map(e => e.trim()).filter(e => e.length > 0));
        } else if (typeof email === 'string' && email.length > 0) {
          emailArray.push(email.trim());
        }
      });
    }

    if (!role_id || !emailArray || emailArray.length === 0) {
      return req.error(400, bundle.getText('invalidRequestRoleIdAndEmails'));
    }

    user_emails = emailArray;
    const ZBTP_EHS_INCIDENT_MANAGEMENT_SRV = await cds.connect.to("ZBTP_EHS_INCIDENT_MANAGEMENT_SRV");
    const { ZBTP_EHS_DD_USER } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;
    const responseDetails = [];
    let overallSuccess = true;

    const existingAssignments = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
      SELECT.from(ZBTP_EHS_DD_USER).where({ id: role_id }).and('smtp_addr', 'in', user_emails)
    );
    const existingEmails = new Set(existingAssignments.map(assignment => assignment.smtp_addr));

    const newEmails = [];
    for (const email of user_emails) {
      if (existingEmails.has(email)) {
        responseDetails.push({ email: email, status: 'Exists', message: bundle.getText('userAlreadyAssignedToRole') });
      } else {
        newEmails.push(email);
      }
    }

    if (newEmails.length > 0) {
      try {
        const insertEntries = newEmails.map(email => ({ id: role_id, smtp_addr: email }));
        await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.batch().run(
          ...insertEntries.map(entry => INSERT.into(ZBTP_EHS_DD_USER).entries(entry))
        );

        newEmails.forEach(email => {
          responseDetails.push({ email: email, status: 'Assigned', message: bundle.getText('userAssignedToRoleSuccessfully') });
        });
      } catch (batchError) {
        console.error(`${logPrefix} Batch INSERT failed, falling back to individual inserts:`, batchError);
        overallSuccess = false;

        for (const email of newEmails) {
          try {
            const insertData = { id: role_id, smtp_addr: email };
            await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT.into(ZBTP_EHS_DD_USER).entries(insertData));
            responseDetails.push({ email: email, status: 'Assigned', message: bundle.getText('userAssignedToRoleSuccessfully') });
          } catch (individualError) {
            responseDetails.push({ email: email, status: 'Error', message: bundle.getText('assignmentError', [individualError.message]) });
            console.error(`${logPrefix} Individual INSERT failed for ${email}:`, individualError);
          }
        }
      }
    }
    return { success: overallSuccess, message: overallSuccess ? bundle.getText('operationCompletedSuccess') : bundle.getText('operationCompletedWithErrors'), details: responseDetails };
  });



  srv.on('assignRolesToUser', async (req) => {

    const email = req.data.email || req.query.email || (req._.req.query && req._.req.query.email);
    let role_ids = req.data.role_ids || req.query.role_ids || (req._.req.query && req._.req.query.role_ids);
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);
    const logPrefix = '[assignRolesToUser]';

    if (typeof role_ids === 'string') {
      console.log(`${logPrefix} role_ids is string, attempting to parse...`);
      try {
        role_ids = JSON.parse(role_ids);
        console.log(`${logPrefix} JSON parse successful:`, role_ids);
      } catch (e) {
        console.error(`${logPrefix} role_ids JSON parse hatası:`, e);
      }
    }


    let roleIdArray = [];
    if (Array.isArray(role_ids)) {
      role_ids.forEach((roleId, index) => {
        console.log(`${logPrefix} Processing role_ids[${index}]:`, roleId, 'type:', typeof roleId);
        if (typeof roleId === 'string' && roleId.includes(',')) {
          const splitIds = roleId.split(',').map(r => r.trim()).filter(r => r.length > 0);
          roleIdArray.push(...splitIds);
        } else if (typeof roleId === 'string' && roleId.length > 0) {
          roleIdArray.push(roleId.trim());
        }
      });
    }

    if (!email || !roleIdArray || roleIdArray.length === 0) {
      return req.error(400, bundle.getText('invalidRequestEmailAndRoleIds'));
    }

    role_ids = roleIdArray;
    console.log(`${logPrefix} Başlatıldı. Kullanıcı: ${email}, Atanacak Roller: ${role_ids.join(', ')}`);
    const ZBTP_EHS_INCIDENT_MANAGEMENT_SRV = await cds.connect.to("ZBTP_EHS_INCIDENT_MANAGEMENT_SRV");
    const { ZBTP_EHS_DD_USER } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;
    const responseDetails = [];
    let overallSuccess = true;

    const existingAssignments = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
      SELECT.from(ZBTP_EHS_DD_USER).where({ smtp_addr: email }).and('id', 'in', roleIdArray)
    );

    const existingRoleIds = new Set(existingAssignments.map(assignment => assignment.id));

    for (const role_id of roleIdArray) {
      try {
        if (existingRoleIds.has(role_id)) {
          responseDetails.push({ role_id: role_id, status: 'Exists', message: bundle.getText('roleAlreadyAssignedToUser') });
        } else {
          const insertData = { id: role_id, smtp_addr: email };
          try {
            await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT.into(ZBTP_EHS_DD_USER).entries(insertData));
            console.log(`${logPrefix} Assignment successful for role_id=${role_id}, email=${email}`);
            responseDetails.push({ role_id: role_id, status: 'Assigned', message: bundle.getText('roleAssignedToUserSuccessfully') });
          } catch (insertError) {
            console.error(`${logPrefix} INSERT failed for role_id=${role_id}, email=${email}:`, insertError);
            if (insertError.message && insertError.message.includes('same key already exists')) {
              const recheckExisting = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from(ZBTP_EHS_DD_USER).where({ id: role_id, smtp_addr: email }));
              if (recheckExisting) {
                responseDetails.push({ role_id: role_id, status: 'Exists', message: bundle.getText('roleAlreadyAssignedToUser') });
              } else {
                throw insertError;
              }
            } else {
              throw insertError;
            }
          }
        }
      } catch (error) {
        overallSuccess = false;
        responseDetails.push({ role_id: role_id, status: 'Error', message: bundle.getText('assignmentError', [error.message]) });
        console.error(`${logPrefix} ${role_id} için hata:`, error);
      }
    }
    return { success: overallSuccess, message: overallSuccess ? bundle.getText('operationCompletedSuccess') : bundle.getText('operationCompletedWithErrors'), details: responseDetails };
  });



  srv.on('deleteUsersFromRole', async (req) => {

    const role_id = req.data.role_id || req.query.role_id || (req._.req.query && req._.req.query.role_id);
    let user_emails = req.data.user_emails || req.query.user_emails || (req._.req.query && req._.req.query.user_emails);
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);
    const logPrefix = '[deleteUsersFromRole]';

    if (typeof user_emails === 'string') {
      try {
        user_emails = JSON.parse(user_emails);
      } catch (e) {
        console.error(`${logPrefix} user_emails JSON parse hatası:`, e);
      }
    }

    if (!role_id || !user_emails || !Array.isArray(user_emails) || user_emails.length === 0) {
      return req.error(400, bundle.getText('invalidRequestRoleIdAndEmailArray'));
    }

    const ZBTP_EHS_INCIDENT_MANAGEMENT_SRV = await cds.connect.to("ZBTP_EHS_INCIDENT_MANAGEMENT_SRV");
    const { ZBTP_EHS_DD_USER } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;
    const responseDetails = [];
    let overallSuccess = true;

    const existingRecords = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
      SELECT.from(ZBTP_EHS_DD_USER).where({ id: role_id }).and('smtp_addr', 'in', user_emails)
    );
    const existingEmails = new Set(existingRecords.map(record => record.smtp_addr));

    const emailsToDelete = [];
    for (const email of user_emails) {
      if (!existingEmails.has(email)) {
        responseDetails.push({ email: email, status: 'NotFound', message: bundle.getText('userRoleAssignmentNotFound') });
      } else {
        emailsToDelete.push(email);
      }
    }

    if (emailsToDelete.length > 0) {
      try {
        await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.batch().run(
          ...emailsToDelete.map(email => DELETE.from(ZBTP_EHS_DD_USER).where({ id: role_id, smtp_addr: email }))
        );

        emailsToDelete.forEach(email => {
          responseDetails.push({ email: email, status: 'Removed', message: bundle.getText('userRoleAssignmentRemoved') });
        });
        console.log(`${logPrefix} Batch deletion successful for ${emailsToDelete.length} users from role_id=${role_id}`);
      } catch (batchError) {
        console.error(`${logPrefix} Batch DELETE failed, falling back to individual deletes:`, batchError);
        overallSuccess = false;

        for (const email of emailsToDelete) {
          try {
            const result = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(DELETE.from(ZBTP_EHS_DD_USER).where({ id: role_id, smtp_addr: email }));
            if (result > 0) {
              responseDetails.push({ email: email, status: 'Removed', message: bundle.getText('userRoleAssignmentRemoved') });
            } else {
              responseDetails.push({ email: email, status: 'NotFound', message: bundle.getText('userRoleAssignmentNotFound') });
            }
          } catch (individualError) {
            responseDetails.push({ email: email, status: 'Error', message: bundle.getText('removalError', [individualError.message]) });
            console.error(`${logPrefix} Individual DELETE failed for ${email}:`, individualError);
          }
        }
      }
    }
    return { success: overallSuccess, message: overallSuccess ? bundle.getText('operationCompletedSuccess') : bundle.getText('operationCompletedWithErrors'), details: responseDetails };
  });



  srv.on('deleteRolesFromUser', async (req) => {

    const email = req.data.email || req.query.email || (req._.req.query && req._.req.query.email);
    let role_ids = req.data.role_ids || req.query.role_ids || (req._.req.query && req._.req.query.role_ids);
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);
    const logPrefix = '[deleteRolesFromUser]';
    if (typeof role_ids === 'string') {
      try {
        role_ids = JSON.parse(role_ids);
      } catch (e) {
        console.error(`${logPrefix} role_ids JSON parse hatası:`, e);
      }
    }

    if (!email || !role_ids || !Array.isArray(role_ids) || role_ids.length === 0) {
      return req.error(400, bundle.getText('invalidRequestEmailAndRoleIdArray'));
    }
    const ZBTP_EHS_INCIDENT_MANAGEMENT_SRV = await cds.connect.to("ZBTP_EHS_INCIDENT_MANAGEMENT_SRV");
    const { ZBTP_EHS_DD_USER } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;
    const responseDetails = [];
    let overallSuccess = true;
    for (const role_id of role_ids) {
      try {
        const existingRecord = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
          SELECT.one.from(ZBTP_EHS_DD_USER).where({ id: role_id, smtp_addr: email })
        );

        if (!existingRecord) {
          console.log(`${logPrefix} Kayıt bulunamadı: role_id=${role_id}, email=${email}`);
          responseDetails.push({ role_id: role_id, status: 'NotFound', message: bundle.getText('userRoleAssignmentNotFoundForRole') });
          continue;
        }

        const result = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(DELETE.from(ZBTP_EHS_DD_USER).where({ id: role_id, smtp_addr: email }));

        if (result > 0) {
          responseDetails.push({ role_id: role_id, status: 'Removed', message: bundle.getText('roleRemovedFromUserSuccessfully') });
        } else {
          responseDetails.push({ role_id: role_id, status: 'NotFound', message: bundle.getText('roleAssignmentNotFoundForUser') });
        }
      } catch (error) {
        overallSuccess = false;
        responseDetails.push({ role_id: role_id, status: 'Error', message: bundle.getText('removalError', [error.message]) });
        console.error(`${logPrefix} ${role_id} için hata:`, error);
        console.error(`${logPrefix} Hata detayları:`, {
          role_id: role_id,
          email: email,
          errorMessage: error.message,
          errorStack: error.stack
        });
      }
    }
    return { success: overallSuccess, message: overallSuccess ? bundle.getText('operationCompletedSuccess') : bundle.getText('operationCompletedWithErrors'), details: responseDetails };
  });



  srv.on('getRoleStatistics', async (req) => {

    const logPrefix = "[getRoleStatistics]";
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);
    const ZBTP_EHS_INCIDENT_MANAGEMENT_SRV = await cds.connect.to("ZBTP_EHS_INCIDENT_MANAGEMENT_SRV");
    const {
      ZBTP_EHS_DD_FULL_MNGMNT,
      ZBTP_EHS_DD_DEPARTM,
      ZBTP_EHS_DD_UNITS,
      ZBTP_EHS_DD_WROLES
    } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;

    try {
      const [managementCount, departmentCount, facilityCountData, existingRolesCount] = await Promise.all([
        ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from(ZBTP_EHS_DD_FULL_MNGMNT).columns('count(*) as total')),
        ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from(ZBTP_EHS_DD_DEPARTM).columns('count(*) as total')),
        ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from(ZBTP_EHS_DD_UNITS).columns('count(*) as total')),
        ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(SELECT.one.from(ZBTP_EHS_DD_WROLES).columns('count(*) as total'))
      ]);

      const mgmtCount = managementCount?.total || 0;
      const deptCount = departmentCount?.total || 0;
      const facilityTotal = facilityCountData?.total || 0;
      const currentRolesCount = existingRolesCount?.total || 0;

      let potentialRolesCount = 1;

      if (mgmtCount > 0) {
        potentialRolesCount += mgmtCount * 2;

        if (deptCount > 0) {
          potentialRolesCount += deptCount * 2;

          if (facilityTotal > 0) {
            potentialRolesCount += facilityTotal * 2;
          }
        }
      }

      const rolesToBeCreated = Math.max(0, potentialRolesCount - currentRolesCount);

      let roleStatus = "unknown";
      let roleStatusMessage = "";

      if (currentRolesCount === 0) {
        roleStatus = "empty";
        roleStatusMessage = bundle.getText('roleStatusEmpty');
      } else if (currentRolesCount < potentialRolesCount) {
        roleStatus = "incomplete";
        roleStatusMessage = bundle.getText('roleStatusIncomplete', [rolesToBeCreated]);
      } else if (currentRolesCount === potentialRolesCount) {
        roleStatus = "complete";
        roleStatusMessage = bundle.getText('roleStatusComplete');
      } else {
        roleStatus = "excess";
        roleStatusMessage = bundle.getText('roleStatusExcess');
      }

      const statistics = {
        managementCount: mgmtCount,
        departmentCount: deptCount,
        facilityCount: facilityTotal,
        currentRolesCount: currentRolesCount,
        potentialRolesCount: potentialRolesCount,
        rolesToBeCreated: rolesToBeCreated,
        roleStatus: roleStatus,
        roleStatusMessage: roleStatusMessage,
        lastCalculated: new Date().toISOString()
      };

      return {
        getRoleStatistics: statistics,
        success: true
      };

    } catch (error) {
      console.error(`\n--- ${logPrefix} !!!HATA!!! İstatistik hesaplama sırasında bir hata oluştu. ---`);
      console.error("Detaylı Hata Objesi:", error);
      console.error("Hata Mesajı:", error.message);
      return req.error(500, bundle.getText('statisticsCalculationError', [error.message]));
    }
  });


  srv.on("sendUserActionEmail", async (req) => {

    const { email, firstname, lastname, title, department, description, status } = req.data;
    const logPrefix = "[sendUserActionEmail]";

    try {
      const processAutomation = await cds.connect.to('obscard_spa');
      const context = {
        email: email,
        firstname: firstname,
        lastname: lastname,
        title: title,
        department: department,
        description: description,
        status: status
      };

      return processAutomation.tx(req).post('/v1/workflow-instances', {
        "definitionId": "eu10.dev1ain.ehsroleuser.userMail",
        "context": context
      });

    } catch (error) {
      console.error(`${logPrefix} mail process hatası :`, error);
      req.error(500, "E-posta gönderme sürecinde bir hata oluştu.");
      return {
        success: false,
        message: `E-posta gönderme sürecinde bir hata oluştu: ${error.message}`
      };
    }
  });



  const validateRequiredFields = (data, requiredFields, bundle) => {
    const missing = requiredFields.filter(field => !data[field]);
    if (missing.length > 0) {
      return {
        error: true,
        message: bundle.getText('errorMissingFields', [missing.join(', ')])
      };
    }
    return null;
  };



  const handleServiceError = (logPrefix, error, req, bundle, operationType) => {
    console.error(`${logPrefix} Error during ${operationType}:`, error);
    const errorMessage = error.reason?.message || error.message || bundle.getText('errorUnknown');
    return req.error(500, bundle.getText(`${operationType}Error`, [errorMessage]));
  };



  const createBatchOperations = (operation, entries) => {
    return entries.map(entry => operation(entry));
  };



  const executeBatchWithFallback = async (service, operations, fallbackData, individualOperation, logPrefix) => {
    try {
      await service.batch().run(...operations);
      console.log(`${logPrefix} Batch operation successful for ${operations.length} items`);
      return { success: true, processedCount: operations.length };
    } catch (batchError) {
      console.warn(`${logPrefix} Batch operation failed, falling back to individual operations:`, batchError.message);

      let successCount = 0;
      const errors = [];

      for (const data of fallbackData) {
        try {
          await individualOperation(data);
          successCount++;
        } catch (individualError) {
          errors.push({ data, error: individualError.message });
          console.error(`${logPrefix} Individual operation failed:`, individualError);
        }
      }

      return {
        success: errors.length === 0,
        processedCount: successCount,
        errors: errors,
        fallbackUsed: true
      };
    }
  };


  srv.on('createManagement', async (req) => {

    const { managementKey, nameEN, nameTR } = req.data;
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);
    const logPrefix = '[createManagement]';

    const validationError = validateRequiredFields(req.data, ['managementKey', 'nameEN', 'nameTR'], bundle);
    if (validationError) {
      return req.error(400, validationError.message);
    }

    try {
      const { ZBTP_EHS_DD_T_MANAGEMENT } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;
      const existingEntry = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        SELECT.one.from(ZBTP_EHS_DD_T_MANAGEMENT).where({ zmanagement_key: managementKey })
      );

      if (existingEntry) {
        return req.error(409, bundle.getText('managementExistsError', [managementKey]));
      }

      const entryEN = { spras: 'E', zmanagement_key: managementKey, zmanagement_name: nameEN };
      const entryTR = { spras: 'T', zmanagement_key: managementKey, zmanagement_name: nameTR };

      await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT.into(ZBTP_EHS_DD_T_MANAGEMENT).entries(entryEN));
      await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT.into(ZBTP_EHS_DD_T_MANAGEMENT).entries(entryTR));

      const successMessage = bundle.getText('managementCreateSuccess', [managementKey]);
      return { success: true, message: successMessage };

    } catch (error) {
      return handleServiceError(logPrefix, error, req, bundle, 'managementCreate');
    }
  });



  srv.on('updateManagement', async (req) => {

    const { managementKey, nameEN, nameTR } = req.data;
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);
    if (!managementKey || !nameEN || !nameTR) {
      return req.error(400, bundle.getText('errorMissingFields', ['managementKey, nameEN, nameTR']));
    }

    try {
      const { ZBTP_EHS_DD_T_MANAGEMENT } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;

      await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        UPDATE(ZBTP_EHS_DD_T_MANAGEMENT)
          .set({ zmanagement_name: nameEN })
          .where({ zmanagement_key: managementKey, spras: 'E' })
      );

      await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        UPDATE(ZBTP_EHS_DD_T_MANAGEMENT)
          .set({ zmanagement_name: nameTR })
          .where({ zmanagement_key: managementKey, spras: 'T' })
      );

      const successMessage = bundle.getText('managementUpdateSuccess', [managementKey]);
      return { success: true, message: successMessage };

    } catch (error) {
      const errorMessage = error.reason?.message || error.message || bundle.getText('errorUnknown');
      return req.error(500, bundle.getText('managementUpdateError', [errorMessage]));
    }
  });



  srv.on('createDepartment', async (req) => {

    const { departmentKey, nameEN, nameTR, managementKey } = req.data;
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);

    if (!departmentKey || !nameEN || !nameTR || !managementKey) {
      return req.error(400, bundle.getText('errorMissingFields', ['departmentKey, nameEN, nameTR, managementKey']));
    }

    try {
      const { ZBTP_EHS_DD_T_DEPARTMENT, ZBTP_EHS_DD_T_MANAGEMENT } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;

      const existingManagement = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        SELECT.one.from(ZBTP_EHS_DD_T_MANAGEMENT).where({ zmanagement_key: managementKey })
      );
      if (!existingManagement) {
        return req.error(400, bundle.getText('departmentManagementNotFoundError', [managementKey]));
      }

      const existingDepartment = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        SELECT.one.from(ZBTP_EHS_DD_T_DEPARTMENT).where({
          zdepartment_key: departmentKey,
          zmanagement_key: managementKey
        })
      );
      if (existingDepartment) {
        return req.error(409, bundle.getText('departmentExistsError', [departmentKey, managementKey]));
      }

      const entryEN = { spras: 'E', zdepartment_key: departmentKey, zmanagement_key: managementKey, zdepartment_name: nameEN };
      const entryTR = { spras: 'T', zdepartment_key: departmentKey, zmanagement_key: managementKey, zdepartment_name: nameTR };

      await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT.into(ZBTP_EHS_DD_T_DEPARTMENT).entries(entryEN));
      await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT.into(ZBTP_EHS_DD_T_DEPARTMENT).entries(entryTR));

      const successMessage = bundle.getText('departmentCreateSuccess', [departmentKey, managementKey]);
      return { success: true, message: successMessage };

    } catch (error) {
      const errorMessage = error.reason?.message || error.message || bundle.getText('errorUnknown');
      return req.error(500, bundle.getText('departmentCreateError', [errorMessage]));
    }
  });



  srv.on('updateDepartment', async (req) => {
    const { departmentKey, nameEN, nameTR, managementKey } = req.data;
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);

    if (!departmentKey || !nameEN || !nameTR || !managementKey) {
      return req.error(400, bundle.getText('errorMissingFields', ['departmentKey, nameEN, nameTR, managementKey']));
    }

    try {
      const { ZBTP_EHS_DD_T_DEPARTMENT, ZBTP_EHS_DD_T_MANAGEMENT } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;

      const existingManagement = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        SELECT.one.from(ZBTP_EHS_DD_T_MANAGEMENT).where({ zmanagement_key: managementKey })
      );
      if (!existingManagement) {
        return req.error(400, bundle.getText('departmentManagementNotFoundError', [managementKey]));
      }

      const existingDepartment = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        SELECT.one.from(ZBTP_EHS_DD_T_DEPARTMENT).where({ zdepartment_key: departmentKey })
      );
      if (!existingDepartment) {
        return req.error(404, bundle.getText('departmentNotFoundError', [departmentKey]));
      }

      if (existingDepartment.zmanagement_key && existingDepartment.zmanagement_key !== managementKey) {
        return req.error(400, bundle.getText('departmentManagementChangeError', [departmentKey, existingDepartment.zmanagement_key]));
      }

      await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        UPDATE(ZBTP_EHS_DD_T_DEPARTMENT)
          .set({ zdepartment_name: nameEN })
          .where({ zdepartment_key: departmentKey, zmanagement_key: managementKey, spras: 'E' })
      );
      await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        UPDATE(ZBTP_EHS_DD_T_DEPARTMENT)
          .set({ zdepartment_name: nameTR })
          .where({ zdepartment_key: departmentKey, zmanagement_key: managementKey, spras: 'T' })
      );

      const successMessage = bundle.getText('departmentUpdateSuccess', [departmentKey, managementKey]);
      return { success: true, message: successMessage };

    } catch (error) {
      const errorMessage = error.reason?.message || error.message || bundle.getText('errorUnknown');
      return req.error(500, bundle.getText('departmentUpdateError', [errorMessage]));
    }
  });



  srv.on('createFacility', async (req) => {

    const { facilityKey, nameEN, nameTR, departmentKey } = req.data;
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);

    if (!facilityKey || !nameEN || !nameTR || !departmentKey) {
      return req.error(400, bundle.getText('errorMissingFields', ['facilityKey, nameEN, nameTR, departmentKey']));
    }

    try {
      const { ZBTP_EHS_DD_T_UNITS, ZBTP_EHS_DD_T_DEPARTMENT } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;

      const existingDepartment = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        SELECT.one.from(ZBTP_EHS_DD_T_DEPARTMENT).where({ zdepartment_key: departmentKey })
      );
      if (!existingDepartment) {
        return req.error(400, bundle.getText('facilityDepartmentNotFoundError', [departmentKey]));
      }

      const existingFacility = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        SELECT.one.from(ZBTP_EHS_DD_T_UNITS).where({ zunit_key: facilityKey })
      );
      if (existingFacility) {
        return req.error(409, bundle.getText('facilityExistsError', [facilityKey]));
      }

      const entryEN = { spras: 'E', zunit_key: facilityKey, zdepartment_id: departmentKey, zfacility_unit: nameEN };
      const entryTR = { spras: 'T', zunit_key: facilityKey, zdepartment_id: departmentKey, zfacility_unit: nameTR };

      await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT.into(ZBTP_EHS_DD_T_UNITS).entries(entryEN));
      await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(INSERT.into(ZBTP_EHS_DD_T_UNITS).entries(entryTR));

      const successMessage = bundle.getText('facilityCreateSuccess', [facilityKey, departmentKey]);
      return { success: true, message: successMessage };

    } catch (error) {
      const errorMessage = error.reason?.message || error.message || bundle.getText('errorUnknown');
      return req.error(500, bundle.getText('facilityCreateError', [errorMessage]));
    }
  });



  srv.on('updateFacility', async (req) => {

    const { facilityKey, nameEN, nameTR, departmentKey } = req.data;
    const locale = req.user.locale;
    const bundle = textBundle.getTextBundle(locale);

    if (!facilityKey || !nameEN || !nameTR || !departmentKey) {
      return req.error(400, bundle.getText('errorMissingFields', ['facilityKey, nameEN, nameTR, departmentKey']));
    }
    try {
      const { ZBTP_EHS_DD_T_UNITS, ZBTP_EHS_DD_T_DEPARTMENT } = ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.entities;

      const existingDepartment = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        SELECT.one.from(ZBTP_EHS_DD_T_DEPARTMENT).where({ zdepartment_key: departmentKey })
      );
      if (!existingDepartment) {
        return req.error(400, bundle.getText('facilityDepartmentNotFoundError', [departmentKey]));
      }

      const existingFacility = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        SELECT.one.from(ZBTP_EHS_DD_T_UNITS).where({ zunit_key: facilityKey })
      );
      if (!existingFacility) {
        return req.error(404, bundle.getText('facilityNotFoundError', [facilityKey]));
      }

      if (existingFacility.zdepartment_id && existingFacility.zdepartment_id !== departmentKey) {
        return req.error(400, bundle.getText('facilityDepartmentChangeError', [facilityKey, existingFacility.zdepartment_id]));
      }

      await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        UPDATE(ZBTP_EHS_DD_T_UNITS)
          .set({ zfacility_unit: nameEN })
          .where({ zunit_key: facilityKey, spras: 'E' })
      );
      await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        UPDATE(ZBTP_EHS_DD_T_UNITS)
          .set({ zfacility_unit: nameTR })
          .where({ zunit_key: facilityKey, spras: 'T' })
      );

      const successMessage = bundle.getText('facilityUpdateSuccess', [facilityKey, departmentKey]);
      return { success: true, message: successMessage };

    } catch (error) {
      const errorMessage = error.reason?.message || error.message || bundle.getText('errorUnknown');
      return req.error(500, bundle.getText('facilityUpdateError', [errorMessage]));
    }
  });


  srv.on('UpdateIncidentStatus', async (req) => {
    const { zreport_no, status } = req.data;

    if (!zreport_no || !status) {
      req.error(400, 'Rapor no ve status alanları gereklidir');
      return;
    }

    try {
      // Önce mevcut kaydı oku
      var oExistingRecord = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        SELECT.one.from("ZBTP_EHS_DD_FLASHFORM").where(`zreport_no='${zreport_no}'`)
      );

      if (!oExistingRecord) {
        req.error(404, `Rapor bulunamadı: ${zreport_no}`);
        return;
      }

      var oCurrentDate = new Date();
      var sTime = `${oCurrentDate.toLocaleTimeString("tr-TR", { timeZone: "Turkey" }).split(":").join("")}`;
      sTime = `PT${sTime.substr(0, 2)}H${sTime.substr(2, 2)}M${sTime.substr(4, 2)}S`;

      // FlashForm status'unu güncelle
      // Not: zinc_status hesaplanan bir field, status field'ını güncelleyince otomatik değişir
      var oUpdate = {
        status: status,
        aedat: oCurrentDate.toLocaleDateString('en-CA', { timeZone: "Turkey" }) + "T00:00:00",
        aezet: sTime,
        aenam: req.user.id
      };

      console.log(`Updating FlashForm status for ${zreport_no}: ${status}`);

      var sQuery = UPDATE("ZBTP_EHS_DD_FLASHFORM").with(oUpdate).where(`zreport_no='${zreport_no}'`);
      var result = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(sQuery);

      console.log('UPDATE Result:', result);

      var oUpdatedRecord = await ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.run(
        SELECT.one.from("ZBTP_EHS_DD_FLASHFORM").where(`zreport_no='${zreport_no}'`)
      );

      if (oUpdatedRecord && oUpdatedRecord.status === status) {
        console.log(`Status successfully updated. New zinc_status: ${oUpdatedRecord.zinc_status}`);
        return `Status başarıyla güncellendi (zinc_status: ${oUpdatedRecord.zinc_status})`;
      } else {
        console.error('UPDATE FAILED - Status did not change in database');
        console.error('Previous status:', oExistingRecord.status);
        console.error('Expected new status:', status);
        console.error('Actual new status:', oUpdatedRecord?.status);
        req.error(500, 'Status güncellenemedi - SAP backend UPDATE yapmadı. Lütfen SAP administrator ile iletişime geçin.');
        return;
      }
    } catch (error) {
      console.error('UpdateIncidentStatus Error:', error);
      req.error(500, `Status güncellenirken hata oluştu: ${error.message}`);
      return;
    }
  });


}