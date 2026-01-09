using {ZBTP_EHS_DD_OBS_CARD_CDS} from './external/ZBTP_EHS_DD_OBS_CARD_CDS';
service OBSCard{
    action SendOBSCardEmail( zcard_no: String ) returns String;

    entity OBSCard as projection on ZBTP_EHS_DD_OBS_CARD_CDS.ZBTP_EHS_DD_OBS_CARD;
}