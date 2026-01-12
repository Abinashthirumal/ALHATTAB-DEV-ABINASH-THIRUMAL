CLASS lhc_zi_project_upl DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_project_upl RESULT result.

    METHODS autolo FOR MODIFY
      IMPORTING keys FOR ACTION zi_project_upl~autolo.

    METHODS post1 FOR MODIFY
      IMPORTING keys FOR ACTION zi_project_upl~post1.

    METHODS autoloading FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_project_upl~autoloading.

ENDCLASS.

CLASS lhc_zi_project_upl IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD autolo.






      READ ENTITIES OF Zi_Project_Upl IN LOCAL MODE
     ENTITY zi_project_upl
     ALL FIELDS
     WITH CORRESPONDING #( keys )
     RESULT DATA(it_travel).


      LOOP AT it_travel ASSIGNING FIELD-SYMBOL(<ls_travel>).



        IF <ls_travel>-status IS  INITIAL .



                <ls_travel>-Status = 'Open'.

        enDIF.

     ENDLOOP.




      MODIFY ENTITIES OF Zi_Project_Upl IN LOCAL MODE
    ENTITY zi_project_upl
    UPDATE FIELDS (  status   )
    WITH CORRESPONDING #( it_travel  ).











  ENDMETHOD.

METHOD post1.

  "-----------------------------------------
  " Read RAP data
  "-----------------------------------------
  READ ENTITIES OF zi_project_upl IN LOCAL MODE
    ENTITY zi_project_upl
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(it_result).

  IF it_result IS INITIAL.
    RETURN.
  ENDIF.


  "-----------------------------------------
  " Type Definitions
  "-----------------------------------------
  TYPES: BEGIN OF ty_proj_element,
           ProjectElement                  TYPE string,
           WBSElementInternalID            TYPE string,
           ProjectUUID                     TYPE string,
           ProjectElementDescription       TYPE string,
           ParentObjectUUID                TYPE string,
           EntProjectElementType           TYPE string,
           PlannedStartDate                TYPE string,
           PlannedEndDate                  TYPE string,
           WBSIsStatisticalWBSElement      TYPE abap_boolean,
           WBSElementIsBillingElement      TYPE abap_boolean,
           IsMainMilestone                 TYPE abap_boolean,
         END OF ty_proj_element.

  "-----------------------------------------
  " Declarations
  "-----------------------------------------
  DATA: lo_http_client   TYPE REF TO if_web_http_client,
        lo_http_request  TYPE REF TO if_web_http_request,
        lo_http_response TYPE REF TO if_web_http_response,
        lo_destination   TYPE REF TO if_http_destination,
        lv_url           TYPE string,
        lv_json          TYPE string.

  "-----------------------------------------
  " URL determination
  "-----------------------------------------
  IF sy-sysid = 'JFA'.
    lv_url = 'https://my412486-api.s4hana.cloud.sap/sap/opu/odata/sap/API_ENTERPRISE_PROJECT_SRV;v=0002/A_EnterpriseProjectElement'.
  ELSE.
    lv_url = 'https://<PRD>-api.s4hana.cloud.sap/sap/opu/odata/sap/API_ENTERPRISE_PROJECT_SRV;v=0002/A_EnterpriseProjectElement'.
  ENDIF.

  LOOP AT it_result INTO DATA(wa_result).

    CLEAR: lo_http_client, lo_http_request, lo_http_response, lv_json.

    "-----------------------------------------
    " Build Payload
    "-----------------------------------------
    DATA(ls_payload) = VALUE ty_proj_element(
      ProjectElement             =  wa_result-ProjectElement
      WBSElementInternalID       = wa_result-WbselementId
      ProjectUUID                = 'fa163e8d-1f7e-1fd0-88e8-750c24e4300f'
      ProjectElementDescription  = wa_result-ProjectElementDesc
      ParentObjectUUID           = 'fa163e8d-1f7e-1fd0-88e8-79d3b747d00f'
      EntProjectElementType      =  wa_result-Entprojectelementtype
      PlannedStartDate           = wa_result-PlannedStartDate
      PlannedEndDate             = wa_result-PlannedEndDate
      WBSIsStatisticalWBSElement = wa_result-WbsIsStatistical
      WBSElementIsBillingElement = wa_result-WbsIsBillingElement
      IsMainMilestone            = wa_result-IsMainMilestone
    ).

    "-----------------------------------------
    " Serialize JSON (CamelCase)
    "-----------------------------------------
    /ui2/cl_json=>serialize(
      EXPORTING
        data        = ls_payload
        pretty_name = /ui2/cl_json=>pretty_mode-camel_case
      RECEIVING
        r_json      = lv_json
    ).

    "-----------------------------------------
    " HTTP POST
    "-----------------------------------------
    TRY.
        lo_destination = cl_http_destination_provider=>create_by_url( lv_url ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

        lo_http_request = lo_http_client->get_http_request( ).

        lo_http_request->set_header_fields(
          VALUE #(
            ( name = if_web_http_header=>content_type
              value = if_web_http_header=>accept_application_json )
            ( name = if_web_http_header=>accept
              value = if_web_http_header=>accept_application_json )
            ( name = if_web_http_header=>authorization
              value = 'Basic QVBJVVNFUjpBbGhhdHRhYkAxMjNBbGhhdHRhYkAxMjNBbGhhdHRhYkAxMjM= '
)
          )
        ).

        lo_http_request->set_text( lv_json ).
        lo_http_client->set_csrf_token( ).

        lo_http_response =
          lo_http_client->execute( if_web_http_client=>post ).

      CATCH cx_web_http_client_error INTO DATA(lx_http).
        " Technical error handling
        CONTINUE.
    ENDTRY.

    "-----------------------------------------
    " Response handling
    "-----------------------------------------
    DATA(ls_status)   = lo_http_response->get_status( ).
    DATA(lv_response) = lo_http_response->get_text( ).

    IF ls_status-code = '201'.
    ELSE.
    ENDIF.

  ENDLOOP.

ENDMETHOD.

  METHOD autoloading.



      MODIFY ENTITIES OF Zi_Project_Upl  IN LOCAL MODE
     ENTITY zi_project_upl
     EXECUTE autolo
     FROM CORRESPONDING #( keys ).


  ENDMETHOD.

ENDCLASS.
