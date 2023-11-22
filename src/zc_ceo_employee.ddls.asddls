@EndUserText.label: 'Employee Consumption View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_CEO_Employee
  provider contract transactional_query
  as projection on ZR_CEO_Employee
{
      /* Fields */
  key EmployeeId,
      EmployeeNumber,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CEO_EmployeeNumVH', element: 'EmployeeNumberWithLeadingZeros' } }]
      EmployeeNumberWithLeadingZeros,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      FirstName,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      LastName,
      FullName,
      EntryDate,
      AvailableVacationDays,
      PlannedVacationDays,
      ConsumedVacationDays,
      AvailableVDaysCriticality,
      PlannedVDaysCriticality,
      ConsumedVDaysCriticality,

      /* Admin Data */
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

      /* Associations */
      _LeaveEntitlements : redirected to composition child ZC_CEO_LeaveEntitlement,
      _LeaveRequests     : redirected to composition child ZC_CEO_LeaveRequest
}
