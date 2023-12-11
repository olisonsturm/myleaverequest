CLASS lhc_leaverequest DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR LeaveRequest RESULT result.
    METHODS DeclineLeaveRequest FOR MODIFY
      IMPORTING keys FOR ACTION LeaveRequest~DeclineLeaveRequest RESULT result.
    METHODS ApproveLeaveRequest FOR MODIFY
      IMPORTING keys FOR ACTION LeaveRequest~ApproveLeaveRequest RESULT result.
    METHODS DetermineState FOR DETERMINE ON MODIFY
      IMPORTING keys FOR LeaveRequest~DetermineState.
    METHODS DetermineVacationDays FOR DETERMINE ON MODIFY
      IMPORTING keys FOR LeaveRequest~DetermineVacationDays.
    METHODS ValidateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR LeaveRequest~ValidateDates.
    METHODS ValidateSufficientVacationDays FOR VALIDATE ON SAVE
      IMPORTING keys FOR LeaveRequest~ValidateSufficientVacationDays.

ENDCLASS.

CLASS lhc_leaverequest IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD DeclineLeaveRequest.

    DATA message TYPE REF TO zcm_ceo_lrequest.

    " Read Leave Request
    READ ENTITY IN LOCAL MODE ZR_CEO_LeaveRequest
        FIELDS ( State Remark )
        WITH CORRESPONDING #( keys )
        RESULT DATA(leaverequests).

    " Process Leave Request
    LOOP AT leaverequests REFERENCE INTO DATA(leaverequest). " foreach quasi

      " Validate State and Create Error Message
      IF leaverequest->State = 'D'.
        message = NEW zcm_ceo_lrequest(
            textid = zcm_ceo_lrequest=>lrequest_already_declined
            severity = if_abap_behv_message=>severity-error
            remark  = leaverequest->Remark
        ).
        APPEND VALUE #( %tky = leaverequest->%tky %msg = message ) TO reported-leaverequest.
        APPEND VALUE #( %tky = leaverequest->%tky ) TO failed-leaverequest.
        DELETE leaverequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      IF leaverequest->State = 'A'.
        message = NEW zcm_ceo_lrequest(
            textid = zcm_ceo_lrequest=>lrequest_already_approved
            severity = if_abap_behv_message=>severity-error
            remark  = leaverequest->Remark
        ).
        APPEND VALUE #( %tky = leaverequest->%tky %msg = message ) TO reported-leaverequest.
        APPEND VALUE #( %tky = leaverequest->%tky ) TO failed-leaverequest.
        DELETE leaverequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      " Set State to D und Create Success Message
      leaverequest->State = 'D'.
      message = NEW zcm_ceo_lrequest(
            textid = zcm_ceo_lrequest=>lrequest_decline
            severity = if_abap_behv_message=>severity-success
            remark = leaverequest->Remark
        ).
      APPEND VALUE #( %tky = leaverequest->%tky %msg = message ) TO reported-leaverequest.
    ENDLOOP.

    " Modify Leave Request
    MODIFY ENTITY IN LOCAL MODE ZR_CEO_LeaveRequest
        UPDATE FIELDS ( State )
        WITH VALUE #( FOR lr IN leaverequests ( %tky = lr-%tky State = lr-State ) ).

    " Set Result
    result = VALUE #( FOR lr IN leaverequests ( %tky = lr-%tky %param = lr ) ).

  ENDMETHOD.

  METHOD ApproveLeaveRequest.

    DATA message TYPE REF TO zcm_ceo_lrequest.

    " Read Leave Request
    READ ENTITY IN LOCAL MODE ZR_CEO_LeaveRequest
        FIELDS ( State Remark )
        WITH CORRESPONDING #( keys )
        RESULT DATA(leaverequests).

    " Process Leave Request
    LOOP AT leaverequests REFERENCE INTO DATA(leaverequest). " foreach quasi

      " Validate State and Create Error Message
      IF leaverequest->State = 'D'.
        message = NEW zcm_ceo_lrequest(
            textid = zcm_ceo_lrequest=>lrequest_already_declined
            severity = if_abap_behv_message=>severity-error
            remark  = leaverequest->Remark
        ).
        APPEND VALUE #( %tky = leaverequest->%tky %msg = message ) TO reported-leaverequest.
        APPEND VALUE #( %tky = leaverequest->%tky ) TO failed-leaverequest.
        DELETE leaverequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      IF leaverequest->State = 'A'.
        message = NEW zcm_ceo_lrequest(
            textid = zcm_ceo_lrequest=>lrequest_already_approved
            severity = if_abap_behv_message=>severity-error
            remark  = leaverequest->Remark
        ).
        APPEND VALUE #( %tky = leaverequest->%tky %msg = message ) TO reported-leaverequest.
        APPEND VALUE #( %tky = leaverequest->%tky ) TO failed-leaverequest.
        DELETE leaverequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      " Set State to D und Create Success Message
      leaverequest->State = 'A'.
      message = NEW zcm_ceo_lrequest(
            textid = zcm_ceo_lrequest=>lrequest_approve
            severity = if_abap_behv_message=>severity-success
            remark = leaverequest->Remark
        ).
      APPEND VALUE #( %tky = leaverequest->%tky %msg = message ) TO reported-leaverequest.
    ENDLOOP.

    " Modify Leave Request
    MODIFY ENTITY IN LOCAL MODE ZR_CEO_LeaveRequest
        UPDATE FIELDS ( State )
        WITH VALUE #( FOR lr IN leaverequests ( %tky = lr-%tky State = lr-State ) ).

    " Set Result
    result = VALUE #( FOR lr IN leaverequests ( %tky = lr-%tky %param = lr ) ).

  ENDMETHOD.

  METHOD DetermineState.
    " Read LeaveRequests
    READ ENTITY IN LOCAL MODE ZR_CEO_LeaveRequest
        FIELDS ( State )
        WITH CORRESPONDING #( keys )
        RESULT DATA(leaverequests).

    " Modify LeaveRequests
    MODIFY ENTITY IN LOCAL MODE ZR_CEO_LeaveRequest
        UPDATE FIELDS ( State )
        WITH VALUE #( FOR lr IN leaverequests ( %tky = lr-%tky State = 'R' ) ).

  ENDMETHOD.

  METHOD DetermineVacationDays.
    " Read LeaveRequests
    READ ENTITY IN LOCAL MODE ZR_CEO_LeaveRequest
         FIELDS ( StartDate EndDate VacationDays )
         WITH CORRESPONDING #( keys )
         RESULT DATA(leaverequests).

    " Process Leave Request
    LOOP AT leaverequests REFERENCE INTO DATA(leaverequest).
    DATA working_days TYPE int1.
    working_days = 0.
      TRY.
          DATA: start_date_extended TYPE d.
          start_date_extended = leaverequest->StartDate - 1.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          working_days = calendar->calc_workingdays_between_dates( iv_start = start_date_extended iv_end = leaverequest->EndDate ).
          leaverequest->VacationDays = working_days.
        CATCH cx_fhc_runtime INTO DATA(exc).
      ENDTRY.
    ENDLOOP.

    " Modify Leave Requests
    MODIFY ENTITY IN LOCAL MODE ZR_CEO_LeaveRequest
        UPDATE FIELDS ( VacationDays )
        WITH VALUE #( FOR lr IN leaverequests ( %tky = lr-%tky VacationDays = lr-VacationDays ) ).
  ENDMETHOD.

  METHOD ValidateDates.
    DATA message TYPE REF TO zcm_ceo_lrequest.
    DATA current_date TYPE d.
    current_date = cl_abap_context_info=>get_system_date(  ).

    " Read Leave Request
    READ ENTITY IN LOCAL MODE ZR_CEO_LeaveRequest
        FIELDS ( StartDate EndDate CreatedAt )
        WITH CORRESPONDING #( keys )
        RESULT DATA(leaverequests).

    " Process Leave Request
    LOOP AT leaverequests REFERENCE INTO DATA(leaverequest).
      " Validate Dates and Create Error Message
      IF leaverequest->StartDate > leaverequest->EndDate.
        message = NEW zcm_ceo_lrequest(
            textid = zcm_ceo_lrequest=>lrequest_endbeforestartdate
            severity = if_abap_behv_message=>severity-error
        ).
        APPEND VALUE #( %tky = leaverequest->%tky  %element = VALUE #( EndDate = if_abap_behv=>mk-on ) %msg = message ) TO reported-leaverequest.
        APPEND VALUE #( %tky = leaverequest->%tky ) TO failed-leaverequest.
      ENDIF.

      IF leaverequest->StartDate < current_date.
        message = NEW zcm_ceo_lrequest(
            textid = zcm_ceo_lrequest=>lrequest_startdateinthepast
            severity = if_abap_behv_message=>severity-error
        ).
        APPEND VALUE #( %tky = leaverequest->%tky %element = VALUE #( StartDate = if_abap_behv=>mk-on ) %msg = message ) TO reported-leaverequest.
        APPEND VALUE #( %tky = leaverequest->%tky ) TO failed-leaverequest.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD ValidateSufficientVacationDays.
    DATA message TYPE REF TO zcm_ceo_lrequest.

    " Read Leave Request
    READ ENTITY IN LOCAL MODE ZR_CEO_LeaveRequest
        ALL FIELDS
        WITH CORRESPONDING #( keys )
        RESULT DATA(leaverequests).

    " Process Leave Request
    LOOP AT leaverequests REFERENCE INTO DATA(leaverequest).
    DATA working_days TYPE int1.
    working_days = 0.
      " Validate AvailableVacationDays and Create Error Message
      TRY.
          DATA: start_date_extended TYPE d.
          start_date_extended = leaverequest->StartDate - 1.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          working_days = calendar->calc_workingdays_between_dates( iv_start = start_date_extended iv_end = leaverequest->EndDate ).
        CATCH cx_fhc_runtime INTO DATA(exc).
      ENDTRY.
      SELECT FROM ZI_CEO_AvailableVacationDays FIELDS AvailableVacationDays WHERE EmployeeUuid = @leaverequest->ApplicantId INTO @DATA(availablevacationdays). ENDSELECT.
      IF availablevacationdays IS INITIAL.
        availablevacationdays = 0.
      ENDIF.
      IF availablevacationdays < working_days.
        message = NEW zcm_ceo_lrequest(
            textid = zcm_ceo_lrequest=>lrequest_insufficientvacdays
            severity = if_abap_behv_message=>severity-error
        ).
        APPEND VALUE #( %tky = leaverequest->%tky %msg = message ) TO reported-leaverequest.
        APPEND VALUE #( %tky = leaverequest->%tky ) TO failed-leaverequest.
        CONTINUE.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_employee DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Employee RESULT result.
    METHODS determineemployeenumber FOR DETERMINE ON MODIFY
      IMPORTING keys FOR employee~determineemployeenumber.
    METHODS refresh FOR MODIFY
      IMPORTING keys FOR ACTION employee~refresh RESULT result.

ENDCLASS.

CLASS lhc_employee IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD DetermineEmployeeNumber.
    " Read Employee
    READ ENTITY IN LOCAL MODE ZR_CEO_Employee
         FIELDS ( EmployeeNumber )
         WITH CORRESPONDING #( keys )
         RESULT DATA(employees).

    " Process Employee
    LOOP AT employees REFERENCE INTO DATA(employee).

      " Set Employee Number
      SELECT FROM zceo_employee_a FIELDS MAX( employee_number ) INTO @DATA(max_employee_number).
      employee->EmployeeNumber = max_employee_number + 1.

    ENDLOOP.

    " Modify Employee
    MODIFY ENTITY IN LOCAL MODE ZR_CEO_Employee
           UPDATE FIELDS ( EmployeeNumber )
           WITH VALUE #( FOR e IN employees
                         ( %tky     = employee->%tky
                           EmployeeNumber = employee->EmployeeNumber ) ).
  ENDMETHOD.

  METHOD Refresh.

    " Read Leave Request
    READ ENTITY IN LOCAL MODE ZR_CEO_Employee
        ALL FIELDS
        WITH CORRESPONDING #( keys )
        RESULT DATA(employees).

    " Set Result only for refresh
    result = VALUE #( FOR e IN employees ( %tky = e-%tky %param = e ) ).

  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
