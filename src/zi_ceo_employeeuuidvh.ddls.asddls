@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee UUID Vlaue Help'
@Search.searchable: true
@UI.presentationVariant: [{sortOrder: [{ by: 'EmployeeNumber', direction: #ASC }]}]
define view entity ZI_CEO_EmployeeUuidVH
  as select from zceo_employee_a
{
      /* Fields */
      @UI.hidden: true
  key employee_id                                        as EmployeeId,
  
      @EndUserText: { label: 'Employee Number', quickInfo: 'Number of Employee' }
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CEO_EmployeeNumVH', element: 'EmployeeNumber' } }]
      employee_number as EmployeeNumber,
      
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      first_name                                         as FirstName,
      
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      last_name                                          as LastName
}
