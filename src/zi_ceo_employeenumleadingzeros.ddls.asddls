@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Number With Leading Zeros'
define view entity ZI_CEO_EmployeeNumLeadingZeros
  as select from zceo_employee_a
{
  key employee_id      as EmployeeId,
  cast(employee_number as abap.char(6)) as EmployeeNumberWithLeadingZeros
}
