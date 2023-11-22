@EndUserText.label: 'Leave Request Consumption View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_CEO_LeaveRequest
  as projection on ZR_CEO_LeaveRequest
{
  /* Fields */
  key RequestId,
  ApplicantId,
  ApproverId,
  StartDate,
  EndDate,
  Remark,
  State,
  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CEO_StateVH', element: 'StateDescription' }}]
  StateDescription,
  StartDateCriticality,
  StateCriticality,
  
  /* Admin Data */
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt,
  
  /* Associations */
  _Applicant : redirected to parent ZC_CEO_Employee,
  _Approver  : redirected to ZC_CEO_Employee
}
