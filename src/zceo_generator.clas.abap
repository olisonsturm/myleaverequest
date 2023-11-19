CLASS zceo_generator DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS ZCEO_GENERATOR IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA: employee TYPE zceo_employee_a,
          employees TYPE TABLE OF zceo_employee_a.

    DATA: entitlement TYPE zceo_entitleme_a,
          entitlements TYPE TABLE OF zceo_entitleme_a.

    DATA: lrequest TYPE zceo_lrequest_a,
          lrequests TYPE TABLE OF zceo_lrequest_a.

    DATA lisa_uuid TYPE sysuuid_x16.
    DATA hans_uuid TYPE sysuuid_x16.

    DELETE FROM zceo_employee_a.
    out->write( |Deleted Employees: { sy-dbcnt }| ).

    DELETE FROM zceo_entitleme_a.
    out->write( |Deleted Entitlements: { sy-dbcnt }| ).

    DELETE FROM zceo_lrequest_a.
    out->write( |Deleted Leave Resquests: { sy-dbcnt }| ).

    employee-client          = sy-mandt.
    employee-created_by      = 'SAP'.
    employee-last_changed_by = 'SAP'.
    GET TIME STAMP FIELD employee-created_at.
    GET TIME STAMP FIELD employee-last_changed_at.

    entitlement-client          = sy-mandt.
    entitlement-created_by      = 'SAP'.
    entitlement-last_changed_by = 'SAP'.
    GET TIME STAMP FIELD entitlement-created_at.
    GET TIME STAMP FIELD entitlement-last_changed_at.

    lrequest-client          = sy-mandt.
    lrequest-created_by      = 'SAP'.
    lrequest-last_changed_by = 'SAP'.
    GET TIME STAMP FIELD lrequest-created_at.
    GET TIME STAMP FIELD lrequest-last_changed_at.


    " Create second employee
    employee-employee_id     = cl_system_uuid=>create_uuid_x16_static( ).
    employee-employee_number = '000002'.
    employee-first_name      = 'Lisa'.
    employee-last_name       = 'Müller'.
    employee-entry_date      = '20100701'.
    lisa_uuid = employee-employee_id.
    APPEND employee TO employees.
    entitlement-entitlement_id   = cl_system_uuid=>create_uuid_x16_static( ).
    entitlement-employee_uuid    = employee-employee_id.
    entitlement-entitlement_year = 2023.
    entitlement-vacation_days    = 30.
    APPEND entitlement TO entitlements.

    " Create first employee
    employee-employee_id     = cl_system_uuid=>create_uuid_x16_static( ).
    employee-employee_number = '000001'.
    employee-first_name      = 'Hans'.
    employee-last_name       = 'Maier'.
    employee-entry_date      = '20000501'.
    hans_uuid = employee-employee_id.
    APPEND employee TO employees.
    entitlement-entitlement_id   = cl_system_uuid=>create_uuid_x16_static( ).
    entitlement-employee_uuid    = employee-employee_id.
    entitlement-entitlement_year = 2022.
    entitlement-vacation_days    = 30.
    APPEND entitlement TO entitlements.
    entitlement-entitlement_id   = cl_system_uuid=>create_uuid_x16_static( ).
    entitlement-employee_uuid    = employee-employee_id.
    entitlement-entitlement_year = 2023.
    entitlement-vacation_days    = 30.
    APPEND entitlement TO entitlements.
    lrequest-request_id      = cl_system_uuid=>create_uuid_x16_static( ).
    lrequest-applicant_id    = employee-employee_id.
    lrequest-approver_id     = lisa_uuid.
    lrequest-start_date      = '20220701'.
    lrequest-end_date        = '20220710'.
    lrequest-remark          = 'Summer Holiday'.
    lrequest-state           = 'A'.
    APPEND lrequest TO lrequests.
    lrequest-request_id      = cl_system_uuid=>create_uuid_x16_static( ).
    lrequest-applicant_id    = employee-employee_id.
    lrequest-approver_id     = lisa_uuid.
    lrequest-start_date      = '20221227'.
    lrequest-end_date        = '20221230'.
    lrequest-remark          = 'Christmas Holiday'.
    lrequest-state           = 'D'.
    APPEND lrequest TO lrequests.
    lrequest-request_id      = cl_system_uuid=>create_uuid_x16_static( ).
    lrequest-applicant_id    = employee-employee_id.
    lrequest-approver_id     = lisa_uuid.
    lrequest-start_date      = '20221228'.
    lrequest-end_date        = '20221230'.
    lrequest-remark          = 'Christmas Holiday (Second try)'.
    lrequest-state           = 'A'.
    APPEND lrequest TO lrequests.
    lrequest-request_id      = cl_system_uuid=>create_uuid_x16_static( ).
    lrequest-applicant_id    = employee-employee_id.
    lrequest-approver_id     = lisa_uuid.
    lrequest-start_date      = '20230527'.
    lrequest-end_date        = '20230614'.
    lrequest-remark          = ' '.
    lrequest-state           = 'Approved'.
    APPEND lrequest TO lrequests.
    lrequest-request_id      = cl_system_uuid=>create_uuid_x16_static( ).
    lrequest-applicant_id    = employee-employee_id.
    lrequest-approver_id     = lisa_uuid.
    lrequest-start_date      = '20231220'.
    lrequest-end_date        = '20231231'.
    lrequest-remark          = 'Winter Holiday'.
    lrequest-state           = 'R'.
    APPEND lrequest TO lrequests.

    " Create third employee
    employee-employee_id     = cl_system_uuid=>create_uuid_x16_static( ).
    employee-employee_number = '000003'.
    employee-first_name      = 'Petra'.
    employee-last_name       = 'Schmid'.
    employee-entry_date      = '20221001'.
    APPEND employee TO employees.
    entitlement-entitlement_id   = cl_system_uuid=>create_uuid_x16_static( ).
    entitlement-employee_uuid    = employee-employee_id.
    entitlement-entitlement_year = 2023.
    entitlement-vacation_days    = 7.
    APPEND entitlement TO entitlements.
    lrequest-request_id      = cl_system_uuid=>create_uuid_x16_static( ).
    lrequest-applicant_id    = employee-employee_id.
    lrequest-approver_id     = hans_uuid.
    lrequest-start_date      = '20231227'.
    lrequest-end_date        = '20231231'.
    lrequest-remark          = 'Christmas Holiday'.
    lrequest-state           = 'R'.
    APPEND lrequest TO lrequests.

    employee-employee_id     = cl_system_uuid=>create_uuid_x16_static( ).
    employee-employee_number = '00004'.
    employee-first_name      = 'Charlie'.
    employee-last_name       = 'Brown'.
    employee-entry_date      = '20230101'.
    APPEND employee TO employees.

    employee-employee_id     = cl_system_uuid=>create_uuid_x16_static( ).
    employee-employee_number = '00005'.
    employee-first_name      = 'Christian'.
    employee-last_name       = 'Kimmes'.
    employee-entry_date      = '20220901'.
    APPEND employee TO employees.

    employee-employee_id     = cl_system_uuid=>create_uuid_x16_static( ).
    employee-employee_number = '00006'.
    employee-first_name      = 'Olison'.
    employee-last_name       = 'Sturm'.
    employee-entry_date      = '20220901'.
    APPEND employee TO employees.

    employee-employee_id     = cl_system_uuid=>create_uuid_x16_static( ).
    employee-employee_number = '00007'.
    employee-first_name      = 'Elia'.
    employee-last_name       = 'Heitzmann'.
    employee-entry_date      = '20220901'.
    APPEND employee TO employees.

    employee-employee_id     = cl_system_uuid=>create_uuid_x16_static( ).
    employee-employee_number = '00008'.
    employee-first_name      = 'Simon'.
    employee-last_name       = 'Klugger'.
    employee-entry_date      = '20220901'.
    APPEND employee TO employees.

    employee-employee_id     = cl_system_uuid=>create_uuid_x16_static( ).
    employee-employee_number = '00009'.
    employee-first_name      = 'Nico'.
    employee-last_name       = 'Richter'.
    employee-entry_date      = '20220901'.
    APPEND employee TO employees.

    INSERT zceo_employee_a FROM TABLE @employees.
    out->write( |Inserted Employees: { sy-dbcnt }| ).

    INSERT zceo_entitleme_a FROM TABLE @entitlements.
    out->write( |Inserted Entitlements: { sy-dbcnt }| ).

    INSERT zceo_lrequest_a FROM TABLE @lrequests.
    out->write( |Inserted Leave Requests: { sy-dbcnt }| ).

  ENDMETHOD.
ENDCLASS.
