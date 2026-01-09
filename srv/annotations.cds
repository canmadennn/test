using IncidentManagementForms from './FormManagement';

annotate IncidentManagementForms.FlashForm with @UI {
  zreport_no                @title: '{i18n>zreport_no}'                @Common.Label: '{i18n>zreport_no}';
  zmanagement               @title: '{i18n>zmanagement}'               @Common.Label: '{i18n>zmanagement}'  @ObjectModel.text.association: 'to_Management';
  zdepartment               @title: '{i18n>zdepartment}'               @Common.Label: '{i18n>zdepartment}'  @ObjectModel.text.association: 'to_Department';
  zfacility                 @title: '{i18n>zfacility}'                 @Common.Label: '{i18n>zfacility}'    @ObjectModel.text.association: 'to_Facility';
  zwell                     @title: '{i18n>zwell}'                     @Common.Label: '{i18n>zwell}';
  zincident_title           @title: '{i18n>zincident_title}'           @Common.Label: '{i18n>zincident_title}';
  zreport_date              @title: '{i18n>zreport_date}'              @Common.Label: '{i18n>zreport_date}';
  zreport_time              @title: '{i18n>zreport_time}'              @Common.Label: '{i18n>zreport_time}';
  zincident_date            @title: '{i18n>zincident_date}'            @Common.Label: '{i18n>zincident_date}';
  zincident_time            @title: '{i18n>zincident_time}'            @Common.Label: '{i18n>zincident_time}';
  zincident_loc             @title: '{i18n>zincident_loc}'             @Common.Label: '{i18n>zincident_loc}';
  zincident_class           @title: '{i18n>zincident_class}'           @Common.Label: '{i18n>zincident_class}';
  zdrop                     @title: '{i18n>zdrop}'                     @Common.Label: '{i18n>zdrop}';
  zmedevac                  @title: '{i18n>zmedevac}'                  @Common.Label: '{i18n>zmedevac}';
  zincident_desc            @title: '{i18n>zincident_desc}'            @Common.Label: '{i18n>zincident_desc}';
  zcustom_text1;
  zcustom_text2;
  zcustom_text3;
  zcustom_dec1;
  zcustom_dec2;
  zcustom_dec3;
  erdat                     @title: '{i18n>erdat}'                     @Common.Label: '{i18n>erdat}';
  erzet                     @title: '{i18n>erzet}'                     @Common.Label: '{i18n>erzet}';
  ernam                     @title: '{i18n>ernam}'                     @Common.Label: '{i18n>ernam}';
  aedat                     @title: '{i18n>aedat}'                     @Common.Label: '{i18n>aedat}';
  aezet                     @title: '{i18n>aezet}'                     @Common.Label: '{i18n>aezet}';
  aenam                     @title: '{i18n>aenam}'                     @Common.Label: '{i18n>aenam}';
  status                    @title: '{i18n>status}'                    @Common.Label: '{i18n>status}';
  zinc_status               @title: '{i18n>zinc_status}'               @Common.Label: '{i18n>zinc_status}';
  // InitStatusText @title : '{i18n>InitStatusText}' @Common.Label : '{i18n>InitStatusText}';
  // InvStatusText @title : '{i18n>InvStatusText}' @Common.Label : '{i18n>InvStatusText}';
  zincident_relevance_desc  @title: '{i18n>zincident_relevance_desc}'  @Common.Label: '{i18n>zincident_relevance_desc}';
  zincident_type_desc       @title: '{i18n>zincident_type_desc}'       @Common.Label: '{i18n>zincident_type_desc}';
  signfolderid              @title: '{i18n>Flashsignfolderid}'         @Common.Label: '{i18n>Flashsignfolderid}';
  to_Department;
  to_Facility;
  to_IncCLass;
  to_IncStatus;
  to_Init;
  to_Inv;
  to_Management;
  to_Status;
};



annotate IncidentManagementForms.FlashformListSet with @UI {
  zreport_no                @title: '{i18n>zreport_no}'                @Common.Label: '{i18n>zreport_no}';
  zmanagement               @title: '{i18n>zmanagement}'               @Common.Label: '{i18n>zmanagement}'  @ObjectModel.text.association: 'to_Management';
  zdepartment               @title: '{i18n>zdepartment}'               @Common.Label: '{i18n>zdepartment}'  @ObjectModel.text.association: 'to_Department';
  zfacility                 @title: '{i18n>zfacility}'                 @Common.Label: '{i18n>zfacility}'    @ObjectModel.text.association: 'to_Facility';
  zwell                     @title: '{i18n>zwell}'                     @Common.Label: '{i18n>zwell}';
  zincident_title           @title: '{i18n>zincident_title}'           @Common.Label: '{i18n>zincident_title}';
  zreport_date              @title: '{i18n>zreport_date}'              @Common.Label: '{i18n>zreport_date}';
  zreport_time              @title: '{i18n>zreport_time}'              @Common.Label: '{i18n>zreport_time}';
  zincident_date            @title: '{i18n>zincident_date}'            @Common.Label: '{i18n>zincident_date}';
  zincident_time            @title: '{i18n>zincident_time}'            @Common.Label: '{i18n>zincident_time}';
  zincident_loc             @title: '{i18n>zincident_loc}'             @Common.Label: '{i18n>zincident_loc}';
  zincident_class           @title: '{i18n>zincident_class}'           @Common.Label: '{i18n>zincident_class}';
  zdrop                     @title: '{i18n>zdrop}'                     @Common.Label: '{i18n>zdrop}';
  zmedevac                  @title: '{i18n>zmedevac}'                  @Common.Label: '{i18n>zmedevac}';
  zincident_desc            @title: '{i18n>zincident_desc}'            @Common.Label: '{i18n>zincident_desc}';
  zcustom_text1;
  zcustom_text2;
  zcustom_text3;
  zcustom_dec1;
  zcustom_dec2;
  zcustom_dec3;
  erdat                     @title: '{i18n>erdat}'                     @Common.Label: '{i18n>erdat}';
  erzet                     @title: '{i18n>erzet}'                     @Common.Label: '{i18n>erzet}';
  ernam                     @title: '{i18n>ernam}'                     @Common.Label: '{i18n>ernam}';
  aedat                     @title: '{i18n>aedat}'                     @Common.Label: '{i18n>aedat}';
  aezet                     @title: '{i18n>aezet}'                     @Common.Label: '{i18n>aezet}';
  aenam                     @title: '{i18n>aenam}'                     @Common.Label: '{i18n>aenam}';
  status                    @title: '{i18n>status}'                    @Common.Label: '{i18n>status}';
  zinc_status               @title: '{i18n>zinc_status}'               @Common.Label: '{i18n>zinc_status}';
  // InitStatusText @title : '{i18n>InitStatusText}' @Common.Label : '{i18n>InitStatusText}';
  // InvStatusText @title : '{i18n>InvStatusText}' @Common.Label : '{i18n>InvStatusText}';
  zincident_relevance_desc  @title: '{i18n>zincident_relevance_desc}'  @Common.Label: '{i18n>zincident_relevance_desc}';
  zincident_type_desc       @title: '{i18n>zincident_type_desc}'       @Common.Label: '{i18n>zincident_type_desc}';
  signfolderid              @title: '{i18n>Flashsignfolderid}'         @Common.Label: '{i18n>Flashsignfolderid}';
  to_Department;
  to_Facility;
  to_IncCLass;
  to_IncStatus;
  to_Init;
  to_Inv;
  to_Management;
  to_Status;
};



annotate IncidentManagementForms.Department with @Semantics {
  spras            @language: true;
  zdepartment_name @text    : true;
  zdepartment_key;
  zmanagement_key;
};



annotate IncidentManagementForms.Management with @Semantics {
  spras            @language: true;
  zmanagement_name @text    : true;
  zmanagement_key;
};



annotate IncidentManagementForms.Facility with @Semantics {
  spras          @language: true;
  zfacility_unit @text    : true;
  zunit_key;
  zdepartment_key;
};



annotate IncidentManagementForms.ZBTP_EHS_INC_STS {
  spras            @Semantics.language: true;
  zinc_status;
  zinc_status_desc @Semantics.text    : true;
};


annotate IncidentManagementForms.FlashformList {
  p_email;
  Set @Capabilities.SortRestrictions: {
    $Type                : 'Capabilities.SortRestrictionsType',
    NonSortableProperties: [p_email],
  }
};

//! -- REMEDIAL ACTIONS ADMIN LIST --
annotate IncidentManagementForms.RemedialAdminList {
  p_email;
  Set @Capabilities.SortRestrictions: {
    $Type                : 'Capabilities.SortRestrictionsType',
    NonSortableProperties: [p_email],
  }
};
//! -- REMEDIAL ACTIONS ADMIN LIST --