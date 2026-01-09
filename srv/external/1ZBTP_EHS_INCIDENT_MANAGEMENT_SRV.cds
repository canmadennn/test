/* checksum : 250555c1cb685c40b82aa954577021c4 */
@cds.external : true
@m.IsDefaultEntityContainer : 'true'
@sap.message.scope.supported : 'true'
@sap.supported.formats : 'atom json xlsx'
service ZBTP_EHS_INCIDENT_MANAGEMENT_SRV {};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Company - Manager'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_CMPMNG {
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.label : 'Director Key'
  @sap.quickinfo : 'BTP Data Element For Director Key'
  zdirector_key : String(3);
  @sap.label : 'Director Description'
  @sap.quickinfo : 'BTP Data Element For Director Description'
  zdirector_desc : String(255);
  @sap.label : 'Manager Key'
  @sap.quickinfo : 'BTP Data Element For Manager Key'
  zmanager_key : String(5);
  @sap.label : 'Manager Description'
  @sap.quickinfo : 'BTP Data Element For Manager Description'
  zmanager_desc : String(255);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Company Information Manager'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CMP_MNG {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Director Key'
  @sap.quickinfo : 'BTP Data Element For Director Key'
  key zdirector_key : String(3) not null;
  @sap.label : 'Manager Key'
  @sap.quickinfo : 'BTP Data Element For Manager Key'
  key zmanager_key : String(5) not null;
  @sap.label : 'Manager Description'
  @sap.quickinfo : 'BTP Data Element For Manager Description'
  zmanager_desc : String(255);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Consequences CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CONSEQUENCES {
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.label : 'Consequences Key'
  @sap.quickinfo : 'BTP Forms Data Element For Consequences Key'
  key zconsequences_key : String(3) not null;
  @sap.label : 'Inc Likelihood Key'
  @sap.quickinfo : 'BTP Data Element For Incident Likelihood Key'
  key zlikelihood : String(3) not null;
  to_ConsDetails : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CONSEQUENCES_SH {  };
  to_Likelihood : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_LIKELIHOOD_SH {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'EHS Consequences SH CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CONSEQUENCES_SH {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Consequences Key'
  @sap.quickinfo : 'BTP Forms Data Element For Consequences Key'
  key zconsequences_key : String(3) not null;
  @sap.label : 'Consequences Type'
  @sap.quickinfo : 'BTP Data Element For Consequences Type'
  zconsequences_type : String(200);
  @sap.label : 'Consequences'
  @sap.quickinfo : 'BTP Forms Data Element For Consequences'
  zconsequences : String(200);
  @sap.label : 'Incident Severity'
  @sap.quickinfo : 'BTP Forms Data Element For Incident Severity'
  zincident_severity : String(1);
  @odata.Type : 'Edm.Byte'
  @sap.label : 'Order'
  @sap.quickinfo : 'BTP Order'
  zorder : Integer;
  @sap.label : 'Short Description'
  @sap.quickinfo : 'Short Text for Fixed Values'
  ddtext : String(60);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Company Information Director'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CPM_DRC {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Director Key'
  @sap.quickinfo : 'BTP Data Element For Director Key'
  key zdirector_key : String(3) not null;
  @sap.label : 'Director Description'
  @sap.quickinfo : 'BTP Data Element For Director Description'
  zdirector_desc : String(255);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Department CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_DEPARTM {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.text : 'zdepartment_name'
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Key'
  key zdepartment_key : String(3) not null;
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  key zmanagement_key : String(3) not null;
  @sap.label : 'Department Name'
  @sap.quickinfo : 'BTP Data Element For Department Name'
  zdepartment_name : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.addressable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Package 1 Department Field Roles CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_DPRTMNT_ROLESSet {
  @sap.label : 'E-Mail Address'
  key p_email : String(241) not null;
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  key zmanagement_key : String(3) not null;
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Key'
  key zdepartment_key : String(3) not null;
  @sap.label : 'Department Name'
  @sap.quickinfo : 'BTP Data Element For Department Name'
  zdepartment_name : String(200);
  @sap.filterable : 'false'
  Parameters : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_DPRTMNT_ROLES {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.pageable : 'false'
@sap.content.version : '1'
@sap.semantics : 'parameters'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_DPRTMNT_ROLES {
  @sap.parameter : 'mandatory'
  @sap.label : 'E-Mail Address'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.sortable : 'false'
  @sap.filterable : 'false'
  key p_email : String(241) not null;
  Set : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_DPRTMNT_ROLESSet {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.addressable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Package 1 Facility Field Roles CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FACILITY_ROLESSet {
  @sap.label : 'E-Mail Address'
  key p_email : String(241) not null;
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  key zmanagement_key : String(3) not null;
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Key'
  key zdepartment_key : String(3) not null;
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Unit Key'
  key zunit_key : String(3) not null;
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility/Unit'
  zfacility_unit : String(200);
  @sap.filterable : 'false'
  Parameters : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FACILITY_ROLES {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.pageable : 'false'
@sap.content.version : '1'
@sap.semantics : 'parameters'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FACILITY_ROLES {
  @sap.parameter : 'mandatory'
  @sap.label : 'E-Mail Address'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.sortable : 'false'
  @sap.filterable : 'false'
  key p_email : String(241) not null;
  Set : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FACILITY_ROLESSet {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Flashform CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FLASHFORM {
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  zmanagement : String(3);
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Key'
  zdepartment : String(3);
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility Key'
  zfacility : String(3);
  @sap.label : 'Well/Project/Site'
  @sap.quickinfo : 'BTP Data Element For Well'
  zwell : String(100);
  @sap.label : 'Incident Title'
  @sap.quickinfo : 'BTP Data Element For Incident Title'
  zincident_title : String(100);
  @sap.display.format : 'Date'
  @sap.label : 'Date Of Report'
  @sap.quickinfo : 'BTP Data Element For Report Date'
  zreport_date : Date;
  @sap.label : 'Time Of Report'
  @sap.quickinfo : 'BTP Data Element For Report Time'
  zreport_time : Time;
  @sap.display.format : 'Date'
  @sap.label : 'Date Of Incident'
  @sap.quickinfo : 'BTP Data Element For Incident Date'
  zincident_date : Date;
  @sap.label : 'Time Of Incident'
  @sap.quickinfo : 'BTP Data Element For Incident Time'
  zincident_time : Time;
  @sap.label : 'Incident Location'
  @sap.quickinfo : 'BTP Data Element For Incident Location'
  zincident_loc : LargeString;
  @sap.label : 'Incident Class'
  @sap.quickinfo : 'BTP Data Element For Incident Class Key'
  zincident_class : String(3);
  @sap.label : 'DROP'
  @sap.quickinfo : 'BTP Data Element For DROP'
  zdrop : String(1);
  @sap.label : 'MEDEVAC'
  @sap.quickinfo : 'BTP Data Element For MEDEVAC'
  zmedevac : String(1);
  @sap.label : 'Incident Description'
  @sap.quickinfo : 'BTP Data Element For Incident Description'
  zincident_desc : LargeString;
  @sap.label : 'Custom Text 1'
  @sap.quickinfo : 'BTP Data Element For Custom Text 1'
  zcustom_text1 : String(100);
  @sap.label : 'Custom Text 2'
  @sap.quickinfo : 'BTP Data Element For Custom Text 2'
  zcustom_text2 : String(100);
  @sap.label : 'Custom Text 3'
  @sap.quickinfo : 'BTP Data Element For Custom Text 2'
  zcustom_text3 : String(100);
  @sap.label : 'Custom Dec 1'
  @sap.quickinfo : 'BTP Data Element For Custom Dec 1'
  zcustom_dec1 : Decimal(13, 3);
  @sap.label : 'Custom Dec 2'
  @sap.quickinfo : 'BTP Data Element For Custom Dec 2'
  zcustom_dec2 : Decimal(13, 3);
  @sap.label : 'Custom Dec 3'
  @sap.quickinfo : 'BTP Data Element For Custom Dec 3'
  zcustom_dec3 : Decimal(13, 3);
  @sap.display.format : 'Date'
  @sap.label : 'Created On'
  @sap.quickinfo : 'Record Creation Date'
  erdat : Date;
  @sap.label : 'Time'
  @sap.quickinfo : 'Entry time'
  erzet : Time;
  @sap.label : 'Created By'
  @sap.quickinfo : 'BTP EHS Data Element For Created By'
  ernam : String(241);
  @sap.display.format : 'Date'
  @sap.label : 'Changed On'
  @sap.quickinfo : 'Last Changed On'
  aedat : Date;
  @sap.label : 'Changed at'
  @sap.quickinfo : 'Time last change was made'
  aezet : Time;
  @sap.label : 'Changed By'
  @sap.quickinfo : 'BTP EHS Data Element For Changed By'
  aenam : String(241);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Status'
  @sap.quickinfo : 'BTP Data Element For Form Status'
  status : String(1);
  @sap.display.format : 'UpperCase'
  @sap.text : 'zinc_status_Text'
  @sap.label : 'Incident Status'
  @sap.quickinfo : 'BTP EHS Total Incident Status DE'
  zinc_status : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Incident Status Desc'
  @sap.quickinfo : 'BTP EHS Total Incident Status Desc DE'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  zinc_status_Text : String(200);
  @sap.label : 'Incident Relevance'
  @sap.quickinfo : 'BTP Forms Data Element For Incident Relevance'
  zincident_relevance_desc : String(3);
  @sap.label : ''
  zincident_type_desc : String(255);
  @sap.label : 'Signature Folder ID'
  @sap.quickinfo : 'BTP EHS Signature Folder ID Data Element'
  signfolderid : String(70);
  @sap.label : 'Incident Title'
  @sap.quickinfo : 'BTP: Incident Title String Type - Max'
  ztitle_max : LargeString;
  to_Department : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_DEPARTM {  };
  to_Facility : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_UNITS {  };
  to_IncCLass : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_CLASS {  };
  to_IncStatus : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_STATUS {  };
  to_Init : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INITIAL {  };
  to_Inv : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INVESTIGATION {  };
  to_Management : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_MNGMT {  };
  to_Status : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FORM_STATUS {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Form Status CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FORM_STATUS {
  @sap.label : 'Lang.'
  @sap.quickinfo : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Short Description'
  @sap.quickinfo : 'Short Text for Fixed Values'
  key status_text : String(60) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Lower Value'
  @sap.quickinfo : 'Values for Domains: Single Value/Lower Limit'
  status : String(10);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Full Management'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FULL_MNGMNT {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.text : 'zmanagement_name'
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  key zmanagement_key : String(3) not null;
  @sap.label : 'Management Name'
  @sap.quickinfo : 'BTP Data Element For Management Name'
  zmanagement_name : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Immediate Causes CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_IMMEDIATE_CAUSES {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'İmmediate Causes'
  @sap.quickinfo : 'BTP Data Element For İmmediate Causes Key'
  key zimm_caueses_key : String(3) not null;
  @sap.label : 'Row No'
  @sap.quickinfo : 'EHS Row No'
  key zrow_no : Integer not null;
  @sap.label : 'Immediate Causes'
  @sap.quickinfo : 'BTP Data Element For Immediate Causes'
  zimmediate_causes : String(200);
  @sap.label : 'Mic Key'
  @sap.quickinfo : 'BTP Data Element For Mic Key'
  zmic_key : String(3);
  zdefinition : String(1279);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Incident Class CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_CLASS {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Incident Class'
  @sap.quickinfo : 'BTP Data Element For Incident Class Key'
  key zincident_classname_key : String(3) not null;
  @sap.label : 'Incident Class Name'
  @sap.quickinfo : 'BTP Data Element For Incident Class Name'
  zincident_classname : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'BTP EHS Incident Status CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_STATUS {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Incident Status'
  @sap.quickinfo : 'BTP EHS Total Incident Status DE'
  key zinc_status : String(1) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Incident Status Desc'
  @sap.quickinfo : 'BTP EHS Total Incident Status Desc DE'
  zinc_status_desc : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Incident Type CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_TYPE {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Incident Type'
  @sap.quickinfo : 'BTP Data Element For Incident Type Key'
  key zincident_type_key : String(3) not null;
  @sap.label : 'Incident Class'
  @sap.quickinfo : 'BTP Data Element For Incident Class Key'
  key zincident_class_id : String(3) not null;
  @sap.label : ''
  zincident_type_desc : String(255);
  @sap.label : 'Incident Class Name'
  @sap.quickinfo : 'BTP Data Element For Incident Class Name'
  zincident_classname : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Initialform CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INITIAL {
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  zmanagement : String(3);
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Key'
  zdepartment : String(3);
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility Key'
  zfacility : String(3);
  @sap.label : 'Well/Project/Site'
  @sap.quickinfo : 'BTP Data Element For Well'
  zwell : String(100);
  @sap.label : 'Incident Title'
  @sap.quickinfo : 'BTP Data Element For Incident Title'
  zincident_title : String(100);
  @sap.display.format : 'Date'
  @sap.label : 'Date Of Report'
  @sap.quickinfo : 'BTP Data Element For Report Date'
  zreport_date : Date;
  @sap.label : 'Time Of Report'
  @sap.quickinfo : 'BTP Data Element For Report Time'
  zreport_time : Time;
  @sap.display.format : 'Date'
  @sap.label : 'Date Of Incident'
  @sap.quickinfo : 'BTP Data Element For Incident Date'
  zincident_date : Date;
  @sap.label : 'Time Of Incident'
  @sap.quickinfo : 'BTP Data Element For Incident Time'
  zincident_time : Time;
  @sap.label : 'Incident Location'
  @sap.quickinfo : 'BTP Data Element For Incident Location'
  zincident_loc : LargeString;
  @sap.label : 'Incident Class'
  @sap.quickinfo : 'BTP Data Element For Incident Class Key'
  zincident_class : String(3);
  @sap.label : 'DROP'
  @sap.quickinfo : 'BTP Data Element For DROP'
  zdrop : String(1);
  @sap.label : 'MEDEVAC'
  @sap.quickinfo : 'BTP Data Element For MEDEVAC'
  zmedevac : String(1);
  @sap.label : 'Incident Description'
  @sap.quickinfo : 'BTP Data Element For Incident Description'
  zincident_desc : LargeString;
  @sap.label : 'Initial Findings'
  @sap.quickinfo : 'BTP Data Element For Initial Findings'
  zinitial_findings : LargeString;
  @sap.label : 'Custom Text 1'
  @sap.quickinfo : 'BTP Data Element For Custom Text 1'
  zcustom_text1 : String(100);
  @sap.label : 'Custom Text 2'
  @sap.quickinfo : 'BTP Data Element For Custom Text 2'
  zcustom_text2 : String(100);
  @sap.label : 'Custom Text 3'
  @sap.quickinfo : 'BTP Data Element For Custom Text 2'
  zcustom_text3 : String(100);
  @sap.label : 'Custom Dec 1'
  @sap.quickinfo : 'BTP Data Element For Custom Dec 1'
  zcustom_dec1 : Decimal(13, 3);
  @sap.label : 'Custom Dec 2'
  @sap.quickinfo : 'BTP Data Element For Custom Dec 2'
  zcustom_dec2 : Decimal(13, 3);
  @sap.label : 'Custom Dec 3'
  @sap.quickinfo : 'BTP Data Element For Custom Dec 3'
  zcustom_dec3 : Decimal(13, 3);
  @sap.display.format : 'Date'
  @sap.label : 'Created On'
  @sap.quickinfo : 'Record Creation Date'
  erdat : Date;
  @sap.label : 'Time'
  @sap.quickinfo : 'Entry time'
  erzet : Time;
  @sap.label : 'Created By'
  @sap.quickinfo : 'BTP EHS Data Element For Created By'
  ernam : String(241);
  @sap.display.format : 'Date'
  @sap.label : 'Changed On'
  @sap.quickinfo : 'Last Changed On'
  aedat : Date;
  @sap.label : 'Changed at'
  @sap.quickinfo : 'Time last change was made'
  aezet : Time;
  @sap.label : 'Changed By'
  @sap.quickinfo : 'BTP EHS Data Element For Changed By'
  aenam : String(241);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Status'
  @sap.quickinfo : 'BTP Data Element For Form Status'
  status : String(1);
  @sap.label : 'Incident Type'
  @sap.quickinfo : 'BTP Data Element For Incident Type Key'
  zincident_type : String(3);
  @sap.label : 'Incident Relevance'
  @sap.quickinfo : 'BTP Data Element For Incident Relevance Key'
  zincident_relevance : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Prepared Name'
  @sap.quickinfo : 'EHS Prepared Name'
  zprepared_name : String(200);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Prepared Signature'
  @sap.quickinfo : 'EHS Prepared Signature'
  zprepared_signature : String(200);
  @sap.display.format : 'Date'
  @sap.label : 'Prepared Date'
  @sap.quickinfo : 'EHS Prepared Date'
  zprepared_date : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Approved Name'
  @sap.quickinfo : 'EHS Approved Name'
  zapproved_name : String(200);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Approved Signature'
  @sap.quickinfo : 'EHS Approved Signature'
  zapproved_signature : String(200);
  @sap.display.format : 'Date'
  @sap.label : 'Approved Date'
  @sap.quickinfo : 'EHS Approved Date'
  zapproved_date : Date;
  @sap.label : 'Consequences Key'
  @sap.quickinfo : 'BTP Forms Data Element For Consequences Key'
  zreal_outcome : String(3);
  @sap.label : 'Signature Folder ID'
  @sap.quickinfo : 'BTP EHS Signature Folder ID Data Element'
  signfolderid : String(70);
  @sap.label : 'Incident Title'
  @sap.quickinfo : 'BTP: Incident Title String Type - Max'
  ztitle_max : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Single-Character Flag'
  @sap.heading : ''
  signfolderpresent : String(1);
  to_Act : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INIT_IMM_ACT {  };
  to_Cons : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CONSEQUENCES {  };
  to_Department : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_DEPARTM {  };
  to_Facility : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_UNITS {  };
  to_Files : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INIT_FILES {  };
  to_IncClass : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_CLASS {  };
  to_IncRelv : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_RELEVANCE_SH {  };
  to_IncType : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_TYPE {  };
  to_Inv : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INVESTIGATION {  };
  to_Management : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_MNGMT {  };
  to_Pos : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INIT_POS_CAU {  };
  to_RealOut : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CONSEQUENCES_SH {  };
  to_Status : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FORM_STATUS {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'BTP EHS InitialForm Files BASE64'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INIT_FILES {
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.label : 'c'
  @sap.quickinfo : 'Comment'
  key filename : String(50) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Char20'
  @sap.quickinfo : 'Char 20'
  key fileType : String(20) not null;
  fileContent : LargeString;
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Initial Form Immediate Actions CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INIT_IMM_ACT {
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.label : 'Row No'
  @sap.quickinfo : 'EHS Row No'
  key zrow_no : Integer not null;
  @sap.label : 'Immediate Act Taken'
  @sap.quickinfo : 'BTP Data Element For Immediate Action Taken'
  zimm_act_taken : LargeString;
  @sap.label : 'Responsible Party'
  @sap.quickinfo : 'BTP Data Element For Responsible Party'
  zresponsible_party : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Initial Form Possible Causes CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INIT_POS_CAU {
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.label : 'Mrc Key'
  @sap.quickinfo : 'BTP Data Element For MIC Mrc Key'
  key mic_key : String(3) not null;
  @sap.label : 'Row No'
  @sap.quickinfo : 'EHS Row No'
  key zrow_no : Integer not null;
  @sap.label : 'İmmediate Causes'
  @sap.quickinfo : 'BTP Data Element For İmmediate Causes Key'
  key immediate_key : String(3) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Note'
  @sap.quickinfo : 'BTP EHS Note'
  znote : LargeString;
  to_Immc : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_IMMEDIATE_CAUSES {  };
  to_Mimm : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_M_IMMEDIATE_CAUSES {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Injury Illness CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INJ_ILL {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Inj Illness Dmg Type'
  @sap.quickinfo : 'BTP Data Element For Injury Illness Damage Types Key'
  key zill_types_key : String(3) not null;
  @sap.label : 'Inj Ill Dmg Typ Desc'
  @sap.quickinfo : 'BTP Data Element For Injury Illness Damage Types Key'
  zinj_ill_damage_type : String(200);
  @sap.label : 'Incident Class'
  @sap.quickinfo : 'BTP Data Element For Incident Class Key'
  zincident_class : String(3);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Injurey Personel Company CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INj_PERS_COMP {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Injured Personel Com'
  @sap.quickinfo : 'BTP Data Element For Injured Personel Company Key'
  key zinj_per_comp_key : String(3) not null;
  @sap.label : 'Injured Per Com Desc'
  @sap.quickinfo : 'BTP Data Element For Injured Personel Company Desc'
  zinj_per_comp_desc : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Investigationform CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INVESTIGATION {
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  zmanagement : String(3);
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Key'
  zdepartment : String(3);
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility Key'
  zfacility : String(3);
  @sap.label : 'Well/Project/Site'
  @sap.quickinfo : 'BTP Data Element For Well'
  zwell : String(100);
  @sap.label : 'Incident Title'
  @sap.quickinfo : 'BTP Data Element For Incident Title'
  zincident_title : String(100);
  @sap.display.format : 'Date'
  @sap.label : 'Date Of Report'
  @sap.quickinfo : 'BTP Data Element For Report Date'
  zreport_date : Date;
  @sap.label : 'Time Of Report'
  @sap.quickinfo : 'BTP Data Element For Report Time'
  zreport_time : Time;
  @sap.display.format : 'Date'
  @sap.label : 'Date Of Incident'
  @sap.quickinfo : 'BTP Data Element For Incident Date'
  zincident_date : Date;
  @sap.label : 'Time Of Incident'
  @sap.quickinfo : 'BTP Data Element For Incident Time'
  zincident_time : Time;
  @sap.label : 'Incident Location'
  @sap.quickinfo : 'BTP Data Element For Incident Location'
  zincident_loc : LargeString;
  @sap.label : 'Incident Class'
  @sap.quickinfo : 'BTP Data Element For Incident Class Key'
  zincident_class : String(3);
  @sap.label : 'DROP'
  @sap.quickinfo : 'BTP Data Element For DROP'
  zdrop : String(1);
  @sap.label : 'MEDEVAC'
  @sap.quickinfo : 'BTP Data Element For MEDEVAC'
  zmedevac : String(1);
  @sap.label : 'Incident Description'
  @sap.quickinfo : 'BTP Data Element For Incident Description'
  zincident_desc : LargeString;
  @sap.label : 'Initial Findings'
  @sap.quickinfo : 'BTP Data Element For Initial Findings'
  zinitial_findings : LargeString;
  @sap.label : 'Custom Text 1'
  @sap.quickinfo : 'BTP Data Element For Custom Text 1'
  zcustom_text1 : String(100);
  @sap.label : 'Custom Text 2'
  @sap.quickinfo : 'BTP Data Element For Custom Text 2'
  zcustom_text2 : String(100);
  @sap.label : 'Custom Text 3'
  @sap.quickinfo : 'BTP Data Element For Custom Text 2'
  zcustom_text3 : String(100);
  @sap.label : 'Custom Dec 1'
  @sap.quickinfo : 'BTP Data Element For Custom Dec 1'
  zcustom_dec1 : Decimal(13, 3);
  @sap.label : 'Custom Dec 2'
  @sap.quickinfo : 'BTP Data Element For Custom Dec 2'
  zcustom_dec2 : Decimal(13, 3);
  @sap.label : 'Custom Dec 3'
  @sap.quickinfo : 'BTP Data Element For Custom Dec 3'
  zcustom_dec3 : Decimal(13, 3);
  @sap.display.format : 'Date'
  @sap.label : 'Created On'
  @sap.quickinfo : 'Record Creation Date'
  erdat : Date;
  @sap.label : 'Time'
  @sap.quickinfo : 'Entry time'
  erzet : Time;
  @sap.label : 'Created By'
  @sap.quickinfo : 'BTP EHS Data Element For Created By'
  ernam : String(241);
  @sap.display.format : 'Date'
  @sap.label : 'Changed On'
  @sap.quickinfo : 'Last Changed On'
  aedat : Date;
  @sap.label : 'Changed at'
  @sap.quickinfo : 'Time last change was made'
  aezet : Time;
  @sap.label : 'Changed By'
  @sap.quickinfo : 'BTP EHS Data Element For Changed By'
  aenam : String(241);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Status'
  @sap.quickinfo : 'BTP Data Element For Form Status'
  status : String(1);
  @sap.label : 'Incident Type'
  @sap.quickinfo : 'BTP Data Element For Incident Type Key'
  zincident_type : String(3);
  @sap.label : 'Incident Relevance'
  @sap.quickinfo : 'BTP Data Element For Incident Relevance Key'
  zincident_relevance : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Approved Name'
  @sap.quickinfo : 'EHS Approved Name'
  zapproved_name : String(200);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Approved Signature'
  @sap.quickinfo : 'EHS Approved Signature'
  zapproved_signature : String(200);
  @sap.display.format : 'Date'
  @sap.label : 'Approved Date'
  @sap.quickinfo : 'EHS Approved Date'
  zapproved_date : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Lead Investigator(Na'
  @sap.quickinfo : 'EHS Lead Investigator Name'
  zinvestigator_name : String(200);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Lead Investigator Si'
  @sap.quickinfo : 'EHS Lead Investigator Signature'
  zinvestigator_signature : String(200);
  @sap.display.format : 'Date'
  @sap.label : 'Lead Investigator Da'
  @sap.quickinfo : 'EHS Lead Investigator Date'
  zinvestigator_date : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Verification By(Name'
  @sap.quickinfo : 'EHS Verification By Name'
  zverification_name : String(200);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Verification By Sign'
  @sap.quickinfo : 'EHS Verification By Signature'
  zverification_signature : String(200);
  @sap.display.format : 'Date'
  @sap.label : 'Verification By Date'
  @sap.quickinfo : 'EHS Verification By Date'
  zverification_date : Date;
  @sap.label : 'Consequences Key'
  @sap.quickinfo : 'BTP Forms Data Element For Consequences Key'
  zreal_outcome : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Company Name'
  @sap.quickinfo : 'BTP EHS Company Name'
  zcomp_name : LargeString;
  @sap.label : 'Injured Personel Com'
  @sap.quickinfo : 'BTP Data Element For Injured Personel Company Key'
  zinj_per_comp_key : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Activity at the Time'
  @sap.quickinfo : 'BTP EHS Activity at the Time of Incident'
  zactivity : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Incident Detailed De'
  @sap.quickinfo : 'BTP EHS Incident Detailed Description'
  zinc_det_desc : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Job being Undertaken'
  @sap.quickinfo : 'BTP EHS Job being Undertaken'
  zjob_undertaken : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'JRA No(if any)'
  @sap.quickinfo : 'BTP EHS JRA No(if any)'
  zjra_no : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Permit No(if any)'
  @sap.quickinfo : 'BTP EHS Permit No(if any)'
  zpermit_no : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Findings from Invest'
  @sap.quickinfo : 'BTP EHS Findings from Investigation'
  zfindings : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Lessons Learned'
  @sap.quickinfo : 'BTP EHS Lessons Learned'
  zlessons : LargeString;
  @sap.label : 'Signature Folder ID'
  @sap.quickinfo : 'BTP EHS Signature Folder ID Data Element'
  signfolderid : String(70);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Single-Character Flag'
  @sap.heading : ''
  signfolderpresent : String(1);
  @sap.label : 'Incident Title'
  @sap.quickinfo : 'BTP: Incident Title String Type - Max'
  ztitle_max : LargeString;
  @sap.label : 'Director Key'
  @sap.quickinfo : 'BTP Data Element For Director Key'
  zdirector_key : String(3);
  @sap.label : 'Manager Key'
  @sap.quickinfo : 'BTP Data Element For Manager Key'
  zmanager_key : String(5);
  @sap.label : 'Director Description'
  @sap.quickinfo : 'BTP Data Element For Director Description'
  zdirector_desc : String(255);
  @sap.label : 'Manager Description'
  @sap.quickinfo : 'BTP Data Element For Manager Description'
  zmanager_desc : String(255);
  to_Act : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INIT_IMM_ACT {  };
  to_Body : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INV_INJ_PPL {  };
  to_Cons : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CONSEQUENCES {  };
  to_Department : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_DEPARTM {  };
  to_Facility : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_UNITS {  };
  to_IncClass : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_CLASS {  };
  to_IncRelv : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_RELEVANCE_SH {  };
  to_IncType : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_TYPE {  };
  to_InjDmg : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INV_INJ_DMG {  };
  to_InjPersComp : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INj_PERS_COMP {  };
  to_InvTeam : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INV_TEAM {  };
  to_Management : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_MNGMT {  };
  to_Pos : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INIT_POS_CAU {  };
  to_RealOut : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CONSEQUENCES_SH {  };
  to_RemAct : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_REMEDIAL_ACTIONS {  };
  to_Root : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_ROOT_CAUSES_SH {  };
  to_Status : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FORM_STATUS {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Investigation Body CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INV_BDY {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'BODY PART KEY'
  @sap.quickinfo : 'BTP EHS BODY PARTS KEY'
  key zbody_key : String(3) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'BODY PART TEXT'
  @sap.quickinfo : 'BTP EHS BODY PART TEXT'
  zbody_text : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Investigation Form Body Parts CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INV_BODY_PART {
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.label : 'Row No'
  @sap.quickinfo : 'EHS Row No'
  key idx : Integer not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'BODY PART KEY'
  @sap.quickinfo : 'BTP EHS BODY PARTS KEY'
  key zbody_key : String(3) not null;
  to_Body : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INV_BDY {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Investigationform Injury Damage CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INV_INJ_DMG {
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.label : 'Inj Illness Dmg Type'
  @sap.quickinfo : 'BTP Data Element For Injury Illness Damage Types Key'
  key zill_types_key : String(3) not null;
  to_Inv : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INJ_ILL {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'BTP EHS Investigation Form Injured People CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INV_INJ_PPL {
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.label : 'Row No'
  @sap.quickinfo : 'EHS Row No'
  key idx : Integer not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Name'
  @sap.quickinfo : 'BTP EHS First Name Data Element'
  name : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Last Name'
  @sap.quickinfo : 'BTP EHS Last Name Data Element'
  lastname : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Position'
  @sap.quickinfo : 'BTP EHS Position'
  zposition : LargeString;
  @odata.Type : 'Edm.Byte'
  @sap.label : 'Experience In Occupa'
  @sap.quickinfo : 'BTP EHS Experience In Occupation(Year)'
  zexp_occu : Integer;
  @odata.Type : 'Edm.Byte'
  @sap.label : 'Experience In Presen'
  @sap.quickinfo : 'BTP EHS Experience In Present Position(Year)'
  zexp_pos : Integer;
  @sap.label : 'Days In Shift'
  @sap.quickinfo : 'BTP EHS Days In Shift'
  zdays_shift : Integer;
  @sap.label : 'Time In Tour'
  @sap.quickinfo : 'BTP EHS Time In Tour'
  ztour_time : Decimal(13, 3);
  to_Parts : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INV_BODY_PART {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Investigationform Investigation Team CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INV_TEAM {
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.label : 'Row No'
  @sap.quickinfo : 'EHS Row No'
  key zrow_no : Integer not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Lead Investigator(Na'
  @sap.quickinfo : 'EHS Lead Investigator Name'
  zinvestigator_name : String(200);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Company Name'
  @sap.quickinfo : 'BTP EHS Company Name'
  zcompany : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Position'
  @sap.quickinfo : 'BTP EHS Position'
  zposition : LargeString;
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'EHS Likelihood SH CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_LIKELIHOOD_SH {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Inc Likelihood Key'
  @sap.quickinfo : 'BTP Data Element For Incident Likelihood Key'
  key zinc_like_key : String(3) not null;
  @sap.label : 'Likelihood'
  @sap.quickinfo : 'BTP Data Element For Likelihood'
  zlikelihood : String(200);
  @sap.label : 'Short Description'
  @sap.quickinfo : 'Short Text for Fixed Values'
  ddtext : String(60);
  @sap.label : 'Exposure'
  @sap.quickinfo : 'BTP Data Element For LKL_EXPOSURE'
  zlkl_exposure : String(200);
  @sap.label : 'Company'
  @sap.quickinfo : 'BTP Data Element For LKL_COMPANY'
  zlkl_company : String(200);
  @sap.label : 'Sectoral'
  @sap.quickinfo : 'BTP Data Element For LKL_SECTORAL'
  zlkl_sectoral : String(200);
  @sap.label : 'HO'
  @sap.quickinfo : 'BTP Data Element For LKL_HO'
  zlkl_zho : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.addressable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Package 1 List CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_LISTSet {
  @sap.label : 'E-Mail Address'
  key p_email : String(241) not null;
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.text : 'zmanagement_Text'
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  zmanagement : String(3);
  @sap.label : 'Management Name'
  @sap.quickinfo : 'BTP Data Element For Management Name'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  zmanagement_Text : String(200);
  @sap.text : 'zdepartment_Text'
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Key'
  zdepartment : String(3);
  @sap.label : 'Department Name'
  @sap.quickinfo : 'BTP Data Element For Department Name'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  zdepartment_Text : String(200);
  @sap.text : 'zfacility_Text'
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility Key'
  zfacility : String(3);
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility/Unit'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  zfacility_Text : String(200);
  @sap.label : 'Well/Project/Site'
  @sap.quickinfo : 'BTP Data Element For Well'
  zwell : String(100);
  @sap.label : 'Incident Title'
  @sap.quickinfo : 'BTP Data Element For Incident Title'
  zincident_title : String(100);
  @sap.display.format : 'Date'
  @sap.label : 'Date Of Report'
  @sap.quickinfo : 'BTP Data Element For Report Date'
  zreport_date : Date;
  @sap.label : 'Time Of Report'
  @sap.quickinfo : 'BTP Data Element For Report Time'
  zreport_time : Time;
  @sap.display.format : 'Date'
  @sap.label : 'Date Of Incident'
  @sap.quickinfo : 'BTP Data Element For Incident Date'
  zincident_date : Date;
  @sap.label : 'Time Of Incident'
  @sap.quickinfo : 'BTP Data Element For Incident Time'
  zincident_time : Time;
  @sap.label : 'Incident Location'
  @sap.quickinfo : 'BTP Data Element For Incident Location'
  zincident_loc : LargeString;
  @sap.label : 'Incident Class'
  @sap.quickinfo : 'BTP Data Element For Incident Class Key'
  zincident_class : String(3);
  @sap.label : 'DROP'
  @sap.quickinfo : 'BTP Data Element For DROP'
  zdrop : String(1);
  @sap.label : 'MEDEVAC'
  @sap.quickinfo : 'BTP Data Element For MEDEVAC'
  zmedevac : String(1);
  @sap.label : 'Incident Description'
  @sap.quickinfo : 'BTP Data Element For Incident Description'
  zincident_desc : LargeString;
  @sap.label : 'Custom Text 1'
  @sap.quickinfo : 'BTP Data Element For Custom Text 1'
  zcustom_text1 : String(100);
  @sap.label : 'Custom Text 2'
  @sap.quickinfo : 'BTP Data Element For Custom Text 2'
  zcustom_text2 : String(100);
  @sap.label : 'Custom Text 3'
  @sap.quickinfo : 'BTP Data Element For Custom Text 2'
  zcustom_text3 : String(100);
  @sap.label : 'Custom Dec 1'
  @sap.quickinfo : 'BTP Data Element For Custom Dec 1'
  zcustom_dec1 : Decimal(13, 3);
  @sap.label : 'Custom Dec 2'
  @sap.quickinfo : 'BTP Data Element For Custom Dec 2'
  zcustom_dec2 : Decimal(13, 3);
  @sap.label : 'Custom Dec 3'
  @sap.quickinfo : 'BTP Data Element For Custom Dec 3'
  zcustom_dec3 : Decimal(13, 3);
  @sap.display.format : 'Date'
  @sap.label : 'Created On'
  @sap.quickinfo : 'Record Creation Date'
  erdat : Date;
  @sap.label : 'Time'
  @sap.quickinfo : 'Entry time'
  erzet : Time;
  @sap.label : 'Created By'
  @sap.quickinfo : 'BTP EHS Data Element For Created By'
  ernam : String(241);
  @sap.display.format : 'Date'
  @sap.label : 'Changed On'
  @sap.quickinfo : 'Last Changed On'
  aedat : Date;
  @sap.label : 'Changed at'
  @sap.quickinfo : 'Time last change was made'
  aezet : Time;
  @sap.label : 'Changed By'
  @sap.quickinfo : 'BTP EHS Data Element For Changed By'
  aenam : String(241);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Status'
  @sap.quickinfo : 'BTP Data Element For Form Status'
  status : String(1);
  @sap.label : 'Manager Key'
  @sap.quickinfo : 'BTP Data Element For Manager Key'
  zmanager_key : String(5);
  @sap.label : 'Director Key'
  @sap.quickinfo : 'BTP Data Element For Director Key'
  zdirector_key : String(3);
  @sap.label : 'Manager Description'
  @sap.quickinfo : 'BTP Data Element For Manager Description'
  zmanager_desc : String(255);
  @sap.label : 'Director Description'
  @sap.quickinfo : 'BTP Data Element For Director Description'
  zdirector_desc : String(255);
  @sap.display.format : 'UpperCase'
  @sap.text : 'zinc_status_Text'
  @sap.label : 'Incident Status'
  @sap.quickinfo : 'BTP EHS Total Incident Status DE'
  zinc_status : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Incident Status Desc'
  @sap.quickinfo : 'BTP EHS Total Incident Status Desc DE'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  zinc_status_Text : String(200);
  @sap.label : 'Incident Relevance'
  @sap.quickinfo : 'BTP Forms Data Element For Incident Relevance'
  zincident_relevance_desc : String(3);
  @sap.label : ''
  zincident_type_desc : String(255);
  @sap.label : 'Signature Folder ID'
  @sap.quickinfo : 'BTP EHS Signature Folder ID Data Element'
  signfolderid : String(70);
  @sap.label : 'Incident Title'
  @sap.quickinfo : 'BTP: Incident Title String Type - Max'
  ztitle_max : LargeString;
  @sap.label : 'Checkbox'
  @sap.heading : ''
  xfeld : Boolean;
  to_Department : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_DEPARTM {  };
  to_Facility : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_UNITS {  };
  to_IncCLass : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_CLASS {  };
  to_IncStatus : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_STATUS {  };
  to_Init : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INITIAL {  };
  to_Inv : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INVESTIGATION {  };
  to_Management : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_MNGMT {  };
  to_Status : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FORM_STATUS {  };
  @sap.filterable : 'false'
  Parameters : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_LIST {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.pageable : 'false'
@sap.content.version : '1'
@sap.semantics : 'parameters'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_LIST {
  @sap.parameter : 'mandatory'
  @sap.label : 'E-Mail Address'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.sortable : 'false'
  @sap.filterable : 'false'
  key p_email : String(241) not null;
  Set : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_LISTSet {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Management CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_MNGMT {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.text : 'zmanagement_name'
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  key zmanagement_key : String(3) not null;
  @sap.label : 'Management Name'
  @sap.quickinfo : 'BTP Data Element For Management Name'
  zmanagement_name : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.addressable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Package 1 Management Field Roles CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_MNGMT_ROLESSet {
  @sap.label : 'E-Mail Address'
  key p_email : String(241) not null;
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  key zmanagement_key : String(3) not null;
  @sap.label : 'Management Name'
  @sap.quickinfo : 'BTP Data Element For Management Name'
  zmanagement_name : String(200);
  @sap.filterable : 'false'
  Parameters : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_MNGMT_ROLES {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.pageable : 'false'
@sap.content.version : '1'
@sap.semantics : 'parameters'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_MNGMT_ROLES {
  @sap.parameter : 'mandatory'
  @sap.label : 'E-Mail Address'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.sortable : 'false'
  @sap.filterable : 'false'
  key p_email : String(241) not null;
  Set : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_MNGMT_ROLESSet {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Main Immediate Causes CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_M_IMMEDIATE_CAUSES {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Mrc Key'
  @sap.quickinfo : 'BTP Data Element For MIC Mrc Key'
  key zmrc_key : String(3) not null;
  @sap.label : 'Main Imm Cauese'
  @sap.quickinfo : 'BTP Data Element For Main Immediate Cauese'
  zmain_imm_causes : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Main Root Causes CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_M_ROOT {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Mrc Key'
  @sap.quickinfo : 'BTP Data Element For Mrc Key'
  key zmrc_key : String(3) not null;
  @sap.label : 'Main Root Causes'
  @sap.quickinfo : 'BTP Data Element For Main Root Causes'
  zmain_root_causes : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'EHS Relevance SH CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_RELEVANCE_SH {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Incident Relevance'
  @sap.quickinfo : 'BTP Data Element For Incident Relevance Key'
  key zincident_relevance_key : String(3) not null;
  @sap.label : 'Incident Relevance'
  @sap.quickinfo : 'BTP Forms Data Element For Incident Relevance'
  zincident_relevance : String(3);
  @sap.label : 'Short Description'
  @sap.quickinfo : 'Short Text for Fixed Values'
  zincident_relevance_desc : String(60);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Investigation Form Remedial Actions CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_REMEDIAL_ACTIONS {
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.label : 'Row No'
  @sap.quickinfo : 'EHS Row No'
  key zrow_no : Integer not null;
  @sap.label : 'Rem Act Text'
  @sap.quickinfo : 'Remedial Action String Data Element'
  zrem_act_actions : LargeString;
  @sap.label : 'Rem Act Text'
  @sap.quickinfo : 'Remedial Action String Data Element'
  zrem_act_respons : LargeString;
  @sap.display.format : 'Date'
  @sap.label : 'Date'
  zrem_act_due_date : Date;
  @sap.label : 'Remedial Act Status'
  @sap.quickinfo : 'BTP Data Element For Remedial Actions Status'
  zrem_act_status : String(200);
  @sap.display.format : 'Date'
  @sap.label : 'Date'
  zrem_act_closed_date : Date;
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.addressable : 'false'
@sap.content.version : '1'
@sap.label : 'Remedial Actions Admin List'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_REMEDIAL_ADMINSet {
  @sap.label : 'E-Mail Address'
  key p_email : String(241) not null;
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.label : 'Row No'
  @sap.quickinfo : 'EHS Row No'
  key zrow_no : Integer not null;
  @sap.display.format : 'Date'
  @sap.label : 'Date Of Report'
  @sap.quickinfo : 'BTP Data Element For Report Date'
  zreport_date : Date;
  @sap.text : 'zmanagement_Text'
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  zmanagement : String(3);
  @sap.label : 'Management Name'
  @sap.quickinfo : 'BTP Data Element For Management Name'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  zmanagement_Text : String(200);
  @sap.text : 'zdepartment_Text'
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Key'
  zdepartment : String(3);
  @sap.label : 'Department Name'
  @sap.quickinfo : 'BTP Data Element For Department Name'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  zdepartment_Text : String(200);
  @sap.text : 'zfacility_Text'
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility Key'
  zfacility : String(3);
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility/Unit'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  zfacility_Text : String(200);
  @sap.label : 'Well/Project/Site'
  @sap.quickinfo : 'BTP Data Element For Well'
  zwell : String(100);
  @sap.label : 'Incident Title'
  @sap.quickinfo : 'BTP: Incident Title String Type - Max'
  ztitle_max : LargeString;
  @sap.label : 'Incident Class'
  @sap.quickinfo : 'BTP Data Element For Incident Class Key'
  zincident_class : String(3);
  @sap.label : 'Incident Type'
  @sap.quickinfo : 'BTP Data Element For Incident Type Key'
  zincident_type : String(3);
  @sap.label : 'Rem Act Text'
  @sap.quickinfo : 'Remedial Action String Data Element'
  zrem_act_actions : LargeString;
  @sap.label : 'Rem Act Text'
  @sap.quickinfo : 'Remedial Action String Data Element'
  zrem_act_respons : LargeString;
  @sap.display.format : 'Date'
  @sap.label : 'Date'
  zrem_act_due_date : Date;
  @sap.label : 'Remedial Act Status'
  @sap.quickinfo : 'BTP Data Element For Remedial Actions Status'
  zrem_act_status : String(200);
  @sap.text : 'zrem_act_status_text'
  @sap.label : 'Remedial Status'
  zrem_act_status_text : String(6);
  @sap.display.format : 'Date'
  @sap.label : 'Date'
  zrem_act_closed_date : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Status'
  @sap.quickinfo : 'BTP Data Element For Form Status'
  status : String(1);
  @sap.label : 'Checkbox'
  @sap.heading : ''
  xfeld : Boolean;
  to_Department : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_DEPARTM {  };
  to_Facility : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_UNITS {  };
  to_IncClass : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_CLASS {  };
  to_IncType : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_TYPE {  };
  to_Management : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_MNGMT {  };
  to_RemAct : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_REMEDIAL_ACTIONS {  };
  @sap.filterable : 'false'
  Parameters : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_REMEDIAL_ADMIN {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.pageable : 'false'
@sap.content.version : '1'
@sap.semantics : 'parameters'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_REMEDIAL_ADMIN {
  @sap.parameter : 'mandatory'
  @sap.label : 'E-Mail Address'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  @sap.sortable : 'false'
  @sap.filterable : 'false'
  key p_email : String(241) not null;
  Set : Association to many ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_REMEDIAL_ADMINSet {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'EHS Risk CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_RISK {
  @sap.label : 'Risk Key'
  @sap.quickinfo : 'BTP Data Element For Risk Key'
  key zrisk_key : String(3) not null;
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Risk Desc'
  @sap.quickinfo : 'BTP Data Element For Risk Desc'
  zrisk : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Flattened Role-User Assignment List'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_ROLEUSERLIST {
  @sap.label : 'Rol Id'
  @sap.quickinfo : 'BTP Data Element For Roles Id'
  key role_id : String(8) not null;
  @sap.label : 'E-Mail Address'
  key email : String(241) not null;
  @sap.display.format : 'NonNegative'
  @sap.label : 'User Id'
  @sap.quickinfo : 'BTP Data Element For User Id'
  user_id : String(5);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Firstname'
  @sap.quickinfo : 'BTP Data Element For Firstname'
  firstname : String(100);
  @sap.label : 'Lastname'
  @sap.quickinfo : 'BTP Data Element For Lastname Role'
  lastname : String(100);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Title'
  @sap.quickinfo : 'BTP Data Element For Title'
  title : String(100);
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Office'
  department : String(100);
  @sap.label : 'Role Description'
  @sap.quickinfo : 'BTP Data Element For Role Description'
  UserDescription : String(255);
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  zmanagement_key : String(3);
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Key'
  zdepartment_key : String(3);
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility Key'
  zfacility_key : String(3);
  @sap.label : 'Checkbox'
  @sap.heading : ''
  ownforms : Boolean;
  @sap.label : 'Checkbox'
  @sap.heading : ''
  is_active : Boolean;
  @sap.label : 'Role Description'
  @sap.quickinfo : 'BTP Data Element For Role Description'
  RoleDescription : String(255);
  to_Role : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_WROLES {  };
  to_User : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_WUSERS {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Root Causes SH CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_ROOT_CAUSES_SH {
  @sap.label : 'Report No'
  @sap.quickinfo : 'BTP Forms Data Element For Report No'
  key zreport_no : String(17) not null;
  @sap.label : 'Mrc Key'
  @sap.quickinfo : 'BTP Data Element For Mrc Key'
  key zmrc_key : String(3) not null;
  @sap.label : 'Root_Causes Key'
  @sap.quickinfo : 'BTP Data Element For Root_Causes Key'
  key zrc_key : String(3) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Note'
  @sap.quickinfo : 'BTP EHS Note'
  znote : LargeString;
  @sap.label : 'Row No'
  @sap.quickinfo : 'EHS Row No'
  zrow_no : Integer;
  to_MainRoot : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_M_ROOT {  };
  to_Root : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_ROOT_CS {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Root Causes CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_ROOT_CS {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Root_Causes Key'
  @sap.quickinfo : 'BTP Data Element For Root_Causes Key'
  key zroot_causes_key : String(3) not null;
  @sap.label : 'Root_Causes Desc'
  @sap.quickinfo : 'BTP Data Element For Root_Causes Desc'
  zroot_causes_desc : String(200);
  @sap.label : 'Mrc Key'
  @sap.quickinfo : 'BTP Data Element For Mrc Key'
  zr_c_mrc_key : String(3);
  zr_c_definition : String(1023);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Maintenance Department'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_T_DEPARTMENT {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Key'
  key zdepartment_key : String(3) not null;
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  key zmanagement_key : String(3) not null;
  @sap.label : 'Department Name'
  @sap.quickinfo : 'BTP Data Element For Department Name'
  zdepartment_name : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Management Maintenance'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_T_MANAGEMENT {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  key zmanagement_key : String(3) not null;
  @sap.label : 'Management Name'
  @sap.quickinfo : 'BTP Data Element For Management Name'
  zmanagement_name : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Maintenance Facility Units'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_T_UNITS {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Unit Key'
  key zunit_key : String(3) not null;
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility/Unit'
  zfacility_unit : String(200);
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Key'
  zdepartment_id : String(3);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'BTP EHS Facility/Units CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_UNITS {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.text : 'zfacility_unit'
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Unit Key'
  key zunit_key : String(3) not null;
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility/Unit'
  zfacility_unit : String(200);
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Key'
  zdepartment_id : String(3);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'BTP EHS Users Submitted Edit Rol CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_USER {
  @sap.label : 'Rol Id'
  @sap.quickinfo : 'BTP Data Element For Roles Id'
  key id : String(8) not null;
  @sap.label : 'E-Mail Address'
  key smtp_addr : String(241) not null;
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Workzone Role List'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_WROLES {
  @sap.label : 'Rol Id'
  @sap.quickinfo : 'BTP Data Element For Roles Id'
  key role_id : String(8) not null;
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  zmanagement_key : String(3);
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Key'
  zdepartment_key : String(3);
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility Key'
  zfacility_key : String(3);
  @sap.label : 'Checkbox'
  @sap.heading : ''
  ownforms : Boolean;
  @sap.label : 'Checkbox'
  @sap.heading : ''
  is_active : Boolean;
  @sap.label : 'Role Description'
  @sap.quickinfo : 'BTP Data Element For Role Description'
  description : String(255);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Workzone User List'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_WUSERS {
  @sap.display.format : 'NonNegative'
  @sap.label : 'User Id'
  @sap.quickinfo : 'BTP Data Element For User Id'
  key user_id : String(5) not null;
  @sap.label : 'E-Mail Address'
  key email : String(241) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Firstname'
  @sap.quickinfo : 'BTP Data Element For Firstname'
  firstname : String(100);
  @sap.label : 'Lastname'
  @sap.quickinfo : 'BTP Data Element For Lastname Role'
  lastname : String(100);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Title'
  @sap.quickinfo : 'BTP Data Element For Title'
  title : String(100);
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Office'
  department : String(100);
  @sap.label : 'Role Description'
  @sap.quickinfo : 'BTP Data Element For Role Description'
  description : String(255);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Management Not Crp'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_MNGMNT_NOT_CRP {
  @sap.label : 'Language Key'
  key spras : String(2) not null;
  @sap.text : 'zmanagement_name'
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  key zmanagement_key : String(3) not null;
  @sap.label : 'Management Name'
  @sap.quickinfo : 'BTP Data Element For Management Name'
  zmanagement_name : String(200);
};

