@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Available Vacation Days'
define view entity ZI_CEO_AvailableVacationDays
  as select from zceo_entitleme_a
  association [1..1] to ZI_CEO_ConsumedVacationDays as _ConsumedVD on $projection.EmployeeUuid = _ConsumedVD.EmployeeUuid
{
      /* Fields */
  key employee_uuid                                                             as EmployeeUuid,
      coalesce(vacation_days - _ConsumedVD.ConsumedVacationDays, vacation_days) as AvailableVacationDays

}
where
  entitlement_year = left($session.system_date, 4);
