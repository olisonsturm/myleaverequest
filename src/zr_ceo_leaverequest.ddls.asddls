@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Leave Request Entity'
define view entity ZR_CEO_LeaveRequest 
  as select from zceo_lrequest_a
  association to parent ZR_CEO_Employee as _Applicant
  on $projection.ApplicantId = _Applicant.EmployeeId
  association to ZR_CEO_Employee as _Approver
  on $projection.ApproverId = _Approver.EmployeeId
{
  @Semantics.uuid: true
  key request_id as RequestId,
  @Semantics.uuid: true
  applicant_id as ApplicantId,
  @Semantics.uuid: true
  approver_id as ApproverId,
  @Semantics.dateTime: true
  start_date as StartDate,
  @Semantics.dateTime: true
  end_date as EndDate,
  @Semantics.text: true
  remark as Remark,
  state as State,
  case state
    when 'A' then 'Approved'
    when 'D' then 'Decliend'
    else 'Requested'
  end as StateDescription,
  
  /* Admin Data */
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  
  /* Association */
  _Applicant,
  _Approver
}
