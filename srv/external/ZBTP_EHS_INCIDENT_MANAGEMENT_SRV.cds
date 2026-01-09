/* checksum : e2908e1e99b780ba5070c7df3d9fc198 */
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
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
  key zreport_no : String(17) not null;
  @sap.label : 'Direktörlük Anahtarı'
  @sap.quickinfo : 'BTP Veri Yapısı Direktörlük Anahtarı'
  zdirector_key : String(3);
  @sap.label : 'Direktor Açıklaması'
  @sap.quickinfo : 'BTP Veri Yapısı Direktor Açıklaması'
  zdirector_desc : String(255);
  @sap.label : 'Müdürlük Anahtar'
  @sap.quickinfo : 'BTP Veri Yapısı Müdürlük'
  zmanager_key : String(5);
  @sap.label : 'Müdürlük Açıklaması'
  @sap.quickinfo : 'BTP Veri Yapısı Müdürlük Açıklaması'
  zmanager_desc : String(255);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Company Information Manager'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CMP_MNG {
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.label : 'Direktörlük Anahtarı'
  @sap.quickinfo : 'BTP Veri Yapısı Direktörlük Anahtarı'
  key zdirector_key : String(3) not null;
  @sap.label : 'Müdürlük Anahtar'
  @sap.quickinfo : 'BTP Veri Yapısı Müdürlük'
  key zmanager_key : String(5) not null;
  @sap.label : 'Müdürlük Açıklaması'
  @sap.quickinfo : 'BTP Veri Yapısı Müdürlük Açıklaması'
  zmanager_desc : String(255);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Consequences CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CONSEQUENCES {
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
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
  @sap.label : 'Dil anahtarı'
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
  @sap.label : 'Hasar'
  @sap.quickinfo : 'BTP Forms Data Element For Assets Damage'
  zassets_damage : String(255);
  @sap.label : 'Operasyonel Etki'
  @sap.quickinfo : 'BTP Forms Data Element For Assets Operation Impact'
  zassets_operational_impact : String(255);
  @sap.label : 'Finansal Etki'
  @sap.quickinfo : 'BTP Forms Data Element For Assets Financial Impact'
  zassets_financial_impact : String(255);
  @sap.label : 'Kısa tanım'
  @sap.quickinfo : 'Sabit değerler için kısa metin'
  ddtext : String(60);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Company Information Director'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CPM_DRC {
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.label : 'Direktörlük Anahtarı'
  @sap.quickinfo : 'BTP Veri Yapısı Direktörlük Anahtarı'
  key zdirector_key : String(3) not null;
  @sap.label : 'Direktor Açıklaması'
  @sap.quickinfo : 'BTP Veri Yapısı Direktor Açıklaması'
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
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.text : 'zdepartment_name'
  @sap.label : 'Departman'
  @sap.quickinfo : 'BTP Forms Departman İçin Data Element'
  key zdepartment_key : String(3) not null;
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
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
  @sap.label : 'E-posta adresi'
  key p_email : String(241) not null;
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
  key zmanagement_key : String(3) not null;
  @sap.label : 'Departman'
  @sap.quickinfo : 'BTP Forms Departman İçin Data Element'
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
  @sap.label : 'E-posta adresi'
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
  @sap.label : 'E-posta adresi'
  key p_email : String(241) not null;
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
  key zmanagement_key : String(3) not null;
  @sap.label : 'Departman'
  @sap.quickinfo : 'BTP Forms Departman İçin Data Element'
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
  @sap.label : 'E-posta adresi'
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
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
  key zreport_no : String(17) not null;
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
  zmanagement : String(3);
  @sap.label : 'Departman'
  @sap.quickinfo : 'BTP Forms Departman İçin Data Element'
  zdepartment : String(3);
  @sap.label : 'Tesis/Birim'
  @sap.quickinfo : 'BTP Forms Tesis/Birim İçin Data Element'
  zfacility : String(3);
  @sap.label : 'Kuyu/Proje/Saha'
  @sap.quickinfo : 'BTP Forms Kuyu İçin Data Element'
  zwell : String(100);
  @sap.label : 'Olay Başlığı'
  @sap.quickinfo : 'BTP Forms Olay Başlığı İçin Data Element'
  zincident_title : String(100);
  @sap.display.format : 'Date'
  @sap.label : 'Rapor Tarihi'
  @sap.quickinfo : 'BTP Forms Rapor Tarihi İçin Data Element'
  zreport_date : Date;
  @sap.label : 'Rapor Saati'
  @sap.quickinfo : 'BTP Forms Rapor Saati İçin Data Element'
  zreport_time : Time;
  @sap.display.format : 'Date'
  @sap.label : 'Olay Tarihi'
  @sap.quickinfo : 'BTP Forms Olay Tarihi İçin Data Element'
  zincident_date : Date;
  @sap.label : 'Olay Saati'
  @sap.quickinfo : 'BTP Forms Olay Saati İçin Data Element'
  zincident_time : Time;
  @sap.label : 'Olay Yeri'
  @sap.quickinfo : 'BTP Forms Olay Yeri İçin Data Element'
  zincident_loc : LargeString;
  @sap.label : 'Olay Sınıfı'
  @sap.quickinfo : 'BTP Forms Olay Sınıfı İçin Data Element'
  zincident_class : String(3);
  @sap.label : 'DROP'
  @sap.quickinfo : 'BTP Forms Drop İçin Data Element'
  zdrop : String(1);
  @sap.label : 'MEDEVAC'
  @sap.quickinfo : 'BTP Forms Medevac İçin Data Element'
  zmedevac : String(1);
  @sap.label : 'Olay Tanımı'
  @sap.quickinfo : 'BTP Forms Olay Tanımı İçin Data Element'
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
  @sap.label : 'Yaratma tarihi'
  @sap.quickinfo : 'Kaydın eklendiği tarih'
  erdat : Date;
  @sap.label : 'Saat'
  @sap.quickinfo : 'Giriş saati'
  erzet : Time;
  @sap.label : 'Yaratan'
  @sap.quickinfo : 'BTP EHS Yaratan İçin Data Element'
  ernam : String(241);
  @sap.display.format : 'Date'
  @sap.label : 'Değişiklik tarihi'
  @sap.quickinfo : 'Son değişiklik tarihi'
  aedat : Date;
  @sap.label : 'Değişiklik saati'
  @sap.quickinfo : 'Son değişiklik saati'
  aezet : Time;
  @sap.label : 'Değiştiren'
  @sap.quickinfo : 'BTP EHS Değitiren İçin Data Element'
  aenam : String(241);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Durum'
  @sap.quickinfo : 'BTP EHS Durum İçin Data Element'
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
  @sap.label : 'Incident Type Desc'
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
  @sap.label : 'Dil'
  @sap.quickinfo : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.label : 'Kısa tanım'
  @sap.quickinfo : 'Sabit değerler için kısa metin'
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
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.text : 'zmanagement_name'
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
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
  @sap.label : 'Dil anahtarı'
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
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.label : 'Olay Sınıfı'
  @sap.quickinfo : 'BTP Forms Olay Sınıfı İçin Data Element'
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
  @sap.label : 'Dil anahtarı'
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
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.label : 'Incident Type'
  @sap.quickinfo : 'BTP Data Element For Incident Type Key'
  key zincident_type_key : String(3) not null;
  @sap.label : 'Olay Sınıfı'
  @sap.quickinfo : 'BTP Forms Olay Sınıfı İçin Data Element'
  key zincident_class_id : String(3) not null;
  @sap.label : 'Incident Type Desc'
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
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
  key zreport_no : String(17) not null;
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
  zmanagement : String(3);
  @sap.label : 'Departman'
  @sap.quickinfo : 'BTP Forms Departman İçin Data Element'
  zdepartment : String(3);
  @sap.label : 'Tesis/Birim'
  @sap.quickinfo : 'BTP Forms Tesis/Birim İçin Data Element'
  zfacility : String(3);
  @sap.label : 'Kuyu/Proje/Saha'
  @sap.quickinfo : 'BTP Forms Kuyu İçin Data Element'
  zwell : String(100);
  @sap.label : 'Olay Başlığı'
  @sap.quickinfo : 'BTP Forms Olay Başlığı İçin Data Element'
  zincident_title : String(100);
  @sap.display.format : 'Date'
  @sap.label : 'Rapor Tarihi'
  @sap.quickinfo : 'BTP Forms Rapor Tarihi İçin Data Element'
  zreport_date : Date;
  @sap.label : 'Rapor Saati'
  @sap.quickinfo : 'BTP Forms Rapor Saati İçin Data Element'
  zreport_time : Time;
  @sap.display.format : 'Date'
  @sap.label : 'Olay Tarihi'
  @sap.quickinfo : 'BTP Forms Olay Tarihi İçin Data Element'
  zincident_date : Date;
  @sap.label : 'Olay Saati'
  @sap.quickinfo : 'BTP Forms Olay Saati İçin Data Element'
  zincident_time : Time;
  @sap.label : 'Olay Yeri'
  @sap.quickinfo : 'BTP Forms Olay Yeri İçin Data Element'
  zincident_loc : LargeString;
  @sap.label : 'Olay Sınıfı'
  @sap.quickinfo : 'BTP Forms Olay Sınıfı İçin Data Element'
  zincident_class : String(3);
  @sap.label : 'DROP'
  @sap.quickinfo : 'BTP Forms Drop İçin Data Element'
  zdrop : String(1);
  @sap.label : 'MEDEVAC'
  @sap.quickinfo : 'BTP Forms Medevac İçin Data Element'
  zmedevac : String(1);
  @sap.label : 'Olay Tanımı'
  @sap.quickinfo : 'BTP Forms Olay Tanımı İçin Data Element'
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
  @sap.label : 'Yaratma tarihi'
  @sap.quickinfo : 'Kaydın eklendiği tarih'
  erdat : Date;
  @sap.label : 'Saat'
  @sap.quickinfo : 'Giriş saati'
  erzet : Time;
  @sap.label : 'Yaratan'
  @sap.quickinfo : 'BTP EHS Yaratan İçin Data Element'
  ernam : String(241);
  @sap.display.format : 'Date'
  @sap.label : 'Değişiklik tarihi'
  @sap.quickinfo : 'Son değişiklik tarihi'
  aedat : Date;
  @sap.label : 'Değişiklik saati'
  @sap.quickinfo : 'Son değişiklik saati'
  aezet : Time;
  @sap.label : 'Değiştiren'
  @sap.quickinfo : 'BTP EHS Değitiren İçin Data Element'
  aenam : String(241);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Durum'
  @sap.quickinfo : 'BTP EHS Durum İçin Data Element'
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
  @sap.label : 'Karakter 1'
  @sap.quickinfo : 'Tek basamaklı gösterge'
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
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
  key zreport_no : String(17) not null;
  @sap.label : 'c'
  @sap.quickinfo : 'Açıklama'
  key filename : String(50) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : '20 karakter'
  key fileType : String(20) not null;
  fileContent : LargeString;
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Initial Form Immediate Actions CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INIT_IMM_ACT {
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
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
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
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
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.label : 'Inj Illness Dmg Type'
  @sap.quickinfo : 'BTP Data Element For Injury Illness Damage Types Key'
  key zill_types_key : String(3) not null;
  @sap.label : 'Inj Ill Dmg Typ Desc'
  @sap.quickinfo : 'BTP Data Element For Injury Illness Damage Types Key'
  zinj_ill_damage_type : String(200);
  @sap.label : 'Olay Sınıfı'
  @sap.quickinfo : 'BTP Forms Olay Sınıfı İçin Data Element'
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
  @sap.label : 'Dil anahtarı'
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
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
  key zreport_no : String(17) not null;
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
  zmanagement : String(3);
  @sap.label : 'Departman'
  @sap.quickinfo : 'BTP Forms Departman İçin Data Element'
  zdepartment : String(3);
  @sap.label : 'Tesis/Birim'
  @sap.quickinfo : 'BTP Forms Tesis/Birim İçin Data Element'
  zfacility : String(3);
  @sap.label : 'Kuyu/Proje/Saha'
  @sap.quickinfo : 'BTP Forms Kuyu İçin Data Element'
  zwell : String(100);
  @sap.label : 'Olay Başlığı'
  @sap.quickinfo : 'BTP Forms Olay Başlığı İçin Data Element'
  zincident_title : String(100);
  @sap.display.format : 'Date'
  @sap.label : 'Rapor Tarihi'
  @sap.quickinfo : 'BTP Forms Rapor Tarihi İçin Data Element'
  zreport_date : Date;
  @sap.label : 'Rapor Saati'
  @sap.quickinfo : 'BTP Forms Rapor Saati İçin Data Element'
  zreport_time : Time;
  @sap.display.format : 'Date'
  @sap.label : 'Olay Tarihi'
  @sap.quickinfo : 'BTP Forms Olay Tarihi İçin Data Element'
  zincident_date : Date;
  @sap.label : 'Olay Saati'
  @sap.quickinfo : 'BTP Forms Olay Saati İçin Data Element'
  zincident_time : Time;
  @sap.label : 'Olay Yeri'
  @sap.quickinfo : 'BTP Forms Olay Yeri İçin Data Element'
  zincident_loc : LargeString;
  @sap.label : 'Olay Sınıfı'
  @sap.quickinfo : 'BTP Forms Olay Sınıfı İçin Data Element'
  zincident_class : String(3);
  @sap.label : 'DROP'
  @sap.quickinfo : 'BTP Forms Drop İçin Data Element'
  zdrop : String(1);
  @sap.label : 'MEDEVAC'
  @sap.quickinfo : 'BTP Forms Medevac İçin Data Element'
  zmedevac : String(1);
  @sap.label : 'Olay Tanımı'
  @sap.quickinfo : 'BTP Forms Olay Tanımı İçin Data Element'
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
  @sap.label : 'Yaratma tarihi'
  @sap.quickinfo : 'Kaydın eklendiği tarih'
  erdat : Date;
  @sap.label : 'Saat'
  @sap.quickinfo : 'Giriş saati'
  erzet : Time;
  @sap.label : 'Yaratan'
  @sap.quickinfo : 'BTP EHS Yaratan İçin Data Element'
  ernam : String(241);
  @sap.display.format : 'Date'
  @sap.label : 'Değişiklik tarihi'
  @sap.quickinfo : 'Son değişiklik tarihi'
  aedat : Date;
  @sap.label : 'Değişiklik saati'
  @sap.quickinfo : 'Son değişiklik saati'
  aezet : Time;
  @sap.label : 'Değiştiren'
  @sap.quickinfo : 'BTP EHS Değitiren İçin Data Element'
  aenam : String(241);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Durum'
  @sap.quickinfo : 'BTP EHS Durum İçin Data Element'
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
  @sap.label : 'Karakter 1'
  @sap.quickinfo : 'Tek basamaklı gösterge'
  signfolderpresent : String(1);
  @sap.label : 'Incident Title'
  @sap.quickinfo : 'BTP: Incident Title String Type - Max'
  ztitle_max : LargeString;
  @sap.label : 'Direktörlük Anahtarı'
  @sap.quickinfo : 'BTP Veri Yapısı Direktörlük Anahtarı'
  zdirector_key : String(3);
  @sap.label : 'Müdürlük Anahtar'
  @sap.quickinfo : 'BTP Veri Yapısı Müdürlük'
  zmanager_key : String(5);
  @sap.label : 'Direktor Açıklaması'
  @sap.quickinfo : 'BTP Veri Yapısı Direktor Açıklaması'
  zdirector_desc : String(255);
  @sap.label : 'Müdürlük Açıklaması'
  @sap.quickinfo : 'BTP Veri Yapısı Müdürlük Açıklaması'
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
  @sap.label : 'Dil anahtarı'
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
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
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
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
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
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
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
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
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
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.label : 'Inc Likelihood Key'
  @sap.quickinfo : 'BTP Data Element For Incident Likelihood Key'
  key zinc_like_key : String(3) not null;
  @sap.label : 'Likelihood'
  @sap.quickinfo : 'BTP Data Element For Likelihood'
  zlikelihood : String(200);
  @sap.label : 'Kısa tanım'
  @sap.quickinfo : 'Sabit değerler için kısa metin'
  ddtext : String(60);
  @sap.label : 'Maruz Kalma'
  @sap.quickinfo : 'BTP Data Element Maruz Kalma'
  zlkl_exposure : String(200);
  @sap.label : 'Şirket'
  @sap.quickinfo : 'BTP Data Elemet Şirket'
  zlkl_company : String(200);
  @sap.label : 'Sektörel'
  @sap.quickinfo : 'BTP Data Element Sektörel'
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
  @sap.label : 'E-posta adresi'
  key p_email : String(241) not null;
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
  key zreport_no : String(17) not null;
  @sap.text : 'zmanagement_Text'
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
  zmanagement : String(3);
  @sap.label : 'Management Name'
  @sap.quickinfo : 'BTP Data Element For Management Name'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  zmanagement_Text : String(200);
  @sap.text : 'zdepartment_Text'
  @sap.label : 'Departman'
  @sap.quickinfo : 'BTP Forms Departman İçin Data Element'
  zdepartment : String(3);
  @sap.label : 'Department Name'
  @sap.quickinfo : 'BTP Data Element For Department Name'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  zdepartment_Text : String(200);
  @sap.text : 'zfacility_Text'
  @sap.label : 'Tesis/Birim'
  @sap.quickinfo : 'BTP Forms Tesis/Birim İçin Data Element'
  zfacility : String(3);
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility/Unit'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  zfacility_Text : String(200);
  @sap.label : 'Kuyu/Proje/Saha'
  @sap.quickinfo : 'BTP Forms Kuyu İçin Data Element'
  zwell : String(100);
  @sap.label : 'Olay Başlığı'
  @sap.quickinfo : 'BTP Forms Olay Başlığı İçin Data Element'
  zincident_title : String(100);
  @sap.display.format : 'Date'
  @sap.label : 'Rapor Tarihi'
  @sap.quickinfo : 'BTP Forms Rapor Tarihi İçin Data Element'
  zreport_date : Date;
  @sap.label : 'Rapor Saati'
  @sap.quickinfo : 'BTP Forms Rapor Saati İçin Data Element'
  zreport_time : Time;
  @sap.display.format : 'Date'
  @sap.label : 'Olay Tarihi'
  @sap.quickinfo : 'BTP Forms Olay Tarihi İçin Data Element'
  zincident_date : Date;
  @sap.label : 'Olay Saati'
  @sap.quickinfo : 'BTP Forms Olay Saati İçin Data Element'
  zincident_time : Time;
  @sap.label : 'Olay Yeri'
  @sap.quickinfo : 'BTP Forms Olay Yeri İçin Data Element'
  zincident_loc : LargeString;
  @sap.label : 'Olay Sınıfı'
  @sap.quickinfo : 'BTP Forms Olay Sınıfı İçin Data Element'
  zincident_class : String(3);
  @sap.label : 'DROP'
  @sap.quickinfo : 'BTP Forms Drop İçin Data Element'
  zdrop : String(1);
  @sap.label : 'MEDEVAC'
  @sap.quickinfo : 'BTP Forms Medevac İçin Data Element'
  zmedevac : String(1);
  @sap.label : 'Olay Tanımı'
  @sap.quickinfo : 'BTP Forms Olay Tanımı İçin Data Element'
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
  @sap.label : 'Yaratma tarihi'
  @sap.quickinfo : 'Kaydın eklendiği tarih'
  erdat : Date;
  @sap.label : 'Saat'
  @sap.quickinfo : 'Giriş saati'
  erzet : Time;
  @sap.label : 'Yaratan'
  @sap.quickinfo : 'BTP EHS Yaratan İçin Data Element'
  ernam : String(241);
  @sap.display.format : 'Date'
  @sap.label : 'Değişiklik tarihi'
  @sap.quickinfo : 'Son değişiklik tarihi'
  aedat : Date;
  @sap.label : 'Değişiklik saati'
  @sap.quickinfo : 'Son değişiklik saati'
  aezet : Time;
  @sap.label : 'Değiştiren'
  @sap.quickinfo : 'BTP EHS Değitiren İçin Data Element'
  aenam : String(241);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Durum'
  @sap.quickinfo : 'BTP EHS Durum İçin Data Element'
  status : String(1);
  @sap.label : 'Müdürlük Anahtar'
  @sap.quickinfo : 'BTP Veri Yapısı Müdürlük'
  zmanager_key : String(5);
  @sap.label : 'Direktörlük Anahtarı'
  @sap.quickinfo : 'BTP Veri Yapısı Direktörlük Anahtarı'
  zdirector_key : String(3);
  @sap.label : 'Müdürlük Açıklaması'
  @sap.quickinfo : 'BTP Veri Yapısı Müdürlük Açıklaması'
  zmanager_desc : String(255);
  @sap.label : 'Direktor Açıklaması'
  @sap.quickinfo : 'BTP Veri Yapısı Direktor Açıklaması'
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
  @sap.label : 'Incident Type Desc'
  zincident_type_desc : String(255);
  @sap.label : 'Signature Folder ID'
  @sap.quickinfo : 'BTP EHS Signature Folder ID Data Element'
  signfolderid : String(70);
  @sap.label : 'Incident Title'
  @sap.quickinfo : 'BTP: Incident Title String Type - Max'
  ztitle_max : LargeString;
  @sap.label : 'Seçme kutusu'
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
  @sap.label : 'E-posta adresi'
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
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.text : 'zmanagement_name'
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
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
  @sap.label : 'E-posta adresi'
  key p_email : String(241) not null;
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
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
  @sap.label : 'E-posta adresi'
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
  @sap.label : 'Dil anahtarı'
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
  @sap.label : 'Dil anahtarı'
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
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.label : 'Incident Relevance'
  @sap.quickinfo : 'BTP Data Element For Incident Relevance Key'
  key zincident_relevance_key : String(3) not null;
  @sap.label : 'Incident Relevance'
  @sap.quickinfo : 'BTP Forms Data Element For Incident Relevance'
  zincident_relevance : String(3);
  @sap.label : 'Kısa tanım'
  @sap.quickinfo : 'Sabit değerler için kısa metin'
  zincident_relevance_desc : String(60);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Investigation Form Remedial Actions CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_REMEDIAL_ACTIONS {
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
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
  @sap.label : 'Tarih'
  zrem_act_due_date : Date;
  @sap.label : 'Remedial Act Status'
  @sap.quickinfo : 'BTP Data Element For Remedial Actions Status'
  zrem_act_status : String(200);
  @sap.display.format : 'Date'
  @sap.label : 'Tarih'
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
  @sap.label : 'E-posta adresi'
  key p_email : String(241) not null;
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
  key zreport_no : String(17) not null;
  @sap.label : 'Row No'
  @sap.quickinfo : 'EHS Row No'
  key zrow_no : Integer not null;
  @sap.display.format : 'Date'
  @sap.label : 'Rapor Tarihi'
  @sap.quickinfo : 'BTP Forms Rapor Tarihi İçin Data Element'
  zreport_date : Date;
  @sap.text : 'zmanagement_Text'
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
  zmanagement : String(3);
  @sap.label : 'Management Name'
  @sap.quickinfo : 'BTP Data Element For Management Name'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  zmanagement_Text : String(200);
  @sap.text : 'zdepartment_Text'
  @sap.label : 'Departman'
  @sap.quickinfo : 'BTP Forms Departman İçin Data Element'
  zdepartment : String(3);
  @sap.label : 'Department Name'
  @sap.quickinfo : 'BTP Data Element For Department Name'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  zdepartment_Text : String(200);
  @sap.text : 'zfacility_Text'
  @sap.label : 'Tesis/Birim'
  @sap.quickinfo : 'BTP Forms Tesis/Birim İçin Data Element'
  zfacility : String(3);
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility/Unit'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  zfacility_Text : String(200);
  @sap.label : 'Kuyu/Proje/Saha'
  @sap.quickinfo : 'BTP Forms Kuyu İçin Data Element'
  zwell : String(100);
  @sap.label : 'Incident Title'
  @sap.quickinfo : 'BTP: Incident Title String Type - Max'
  ztitle_max : LargeString;
  @sap.label : 'Olay Sınıfı'
  @sap.quickinfo : 'BTP Forms Olay Sınıfı İçin Data Element'
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
  @sap.label : 'Tarih'
  zrem_act_due_date : Date;
  @sap.label : 'Remedial Act Status'
  @sap.quickinfo : 'BTP Data Element For Remedial Actions Status'
  zrem_act_status : String(200);
  @sap.text : 'zrem_act_status_text'
  @sap.label : 'Remedial Status'
  zrem_act_status_text : String(6);
  @sap.display.format : 'Date'
  @sap.label : 'Tarih'
  zrem_act_closed_date : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Durum'
  @sap.quickinfo : 'BTP EHS Durum İçin Data Element'
  status : String(1);
  @sap.label : 'Seçme kutusu'
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
  @sap.label : 'E-posta adresi'
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
  @sap.label : 'Dil anahtarı'
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
  key role_id : String(8) not null;
  @sap.label : 'E-posta adresi'
  key email : String(241) not null;
  @sap.display.format : 'NonNegative'
  @sap.label : 'Kullanıcı Id'
  user_id : String(5);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Ad'
  firstname : String(100);
  @sap.label : 'Soyadı'
  lastname : String(100);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Ünvan'
  title : String(100);
  @sap.label : 'Departman'
  department : String(100);
  @sap.label : 'Rol Açıklaması'
  UserDescription : String(255);
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
  zmanagement_key : String(3);
  @sap.label : 'Departman'
  @sap.quickinfo : 'BTP Forms Departman İçin Data Element'
  zdepartment_key : String(3);
  @sap.label : 'Tesis/Birim'
  @sap.quickinfo : 'BTP Forms Tesis/Birim İçin Data Element'
  zfacility_key : String(3);
  @sap.label : 'Seçme kutusu'
  @sap.heading : ''
  ownforms : Boolean;
  @sap.label : 'Seçme kutusu'
  @sap.heading : ''
  is_active : Boolean;
  @sap.label : 'Rol Açıklaması'
  RoleDescription : String(255);
  to_Role : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_WROLES {  };
  to_User : Association to ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_WUSERS {  };
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Root Causes SH CDS Service'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_ROOT_CAUSES_SH {
  @sap.label : 'Rapor Numarası'
  @sap.quickinfo : 'BTP Forms Rapor Numarası İçin Data Element'
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
  @sap.label : 'Dil anahtarı'
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
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.label : 'Departman'
  @sap.quickinfo : 'BTP Forms Departman İçin Data Element'
  key zdepartment_key : String(3) not null;
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
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
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
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
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Unit Key'
  key zunit_key : String(3) not null;
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility/Unit'
  zfacility_unit : String(200);
  @sap.label : 'Departman'
  @sap.quickinfo : 'BTP Forms Departman İçin Data Element'
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
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.text : 'zfacility_unit'
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Unit Key'
  key zunit_key : String(3) not null;
  @sap.label : 'Facility/Unit'
  @sap.quickinfo : 'BTP Data Element For Facility/Unit'
  zfacility_unit : String(200);
  @sap.label : 'Departman'
  @sap.quickinfo : 'BTP Forms Departman İçin Data Element'
  zdepartment_id : String(3);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'BTP EHS Users Submitted Edit Rol CDS'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_USER {
  @sap.label : 'Rol Id'
  key id : String(8) not null;
  @sap.label : 'E-posta adresi'
  key smtp_addr : String(241) not null;
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Workzone Role List'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_WROLES {
  @sap.label : 'Rol Id'
  key role_id : String(8) not null;
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
  zmanagement_key : String(3);
  @sap.label : 'Departman'
  @sap.quickinfo : 'BTP Forms Departman İçin Data Element'
  zdepartment_key : String(3);
  @sap.label : 'Tesis/Birim'
  @sap.quickinfo : 'BTP Forms Tesis/Birim İçin Data Element'
  zfacility_key : String(3);
  @sap.label : 'Seçme kutusu'
  @sap.heading : ''
  ownforms : Boolean;
  @sap.label : 'Seçme kutusu'
  @sap.heading : ''
  is_active : Boolean;
  @sap.label : 'Rol Açıklaması'
  description : String(255);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'EHS Workzone User List'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_WUSERS {
  @sap.display.format : 'NonNegative'
  @sap.label : 'Kullanıcı Id'
  key user_id : String(5) not null;
  @sap.label : 'E-posta adresi'
  key email : String(241) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Ad'
  firstname : String(100);
  @sap.label : 'Soyadı'
  lastname : String(100);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Ünvan'
  title : String(100);
  @sap.label : 'Departman'
  department : String(100);
  @sap.label : 'Rol Açıklaması'
  description : String(255);
};

@cds.external : true
@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Management Not Crp'
entity ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_MNGMNT_NOT_CRP {
  @sap.label : 'Dil anahtarı'
  key spras : String(2) not null;
  @sap.text : 'zmanagement_name'
  @sap.label : 'Yönetim'
  @sap.quickinfo : 'BTP Forms Yönetim İçin Data Element'
  key zmanagement_key : String(3) not null;
  @sap.label : 'Management Name'
  @sap.quickinfo : 'BTP Data Element For Management Name'
  zmanagement_name : String(200);
};

