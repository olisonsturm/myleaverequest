@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Number Value Help'
@Search.searchable: true
define view entity ZI_CEO_EmployeeNumVH 
  as select from zceo_employee_a
{
  /* Fields */
  @UI.hidden: true
  key employee_id as EmployeeId,
  
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.7
  @EndUserText: { label: 'Employee Number', quickInfo: 'Number of Employee'}
  employee_number as EmployeeNumber,

  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.7
  first_name as FirstName,
  
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.7
  last_name as LastName
}
