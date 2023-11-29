@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fullname of Employee'
define view entity ZI_CEO_EmployeeFullName
  as select from zceo_employee_a
{
      /* Fields */
  key employee_id                                 as EmployeeId,
      concat_with_space(first_name, last_name, 1) as FullName
}
