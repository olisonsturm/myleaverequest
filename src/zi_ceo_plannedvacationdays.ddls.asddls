@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Planned Vacation Days'
define view entity ZI_CEO_PlannedVacationDays
  as select from zceo_lrequest_a
{
  /* Fields */
  applicant_id                                 as EmployeeUuid,
  sum(dats_days_between(start_date, end_date)) as PlannedVacationDays
}
where
      state      <> 'D'
  and start_date > $session.system_date
group by
  applicant_id,
  state;
