@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumed Vacation Days'
define view entity ZI_CEO_ConsumedVacationDays
  as select from zceo_lrequest_a
{
      /* Fields */
  key applicant_id       as EmployeeUuid,
      sum(vacation_days) as ConsumedVacationDays
}
where
      state    <> 'D'
  and end_date < $session.user_date
group by
  applicant_id;
