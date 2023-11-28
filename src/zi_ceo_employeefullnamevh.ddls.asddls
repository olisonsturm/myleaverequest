@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Full Name Vlaue Help'
@Search.searchable: true
define view entity ZI_CEO_EmployeeFullNameVH
  as select from zceo_employee_a
  association [1..1] to ZI_CEO_EmployeeFullName        as _EmployeeFN         on $projection.EmployeeId = _EmployeeFN.EmployeeId
{
      /* Fields */
      @UI.hidden: true
  key employee_id                                        as EmployeeId,
      @EndUserText: { label: 'Employee Number', quickInfo: 'Number of Employee' }
      @UI.selectionField: [{ position: 10 }]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CEO_EmployeeNumVH', element: 'EmployeeNumber' } }]
      employee_number as EmployeeNumber,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @UI.selectionField: [{ position: 20 }]
      @Semantics.name.givenName: true
      first_name                                         as FirstName,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @UI.selectionField: [{ position: 30 }]
      @Semantics.name.familyName: true
      last_name                                          as LastName,
      @UI.hidden: true
      @Semantics.name.fullName: true
      _EmployeeFN.FullName                               as FullName
}
