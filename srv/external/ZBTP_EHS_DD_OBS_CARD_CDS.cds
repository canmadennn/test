/* checksum : 6d7ee1bda043d3369516466cc36c5c2e */
@cds.external : true
@m.IsDefaultEntityContainer : 'true'
@sap.message.scope.supported : 'true'
@sap.supported.formats : 'atom json xlsx'
service ZBTP_EHS_DD_OBS_CARD_CDS {};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Observation Card CDS Service'
entity ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_DD_OBS_CARD {
  @sap.display.format : 'NonNegative'
  @sap.label : 'ID'
  key zid : String(10) not null;
  @sap.display.format : 'Date'
  @sap.label : 'Create Date'
  zcreate_date : Date;
  @sap.display.format : 'Date'
  @sap.label : 'Date'
  zdate : Date;
  @sap.label : 'Management'
  @sap.quickinfo : 'BTP Data Element For Management Table Key'
  zmanagement : String(3);
  @sap.label : 'Department'
  @sap.quickinfo : 'BTP Data Element For Department Key'
  zdepartment : String(3);
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Unit Key'
  zfacility : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Surname'
  @sap.quickinfo : 'Observer Name/Surname'
  zobserver_name : String(250);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Obsrvr Company other'
  @sap.quickinfo : 'Observer Company other'
  zobserver_cmpny_thr : String(250);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Observer Company'
  zobserver_cmpny : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Observer Position'
  zobserver_pstn : String(250);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Location Class Other'
  @sap.quickinfo : 'Location Classification/other'
  zlctn_class_thr : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Location Classificat'
  @sap.quickinfo : 'Location Classification'
  zlctn_classfctn : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Observation descript'
  @sap.quickinfo : 'Observation description'
  zobserver_desc : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'TOFS'
  ztofs : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Conversation'
  zcnvrstn : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Action Performed'
  zactn_prfrmd : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Category'
  zcategory : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Category/other'
  zcategory_thr : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sub category'
  zsub_category : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sub-category/other'
  zsub_category_thr : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Status'
  zstatus : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Responsible Name/Tit'
  @sap.quickinfo : 'Responsible Name or Title'
  zresponsible_name : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Further Action'
  zfurther_action : LargeString;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Priority'
  zpriority : String(10);
  @sap.display.format : 'Date'
  @sap.label : 'Issue Date'
  zissue_date : Date;
  @sap.display.format : 'Date'
  @sap.label : 'Closed Date'
  zclosed_date : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Responsible Email'
  responsible_email : String(250);
  to_Department : Association to ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_DEPARTM {  };
  to_Facility : Association to ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_UNITS {  };
  to_Management : Association to ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_MNGMT {  };
  to_ObsCategory : Association to ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_OBS_CAT {  };
  to_ObsClass : Association to ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_OBS_CLS {  };
  to_ObsCompany : Association to ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_OBS_CMP {  };
  to_ObsSubCategory : Association to ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_OBS_SCT {  };
  to_Priority : Association to ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_OBS_PRI {  };
  to_Status : Association to ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_OBS_STT {  };
  to_Tfs : Association to ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_OBS_TFS {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
entity ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_DEPARTM {
  @sap.label : 'Language Key'
  key SPRAS : String(2) not null;
  @sap.label : 'Department'
  key ZDEPARTMENT_KEY : String(3) not null;
  @sap.label : 'Management'
  key ZMANAGEMENT_KEY : String(3) not null;
  @sap.label : 'Department Name'
  ZDEPARTMENT_NAME : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
entity ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_MNGMT {
  @sap.label : 'Language Key'
  key SPRAS : String(2) not null;
  @sap.label : 'Management'
  key ZMANAGEMENT_KEY : String(3) not null;
  @sap.label : 'Management Name'
  ZMANAGEMENT_NAME : String(200);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
entity ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_OBS_CAT {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Category'
  key ZCATEGORY_ID : String(3) not null;
  @sap.label : 'Language Key'
  key ZSPRAS : String(2) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Category'
  ZCATEGORY : String(250);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
entity ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_OBS_CLS {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Location Classificat'
  key ZLCTN_CLASSFCTN_ID : String(3) not null;
  @sap.label : 'Language Key'
  key ZSPRAS : String(2) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Location Classificat'
  ZLCTN_CLASSFCTN : String(250);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
entity ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_OBS_CMP {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Observer Company'
  key ZOBSERVER_CMPNY_ID : String(3) not null;
  @sap.label : 'Language Key'
  key ZSPRAS : String(2) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Observer Companies'
  ZOBSERVER_CMPNY : String(250);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
entity ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_OBS_PRI {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Priority'
  key ZPRIORITY_ID : String(10) not null;
  @sap.label : 'Language Key'
  key ZSPRAS : String(2) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Priority'
  ZPRIORITY : String(250);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
entity ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_OBS_SCT {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sub category'
  key ZSUB_CATEGORY_ID : String(3) not null;
  @sap.label : 'Language Key'
  key ZSPRAS : String(2) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sub category'
  ZSUB_CATEGORY : String(250);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
entity ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_OBS_STT {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Status'
  key ZSTATUS_ID : String(3) not null;
  @sap.label : 'Language Key'
  key ZSPRAS : String(2) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Status'
  ZSTATUS : String(250);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
entity ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_OBS_TFS {
  @sap.display.format : 'UpperCase'
  @sap.label : 'TOFS'
  key ZTOFS_ID : String(3) not null;
  @sap.label : 'Language Key'
  key ZSPRAS : String(2) not null;
  @sap.label : 'TOFS'
  ZTOFS : String(255);
  @sap.label : 'Definition'
  ZTOFS_DESC : String(255);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
entity ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_UNITS {
  @sap.label : 'Language Key'
  key SPRAS : String(2) not null;
  @sap.label : 'Facility/Unit'
  key ZUNIT_KEY : String(3) not null;
  @sap.label : 'Facility/Unit'
  ZFACILITY_UNIT : String(200);
  @sap.label : 'Department'
  ZDEPARTMENT_ID : String(3);
};

