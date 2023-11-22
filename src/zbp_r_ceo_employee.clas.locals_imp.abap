CLASS lhc_employee DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Employee RESULT result.

ENDCLASS.

CLASS lhc_employee IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
