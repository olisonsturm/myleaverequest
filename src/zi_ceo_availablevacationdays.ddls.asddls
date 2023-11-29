@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Available Vacation Days'
define view entity ZI_CEO_AvailableVacationDays
  as select from zceo_entitleme_a
  association [1..1] to ZI_CEO_ConsumedVacationDays as _ConsumedVD on $projection.EmployeeUuid = _ConsumedVD.EmployeeUuid
  association [1..1] to ZI_CEO_PlannedVacationDays  as _PlannedVD  on $projection.EmployeeUuid = _PlannedVD.EmployeeUuid
{
      /* Fields */
  key employee_uuid                                                                                                        as EmployeeUuid,
      coalesce(sum(vacation_days) - coalesce(_ConsumedVD.ConsumedVacationDays, 0) - coalesce(_PlannedVD.PlannedVacationDays, 0), sum(vacation_days)) as AvailableVacationDays

}
//where entitlement_year = left($session.system_date, 4);
group by
  employee_uuid,
  vacation_days,
  _ConsumedVD.ConsumedVacationDays,
  _PlannedVD.PlannedVacationDays
