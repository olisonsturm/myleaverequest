@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Number Value Help'
@Search.searchable: true
define view entity ZI_CEO_EmployeeNumVH 
  as select from zceo_employee_a
  association [1..1] to ZI_CEO_EmployeeNumLeadingZeros as _EmployeeNumberWLZs on $projection.EmployeeId = _EmployeeNumberWLZs.EmployeeId
{
  /* Fields */
  @UI.hidden: true
  key employee_id as EmployeeId,
  
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.7
  @UI.hidden: true
  employee_number as EmployeeNumber,
  
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.7
  @EndUserText: { label: 'Employee Number', quickInfo: 'Number of Employee'}
  _EmployeeNumberWLZs.EmployeeNumberWithLeadingZeros,

  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.7
  first_name as FirstName,
  
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.7
  last_name as LastName
}
