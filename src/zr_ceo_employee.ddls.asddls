@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Root Entity'
define root view entity ZR_CEO_Employee
  as select from zceo_employee_a
  composition [0..*] of ZR_CEO_LeaveEntitlement        as _LeaveEntitlements
  composition [0..*] of ZR_CEO_LeaveRequest            as _LeaveRequests
  association [1..1] to ZI_CEO_EmployeeNumLeadingZeros as _EmployeeNumberWLZs on $projection.EmployeeId = _EmployeeNumberWLZs.EmployeeId
  association [1..1] to ZI_CEO_EmployeeFullName        as _EmployeeFN         on $projection.EmployeeId = _EmployeeFN.EmployeeId
  association [1..1] to ZI_CEO_AvailableVacationDays   as _AvailableVD        on $projection.EmployeeId = _AvailableVD.EmployeeUuid
  association [1..1] to ZI_CEO_PlannedVacationDays     as _PlannedVD          on $projection.EmployeeId = _PlannedVD.EmployeeUuid
  association [1..1] to ZI_CEO_ConsumedVacationDays    as _ConsumedVD         on $projection.EmployeeId = _ConsumedVD.EmployeeUuid
{
      /* Fields */
      @Semantics.uuid: true
  key employee_id                                        as EmployeeId,
      employee_number                                    as EmployeeNumber,
      @Semantics.name.givenName: true
      first_name                                         as FirstName,
      @Semantics.name.familyName: true
      last_name                                          as LastName,
      @Semantics.dateTime: true
      entry_date                                         as EntryDate,

      /* Transient Data */
      _EmployeeNumberWLZs.EmployeeNumberWithLeadingZeros as EmployeeNumberWithLeadingZeros,
      @Semantics.name.fullName: true
      _EmployeeFN.FullName                               as FullName,
      @Semantics.durationInDays: true
      _AvailableVD.AvailableVacationDays                 as AvailableVacationDays,
      @Semantics.durationInDays: true
      _PlannedVD.PlannedVacationDays                     as PlannedVacationDays,
      @Semantics.durationInDays: true
      _ConsumedVD.ConsumedVacationDays                   as ConsumedVacationDays,
      '3'                                                as AvailableVDaysCriticality,
      '2'                                                as PlannedVDaysCriticality,
      '1'                                                as ConsumedVDaysCriticality,



      /* Admin Data */
      @Semantics.user.createdBy: true
      created_by                                         as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                                         as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by                                    as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                                    as LastChangedAt,

      /* Association */
      _LeaveEntitlements,
      _LeaveRequests
}
