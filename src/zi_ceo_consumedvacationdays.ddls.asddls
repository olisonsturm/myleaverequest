@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumed Vacation Days'
define view entity ZI_CEO_ConsumedVacationDays
  as select from zceo_lrequest_a
{
      /* Fields */
  key applicant_id as EmployeeUuid,
      sum(
        case when end_date > $session.user_date
          then
            dats_days_between(start_date, $session.user_date)
          else
            dats_days_between(start_date, end_date)
        end)       as ConsumedVacationDays
}
where
      state      = 'A'
  and start_date < $session.user_date
group by
  applicant_id,
  state;
