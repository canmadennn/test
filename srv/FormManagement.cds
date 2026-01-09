using {ZBTP_EHS_INCIDENT_MANAGEMENT_SRV} from './external/ZBTP_EHS_INCIDENT_MANAGEMENT_SRV';

service IncidentManagementForms {
  type InvestigationFormUpdateParam {
    zincident_desc          : LargeString;
    zinitial_findings       : LargeString;
    zapproved_name          : LargeString;
    zapproved_signature     : LargeString;
    zapproved_date          : Date;
    zinvestigator_name      : LargeString;
    zinvestigator_signature : LargeString;
    zinvestigator_date      : Date;
    zverification_name      : LargeString;
    zverification_signature : LargeString;
    zverification_date      : Date;
    zcomp_name              : LargeString;
    zinj_per_comp_key       : String(3);
    zposition               : LargeString;
    zexp_occu               : Integer;
    zexp_pos                : Integer;
    zdays_shift             : Integer;
    ztour_time              : Decimal(13, 3);
    zactivity               : LargeString;
    zinc_det_desc           : LargeString;
    zjob_undertaken         : LargeString;
    zjra_no                 : LargeString;
    zpermit_no              : LargeString;
    zfindings               : LargeString;
    zlessons                : LargeString;
    zdirector_key           : String(3);
    zmanager_key            : String(5);
    zdirector_desc          : String(255);
    zmanager_desc           : String(255);
  }

  type InitialFormUpdateParam {
    zincident_class     : String(3);
    zincident_type      : String(3);
    zincident_relevance : String(3);
    zincident_desc      : String;
    zmedevac            : String(1);
    zdrop               : String(1);
    zinitial_findings   : String;
    zapproved_name      : LargeString;
    zapproved_signature : LargeString;
    zapproved_date      : Date;
    zprepared_name      : LargeString;
    zprepared_signature : LargeString;
    zprepared_date      : Date;
    zreal_outcome       : String(3);
  }

  type ActionReturn {
    zreport_date : Date;
    zreport_time : Time;
  }

  type ConseqReturn {
    zconsequences_type : String;
    zincident_severity : String;
    zconsequences_key  : String(3);
    zlikelihood        : String;
    zinv_lvl           : String;
    zorder             : Integer;
  }

  type PDFData {
    fileContent : LargeString;
    fileName    : LargeString;
    traceString : String;
  }

  entity FlashForm               as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FLASHFORM
    actions {
      action   CancelFlashReport() returns String;
      action   SubmitFlashReport() returns String;
      // function CreatePDF()         returns @Core.MediaType: 'application/pdf' LargeBinary;
      function CreatePDF()         returns PDFData;
    };

  entity Management              as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_MNGMT {
      spras,
      zmanagement_key,
      zmanagement_name
    };


  entity UserRole                as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_USER {
      id,
      smtp_addr
    };


  entity Department              as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_DEPARTM {
      spras,
      zdepartment_key,
      zdepartment_name,
      zmanagement_key
    };


  entity Facility                as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_UNITS {
      spras,
      zunit_key,
      zfacility_unit,
      zdepartment_id as zdepartment_key
    };

  entity IncidentClass           as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_CLASS {
      spras,
      zincident_classname_key,
      zincident_classname
    };

  entity Consequences            as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CONSEQUENCES_SH {
      key zconsequences_key,
      key spras,
          zconsequences_type,
          zconsequences as zsoncesquences,
          zincident_severity,
          zorder,
          zassets_damage,
          zassets_operational_impact,
          zassets_financial_impact,
          ddtext        as zseverity_text
    };

  entity InitialForm             as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INITIAL
    actions {
      action   UpdateInitialForm(FormDetails: InitialFormUpdateParam,
                                 PossibleCauses: InitialPossibleCauses,
                                 ImmediateActions: ImmediateActions,
                                 Consequences: InitConseq) returns ActionReturn;

      action   CancelInitialReport()                       returns ActionReturn;
      action   SubmitInitialReport()                       returns ActionReturn;
      action   CloseInitialReport()                        returns ActionReturn;
      // function CreatePDF()                                  returns @Core.MediaType: 'application/pdf' LargeBinary;
      function CreatePDF()                                 returns PDFData;
      function CheckSignature()                            returns Boolean;
    };

  entity IncidentType            as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_TYPE {
      key spras,
      key zincident_type_key,
      key zincident_class_id,
          zincident_type_desc,
          zincident_classname
    };

  entity IncidentRelevance       as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_RELEVANCE_SH;

  entity ImmediateCauses         as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_IMMEDIATE_CAUSES {
      spras,
      zimm_caueses_key as zimm_causes_key,
      zrow_no,
      zimmediate_causes,
      zmic_key,
      zdefinition
    };

  entity MainImmediateCauses     as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_M_IMMEDIATE_CAUSES {
      spras,
      zmrc_key,
      zmain_imm_causes
    };

  entity InitialPossibleCauses   as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INIT_POS_CAU;

  entity ImmediateActions        as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INIT_IMM_ACT {
      zreport_no,
      zrow_no,
      zimm_act_taken,
      zresponsible_party
    };

  entity Likelihood              as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_LIKELIHOOD_SH {
      key spras,
      key zinc_like_key,
          zlikelihood,
          ddtext as zlikelihood_text,
          zlkl_exposure,
          zlkl_company,
          zlkl_sectoral,
          zlkl_zho
    };

  entity InitConseq              as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CONSEQUENCES;
  entity Risk                    as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_RISK;

  entity FlashformStatus         as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FORM_STATUS {
      spras,
      status_text,
      status
    };

  entity InvestigationForm       as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INVESTIGATION
    actions {
      action   UpdateInvestigationForm(FormDetails: InvestigationFormUpdateParam,
                                       ImmediateActions: ImmediateActions,
                                       RootCauses: InvRootCauses,
                                       InvTeam: ZBTP_EHS_DD_INV_TEAM,
                                       InjDmg: ZBTP_EHS_DD_INV_INJ_DMG,
                                       InjuryPeople: InjuryPeople,
                                       BodyParts: InvBodyParts,
                                       RemdActs: RemdAct) returns ActionReturn;

      action   SubmitInvestigationReport()                returns ActionReturn;
      action   CancelInvestigationReport()                returns ActionReturn;
      // function CreatePDF()                                 returns @Core.MediaType: 'application/pdf' LargeBinary;
      function CreatePDF()                                returns PDFData;
      function CheckSignature()                           returns Boolean;
    };

  entity ZBTP_EHS_DD_INV_INJ_DMG as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INV_INJ_DMG;
  entity ZBTP_EHS_INJ_P_C        as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INj_PERS_COMP;
  entity ZBTP_EHS_DD_INV_TEAM    as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INV_TEAM;
  entity InjuryPeople            as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INV_INJ_PPL;
  entity InvRootCauses           as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_ROOT_CAUSES_SH;
  entity InjuryDamage            as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INJ_ILL;
  entity MainRootCauses          as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_M_ROOT;
  entity RootCauses              as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_ROOT_CS;
  entity InvBodyParts            as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INV_BODY_PART;
  entity BodyParts               as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INV_BDY;
  entity RemdAct                 as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_REMEDIAL_ACTIONS;
  entity ZBTP_EHS_INC_STS        as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INC_STATUS;
  entity InitFiles               as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_INIT_FILES;
  entity DrcMngr                 as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_CMPMNG;


  @readonly
  entity FlashformList           as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_LIST;

  entity FlashformListSet        as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_LISTSet {
      key zreport_no,
          p_email,
          zmanagement,
          zdepartment,
          zfacility,
          zwell,
          zincident_title,
          zreport_date,
          zreport_time,
          zincident_date,
          zincident_time,
          zincident_loc,
          zincident_class,
          zdrop,
          zmedevac,
          zincident_desc,
          zcustom_text1,
          zcustom_text2,
          zcustom_text3,
          zcustom_dec1,
          zcustom_dec2,
          zcustom_dec3,
          erdat,
          erzet,
          ernam,
          aedat,
          aezet,
          aenam,
          status,
          zinc_status,
          zinc_status_Text,
          zmanager_key,
          zdirector_key,
          zmanager_desc,
          zdirector_desc,
          zincident_relevance_desc,
          zincident_type_desc,
          signfolderid,
          ztitle_max,
          xfeld,
          to_Department,
          to_Facility,
          to_IncCLass,
          to_IncStatus,
          to_Init,
          to_Inv,
          to_Management,
          to_Status,

    };

  entity ManagementRoles         as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_MNGMT_ROLES;

  entity ManagementRolesSet      as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_MNGMT_ROLESSet {
      key zmanagement_key,
      key spras,
          p_email,
          zmanagement_name
    };

  entity DepartmentRoles         as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_DPRTMNT_ROLES;

  entity DepartmentRolesSet      as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_DPRTMNT_ROLESSet {
      key zmanagement_key,
      key zdepartment_key,
      key spras,
          p_email,
          zdepartment_name
    };

  entity FacilityRoles           as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FACILITY_ROLES;

  entity FacilityRolesSet        as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FACILITY_ROLESSet {
      key zmanagement_key,
      key zdepartment_key,
      key zunit_key,
      key spras,
          p_email,
          zfacility_unit
    };

  @cds.persistence.exists: false
  type InitFiles2 {
    zreport_no  : String(17);
    filename    : String;
    fileContent : LargeBinary
    @Core.MediaType         : fileType
    @Core.ContentDisposition: {Filename: filename};
    fileType    : String
    @Core.IsMediaType;
  }

  @cds.persistence.exists: false
  type Files {
    zreport_no  : String(17);
    filename    : String;
    fileContent : LargeString;
    fileType    : String;
    zinv        : String(1);
  }


  function RiskMatrix(zreport_no: String(17))                                                                                returns many ConseqReturn;

  function GetDMSFiles(zreport_no: String(17),
                       zinv: String(1))                                                                                      returns many Files;

  action   updateComplaintStatus(value: LargeString)                                                                         returns String;
  action   SendGrievanceFormEmail(zreport_no: String, zform_type: String)                                                    returns String;


  action   UpdateIncidentStatus(zreport_no: String,
                                status: String)                                                                              returns String;

  //! -- REMEDIAL ACTIONS ADMIN LIST --
  entity RemedialAdminList       as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_REMEDIAL_ADMIN;

  entity RemedialAdminListSet    as
    projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_REMEDIAL_ADMINSet {
      key zreport_no,
      key zrow_no,
          p_email,
          zreport_date,
          zmanagement,
          zdepartment,
          zfacility,
          zwell,
          ztitle_max,
          zincident_class,
          zincident_type,
          zrem_act_actions,
          zrem_act_respons,
          zrem_act_due_date,
          zrem_act_status,
          zrem_act_status_text,
          zrem_act_closed_date,
          xfeld,
          status,
          to_Management,
          to_Department,
          to_Facility,
          to_IncClass,
          to_IncType,
          to_RemAct
    }

  action   DeleteRemedial(zreport_no: String,
                          zrow_no: Integer)                                                                                  returns SuccessResponse;

  action   UpdateRemedial(zreport_no: String,
                          zrow_no: Integer,
                          zrem_act_actions: String,
                          zrem_act_respons: String,
                          zrem_act_due_date: DateTime,
                          zrem_act_status: String,
                          zrem_act_closed_date: DateTime)                                                                    returns SuccessResponse;


  type SuccessResponse {
    success : Boolean;
    message : String;
  }

  //! -- REMEDIAL ACTIONS ADMIN LIST --


  //! -- ROLE MAINTENANCE APP - WORKZONE --

  entity WUsers                  as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_WUSERS;
  entity WRoles                  as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_WROLES;
  entity RoleUserList            as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_USER;
  entity RoleUserListAll         as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_ROLEUSERLIST;
  entity ManagementTable         as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_T_MANAGEMENT;
  entity DepartmentTable         as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_T_DEPARTMENT;
  entity FacilityTable           as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_T_UNITS;
  entity FullManagement          as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_FULL_MNGMNT;
  entity ManagementNoCRP         as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_MNGMNT_NOT_CRP;

  action   regenerateRoles()                                                                                                 returns String;
  action   deleteRoleById(roleId: String)                                                                                    returns String;
  action   deleteAllRoles()                                                                                                  returns String;

  action   createUser(email: String,
                      firstname: String,
                      lastname: String,
                      title: String,
                      department: String,
                      description: String)                                                                                   returns {
    user_id     : String(5);
    email       : String(241);
    firstname   : String(100);
    lastname    : String(100);
    title       : String(100);
    department  : String(100);
    description : String(255);
  };

  action   updateUser(user_id: String(5),
                      firstname: String(100),
                      lastname: String(100),
                      title: String(100),
                      department: String(100),
                      description: String(255))                                                                              returns WUsers;

  action   deleteUser(email: String(241))                                                                                    returns String;

  action   assignUsersToRole(role_id: String,
                             user_emails: array of String)                                                                   returns {
    success : Boolean;
    message : String;
    details : array of {
      email   : String;
      status  : String;
      message : String;
    };
  };

  action   assignRolesToUser(email: String,
                             role_ids: array of String)                                                                      returns {
    success : Boolean;
    message : String;
    details : array of {
      role_id : String;
      status  : String;
      message : String;
    };
  };

  action   deleteUsersFromRole(role_id: String,
                               user_emails: array of String)                                                                 returns {
    success : Boolean;
    message : String;
    details : array of {
      email   : String;
      status  : String;
      message : String;
    };
  };

  action   deleteRolesFromUser(email: String,
                               role_ids: array of String)                                                                    returns {
    success : Boolean;
    message : String;
    details : array of {
      role_id : String;
      status  : String;
      message : String;
    };
  };


  type RoleStatistics {
    managementCount     : Integer;
    departmentCount     : Integer;
    facilityCount       : Integer;
    currentRolesCount   : Integer;
    potentialRolesCount : Integer;
    rolesToBeCreated    : Integer;
    roleStatus          : String;
    roleStatusMessage   : String;
    lastCalculated      : String;
  }

  action   getRoleStatistics()                                                                                               returns RoleStatistics;

  action   sendUserActionEmail(email: String,
                               firstname: String,
                               lastname: String,
                               title: String,
                               department: String,
                               description: String,
                               status: String)                                                                               returns SuccessResponse;


  action   createManagement(managementKey: String, nameEN: String, nameTR: String)                                           returns SuccessResponse;
  action   updateManagement(managementKey: String, nameEN: String, nameTR: String)                                           returns SuccessResponse;
  action   createDepartment(departmentKey: String, nameEN: String, nameTR: String, managementKey: String)                    returns SuccessResponse;
  action   updateDepartment(departmentKey: String, nameEN: String, nameTR: String, managementKey: String)                    returns SuccessResponse;
  action   createFacility(facilityKey: String, nameEN: String, nameTR: String, departmentKey: String, managementKey: String) returns SuccessResponse;
  action   updateFacility(facilityKey: String, nameEN: String, nameTR: String, departmentKey: String, managementKey: String) returns SuccessResponse;


  //! - Company Director-Manager IMB-102
  entity CompanyDirector         as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CPM_DRC;
  entity CompanyManager          as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_CMP_MNG;
    entity GrievanceCompany          as projection on ZBTP_EHS_INCIDENT_MANAGEMENT_SRV.ZBTP_EHS_DD_GRVRC;

}
