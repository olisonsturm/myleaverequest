@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Leave Entitlement Entity'
define view entity ZR_CEO_LeaveEntitlement
  as select from zceo_entitleme_a
  association to parent ZR_CEO_Employee as _Employee
  on $projection.EmployeeUuid = _Employee.EmployeeId
{
  @Semantics.uuid: true
  key entitlement_id as EntitlementId,
  @Semantics.uuid: true
  employee_uuid as EmployeeUuid,
  @Semantics.calendar.year: true
  entitlement_year as EntitlementYear,
  @Semantics.durationInDays: true
  vacation_days as VacationDays,
  
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
  _Employee
}
