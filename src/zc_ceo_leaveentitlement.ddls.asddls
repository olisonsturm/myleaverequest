@EndUserText.label: 'Leave Entitlement Consumption View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_CEO_LeaveEntitlement
  as projection on ZR_CEO_LeaveEntitlement
{
  key EntitlementId,
  EmployeeUuid,
  EntitlementYear,
  VacationDays,
  
  /* Admin Data */
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt,
  
  /* Associations */
  _Employee : redirected to parent ZC_CEO_Employee
}
