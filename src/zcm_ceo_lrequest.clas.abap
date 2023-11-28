CLASS zcm_ceo_lrequest DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      BEGIN OF lrequest_decline,
        msgid TYPE symsgid VALUE 'ZCEO_LREQUEST',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'REMARK',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF lrequest_decline.

    CONSTANTS:
      BEGIN OF lrequest_already_declined,
        msgid TYPE symsgid VALUE 'ZCEO_LREQUEST',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'REMARK',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF lrequest_already_declined.

    CONSTANTS:
      BEGIN OF lrequest_approve,
        msgid TYPE symsgid VALUE 'ZCEO_LREQUEST',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'REMARK',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF lrequest_approve.

    CONSTANTS:
      BEGIN OF lrequest_already_approved,
        msgid TYPE symsgid VALUE 'ZCEO_LREQUEST',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'REMARK',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF lrequest_already_approved.

    CONSTANTS:
      BEGIN OF lrequest_endbeforestartdate,
        msgid TYPE symsgid VALUE 'ZCEO_LREQUEST',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF lrequest_endbeforestartdate.

    CONSTANTS:
      BEGIN OF lrequest_startdateinthepast,
        msgid TYPE symsgid VALUE 'ZCEO_LREQUEST',
        msgno TYPE symsgno VALUE '006',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF lrequest_startdateinthepast.

    CONSTANTS:
      BEGIN OF lrequest_insufficientvacdays,
        msgid TYPE symsgid VALUE 'ZCEO_LREQUEST',
        msgno TYPE symsgno VALUE '007',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF lrequest_insufficientvacdays.

    DATA remark TYPE zceo_remark.

    METHODS constructor
      IMPORTING
        textid   LIKE if_t100_message=>t100key OPTIONAL
        severity TYPE if_abap_behv_message=>t_severity
        !previous LIKE previous OPTIONAL
        remark   TYPE zceo_remark OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcm_ceo_lrequest IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).

    if_t100_message~t100key = textid.
    if_abap_behv_message~m_severity = severity.
    me->remark = remark.
  ENDMETHOD.

ENDCLASS.
