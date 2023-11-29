@EndUserText.label: 'Leave Request Consumption View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZC_CEO_LeaveRequestApproval
  as projection on ZR_CEO_LeaveRequest
{
      /* Fields */
  key RequestId,
      ApplicantId,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CEO_EmployeeUuidVH', element: 'EmployeeId' }}]
      ApproverId,
      StartDate,
      EndDate,
      VacationDays,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Remark,
      State,
      ApplicantFullName,
      ApproverFullName,
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
      _Applicant : redirected to parent ZC_CEO_EmployeeApproval,
      _Approver  : redirected to ZC_CEO_EmployeeApproval
}
