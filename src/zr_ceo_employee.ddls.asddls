@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Root Entity'
define root view entity ZR_CEO_Employee 
  as select from zceo_employee_a
  composition [0..*] of ZR_CEO_LeaveEntitlement as _LeaveEntitlements 
  composition [0..*] of ZR_CEO_LeaveRequest     as _LeaveRequests
{
  @Semantics.uuid: true
  key employee_id as EmployeeId,
  employee_number as EmployeeNumber,
  cast(employee_number as abap.char(6)) as EmployeeNumberWithLeadingZeros,
  @Semantics.name.givenName: true
  first_name as FirstName,
  @Semantics.name.familyName: true
  last_name as LastName,
  @Semantics.name.fullName: true
  concat_with_space(first_name, last_name, 1) as FullName,
  @Semantics.dateTime: true
  entry_date as EntryDate,
  
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
  _LeaveEntitlements,
  _LeaveRequests
}
